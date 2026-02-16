from sqlalchemy import create_engine # metodo para crear el motor que se comunica con la bbdd y gestiona el pool de conexiones
from sqlalchemy.orm import sessionmaker # metodo para crear sesiones de la bbdd, es decir, conexiones a la bbdd (donde viven los objetos de python)
from sqlalchemy.ext.declarative import declarative_base # metodo para crear la clase base de la que heredaran los modelos, esta clase se encarga de mapear las clases de python a las tablas de la bbdd

# url hacia la base de datos
SQLACHEMY_DATABASE_URL = "mysql+mysqlconnector://app_radfpd:0dTtnIG!-WDZRC8k@192.168.10.115:3306/app_radfpd"

engine = create_engine(SQLACHEMY_DATABASE_URL) # mantiene un conjunto de conexiones para que no cerrar y abrir cada vez que se necesite una conexion
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine) # autocommit= no se hace significa que tienes que hacer db.commit() para guardar cambios, autoflush= no se hace significa q SQLAlchemy no hace cambios automaticamente dando mas control

Base = declarative_base() # clase de la que heredaran todos los modelos, se encarga de mapear las clases de python a las tablas de la bbdd

def get_db():
    db = SessionLocal()
    try:
        yield db # basicamente es como un return pero espera a que el endpoint termine de usar la conexion para cerrarla
    finally:
        db.close()