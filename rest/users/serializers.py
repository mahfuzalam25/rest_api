from django.contrib.auth.models import User
from rest_framework import serializers
from .models import Profile

class ProfileSerializer(serializers.ModelSerializer):
    user = serializers.HyperlinkedRelatedField(read_only=True, many=False, view_name='user-detail')

    class Meta:
        model = Profile
        fields = [
            'url','bio', 'id', 'user', 'image', 'phone',
            'present_address', 'permanent_address',
            'city', 'state', 'zip_code'
        ]


class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer(read_only=True)
    old_password = serializers.CharField(write_only=True, required=False)
    password = serializers.CharField(write_only=True, required=False)
    username = serializers.CharField(read_only=True)

    class Meta:
        model = User
        fields = [
            'url', 'id', 'username', 'email',
            'first_name', 'last_name',
            'password', 'old_password', 'profile'
        ]

    def create(self, validated_data):
        password = validated_data.pop('password')
        user = User.objects.create(**validated_data)
        user.set_password(password)
        user.save()
        return user

    def update(self, instance, validated_data):
        print('Update called for user:', instance.username)
        print('Validated data:', validated_data)

        request = self.context.get('request')
        print('Request data:', request.data)

        # Handle password update
        try:
            if 'password' in validated_data:
                password = validated_data.pop('password')
                old_password = validated_data.pop('old_password', None)
                if old_password and instance.check_password(old_password):
                    instance.set_password(password)
                elif old_password is None:
                    raise Exception("Old password is required.")
                else:
                    raise Exception("Old password is incorrect.")
        except Exception as err:
            raise serializers.ValidationError({"info": str(err)})

        # Update user fields
        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()

        # Update profile fields using 'profile.' prefix keys
        if request and hasattr(instance, 'profile'):
            profile = instance.profile

            # Fields list without prefix
            profile_fields = [
                'phone', 'present_address', 'permanent_address',
                'city', 'state', 'zip_code', 'bio'
            ]

            for field in profile_fields:
                key = f'profile.{field}'
                if key in request.data:
                    setattr(profile, field, request.data.get(key))

            # Handle image upload
            if 'profile.image' in request.FILES:
                profile.image = request.FILES['profile.image']

            profile.save()

        return instance



    def validate(self, data):
        method = self.context['request'].method
        password = data.get('password', None)

        if method == 'POST':
            if not password:
                raise serializers.ValidationError({"info": "Please provide a password."})
        elif method in ['PUT', 'PATCH']:
            if password and not data.get('old_password'):
                raise serializers.ValidationError({"info": "Please provide the old password to set a new one."})
        return data
