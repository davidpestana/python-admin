### Laboratorio: Operaciones de Red con Python

#### Práctica 1: Crear un Script que Obtenga la Dirección IP de un Sitio Web

### Objetivos:
1. Aprender a obtener la dirección IP de un sitio web utilizando Python.
2. Utilizar el módulo `socket` para resolver nombres de dominio a direcciones IP.

### Paso 1: Introducción al Módulo `socket`

El módulo `socket` proporciona acceso a la interfaz de sockets de bajo nivel y se puede utilizar para realizar resoluciones DNS (convertir nombres de dominio en direcciones IP).

**Importar el Módulo `socket`:**

```python
import socket
```

### Paso 2: Resolver Nombres de Dominio

Usaremos `socket.gethostbyname()` para obtener la dirección IP de un sitio web.

**Ejemplo: Obtener la Dirección IP de un Sitio Web**

```python
import socket

def obtener_direccion_ip(sitio_web):
    try:
        direccion_ip = socket.gethostbyname(sitio_web)
        print(f"La dirección IP de {sitio_web} es {direccion_ip}")
    except socket.gaierror as error:
        print(f"No se puede obtener la dirección IP de {sitio_web}: {error}")

# Ejemplo de uso
obtener_direccion_ip('www.google.com')
```

- `socket.gethostbyname(sitio_web)` resuelve el nombre de dominio a una dirección IP.
- `socket.gaierror` maneja errores de resolución de direcciones.

### Ejemplo Completo: Obtener la Dirección IP

Combina todo lo aprendido en un script completo.

```python
import socket

def obtener_direccion_ip(sitio_web):
    try:
        direccion_ip = socket.gethostbyname(sitio_web)
        print(f"La dirección IP de {sitio_web} es {direccion_ip}")
    except socket.gaierror as error:
        print(f"No se puede obtener la dirección IP de {sitio_web}: {error}")

# Ejemplo de uso
if __name__ == "__main__":
    sitio_web = input("Introduce el nombre del sitio web: ")
    obtener_direccion_ip(sitio_web)
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `obtener_ip.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `obtener_ip.py`.
   - Ejecuta el script:

     ```shell
     python obtener_ip.py
     ```

3. **Interacción con el script:**
   - Introduce el nombre del sitio web cuando se te solicite.

---

#### Práctica 2: Escribir un Script para Realizar Solicitudes HTTP y Analizar Respuestas

### Objetivos:
1. Aprender a realizar solicitudes HTTP utilizando el módulo `requests`.
2. Analizar y procesar las respuestas de las solicitudes HTTP.

### Paso 1: Instalación del Módulo `requests`

Primero, asegúrate de que el módulo `requests` esté instalado. Si no lo tienes, puedes instalarlo usando `pip`.

```shell
pip install requests
```

### Paso 2: Realizar Solicitudes HTTP

Usaremos el módulo `requests` para realizar una solicitud HTTP y obtener la respuesta.

**Ejemplo Inicial: Solicitud GET**

```python
import requests

def realizar_solicitud_http(url):
    try:
        response = requests.get(url)
        print(f"Código de estado: {response.status_code}")
        print(f"Encabezados:\n{response.headers}")
        print(f"Cuerpo de la respuesta:\n{response.text[:500]}")  # Muestra los primeros 500 caracteres
    except requests.exceptions.RequestException as error:
        print(f"Error al realizar la solicitud: {error}")

# Ejemplo de uso
realizar_solicitud_http('https://www.google.com')
```

- `requests.get(url)` realiza una solicitud GET a la URL especificada.
- `response.status_code` devuelve el código de estado HTTP de la respuesta.
- `response.headers` devuelve los encabezados de la respuesta.
- `response.text` devuelve el cuerpo de la respuesta como una cadena de texto.

### Paso 3: Manejo de Errores

Es importante manejar posibles errores durante la solicitud HTTP.

**Ejemplo: Manejo de Errores**

```python
import requests

def realizar_solicitud_http(url):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Lanza una excepción para códigos de error HTTP
        print(f"Código de estado: {response.status_code}")
        print(f"Encabezados:\n{response.headers}")
        print(f"Cuerpo de la respuesta:\n{response.text[:500]}")  # Muestra los primeros 500 caracteres
    except requests.exceptions.HTTPError as http_err:
        print(f"Error HTTP: {http_err}")
    except requests.exceptions.ConnectionError as conn_err:
        print(f"Error de conexión: {conn_err}")
    except requests.exceptions.Timeout as timeout_err:
        print(f"Error de tiempo de espera: {timeout_err}")
    except requests.exceptions.RequestException as req_err:
        print(f"Error en la solicitud: {req_err}")

# Ejemplo de uso
realizar_solicitud_http('https://www.google.com')
```

### Paso 4: Enviar Datos en una Solicitud POST

A veces, necesitamos enviar datos a un servidor. Podemos usar el método `requests.post()`.

**Ejemplo: Enviar Datos con POST**

```python
import requests

def enviar_datos_post(url, datos):
    try:
        response = requests.post(url, data=datos)
        response.raise_for_status()
        print(f"Código de estado: {response.status_code}")
        print(f"Respuesta:\n{response.text}")
    except requests.exceptions.RequestException as error:
        print(f"Error al enviar datos: {error}")

# Ejemplo de uso
url = 'https://httpbin.org/post'
datos = {'nombre': 'Juan', 'edad': '30'}
enviar_datos_post(url, datos)
```

- `requests.post(url, data=datos)` envía una solicitud POST con los datos especificados.

### Ejemplo Completo: Realizar Solicitudes HTTP y Analizar Respuestas

Combina todo lo aprendido en un script completo.

```python
import requests

def realizar_solicitud_http(url):
    try:
        response = requests.get(url)
        response.raise_for_status()  # Lanza una excepción para códigos de error HTTP
        print(f"Código de estado: {response.status_code}")
        print(f"Encabezados:\n{response.headers}")
        print(f"Cuerpo de la respuesta:\n{response.text[:500]}")  # Muestra los primeros 500 caracteres
    except requests.exceptions.HTTPError as http_err:
        print(f"Error HTTP: {http_err}")
    except requests.exceptions.ConnectionError as conn_err:
        print(f"Error de conexión: {conn_err}")
    except requests.exceptions.Timeout as timeout_err:
        print(f"Error de tiempo de espera: {timeout_err}")
    except requests.exceptions.RequestException as req_err:
        print(f"Error en la solicitud: {req_err}")

def enviar_datos_post(url, datos):
    try:
        response = requests.post(url, data=datos)
        response.raise_for_status()
        print(f"Código de estado: {response.status_code}")
        print(f"Respuesta:\n{response.text}")
    except requests.exceptions.RequestException as error:
        print(f"Error al enviar datos: {error}")

# Ejemplo de uso
if __name__ == "__main__":
    print("Ejemplo de solicitud GET:")
    realizar_solicitud_http('https://www.google.com')
    
    print("\nEjemplo de solicitud POST:")
    url = 'https://httpbin.org/post'
    datos = {'nombre': 'Juan', 'edad': '30'}
    enviar_datos_post(url, datos)
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `solicitudes_http.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `solicitudes_http.py`.
   - Ejecuta el script:

     ```shell
     python solicitudes_http.py
     ```

### Conclusión

En estas prácticas, has aprendido a interactuar con redes utilizando Python. Has aprendido a obtener la dirección IP de un sitio web y a realizar solicitudes HTTP, manejando las respuestas y los posibles errores. Estas habilidades son esenciales para trabajar con servicios web y APIs, y te preparan para desarrollar aplicaciones de red robustas y eficientes. Continúa practicando y explorando diferentes APIs y servicios para mejorar tus habilidades en la programación de redes.