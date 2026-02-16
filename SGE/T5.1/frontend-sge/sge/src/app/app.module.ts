import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';
import { NavbarModule } from './shared/navbar/navbar.module';
import { AuthInterceptor } from './shared/interceptor.service';
import { FooterModule } from '../app/shared/footer/footer.module';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule, MatOptionModule } from '@angular/material/core';

import { DatosEntidadComponent } from './entidades/datos-entidad/datos-entidad.component'
import { DatosReunionComponent } from './reuniones/datos-reunion/datos-reunion.component';
import { AlumnosComponent } from './alumnos/alumnos.component';
import { VacantesComponent } from './vacantes/vacantes.component'
import { MatPaginatorModule } from "@angular/material/paginator";
import { MatIconModule } from "@angular/material/icon";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatTableModule } from "@angular/material/table";
import { MatSortModule } from "@angular/material/sort";
import { MatInputModule } from "@angular/material/input";
import { MatSelectModule } from "@angular/material/select";
import { MatButtonModule } from "@angular/material/button";
import { FormAlumnoComponent } from './alumnos/form-alumno/form-alumno.component';
import { FormVacanteComponent } from './form-vacante/form-vacante.component';
import { ReactiveFormsModule } from '@angular/forms';
import { FormsModule } from '@angular/forms';
import { MatDialogModule } from "@angular/material/dialog";
import { GestionAlumnosComponent } from './vacantes/gestion-alumnos/gestion-alumnos.component';
import { MatListModule } from "@angular/material/list";

// import { NgxLoadingXModule, POSITION, SPINNER, NgxLoadingXConfig } from 'ngx-loading-x';

// const ngxLoadingXConfig: NgxLoadingXConfig = {
//   show: false,
//   bgBlur: 2,
//   bgColor: 'rgba(40, 40, 40, 0.5)',
//   bgOpacity: 5,
//   bgLogoUrl: '',
//   bgLogoUrlPosition: POSITION.topLeft,
//   bgLogoUrlSize: 100,
//   spinnerType: SPINNER.wanderingCubes,
//   spinnerSize: 120,
//   spinnerColor: '#dd0031',
//   spinnerPosition: POSITION.centerCenter,
// }

@NgModule({
  declarations: [
    AppComponent,
    AlumnosComponent,
    VacantesComponent,
    FormAlumnoComponent,
    FormVacanteComponent,
    GestionAlumnosComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    HttpClientModule,
    NavbarModule,
    FooterModule,
    MatDatepickerModule,
    MatNativeDateModule
    // NgxLoadingXModule.forRoot(ngxLoadingXConfig)
    ,
    MatPaginatorModule,
    MatIconModule,
    MatFormFieldModule,
    MatTableModule,
    MatSortModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    ReactiveFormsModule,
    FormsModule,
    MatDialogModule,
    MatOptionModule,
    MatListModule,
],
  providers: [
    CookieService,
    { provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true },
    DatosEntidadComponent,
    DatosReunionComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
