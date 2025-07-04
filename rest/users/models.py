from django.db import models
import os
from django.contrib.auth.models import User
from django.utils.deconstruct import deconstructible
from django.core.exceptions import ValidationError
import os
# Create your models here.

def image_validator(value):
    ext = os.path.splitext(value.name)[1]
    validExtension = ['.jpg','.jpeg', '.png','.svg','.webp']
    if not ext.lower() in validExtension:
        raise ValidationError(f'Unsupported file extension: {ext}. Allowed extensions are: .jpg, .jpeg, .png, .webp, .svg')


@deconstructible
class GenerateProfileImagePath(object):
    def __init__(self):
        pass

    def __call_(self, instance, filename):
        ext = filename.split('.')[-1]
        path = f'media/accounts/{instance.user.id}/images/'
        name = f'profile_image.{ext}'
        return os.path.join(path,name)
    
user_profile_image_path = GenerateProfileImagePath()
class Profile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    image = models.FileField(upload_to='profile/', validators=[image_validator], null=True, blank=True)
    bio = models.CharField(max_length=150, blank=True)
    # email = models.CharField(max_length=20, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    present_address = models.CharField(max_length=255, blank=True, null=True)
    permanent_address = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=20, blank=True, null=True)
    def __str__(self):
        return f'{self.user.username}\'s Profile'
