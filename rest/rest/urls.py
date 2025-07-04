"""
URL configuration for rest project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from users import router as users_api_router
from django.conf import settings
from django.conf.urls.static import static

auth_api_urls = [
    path(r'', include('drf_social_oauth2.urls', namespace='drf')),
]
if settings.DEBUG :
    auth_api_urls += [
        path('verify/', include('rest_framework.urls')),
        path('user/', include('users.urls')),  # ✅ Add this for /api/auth/user/me/
    ]

api_url_patterns = [
    path(r'auth/', include(auth_api_urls)),
    path('accounts/',include(users_api_router.router.urls)),
]

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(api_url_patterns)),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)