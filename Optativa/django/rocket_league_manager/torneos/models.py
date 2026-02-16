import datetime
from django.db import models
from django.contrib.auth.models import User

# Opciones
OPCIONES_RANGO = [
    ('Bronce', 'Bronce'),
    ('Plata', 'Plata'),
    ('Oro', 'Oro'),
    ('Platino', 'Platino'),
    ('Diamante', 'Diamante'),
    ('Campeon', 'Campeon'),
    ('Gran Campeon', 'Gran Campeon'),
    ('Supersonico', 'Supersonico')
]

OPCIONES_PLAT = [
    ('PC', 'PC'),
    ('PS4', 'PS4'),
    ('PS5', 'PS5'),
    ('Xbox One', 'Xbox One'),
    ('Xbox Series X', 'Xbox Series X'),
    ('Nintendo Switch', 'Nintendo Switch')
]

# Modelos
class Equipo(models.Model):
    nombre  = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField(blank=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    creado_por = models.ForeignKey(User, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.nombre


class Jugador(models.Model):
    nombre = models.CharField(max_length=50)
    rango =  models.CharField(max_length=20, choices=OPCIONES_RANGO, default='Bronce')
    plataforma = models.CharField(max_length=20, choices=OPCIONES_PLAT, default='PC')
    equipo = models.ForeignKey(Equipo, on_delete=models.SET_NULL, related_name='jugadores', null=True, blank=True)
    
    def __str__(self):
        if self.equipo:
            return f"{self.nombre} - {self.rango} - {self.plataforma} ({self.equipo.nombre})"
        return f"{self.nombre} - {self.rango} - {self.plataforma}"

class Torneo(models.Model):
    nombre = models.CharField(max_length=50)
    fecha_inicio = models.DateTimeField()
    fecha_fin = models.DateTimeField()
    equipos_participantes = models.ManyToManyField(Equipo, related_name='torneos')
    creado_por = models.ForeignKey(User, on_delete=models.CASCADE, related_name='torneos_creados')
    
    def __str__(self):
        return self.nombre
    
class Partido(models.Model):
    torneo = models.ForeignKey(Torneo, on_delete=models.CASCADE, related_name='partidos')
    equipo_local = models.ForeignKey(Equipo, on_delete=models.CASCADE, related_name='partidos_locales')
    equipo_visitante = models.ForeignKey(Equipo, on_delete=models.CASCADE, related_name='partidos_visitantes')
    fecha_hora = models.DateTimeField()
    goles_local = models.IntegerField(default=0)
    goles_visitante = models.IntegerField(default=0)
    
    def __str__(self):    
        return f"{self.equipo_local.nombre} vs {self.equipo_visitante.nombre} - {self.torneo.nombre}"