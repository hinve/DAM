from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import select
import auth
from models import SgiVacantes, SgiAlumno, SgiVacanteAlumno
from schemas import AlumnoResponse, VacanteResponse, VacanteCreate
from database import get_db


router = APIRouter(
    prefix="/vacantes",
    tags=["vacantes"],
    dependencies=[Depends(auth.get_current_user)]
)

@router.get("/", response_model=list[VacanteResponse])
def listar_vacantes(db: Session = Depends(get_db)):
    """
    Obtiene la lista de todas las vacantes, incluyendo el número de alumnos y sus nombres asignados a cada vacante.
    """
    vacantes = db.query(SgiVacantes).options(joinedload(SgiVacantes.entidad), joinedload(SgiVacantes.ciclo)).all()
    num_alumnos = {vacante.id_vacante: len(vacante.alumnos) for vacante in vacantes}
    listado_alumnos = {vacante.id_vacante: [f"{alumno.alumno.nombre} {alumno.alumno.apellidos}" for alumno in vacante.alumnos] for vacante in vacantes}
    
    for vacante in vacantes:
        vacante.num_alumnos = num_alumnos[vacante.id_vacante]
        vacante.listado_alumnos = listado_alumnos[vacante.id_vacante]
    
    return vacantes

@router.post("/", response_model=VacanteResponse, status_code=201)
def crear_vacante(vacante: VacanteCreate, db: Session = Depends(get_db)):
    """
    Crea una nueva vacante si no existe ya una para la misma entidad, ciclo y curso.
    Devuelve la vacante creada.
    """
    if db.query(SgiVacantes).filter(
        SgiVacantes.id_entidad == vacante.id_entidad,
        SgiVacantes.id_ciclo == vacante.id_ciclo,
        SgiVacantes.curso == vacante.curso
    ).first():
        raise HTTPException(status_code=400, detail="Ya existe una vacante para esa entidad, ciclo y curso")
    nueva_vacante = SgiVacantes(
        id_entidad=vacante.id_entidad,
        id_ciclo=vacante.id_ciclo,
        curso=vacante.curso,
        num_vacantes=vacante.num_vacantes,
        observaciones=vacante.observaciones
    )
    db.add(nueva_vacante)
    db.commit()
    db.refresh(nueva_vacante)
    
    nueva_vacante.num_alumnos = 0
    nueva_vacante.listado_alumnos = []
    
    return nueva_vacante

@router.get("/{vacante_id}", response_model=VacanteResponse)
def obtener_vacante(vacante_id: int, db: Session = Depends(get_db)):
    """
    Obtiene la información detallada de una vacante por su ID, incluyendo alumnos asignados.
    """
    vacante = db.query(SgiVacantes).options(joinedload(SgiVacantes.entidad), joinedload(SgiVacantes.ciclo)).filter(SgiVacantes.id_vacante == vacante_id).first()
    
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")
    
    vacante.num_alumnos = len(vacante.alumnos)
    vacante.listado_alumnos = [f"{alumno.alumno.nombre} {alumno.alumno.apellidos}" for alumno in vacante.alumnos]
    
    return vacante

@router.put("/{vacante_id}", response_model=VacanteResponse)
def actualizar_vacante(vacante_id: int, vacante_data: VacanteCreate, db: Session = Depends(get_db)):
    """
    Actualiza los datos de una vacante existente por su ID.
    Valida que no exista duplicidad para entidad, ciclo y curso.
    Devuelve la vacante actualizada.
    """
    vacante = db.query(SgiVacantes).filter(SgiVacantes.id_vacante == vacante_id).first()
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")

    duplicada = db.query(SgiVacantes).filter(
        SgiVacantes.id_entidad == vacante_data.id_entidad,
        SgiVacantes.id_ciclo == vacante_data.id_ciclo,
        SgiVacantes.curso == vacante_data.curso,
        SgiVacantes.id_vacante != vacante_id
    ).first()
    if duplicada:
        raise HTTPException(status_code=400, detail="Ya existe una vacante para esa entidad, ciclo y curso")

    vacante.id_entidad = vacante_data.id_entidad # type: ignore
    vacante.id_ciclo = vacante_data.id_ciclo # type: ignore
    vacante.curso = vacante_data.curso # type: ignore
    vacante.num_vacantes = vacante_data.num_vacantes # type: ignore
    vacante.observaciones = vacante_data.observaciones # type: ignore

    db.commit()
    db.refresh(vacante)

    vacante.num_alumnos = len(vacante.alumnos)
    vacante.listado_alumnos = [f"{va.alumno.nombre} {va.alumno.apellidos}" for va in vacante.alumnos]

    return vacante

@router.delete("/{vacante_id}", status_code=204)
def eliminar_vacante(vacante_id: int, db: Session = Depends(get_db)):
    """
    Elimina una vacante por su ID si no tiene alumnos asignados.
    """
    vacante = db.query(SgiVacantes).filter(SgiVacantes.id_vacante == vacante_id).first()
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")
    if len(vacante.alumnos) > 0:
        raise HTTPException(status_code=400, detail="No se puede eliminar una vacante con alumnos asignados")
    db.delete(vacante)
    db.commit()
    
@router.post("/{vacante_id}/asignar-alumno/{alumno_id}", status_code=204)
def asignar_alumno_a_vacante(vacante_id: int, alumno_id: int, db: Session = Depends(get_db)):
    """
    Asigna un alumno a una vacante si cumple los requisitos de ciclo, curso y disponibilidad.
    """
    vacante = db.query(SgiVacantes).filter(SgiVacantes.id_vacante == vacante_id).first()
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")
    
    alumno = db.query(SgiAlumno).filter(SgiAlumno.id_alumno == alumno_id).first()
    if not alumno:
        raise HTTPException(status_code=404, detail="Alumno no encontrado")
    
    if db.query(SgiVacanteAlumno).filter(SgiVacanteAlumno.id_alumno == alumno_id).first():
        raise HTTPException(status_code=400, detail="El alumno ya tiene asignada una vacante")
    
    if alumno.id_ciclo != vacante.id_ciclo: # type: ignore
        raise HTTPException(status_code=400, detail="El ciclo del alumno no coincide con el ciclo de la vacante")
    
    if alumno.curso != vacante.curso: # type: ignore
        raise HTTPException(status_code=400, detail="El curso del alumno no coincide con el curso de la vacante")
    
    if len(vacante.alumnos) >= vacante.num_vacantes: # type: ignore
        raise HTTPException(status_code=400, detail="No hay vacantes disponibles")
    
    asignacion = SgiVacanteAlumno(id_vacante=vacante_id, id_alumno=alumno_id)
    db.add(asignacion)
    db.commit()
    
@router.delete("/{vacante_id}/alumnos/{alumno_id}", status_code=204)
def quitar_alumno(vacante_id: int, alumno_id: int, db: Session = Depends(get_db)):
    """
    Quita la relación entre un alumno y una vacante.
    """
    relacion = db.query(SgiVacanteAlumno).filter(
        SgiVacanteAlumno.id_vacante == vacante_id,
        SgiVacanteAlumno.id_alumno == alumno_id
    ).first()
    if not relacion:
        raise HTTPException(status_code=404, detail="Relacion no encontrada")
    db.delete(relacion)
    db.commit()
    
@router.get("/{vacante_id}/alumnos-disponibles", response_model=list[AlumnoResponse])
def listar_alumnos_disponibles(vacante_id: int, db: Session = Depends(get_db)):
    """
    Devuelve la lista de alumnos disponibles para ser asignados a una vacante concreta (mismo ciclo y curso, y sin vacante asignada).
    """
    vacante = db.query(SgiVacantes).filter(SgiVacantes.id_vacante == vacante_id).first()
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")
    
    # Obtener alumnos YA asignados a CUALQUIER vacante (no solo a esta)
    alumnos_ocupados_ids = db.query(SgiVacanteAlumno.id_alumno).all()
    lista_ocupados = [id_[0] for id_ in alumnos_ocupados_ids]

    alumnos_disponibles = db.query(SgiAlumno).filter(
        SgiAlumno.id_ciclo == vacante.id_ciclo, # type: ignore
        SgiAlumno.curso == vacante.curso, # type: ignore
        ~SgiAlumno.id_alumno.in_(lista_ocupados) # Excluir a cualquiera que ya tenga vacante
    ).all()
    
    return alumnos_disponibles

@router.get("/{vacante_id}/alumnos-asignados", response_model=list[AlumnoResponse])
def listar_alumnos_asignados(vacante_id: int, db: Session = Depends(get_db)):
    """
    Devuelve la lista de alumnos asignados a una vacante concreta.
    """
    vacante = db.query(SgiVacantes).filter(SgiVacantes.id_vacante == vacante_id).first()
    if not vacante:
        raise HTTPException(status_code=404, detail="Vacante no encontrada")
    
    # Extraemos el objeto 'alumno' de la relación intermedia
    alumnos = [rel.alumno for rel in vacante.alumnos] 
    return alumnos