import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { URL_FASTAPI } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class MaestrosService {

  private apiUrl = `${URL_FASTAPI}/maestros`;

  constructor(private http: HttpClient) { }

  // Obtener lista completa de entidades (para desplegables)
  getEntidades(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/entidades`);
  }

  // Obtener lista completa de ciclos
  getCiclos(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/ciclos`);
  }

  // Obtener lista completa de provincias
  getProvincias(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/provincias`);
  }
}
