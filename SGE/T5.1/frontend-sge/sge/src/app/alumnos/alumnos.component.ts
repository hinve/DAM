import { Component, OnInit, ViewChild } from '@angular/core';
import { AlumnosService } from '../services/alumnos.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog } from '@angular/material/dialog';
import { FormAlumnoComponent } from './form-alumno/form-alumno.component';

@Component({
  selector: 'app-alumnos',
  templateUrl: './alumnos.component.html',
  styleUrls: ['./alumnos.component.scss']
})
export class AlumnosComponent implements OnInit {
[x: string]: any;

  // DEFINICIÓN DE COLUMNAS: Qué mostrar y en qué orden
  displayedColumns: string[] = ['nif', 'nombre', 'apellidos', 'curso', 'entidad', 'telefono', 'acciones'];
  
  dataSource = new MatTableDataSource([]);

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: true}) sort: MatSort;

  constructor(private alumnosService: AlumnosService, private dialog: MatDialog) { }

  abrirFormulario() {
    const dialogRef = this.dialog.open(FormAlumnoComponent, {
      width: '400px',
      data: {} // Aquí podrías pasar datos si quieres editar un alumno existente
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.cargarAlumnos(); // Recargar la lista después de cerrar el formulario
      }
    });
  }

  ngOnInit(): void {
    this.cargarAlumnos();
  }

  cargarAlumnos() {
    this.alumnosService.getAlumnos().subscribe(
      res => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator; // Activar paginación
        this.dataSource.sort = this.sort;       // Activar ordenación
      },
      err => console.error(err)
    );
  }

  anadirAlumno() {
    
  }

  editarAlumno(alumno: any) {
    // Aquí iría la lógica para editar el alumno, como abrir un diálogo con un formulario
    alert(`Editar alumno: ${alumno.nombre} ${alumno.apellidos}`);
  }

  eliminarAlumno(id: number) {
    if (confirm('¿Estás seguro de que deseas eliminar este alumno?')) {
      this.alumnosService.eliminarAlumno(id).subscribe(
        res => {
          alert('Alumno eliminado correctamente');
          this.cargarAlumnos(); // Recargar la lista después de eliminar
        },
        err => console.error(err)
      );
    }
  }

  aplicarFiltro(event: Event) {
    const valor = (event.target as HTMLInputElement).value;
    this.dataSource.filter = valor.trim().toLowerCase();
  }
}