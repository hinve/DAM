from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
import auth

# inicializar el fastAPi
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"]
)

@app.get("/verificar-token")
def verificar_token(user = Depends(auth.get_current_user)):
    return {
        "mensaje": "Token valido",
        "usuario": user.usuario,
        "id": user.id_usuario
    }
    
