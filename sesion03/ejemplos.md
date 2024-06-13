### 1. Supervisión de Servicios

**Propósito:**
Verificar si ciertos servicios (como HTTP, SSH, HTTPS, etc.) están activos en una lista de servidores.

**Uso:**
- Se define una lista de servidores con sus respectivas direcciones IP y puertos.
- Para cada servidor y puerto en la lista, se intenta establecer una conexión.

**Utilidad:**
- **Monitoreo de Red:** Permite a los administradores de sistemas monitorear la disponibilidad de servicios críticos en su infraestructura de red.
- **Automatización:** Puede ser usado en scripts de automatización para verificar la disponibilidad de servicios antes de realizar otras operaciones dependientes.
- **Alertas:** Se puede integrar con sistemas de alerta para notificar a los administradores si un servicio no está disponible.

**Código:**
```python
import socket

def check_service(host, port):
    try:
        with socket.create_connection((host, port), timeout=2):
            print(f"Servicio en {host}:{port} está activo.")
    except (socket.timeout, ConnectionRefusedError):
        print(f"Servicio en {host}:{port} no está disponible.")

servers = [
    ('192.168.1.1', 80),
    ('192.168.1.2', 22),
    ('192.168.1.3', 443),
]

for host, port in servers:
    check_service(host, port)
```

### 2. Transferencia de Archivos

**Propósito:**
Transferir archivos entre un cliente y un servidor.

**Uso:**
- El servidor escucha conexiones entrantes y recibe un archivo desde el cliente.
- El cliente se conecta al servidor y envía un archivo.

**Utilidad:**
- **Distribución de Software:** Permite la distribución de archivos de software o actualizaciones a varios servidores o estaciones de trabajo.
- **Respaldo de Datos:** Facilita el respaldo y restauración de archivos entre sistemas.
- **Migración de Datos:** Útil para migrar archivos de un servidor a otro durante actualizaciones o cambios de hardware.

**Código:**

#### Servidor:
```python
import socket

def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', 65432))
    server_socket.listen(1)
    print("Servidor esperando conexiones...")

    conn, addr = server_socket.accept()
    print(f"Conectado por {addr}")

    with open('archivo_recibido.txt', 'wb') as file:
        while True:
            data = conn.recv(1024)
            if not data:
                break
            file.write(data)
    
    conn.close()
    server_socket.close()
    print("Archivo recibido y servidor cerrado.")

if __name__ == "__main__":
    start_server()
```

#### Cliente:
```python
import socket

def send_file():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 65432))

    with open('archivo_enviar.txt', 'rb') as file:
        for data in file:
            client_socket.sendall(data)

    client_socket.close()
    print("Archivo enviado y cliente cerrado.")

if __name__ == "__main__":
    send_file()
```

### 3. Ejecución Remota de Comandos

**Propósito:**
Permitir la ejecución remota de comandos en un servidor desde un cliente.

**Uso:**
- El servidor espera y ejecuta comandos recibidos del cliente.
- El cliente envía comandos al servidor y recibe los resultados.

**Utilidad:**
- **Gestión Remota:** Facilita la gestión remota de servidores sin necesidad de una sesión SSH completa.
- **Automatización de Tareas:** Permite la automatización de tareas administrativas, como actualizaciones de software o recolección de información del sistema.
- **Solución de Problemas:** Útil para solucionar problemas en servidores remotos ejecutando comandos diagnósticos.

**Código:**

#### Servidor:
```python
import socket
import subprocess

def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', 65432))
    server_socket.listen(1)
    print("Servidor esperando conexiones...")

    conn, addr = server_socket.accept()
    print(f"Conectado por {addr}")

    while True:
        command = conn.recv(1024).decode('utf-8')
        if not command or command.lower() == 'exit':
            break

        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        response = result.stdout + result.stderr
        conn.sendall(response.encode('utf-8'))
    
    conn.close()
    server_socket.close()
    print("Servidor cerrado.")

if __name__ == "__main__":
    start_server()
```

#### Cliente:
```python
import socket

def send_command():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 65432))

    while True:
        command = input("Ingrese el comando a ejecutar (o 'exit' para salir): ")
        if command.lower() == 'exit':
            break

        client_socket.sendall(command.encode('utf-8'))
        response = client_socket.recv(4096).decode('utf-8')
        print(response)

    client_socket.close()
    print("Cliente cerrado.")

if __name__ == "__main__":
    send_command()
```

### 4. Recolección de Registros

**Propósito:**
Recolectar registros generados en varios servidores y enviarlos a un servidor central para su almacenamiento y análisis.

**Uso:**
- El servidor recibe y almacena registros enviados por los clientes.
- Los clientes envían registros generados localmente al servidor.

**Utilidad:**
- **Centralización de Registros:** Permite centralizar los registros de varios sistemas para un análisis más fácil y completo.
- **Monitoreo y Auditoría:** Facilita el monitoreo y auditoría de actividades en múltiples servidores desde una ubicación central.
- **Análisis y Reportes:** Mejora la capacidad para generar informes y análisis de datos a partir de registros centralizados.

**Código:**

#### Servidor:
```python
import socket

def start_log_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', 65432))
    server_socket.listen(5)
    print("Servidor de registros esperando conexiones...")

    while True:
        conn, addr = server_socket.accept()
        print(f"Conectado por {addr}")

        with open('servidor_registros.log', 'a') as log_file:
            while True:
                data = conn.recv(1024).decode('utf-8')
                if not data:
                    break
                log_file.write(data + '\n')

        conn.close()

if __name__ == "__main__":
    start_log_server()
```

#### Cliente:
```python
import socket
import time

def send_logs():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 65432))

    logs = [
        "2024-06-13 12:00:01 INFO Inicio del sistema",
        "2024-06-13 12:00:02 ERROR Error en el módulo X",
        "2024-06-13 12:00:03 INFO Proceso completado exitosamente",
    ]

    for log in logs:
        client_socket.sendall(log.encode('utf-8'))
        time.sleep(1)

    client_socket.close()
    print("Registros enviados y cliente cerrado.")

if __name__ == "__main__":
    send_logs()
```