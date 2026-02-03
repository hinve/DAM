from django.contrib import admin

from .models import Equipo, Jugador, Partido, Torneo


admin.site.register(Equipo)
admin.site.register(Jugador)
admin.site.register(Torneo)
admin.site.register(Partido)
