from django.contrib import admin
from django.urls import path, include
from hotel import views
from booking import views

urlpatterns = [
path('admin/', admin.site.urls),
path('hotel/', include('hotel.urls')),
path('accounts/', include('accounts.urls')),
path('registration/', include('dj_rest_auth.registration.urls')),
path('account/', include('allauth.urls')),
path('booking/', include('booking.urls')),
]

