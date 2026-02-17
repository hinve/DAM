from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
import auth
from models import SgiEntidades, SgiCiclos, SgiProvincias
from schemas import EntidadSimple, CicloSimple, ProvinciaSimple

router = APIRouter(
    prefix="/maestros",
    tags=["maestros"],
    dependencies=[Depends(auth.get_current_user)]
)

@router.get("/entidades", response_model=list[EntidadSimple])
def listar_entidades(db: Session = Depends(get_db)):
    return db.query(SgiEntidades).all()

@router.get("/ciclos", response_model=list[CicloSimple])
def listar_ciclos(db: Session = Depends(get_db)):
    return db.query(SgiCiclos).all()

@router.get("/provincias", response_model=list[ProvinciaSimple])
def listar_provincias(db: Session = Depends(get_db)):
    return db.query(SgiProvincias).all()
