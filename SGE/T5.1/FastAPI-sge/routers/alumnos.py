from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import select
import auth
from models import SgiAlumno, SgiEntidades
from schemas import AlumnoResponse, AlumnoCreate
from database import get_db
from datetime import date

router = APIRouter(
    prefix="/alumnos",
    tags=["alumnos"],
    dependencies=[Depends(auth.get_current_user)]
)

@router.get("/", response_model=list[AlumnoResponse])
def listar_alumnos(db: Session = Depends(get_db)):
    """
    Obtiene la lista de todos los alumnos registrados en la base de datos.
    Incluye información de entidad, ciclo y provincia asociada a cada alumno.
    """
    alumnos = db.query(SgiAlumno).options(joinedload(SgiAlumno.entidad), joinedload(SgiAlumno.ciclo), joinedload(SgiAlumno.provincia)).all()
    
    return alumnos

@router.get("/alumnos/buscar")
def obtener_id_por_nombre_apellidos(
    nombre: str,
    apellidos: str,
    db: Session = Depends(get_db)
):
    """
    Busca el ID de un alumno a partir de su nombre y apellidos.
    Devuelve el id_alumno si existe un único alumno con ese nombre y apellidos.
    Lanza error si hay más de uno o si no se encuentra.
    """
    alumno = db.query(SgiAlumno).filter(
        SgiAlumno.nombre == nombre,
        SgiAlumno.apellidos == apellidos
    ).first()

    if len(alumno) > 1:
        raise HTTPException(status_code=400, detail="Más de un alumno con ese nombre")

    if not alumno:
        raise HTTPException(status_code=404, detail="Alumno no encontrado")

    return {"id_alumno": alumno.id_alumno}

@router.get("/{alumno_id}", response_model=AlumnoResponse)
def obtener_alumno(alumno_id: int, db: Session = Depends(get_db)):
    """
    Obtiene la información detallada de un alumno por su ID.
    Incluye datos de entidad, ciclo y provincia asociada.
    """
    alumno = db.query(SgiAlumno).options(joinedload(SgiAlumno.entidad), joinedload(SgiAlumno.ciclo), joinedload(SgiAlumno.provincia)).filter(SgiAlumno.id_alumno == alumno_id).first()
    
    if not alumno:
        raise HTTPException(status_code=404, detail="Alumno no encontrado")
    
    return alumno

@router.post("/", response_model=AlumnoResponse, status_code=201)
def crear_alumno(alumno: AlumnoCreate, db: Session = Depends(get_db)):
    """
    Crea un nuevo alumno en la base de datos.
    Valida que el DNI/NIE sea único, la fecha de nacimiento sea válida y la entidad sea un centro educativo.
    Devuelve el alumno creado.
    """
    # 1) Validar DNI/NIE único
    existing_alumno = db.query(SgiAlumno).filter(SgiAlumno.nif_nie == alumno.nif_nie).first()
    if existing_alumno:
        raise HTTPException(status_code=400, detail="El DNI/NIE ya existe")
    # 2) Validar fecha_nacimiento < hoy
    if alumno.fecha_nacimiento >= date.today():
        raise HTTPException(status_code=400, detail="La fecha de nacimiento debe ser anterior a hoy")
    # 3) Validar que la entidad sea de tipo 'centro_educativo'
    entidad = db.query(SgiEntidades).filter(SgiEntidades.id_entidad == alumno.id_entidad).first()
    if not entidad:
        raise HTTPException(status_code=400, detail="Entidad no encontrada")
    if entidad.id_tipo_entidad != 1: # type: ignore
        raise HTTPException(status_code=400, detail="La entidad debe ser un centro educativo")
    
    # 3) Crear objeto SgiAlumno
    nuevo_alumno = SgiAlumno(
        nif_nie=alumno.nif_nie,
        nombre=alumno.nombre,
        apellidos=alumno.apellidos,
        fecha_nacimiento=alumno.fecha_nacimiento,
        id_entidad=alumno.id_entidad,
        id_ciclo=alumno.id_ciclo,
        curso=alumno.curso,
        telefono=alumno.telefono,
        direccion=alumno.direccion,
        localidad=alumno.localidad,
        id_provincia=alumno.id_provincia,
        observaciones=alumno.observaciones
    )
    # 4) db.add / db.commit / db.refresh
    db.add(nuevo_alumno)
    db.commit()
    db.refresh(nuevo_alumno)
    # 5) Devolver el alumno creado
    return nuevo_alumno

@router.put("/{alumno_id}", response_model=AlumnoResponse)
def actualizar_alumno(alumno_id: int, alumno: AlumnoCreate, db: Session = Depends(get_db)):
    """
    Actualiza los datos de un alumno existente por su ID.
    Valida la unicidad del DNI/NIE y la fecha de nacimiento.
    Devuelve el alumno actualizado.
    """
    alumno_db = db.query(SgiAlumno).filter(SgiAlumno.id_alumno == alumno_id).first()
    
    if not alumno_db:
        raise HTTPException(status_code=404, detail="Alumno no encontrado")
    
    # Validar DNI/NIE único (si se ha cambiado)
    if alumno.nif_nie != alumno_db.nif_nie:
        existing_alumno = db.query(SgiAlumno).filter(SgiAlumno.nif_nie == alumno.nif_nie).first()
        if existing_alumno:
            raise HTTPException(status_code=400, detail="El DNI/NIE ya existe")
    
    # Validar fecha_nacimiento < hoy
    if alumno.fecha_nacimiento >= date.today():
        raise HTTPException(status_code=400, detail="La fecha de nacimiento debe ser anterior a hoy")
    
    # Actualizar campos
    db.query(SgiAlumno).filter(SgiAlumno.id_alumno == alumno_id).update({
        SgiAlumno.nif_nie: alumno.nif_nie,
        SgiAlumno.nombre: alumno.nombre,
        SgiAlumno.apellidos: alumno.apellidos,
        SgiAlumno.fecha_nacimiento: alumno.fecha_nacimiento,
        SgiAlumno.id_entidad: alumno.id_entidad,
        SgiAlumno.id_ciclo: alumno.id_ciclo,
        SgiAlumno.curso: alumno.curso,
        SgiAlumno.telefono: alumno.telefono,
        SgiAlumno.direccion: alumno.direccion,
        SgiAlumno.localidad: alumno.localidad,
        SgiAlumno.id_provincia: alumno.id_provincia,
        SgiAlumno.observaciones: alumno.observaciones
    })
    
    db.commit()
    db.refresh(alumno_db)
    
    return alumno_db

@router.delete("/{alumno_id}", status_code=204)
def eliminar_alumno(alumno_id: int, db: Session = Depends(get_db)):
    """
    Elimina un alumno de la base de datos por su ID.
    Devuelve un mensaje de confirmación si la operación es exitosa.
    """
    alumno_db = db.query(SgiAlumno).filter(SgiAlumno.id_alumno == alumno_id).first()
    
    if not alumno_db:
        raise HTTPException(status_code=404, detail="Alumno no encontrado")
    
    db.delete(alumno_db)
    db.commit()
    
    return {"mensaje": "Alumno eliminado correctamente"}