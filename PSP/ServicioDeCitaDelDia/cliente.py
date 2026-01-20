import socket

# 1. Crear el socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 2. Conectar al servidor
server_address = ('127.0.0.1', 2017)
print(f"Conectando a {server_address}...")
client_socket.connect(server_address)

try:
    # 3. Enviar datos (el servidor espera recibir algo antes de responder)
    message = "Hola, dame una cita"
    print(f"Enviando: {message}")
    client_socket.sendall(message.encode('utf-8'))

    # 4. Recibir respuesta
    data = client_socket.recv(1024)
    print(f"Cita del día recibida: {data.decode('utf-8')}")

finally:
    # 5. Cerrar la conexión
    print("Cerrando conexión")
    client_socket.close()
