"""
URL configuration for rocket_league_manager project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
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
from torneos import views
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import include, path
from django.views.generic import RedirectView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('', RedirectView.as_view(url='/torneos/', permanent=False), name='home'),
    path('torneos/', include('torneos.urls')),
    path('equipos/', include('torneos.urls')),
    path('equipos/<int:equipo_id>/jugadores/nuevo/', views.jugador_create, name='jugador_create'),
    path('mis-torneos/', views.torneo_list, name='torneo_list'),
    path('mis-torneos/nuevo/', views.torneo_create, name='torneo_create'),
    path('mis-torneos/<int:torneo_id>/', views.torneo_detail, name='torneo_detail'),
    path('mis-torneos/<int:torneo_id>/editar/', views.torneo_update, name='torneo_update'),
    path('mis-torneos/<int:torneo_id>/eliminar/', views.torneo_delete, name='torneo_delete'),
    
]
