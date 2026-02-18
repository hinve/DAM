import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog } from '@angular/material/dialog';
import { VacantesService } from '../services/vacantes.service';
import { FormVacanteComponent } from '../form-vacante/form-vacante.component';
import { GestionAlumnosComponent } from './gestion-alumnos/gestion-alumnos.component';

@Component({
  selector: 'app-vacantes',
  templateUrl: './vacantes.component.html',
  styleUrls: ['./vacantes.component.scss']
})
export class VacantesComponent implements OnInit, AfterViewInit {

  // columnas a mostrar en la tabla
  displayedColumns: string[] = ['entidad', 'ciclo', 'curso', 'num_vacantes', 'num_alumnos', 'acciones'];
  // libro
  dataSource = new MatTableDataSource<any>([]);

  // en vez de ver el libro entero ves las paginas
  @ViewChild(MatPaginator) paginator: MatPaginator;

  // indice del libro
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private vacantesService: VacantesService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this.cargarVacantes();
  }

  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  cargarVacantes() {
    this.vacantesService.getVacantes().subscribe(
      res => {
        this.dataSource.data = res;
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      err => console.error('Error cargando vacantes:', err)
    );
  }

  crearVacante() {
    const dialogRef = this.dialog.open(FormVacanteComponent, {
      data: null,
      width: '500px'
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.cargarVacantes();
      }
    });
  }

  editarVacante(vacante: any) {
    const dialogRef = this.dialog.open(FormVacanteComponent, {
      data: vacante,
      width: '500px'
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.cargarVacantes();
      }
    });
  }

  eliminarVacante(id: number) {
    if (confirm('¿Seguro que quieres borrar esta vacante?')) {
      this.vacantesService.eliminarVacante(id).subscribe(
        () => {
          this.cargarVacantes();
        },
        err => console.error(err)
      );
    }
  }

  aplicarFiltro(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  gestionarAlumnos(vacante: any) {
  const dialogRef = this.dialog.open(GestionAlumnosComponent, {
    width: '800px', // Un poco más ancho para que quepan las dos listas
    data: vacante
  });

  dialogRef.afterClosed().subscribe(result => {
    if (result) {
      this.cargarVacantes(); // Refrescar los contadores
    }
  });
}
}
