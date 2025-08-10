from django.shortcuts import render
from rest_framework import generics
from .models import StationCatagory
from .serializers import EmergencyCallSerializers
# Create your views here.

class EmergencyCallListView(generics.ListAPIView):
    queryset = StationCatagory.objects.all()
    serializer_class = EmergencyCallSerializers
