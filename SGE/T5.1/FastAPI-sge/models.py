from sqlalchemy import Column, Date, Integer, String, Text
from database import Base

class Usuario(Base):
    __tablename__ = "sgi_usuarios"
    id_usuario = Column(Integer, primary_key=True)
    usuario = Column(String(20))
    token_sesion = Column(String(255))
    
class SgiAlumno(Base):
    # nombre tabla
    __tablename__ = "sgi_alumnos"
    
    # columnas
    id_alumno = Column(Integer, primary_key=True)
    nif_nie = Column(String(20))
    nombre = Column(String(100))
    apellidos = Column(String(150))
    fecha_nacimiento = Column(Date)
    
    # claves foraneas
    id_entidad = Column(Integer)
    id_ciclo = Column(Integer)
    curso = Column(Integer)
    
    telefono = Column(String(20))
    direccion = Column(String(255))
    localidad = Column(String(100))
    id_provincia = Column(Integer)
    observaciones = Column(Text)