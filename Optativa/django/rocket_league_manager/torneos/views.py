from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib import messages
from .models import Equipo, Torneo
from .forms import EquipoForm, JugadorForm, TorneoForm


@login_required
def torneos_index(request):
    return render(request, 'torneos/index.html')

# Equipo Views
@login_required
def equipo_list(request):
    equipos = Equipo.objects.filter(creado_por=request.user).order_by('nombre')
    return render(request, 'torneos/equipos/list.html', {'equipos': equipos})

@login_required
def equipo_detail(request, equipo_id):
    equipo = get_object_or_404(Equipo, id=equipo_id, creado_por=request.user)
    return render(request, 'torneos/equipos/detail.html', {'equipo': equipo})

@login_required
def equipo_create(request):
    cantidad_equipos = Equipo.objects.filter(creado_por=request.user).count()
    if cantidad_equipos > 3:
        messages.error(request, 'Has alcanzado el límite de 3 equipos. Elimina un equipo existente para crear uno nuevo.')
        return redirect('equipo_list')
    if request.method == 'POST':
        form = EquipoForm(request.POST)
        if form.is_valid():
            equipo = form.save(commit=False)
            equipo.creado_por = request.user
            equipo.save()
            messages.success(request, 'Equipo creado correctamente.')
            return redirect('equipo_list')
    else:
        form = EquipoForm()
    return render(request, 'torneos/equipos/form.html', {'form': form, 'accion': 'Crear'})

@login_required
def equipo_update(request, equipo_id):
    equipo = get_object_or_404(Equipo, id=equipo_id, creado_por=request.user)
    if request.method == 'POST':
        form = EquipoForm(request.POST, instance=equipo)
        if form.is_valid():
            form.save()
            messages.success(request, 'Equipo actualizado correctamente.')
            return redirect('equipo_detail', equipo_id=equipo.pk)
    else:
        form = EquipoForm(instance=equipo)
    return render(
        request,
        'torneos/equipos/form.html',
        {'form': form, 'accion': 'Editar', 'equipo': equipo},
    )

@login_required
def equipo_delete(request, equipo_id):
    equipo = get_object_or_404(Equipo, id=equipo_id, creado_por=request.user)
    if request.method == 'POST':
        equipo.delete()
        messages.success(request, 'Equipo eliminado correctamente.')
        return redirect('equipo_list')
    return render(request, 'torneos/equipos/confirm_delete.html', {'equipo': equipo})

# Jugador Views
@login_required
def jugador_create(request, equipo_id):
    equipo = get_object_or_404(Equipo, id=equipo_id, creado_por=request.user)
    if request.method == 'POST':
        form = JugadorForm(request.POST)
        if form.is_valid():
            jugador = form.save(commit=False)
            jugador.equipo = equipo
            jugador.save()
            messages.success(request, 'Jugador añadido correctamente.')
            return redirect('equipo_detail', equipo_id=equipo.pk)
    else:
        form = JugadorForm()
    return render(request, 'torneos/jugadores/form.html', {'form': form, 'equipo': equipo, 'accion': 'Añadir'})

@login_required
def torneo_list(request):
    torneos = Torneo.objects.filter(creado_por=request.user).order_by('-fecha_inicio')
    return render(request, 'torneos/torneos/list.html', {'torneos': torneos})

@login_required
def torneo_detail(request, torneo_id):
    torneo = get_object_or_404(Torneo, id=torneo_id, creado_por=request.user)
    return render(request, 'torneos/torneos/detail.html', {'torneo': torneo})

@login_required
def torneo_create(request):
    if request.method == 'POST':
        form = TorneoForm(request.POST)
        if form.is_valid():
            torneo = form.save(commit=False)
            torneo.creado_por = request.user
            torneo.save()
            form.save_m2m()  # Guardar relaciones ManyToMany
            messages.success(request, 'Torneo creado correctamente.')
            return redirect('torneo_list')
    else:
        form = TorneoForm()
    return render(request, 'torneos/torneos/form.html', {'form': form, 'accion': 'Crear'})

@login_required
def torneo_update(request, torneo_id):
    torneo = get_object_or_404(Torneo, id=torneo_id, creado_por=request.user)
    if request.method == 'POST':
        form = TorneoForm(request.POST, instance=torneo)
        if form.is_valid():
            form.save()
            messages.success(request, 'Torneo actualizado correctamente.')
            return redirect('torneo_detail', torneo_id=torneo.pk)
    else:
        form = TorneoForm(instance=torneo)
    return render(request, 'torneos/torneos/form.html', {'form': form, 'accion': 'Editar', 'torneo': torneo})

@login_required
def torneo_delete(request, torneo_id):
    torneo = get_object_or_404(Torneo, id=torneo_id, creado_por=request.user)
    if request.method == 'POST':
        torneo.delete()
        messages.success(request, 'Torneo eliminado correctamente.')
        return redirect('torneo_list')
    return render(request, 'torneos/torneos/confirm_delete.html', {'torneo': torneo})