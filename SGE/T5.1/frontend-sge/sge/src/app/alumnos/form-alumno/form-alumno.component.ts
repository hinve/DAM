import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlumnosService } from 'src/app/services/alumnos.service';
import { MaestrosService } from 'src/app/services/maestros.service';

@Component({
  selector: 'app-form-alumno',
  templateUrl: './form-alumno.component.html',
  styleUrls: ['./form-alumno.component.scss']
})

export class FormAlumnoComponent implements OnInit {

  alumnoForm: FormGroup;
  
  constructor(private fb: FormBuilder, private alumnosService: AlumnosService, private maestrosServices: MaestrosService) { }
  
  entidades: any[] = [];
  ciclos: any[] = [];
  

  ngOnInit(): void {
    // Cargar Entidades
    this.maestrosServices.getEntidades().subscribe(
      (data) => {
        this.entidades = data;
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
      this.alumnosService.crearAlumno(nuevoAlumno).subscribe(
        res => {
          alert('Alumno creado con éxito');
          this.alumnoForm.reset(); // Limpiar el formulario
        },
        err => {
          console.error(err);
          alert('Error al crear el alumno: ' + err.message);
        }
      );
    }
  }
}
