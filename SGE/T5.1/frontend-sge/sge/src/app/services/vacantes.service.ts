import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { URL_FASTAPI } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class VacantesService {

  private apiUrl = `${URL_FASTAPI}/vacantes`;

  constructor(private http: HttpClient) { }

  getVacantes(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  getVacante(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }

  crearVacante(vacante: any): Observable<any> {
    return this.http.post<any>(this.apiUrl, vacante);
  }

  actualizarVacante(id: number, vacante: any): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/${id}`, vacante);
  }

  eliminarVacante(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`);
  }

  getAlumnosDisponibles(idVacante: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/${idVacante}/alumnos-disponibles`);
  }

  getAlumnosAsignados(idVacante: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/${idVacante}/alumnos-asignados`);
  }

  asignarAlumno(idVacante: number, idAlumno: number): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/${idVacante}/asignar-alumno/${idAlumno}`, {});
  }

  quitarAlumno(idVacante: number, idAlumno: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${idVacante}/alumnos/${idAlumno}`);
  }
}
