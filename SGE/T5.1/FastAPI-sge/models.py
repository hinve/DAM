from sqlalchemy import Column, Date, ForeignKey, Integer, String, Text, UniqueConstraint
from sqlalchemy.orm import relationship
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
    id_entidad = Column(Integer, ForeignKey("sgi_entidades.id_entidad"))
    id_ciclo = Column(Integer, ForeignKey("sgi_ciclos.id_ciclo"))
    
    curso = Column(Integer)
    telefono = Column(String(20))
    direccion = Column(String(255))
    localidad = Column(String(100))
    id_provincia = Column(Integer, ForeignKey("sgi_provincias.id_provincia"))
    observaciones = Column(Text)
    
    # relaciones
    entidad = relationship("SgiEntidades", back_populates="alumnos")
    ciclo = relationship("SgiCiclos", back_populates="alumnos")
    provincia = relationship("SgiProvincias")
    
    
class SgiEntidades(Base):
    
    __tablename__ = "sgi_entidades"
    
    id_entidad = Column(Integer, primary_key=True)
    entidad = Column(String(50))
    id_zona = Column(Integer)
    id_contacto = Column(Integer)
    id_tipo_entidad = Column(Integer)
    direccion = Column(String(100))
    cp = Column(String(10))
    localidad = Column(String(50))
    id_provincia = Column(Integer)
    telefono = Column(String(15))
    email = Column(String(100))
    web = Column(String(100))
    codigo = Column(String(50))
    observaciones = Column(Text)
    
    # Relación inversa
    alumnos = relationship("SgiAlumno", back_populates="entidad")
    
class SgiCiclos(Base):
    
    __tablename__ = "sgi_ciclos"
    
    id_ciclo = Column(Integer, primary_key=True)
    ciclo = Column(String(150))
    cod_ciclo = Column(String(10))
    id_nivel = Column(Integer)
    id_familia = Column(Integer)
    observaciones = Column(Text)
    
    # Relación inversa
    alumnos = relationship("SgiAlumno", back_populates="ciclo")
    
class SgiVacantes(Base):
    
    __tablename__ = "sgi_vacantes"
    
    id_vacante = Column(Integer, primary_key=True)
    id_entidad = Column(Integer, ForeignKey("sgi_entidades.id_entidad"))
    id_ciclo = Column(Integer, ForeignKey("sgi_ciclos.id_ciclo"))
    curso = Column(Integer)
    num_vacantes = Column(Integer)
    observaciones = Column(Text)
    
    entidad = relationship("SgiEntidades")
    ciclo = relationship("SgiCiclos")
    alumnos = relationship("SgiVacanteAlumno", back_populates="vacante")
    
    __table_args__ = (
        UniqueConstraint('id_entidad', 'id_ciclo', 'curso', name='uq_vacante_entidad_ciclo_curso'),
    )
    
class SgiVacanteAlumno(Base):
    
    __tablename__ = "sgi_vacantes_X_alumnos"
    
    id_vacante_x_alumno = Column(Integer, primary_key=True)
    id_vacante = Column(Integer, ForeignKey("sgi_vacantes.id_vacante"))
    id_alumno = Column(Integer, ForeignKey("sgi_alumnos.id_alumno"))
    
    vacante = relationship("SgiVacantes", back_populates="alumnos")
    alumno = relationship("SgiAlumno")
    
    __table_args__ = (
        UniqueConstraint('id_alumno', name='uq_vacante_alumno'),
    )

class SgiProvincias(Base):
    
    __tablename__ = "sgi_provincias"
    
    id_provincia = Column(Integer, primary_key=True)
    ine_provincia = Column(Integer)
    siglas_provincia = Column(String(2))
    provincia = Column(String(50))
    observaciones = Column(Text)