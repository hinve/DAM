from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
import auth
from routers import alumnos, vacantes, maestros

# inicializar el fastAPi
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:4200"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True
)

app.include_router(alumnos.router) # Registrar las rutas del router
app.include_router(vacantes.router)
app.include_router(maestros.router)

@app.get("/verificar-token")
def verificar_token(user = Depends(auth.get_current_user)):
    return {
        "mensaje": "Token valido",
        "usuario": user.usuario,
        "id": user.id_usuario
    }
    
