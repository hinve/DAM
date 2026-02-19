import { Component, Inject, OnDestroy, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { VacantesService } from 'src/app/services/vacantes.service';

@Component({
  selector: 'app-gestion-alumnos',
  templateUrl: './gestion-alumnos.component.html',
  styleUrls: ['./gestion-alumnos.component.scss']
})
export class GestionAlumnosComponent implements OnInit, OnDestroy {

  asignados: any[] = [];
  disponibles: any[] = [];
  vacante: any;

  constructor(
    public dialogRef: MatDialogRef<GestionAlumnosComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any, // Recibimos la vacante entera aquí
    private vacantesService: VacantesService
  ) { 
    this.vacante = data;
  }
  ngOnDestroy(): void {
    this.cerrar();
  }

  ngOnInit(): void {
    this.cargarDatos();
  }

  cargarDatos() {
    // 1. Cargar disponibles
    this.vacantesService.getAlumnosDisponibles(this.vacante.id_vacante).subscribe(res => {
      this.disponibles = res;
    });

    // 2. Cargar asignados
    this.vacantesService.getAlumnosAsignados(this.vacante.id_vacante).subscribe(res => {
      this.asignados = res;
    });
  }

  asignar(alumno: any) {
    this.vacantesService.asignarAlumno(this.vacante.id_vacante, alumno.id_alumno).subscribe(
      () => this.cargarDatos(), // Recargar listas
      err => alert('Error al asignar: maximo alcanzado')
    )
  }

  quitar(alumno: any) {
    if(confirm(`¿Desasignar a ${alumno.nombre}?`)) {
      this.vacantesService.quitarAlumno(this.vacante.id_vacante, alumno.id_alumno).subscribe(() => {
        this.cargarDatos(); // Recargar listas
      }, err => alert('Error al quitar: ' + err.message));
    }
  }

  cerrar() {
    this.dialogRef.close(true); // Devolvemos true para que la tabla principal se actualice
  }
}
