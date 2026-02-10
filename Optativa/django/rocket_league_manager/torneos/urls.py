from django.urls import path
from . import views

urlpatterns = [
    path('', views.torneos_index, name='torneos'),
    path('equipos/', views.equipo_list, name='equipo_list'),
    path('equipos/nuevo/', views.equipo_create, name='equipo_create'),
    path('equipos/<int:equipo_id>/', views.equipo_detail, name='equipo_detail'),
    path('equipos/<int:equipo_id>/editar/', views.equipo_update, name='equipo_update'),
    path('equipos/<int:equipo_id>/eliminar/', views.equipo_delete, name='equipo_delete'),
    path('mis-torneos/', views.torneo_list, name='torneo_list'),
    path('mis-torneos/nuevo/', views.torneo_create, name='torneo_create'),
    path('mis-torneos/<int:torneo_id>/', views.torneo_detail, name='torneo_detail'),
    path('mis-torneos/<int:torneo_id>/editar/', views.torneo_update, name='torneo_update'),
    path('mis-torneos/<int:torneo_id>/eliminar/', views.torneo_delete, name='torneo_delete'),
]