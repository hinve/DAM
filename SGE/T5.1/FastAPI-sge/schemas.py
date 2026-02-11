from pydantic import BaseModel, Field
from typing import Optional
from datetime import date

# Schemas anidados para devolver datos relacionados
class EntidadSimple(BaseModel):
    id_entidad: int
    entidad: str  # ← Aquí va "Accenture"
    
    class Config:
        from_attributes = True

class CicloSimple(BaseModel):
    id_ciclo: int
    ciclo: str  # ← Aquí va "DAM"
    
    class Config:
        from_attributes = True

class ProvinciaSimple(BaseModel):
    id_provincia: int
    provincia: str  # ← Aquí va "Sevilla"
    
    class Config:
        from_attributes = True

class AlumnoCreate(BaseModel):
    nif_nie: str = Field(..., min_length=1, max_length=20)
    nombre: str = Field(..., min_length=1, max_length=100)
    apellidos: str = Field(..., min_length=1, max_length=150)
    fecha_nacimiento: date
    id_entidad: int
    id_ciclo: int
    curso: int
    telefono: Optional[str] = Field(None, max_length=20)
    direccion: Optional[str] = Field(None, max_length=255)
    localidad: Optional[str] = Field(None, max_length=100)
    id_provincia: Optional[int] = None
    observaciones: Optional[str] = None

class AlumnoResponse(BaseModel):
    id_alumno: int
    nif_nie: str
    nombre: str
    apellidos: str
    fecha_nacimiento: date
    entidad: EntidadSimple
    ciclo: CicloSimple
    curso: int
    telefono: Optional[str] = None
    direccion: Optional[str] = None
    localidad: Optional[str] = None
    provincia: Optional[ProvinciaSimple] = None
    observaciones: Optional[str] = None
    
    class Config:
        from_attributes = True

class VacanteCreate(BaseModel):
    id_entidad: int
    id_ciclo: int
    curso: int
    num_vacantes: int
    observaciones: Optional[str] = None
    
class VacanteResponse(BaseModel):
    id_vacante: int
    entidad: EntidadSimple
    ciclo: CicloSimple
    curso: int
    num_vacantes: int
    num_alumnos: int
    listado_alumnos: list[str] = Field(default_factory=list)
    observaciones: Optional[str] = None
    
    class Config:
        from_attributes = True
        
class VacanteAlumnoCreate(BaseModel):
    id_alumno: int