import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlumnosService } from 'src/app/services/alumnos.service';
import { MaestrosService } from 'src/app/services/maestros.service';
import { ActivatedRoute, Router } from '@angular/router';
import { AlumnosComponent } from '../alumnos.component';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-edit-alumno',
  templateUrl: './edit-alumno.component.html',
  styleUrls: ['./edit-alumno.component.scss']
})
export class EditAlumnoComponent implements OnInit {
  alumnoForm: FormGroup;
  id!: number;

    constructor(@Inject(MAT_DIALOG_DATA) public data,
      private route: ActivatedRoute, private fb: FormBuilder,
      private alumnosService: AlumnosService,
      private maestrosServices: MaestrosService,
      public dialogRef: MatDialogRef<EditAlumnoComponent>,
      ) { }
    
    entidades: any[] = [];
    ciclos: any[] = [];
    
  
    ngOnInit(): void {
      this.id = this.data.id_alumno;

        // Cargar Entidades FILTRADAS
        this.maestrosServices.getEntidades().subscribe(
          (data) => {
            this.entidades = data.filter((e: any) => e.id_tipo_entidad === 1);
            // Lo hago dentro del subscribe para asegurar que el select tenga opciones antes de marcar la elegida
            const dataFormat = {
              ...this.data,
              id_entidad: this.data.entidad?.id_entidad, // Extraemos solo el ID para el select
              id_ciclo: this.data.ciclo?.id_ciclo          // Extraemos solo el ID para el select
            }
            this.alumnoForm.patchValue(dataFormat);
          },
          (error) => console.error('Error al cargar entidades:', error)
        );

        // Cargar Ciclos
        this.maestrosServices.getCiclos().subscribe(
          (data) => {
            this.ciclos = data;
          },
          (error) => console.error('Error al cargar ciclos:', error)
        );
  
      this.alumnoForm = this.fb.group({
        nombre: ['', Validators.required],
        apellidos: ['', Validators.required],
        nif_nie: ['', [Validators.required, Validators.minLength(9)]],
        fecha_nacimiento: ['', Validators.required],
        curso: ['', Validators.required],
        id_entidad: ['', Validators.required],
        id_ciclo: ['', Validators.required],
        telefono: ['', [Validators.required, Validators.pattern('^[0-9]{9}$')]],
        direccion: [''],
        localidad: [''],
        id_provincia: [null]
      });
    }
  
    guardar() {
      if (this.alumnoForm.valid) {
        const nuevoAlumno = this.alumnoForm.value;
        this.alumnosService.actualizarAlumno(this.id, nuevoAlumno).subscribe(
          res => {
            alert('Alumno editado con éxito');
            this.alumnoForm.reset(); // Limpiar el formulario
            this.dialogRef.close(true); // Cerrar el diálogo y pasar true para indicar que se editó
          },
          err => {
            if(err.status == 400 && err.error?.detail?.includes('DNI/NIE')) {
            alert('Error: El NIF/NIE ya existe en el sistema');
            console.error(err);
            this.dialogRef.close(false); // Cerrar el diálogo y pasar false para indicar que hubo un error
          } else {
            console.error(err);
            this.dialogRef.close(false); // Cerrar el diálogo y pasar false para indicar que hubo un error
            alert('Error al crear el alumno: ' + err.message);
          }
          }
        );
      }
    }

    cancelar() {
      this.dialogRef.close(false);
    }
  }
