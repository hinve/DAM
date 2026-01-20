import socket
import os
import random

 

# 1. Crear el socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

 

# 2. Enlazar el socket a una dirección y puerto

server_address = ('0.0.0.0', 2017)  # Escuchar en todas las interfaces

server_socket.bind(server_address)

 

# 3. Poner el socket en modo escucha

server_socket.listen(5)  # Permite hasta 5 conexiones 

 

print(f"Servidor escuchando en {server_address}")

script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, 'quote_of_the_day_flat.txt')

with open(file_path, 'r') as archivo:
    cita = archivo.read().splitlines()
    


while True:

    # 4. Aceptar conexiones

    client_socket, client_address = server_socket.accept()

    print(f"Conexión aceptada de {client_address}")

    

    # 5. Manejar la conexión

    data = client_socket.recv(1024).decode('utf-8')  # Recibir datos
    citaRandom = cita[random.randint(0, len(cita) - 1)]

    print(f"Datos recibidos: {data}")

    response = "Mensaje recibido"

    client_socket.sendall(citaRandom.encode('utf-8'))  # Enviar cita aleatoria
    client_socket.close()
