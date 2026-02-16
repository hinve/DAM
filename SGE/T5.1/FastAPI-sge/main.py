from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
import auth
from routers import alumnos, vacantes

# inicializar el fastAPi
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True
)

app.include_router(alumnos.router) # Registrar las rutas del router
app.include_router(vacantes.router)

@app.get("/verificar-token")
def verificar_token(user = Depends(auth.get_current_user)):
    return {
        "mensaje": "Token valido",
        "usuario": user.usuario,
        "id": user.id_usuario
    }
    
