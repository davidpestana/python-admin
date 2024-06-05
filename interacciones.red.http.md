### Realización de Solicitudes HTTP con el Módulo `requests`

El módulo `requests` en Python es una biblioteca poderosa y fácil de usar para realizar solicitudes HTTP. Proporciona métodos simples para interactuar con servicios web y APIs, permitiendo enviar solicitudes HTTP/1.1 con métodos como `GET`, `POST`, `PUT`, `DELETE`, y más. A continuación, exploraremos cómo usar `requests` para realizar estas solicitudes.

### Instalación del Módulo `requests`

Antes de empezar a usar `requests`, necesitas instalar la biblioteca. Puedes hacerlo utilizando `pip`:

```shell
pip install requests
```

### Fundamentos de las Solicitudes HTTP

HTTP (HyperText Transfer Protocol) es el protocolo que permite la comunicación entre clientes y servidores en la web. Algunos de los métodos HTTP más comunes incluyen:

- **GET:** Recupera datos de un servidor.
- **POST:** Envía datos al servidor para crear o actualizar un recurso.
- **PUT:** Actualiza un recurso existente en el servidor.
- **DELETE:** Elimina un recurso del servidor.

### Realización de Solicitudes Básicas

#### Solicitud GET

El método `GET` se utiliza para solicitar datos de un servidor. Es la forma más común de realizar solicitudes HTTP.

**Ejemplo de Solicitud GET:**

```python
import requests

response = requests.get('https://api.github.com')
print(response.status_code)  # Imprime el código de estado de la respuesta
print(response.headers)  # Imprime los encabezados de la respuesta
print(response.text)  # Imprime el cuerpo de la respuesta como texto
```

#### Solicitud POST

El método `POST` se utiliza para enviar datos al servidor. Este método se usa comúnmente para enviar datos de formularios o cargar archivos.

**Ejemplo de Solicitud POST:**

```python
import requests

url = 'https://httpbin.org/post'
data = {'key1': 'value1', 'key2': 'value2'}
response = requests.post(url, data=data)
print(response.status_code)
print(response.json())  # Imprime la respuesta como JSON
```

### Envío de Parámetros en Solicitudes

#### Parámetros en una Solicitud GET

Puedes enviar parámetros de consulta en una solicitud `GET` utilizando el argumento `params`.

**Ejemplo:**

```python
import requests

url = 'https://api.github.com/search/repositories'
params = {'q': 'requests+language:python'}
response = requests.get(url, params=params)
print(response.url)  # Imprime la URL completa con parámetros
print(response.json())  # Imprime la respuesta en formato JSON
```

#### Envío de Datos en una Solicitud POST

En una solicitud `POST`, puedes enviar datos en el cuerpo de la solicitud utilizando el argumento `data` para datos de formulario o `json` para datos JSON.

**Ejemplo:**

```python
import requests

url = 'https://httpbin.org/post'
json_data = {'key': 'value'}
response = requests.post(url, json=json_data)
print(response.status_code)
print(response.json())
```

### Manejo de Respuestas

#### Acceso a los Datos de la Respuesta

Después de realizar una solicitud, puedes acceder a diferentes partes de la respuesta.

**Ejemplo:**

```python
import requests

response = requests.get('https://api.github.com')
print(response.status_code)  # Código de estado HTTP
print(response.headers)  # Encabezados de la respuesta
print(response.text)  # Cuerpo de la respuesta como texto
print(response.json())  # Cuerpo de la respuesta como JSON (si es aplicable)
```

#### Manejo de Errores

Es importante manejar errores al realizar solicitudes HTTP. `requests` proporciona una forma sencilla de verificar si una solicitud fue exitosa y manejar diferentes tipos de errores.

**Ejemplo:**

```python
import requests

try:
    response = requests.get('https://api.github.com/invalid-endpoint')
    response.raise_for_status()  # Lanza una excepción si la solicitud no fue exitosa
except requests.exceptions.HTTPError as errh:
    print("HTTP Error:", errh)
except requests.exceptions.ConnectionError as errc:
    print("Error de conexión:", errc)
except requests.exceptions.Timeout as errt:
    print("Tiempo de espera agotado:", errt)
except requests.exceptions.RequestException as err:
    print("Error en la solicitud:", err)
```

### Envío de Encabezados Personalizados

Puedes enviar encabezados personalizados con tu solicitud utilizando el argumento `headers`.

**Ejemplo:**

```python
import requests

url = 'https://httpbin.org/headers'
headers = {'User-Agent': 'mi-aplicacion/0.0.1'}
response = requests.get(url, headers=headers)
print(response.json())
```

### Autenticación

Muchas APIs requieren autenticación. `requests` soporta diferentes métodos de autenticación, como autenticación básica, token, OAuth, etc.

#### Autenticación Básica

**Ejemplo:**

```python
import requests
from requests.auth import HTTPBasicAuth

url = 'https://api.github.com/user'
response = requests.get(url, auth=HTTPBasicAuth('username', 'password'))
print(response.status_code)
print(response.json())
```

#### Autenticación con Token

**Ejemplo:**

```python
import requests

url = 'https://api.github.com/user'
headers = {'Authorization': 'token mi_token'}
response = requests.get(url, headers=headers)
print(response.status_code)
print(response.json())
```

### Subir Archivos

Puedes subir archivos utilizando el argumento `files`.

**Ejemplo:**

```python
import requests

url = 'https://httpbin.org/post'
files = {'file': open('mi_archivo.txt', 'rb')}
response = requests.post(url, files=files)
print(response.status_code)
print(response.json())
```

### Sesiones

Una sesión permite persistir ciertos parámetros a través de múltiples solicitudes. Por ejemplo, puedes mantener cookies y encabezados en todas las solicitudes.

**Ejemplo:**

```python
import requests

# Crear una sesión
session = requests.Session()

# Configurar la sesión con un encabezado
session.headers.update({'User-Agent': 'mi-aplicacion/0.0.1'})

# Realizar una solicitud con la sesión
response = session.get('https://httpbin.org/headers')
print(response.json())

# Cerrar la sesión
session.close()
```

### Conclusión

El módulo `requests` en Python es una herramienta poderosa y versátil para realizar solicitudes HTTP. Proporciona una interfaz simple y limpia para enviar solicitudes y manejar respuestas, lo que facilita la interacción con servicios web y APIs. Dominar `requests` es esencial para cualquier desarrollador que trabaje con aplicaciones web o necesite consumir servicios RESTful.