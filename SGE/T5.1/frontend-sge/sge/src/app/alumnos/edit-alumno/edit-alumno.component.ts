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
            console.log('Datos recibidos del backend:', data); // <--- MIRA ESTO EN LA CONSOLA (F12)
            this.entidades = data.filter((e: any) => e.id_tipo_entidad === 1);
            
            

            // MUY IMPORTANTE: Rellenar el formulario con los datos recibidos (data de MAT_DIALOG_DATA)
            // Lo hacemos dentro del subscribe para asegurar que el select tenga opciones antes de marcar la elegida
            this.alumnoForm.patchValue(this.data);
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
        fecha_nacimiento: ['', Validators.required], // Nuevo campo requerido
        curso: ['', Validators.required],
        id_entidad: ['', Validators.required], // Renombrado de entidad -> id_entidad
        id_ciclo: ['', Validators.required],   // Nuevo campo requerido
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
            console.error(err);
            alert('Error al editar el alumno: ' + err.message);
            this.dialogRef.close(false); // Cerrar el diálogo y pasar false para indicar que no se editó
          }
        );
      }
    }
  }
