### Uso del Módulo `socket` en Python

#### Introducción

El módulo `socket` en Python proporciona una interfaz para trabajar con sockets de red, permitiendo la comunicación entre computadoras a través de redes. Los sockets son puntos finales de una comunicación bidireccional que se utilizan ampliamente en aplicaciones de red, como servidores web, clientes de correo electrónico y aplicaciones de mensajería.

### Fundamentos de los Sockets

Un socket es una combinación de una dirección IP y un número de puerto. Los sockets pueden ser de diferentes tipos, como:

1. **Stream Sockets (SOCK_STREAM):** Utilizados para conexiones TCP.
2. **Datagram Sockets (SOCK_DGRAM):** Utilizados para conexiones UDP.

### Creación de un Socket

Para crear un socket en Python, utilizamos la función `socket()` del módulo `socket`. Esta función toma dos parámetros:
- La familia de direcciones (por ejemplo, `AF_INET` para IPv4).
- El tipo de socket (por ejemplo, `SOCK_STREAM` para TCP).

```python
import socket

# Crear un socket TCP/IP
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```

### Conexión a un Servidor

Un cliente se conecta a un servidor utilizando la función `connect()`. Esta función toma una tupla que contiene la dirección IP del servidor y el número de puerto.

```python
server_address = ('localhost', 10000)
print(f"Conectando a {server_address[0]} puerto {server_address[1]}")
sock.connect(server_address)
```

### Enviar Datos

Para enviar datos a través de un socket, utilizamos la función `sendall()`. Esta función garantiza que todos los datos se envíen al servidor.

```python
try:
    message = 'Este es el mensaje. Se repetirá.'
    print(f"Enviando {message}")
    sock.sendall(message.encode())
```

### Recibir Datos

Para recibir datos de un socket, utilizamos la función `recv()`. Esta función bloquea la ejecución del programa hasta que se reciban datos.

```python
amount_received = 0
amount_expected = len(message)

while amount_received < amount_expected:
    data = sock.recv(16)
    amount_received += len(data)
    print(f"Recibido {data.decode()}")
```

### Cerrar el Socket

Una vez que la comunicación ha terminado, cerramos el socket utilizando la función `close()`.

```python
print("Cerrando el socket")
sock.close()
```

### Ejemplo Completo de un Cliente TCP

Aquí hay un ejemplo completo de un cliente TCP que envía un mensaje a un servidor y espera una respuesta.

```python
import socket

def cliente_tcp():
    # Crear un socket TCP/IP
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Conectar el socket a un puerto
    server_address = ('localhost', 10000)
    print(f"Conectando a {server_address[0]} puerto {server_address[1]}")
    sock.connect(server_address)

    try:
        # Enviar datos
        message = 'Este es el mensaje. Se repetirá.'
        print(f"Enviando {message}")
        sock.sendall(message.encode())

        # Recibir respuesta
        amount_received = 0
        amount_expected = len(message)

        while amount_received < amount_expected:
            data = sock.recv(16)
            amount_received += len(data)
            print(f"Recibido {data.decode()}")

    finally:
        print("Cerrando el socket")
        sock.close()

if __name__ == "__main__":
    cliente_tcp()
```

### Creación de un Servidor

Un servidor espera conexiones de clientes y procesa las solicitudes recibidas. A continuación, se describe cómo crear un servidor básico.

#### Vincular el Socket

El servidor debe vincular su socket a una dirección IP y un puerto utilizando la función `bind()`.

```python
import socket

# Crear un socket TCP/IP
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Vincular el socket a la dirección y puerto
server_address = ('localhost', 10000)
print(f"Iniciando servidor en {server_address[0]} puerto {server_address[1]}")
sock.bind(server_address)
```

#### Escuchar Conexiones

El servidor escucha conexiones entrantes utilizando la función `listen()`. Puede especificar el número máximo de conexiones en cola.

```python
sock.listen(1)
```

#### Aceptar Conexiones

El servidor acepta una conexión entrante utilizando la función `accept()`, que devuelve un nuevo socket y la dirección del cliente.

```python
print("Esperando una conexión")
connection, client_address = sock.accept()
try:
    print(f"Conexión desde {client_address}")

    # Recibir datos en pequeños fragmentos y retransmitirlos
    while True:
        data = connection.recv(16)
        print(f"Recibido {data.decode()}")
        if data:
            print("Enviando datos de vuelta al cliente")
            connection.sendall(data)
        else:
            print("No hay más datos desde", client_address)
            break

finally:
    # Cerrar la conexión
    connection.close()
```

### Ejemplo Completo de un Servidor TCP

Aquí hay un ejemplo completo de un servidor TCP que acepta conexiones de clientes y envía de vuelta los datos recibidos.

```python
import socket

def servidor_tcp():
    # Crear un socket TCP/IP
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Vincular el socket a la dirección y puerto
    server_address = ('localhost', 10000)
    print(f"Iniciando servidor en {server_address[0]} puerto {server_address[1]}")
    sock.bind(server_address)

    # Escuchar conexiones entrantes
    sock.listen(1)

    while True:
        print("Esperando una conexión")
        connection, client_address = sock.accept()
        try:
            print(f"Conexión desde {client_address}")

            # Recibir datos en pequeños fragmentos y retransmitirlos
            while True:
                data = connection.recv(16)
                print(f"Recibido {data.decode()}")
                if data:
                    print("Enviando datos de vuelta al cliente")
                    connection.sendall(data)
                else:
                    print("No hay más datos desde", client_address)
                    break

        finally:
            # Cerrar la conexión
            connection.close()

if __name__ == "__main__":
    servidor_tcp()
```

### Comunicación UDP

UDP es un protocolo sin conexión que no garantiza la entrega de paquetes. Es útil para aplicaciones donde la velocidad es más importante que la confiabilidad.

#### Crear un Cliente UDP

```python
import socket

def cliente_udp():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    server_address = ('localhost', 10000)
    message = 'Este es el mensaje. Se repetirá.'

    try:
        print(f"Enviando {message}")
        sent = sock.sendto(message.encode(), server_address)

        print("Esperando recibir")
        data, server = sock.recvfrom(4096)
        print(f"Recibido {data.decode()}")

    finally:
        print("Cerrando el socket")
        sock.close()

if __name__ == "__main__":
    cliente_udp()
```

#### Crear un Servidor UDP

```python
import socket

def servidor_udp():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    server_address = ('localhost', 10000)
    print(f"Iniciando servidor en {server_address[0]} puerto {server_address[1]}")
    sock.bind(server_address)

    while True:
        print("Esperando recibir un mensaje")
        data, address = sock.recvfrom(4096)

        print(f"Recibido {len(data)} bytes de {address}")
        print(f"Datos: {data.decode()}")

        if data:
            sent = sock.sendto(data, address)
            print(f"Enviado {sent} bytes de vuelta a {address}")

if __name__ == "__main__":
    servidor_udp()
```

### Conclusión

El módulo `socket` en Python es una herramienta poderosa para la comunicación de red. Permite crear aplicaciones de red robustas, como clientes y servidores TCP/UDP, mediante una API simple y flexible. Dominar el uso de sockets es esencial para desarrollar aplicaciones de red eficientes y seguras.