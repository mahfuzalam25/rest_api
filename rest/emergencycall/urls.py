from django.urls import path
from .views import EmergencyCallListView
urlpatterns = [
    path('calllist/', EmergencyCallListView.as_view(), name='emergency-call-list')
]
