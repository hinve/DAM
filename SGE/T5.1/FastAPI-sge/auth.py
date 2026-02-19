from fastapi import Depends, HTTPException
from fastapi.security import APIKeyHeader
from sqlalchemy.orm import Session
from database import get_db
from models import Usuario

# api_key_header sirve para sacar el token de la cabecera Authorization. auto_error=False hace que no se lance un error automáticamente si no se encuentra la cabecera, sino que se devuelva None
api_key_header = APIKeyHeader(name="Authorization", auto_error=False, scheme_name="Token PHP")

def get_current_user(token_header: str = Depends(api_key_header), db: Session = Depends(get_db)):
    
    print(f"DEBUG AUTH: Header received: '{token_header}'") # DEBUG PRINT

    # si no existe el token pues un error 401
    if not token_header:
        print("DEBUG AUTH: No token header provided")
        raise HTTPException(status_code=401, detail="Token no proporcionado")
    
    # angular de por si manda el token con el prefijo Bearer asi que lo borro
    token = token_header.replace("Bearer ", "")
    print(f"DEBUG AUTH: Token parsed: '{token}'") # DEBUG PRINT

    # select para saber si el token existe ne la base d datos
    user = db.query(Usuario).filter(Usuario.token_sesion == token).first()
    
    # si no existe out
    if not user: 
        print(f"DEBUG AUTH: User not found for token: '{token}'") # DEBUG PRINT
        raise HTTPException(status_code=401, detail="Token inválido")
    
    return user # devolvermos el usuario q paso los filtros