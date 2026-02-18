import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { EntidadesService } from '../services/entidades.service';
import { CiclosService } from '../services/ciclos.service';
import { VacantesService } from '../services/vacantes.service';

@Component({
  selector: 'app-form-vacante',
  templateUrl: './form-vacante.component.html',
  styleUrls: ['./form-vacante.component.scss']
})
export class FormVacanteComponent implements OnInit {

  form: FormGroup;
  entidades: any[] = [];
  ciclos: any[] = [];
  isEditMode: boolean = false;
  tieneAlumnosAsignados: boolean = false;

  constructor(
    private fb: FormBuilder,
    private dialogRef: MatDialogRef<FormVacanteComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private entidadesService: EntidadesService,
    private ciclosService: CiclosService,
    private vacantesService: VacantesService
  ) { }

  ngOnInit(): void {
    this.isEditMode = !!this.data;
    this.tieneAlumnosAsignados = this.data?.num_alumnos && this.data.num_alumnos > 0;

    const idEntidadInicial = this.data?.entidad?.id_entidad !== undefined ? this.data.entidad.id_entidad : (this.data?.id_entidad || '');
    const idCicloInicial = this.data?.ciclo?.id_ciclo !== undefined ? this.data.ciclo.id_ciclo : (this.data?.id_ciclo || '');

    this.form = this.fb.group({
      id_entidad: [idEntidadInicial, Validators.required],
      id_ciclo: [idCicloInicial, Validators.required],
      curso: [this.data?.curso || '', [Validators.required, Validators.min(1), Validators.max(2)]],
      num_vacantes: [this.data?.num_vacantes || 1, [Validators.required, Validators.min(1)]],
      observaciones: [this.data?.observaciones || '']
    });

    this.loadMaestros();

    if (this.tieneAlumnosAsignados) {
      this.form.disable();
    }
  }

  loadMaestros() {
    this.entidadesService.getEntidadesSimples().subscribe(res => this.entidades = res);
    this.ciclosService.getCiclosSimples().subscribe(res => this.ciclos = res);
  }

  save() {
    if (this.form.invalid) return;

    const vacante = this.form.value;

    if (this.isEditMode) {
      // Update
      const id = this.data.id_vacante;
      this.vacantesService.actualizarVacante(id, vacante).subscribe(
        () => this.dialogRef.close(true),
        err => this.manejarError(err)
      );
    } else {
      // Create
      this.vacantesService.crearVacante(vacante).subscribe(
        () => this.dialogRef.close(true),
        err => this.manejarError(err)
      );
    }
  }

  private manejarError(err: any) {
    // Si el backend devuelve un mensaje de detalle (ej: "Esta vacante ya existe")
    const mensaje = err.error?.detail || 'Error al procesar la vacante';
    
    alert('AVISO: ' + mensaje);
  } 

  close() {
    this.dialogRef.close();
  }
}
