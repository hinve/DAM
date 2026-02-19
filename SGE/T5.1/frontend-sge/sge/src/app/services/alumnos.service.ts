import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { URL_FASTAPI } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AlumnosService {

  private apiUrl = `${URL_FASTAPI}/alumnos`;

  constructor(private http: HttpClient) { }

  getAlumnos(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  getAlumno(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }

  crearAlumno(alumno: any): Observable<any> {
    return this.http.post<any>(this.apiUrl, alumno);
  }

  actualizarAlumno(id: number, alumno: any): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/${id}`, alumno);
  }

  eliminarAlumno(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`);
  }

  buscarIdPorNombreYApellidos(nombre: string, apellidos: string): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/buscar`, {
      params: {
        nombre: nombre,
        apellidos: apellidos
      }
    });
  }
}
