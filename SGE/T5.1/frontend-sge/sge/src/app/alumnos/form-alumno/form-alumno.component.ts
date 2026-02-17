import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef } from '@angular/material/dialog';
import { AlumnosService } from 'src/app/services/alumnos.service';
import { MaestrosService } from 'src/app/services/maestros.service';

@Component({
  selector: 'app-form-alumno',
  templateUrl: './form-alumno.component.html',
  styleUrls: ['./form-alumno.component.scss']
})

export class FormAlumnoComponent implements OnInit {

  alumnoForm: FormGroup;
  
  constructor(private fb: FormBuilder, private alumnosService: AlumnosService, private maestrosServices: MaestrosService, public dialogRef: MatDialogRef<FormAlumnoComponent>) { }
  
  entidades: any[] = [];
  ciclos: any[] = [];
  

  ngOnInit(): void {
  // Cargar Entidades y FILTRAR por tipo Centro Educativo (1)
    /* this.maestrosServices.getEntidades().subscribe(
      (data) => {
        console.log('Datos recibidos del backend:', data); // <--- MIRA ESTO EN LA CONSOLA (F12)
        // Filtramos aquí para que el HTML solo reciba los centros
        this.entidades = data.filter((e: any) => e.id_tipo_entidad === 1);
      },
      (error) => console.error('Error al cargar entidades:', error)
    ); */

    // Cargar Ciclos
    this.maestrosServices.getCiclos().subscribe(
      (data) => {
        this.ciclos = data;
      },
      (error) => console.error('Error al cargar ciclos:', error)
    );

    this.maestrosServices.getEntidades().subscribe(
      (data) => {
        this.entidades = data.filter((e: any) => e.id_tipo_entidad === 1);
      },
      (error) => console.error('Error al cargar entidades:', error)
    )

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
      this.alumnosService.crearAlumno(nuevoAlumno).subscribe(
        res => {
          alert('Alumno creado con éxito');
          this.alumnoForm.reset(); // Limpiar el formulario
          this.dialogRef.close(true); // Cerrar el diálogo y pasar true para indicar que se editó
        },
        err => {
          console.error(err);
          this.dialogRef.close(false); // Cerrar el diálogo y pasar false para indicar que hubo un error
          alert('Error al crear el alumno: ' + err.message);
        }
      );
    }
  }
}
