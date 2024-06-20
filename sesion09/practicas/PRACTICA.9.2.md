# Práctica 9.2: Seguridad en Python

## Objetivo

El objetivo de esta práctica es aprender a implementar técnicas de cifrado y manejo seguro de contraseñas en scripts Python. Esto es crucial para proteger datos sensibles y prevenir vulnerabilidades en aplicaciones y sistemas.

## Ejercicio

### 1. Cifrado y Descifrado de Datos

#### Instalación de la Biblioteca `cryptography`

Primero, instala la biblioteca `cryptography` utilizando `pip`.

```bash
pip install cryptography
```

#### Código del Script para Cifrado y Descifrado

Este script cifra y descifra un mensaje utilizando la biblioteca `cryptography`.

```python
from cryptography.fernet import Fernet

# Generar una clave de cifrado
clave = Fernet.generate_key()
cipher_suite = Fernet(clave)

# Mensaje a cifrar
mensaje = b"Este es un mensaje secreto"

# Cifrar el mensaje
mensaje_cifrado = cipher_suite.encrypt(mensaje)
print("Mensaje cifrado:", mensaje_cifrado)

# Descifrar el mensaje
mensaje_descifrado = cipher_suite.decrypt(mensaje_cifrado)
print("Mensaje descifrado:", mensaje_descifrado.decode())
```

#### Guardar el Script

Guarda el script con el nombre `cifrar_descifrar.py`.

#### Ejecutar el Script

```bash
python cifrar_descifrar.py
```

### 2. Manejo Seguro de Contraseñas

#### Instalación de la Biblioteca `bcrypt`

Primero, instala la biblioteca `bcrypt` utilizando `pip`.

```bash
pip install bcrypt
```

#### Código del Script para Hashing y Verificación de Contraseñas

Este script hashea una contraseña y luego verifica la contraseña introducida por el usuario.

```python
import bcrypt

# Contraseña a hashear
contrasena = b"mi_contraseña_segura"

# Generar el hash de la contraseña
hash_contrasena = bcrypt.hashpw(contrasena, bcrypt.gensalt())
print("Hash de la contraseña:", hash_contrasena)

# Solicitar la contraseña al usuario
contrasena_usuario = input("Introduce tu contraseña: ").encode()

# Verificar la contraseña
if bcrypt.checkpw(contrasena_usuario, hash_contrasena):
    print("La contraseña es correcta.")
else:
    print("La contraseña es incorrecta.")
```

#### Guardar el Script

Guarda el script con el nombre `hash_verificar_contraseña.py`.

#### Ejecutar el Script

```bash
python hash_verificar_contraseña.py
```

### 3. Uso de Variables de Entorno para Gestionar Secretos

#### Código del Script para Leer Secretos desde Variables de Entorno

Este script lee una contraseña almacenada en una variable de entorno y la utiliza para conectar a una base de datos.

```python
import os

# Leer la contraseña desde la variable de entorno
contrasena = os.getenv('DB_PASSWORD')

if contrasena:
    print("La contraseña ha sido leída desde la variable de entorno.")
else:
    print("No se encontró la variable de entorno DB_PASSWORD.")
```

#### Guardar el Script

Guarda el script con el nombre `leer_variable_entorno.py`.

#### Configurar la Variable de Entorno y Ejecutar el Script

Configura la variable de entorno y ejecuta el script.

```bash
export DB_PASSWORD='mi_contraseña_segura'
python leer_variable_entorno.py
```

## Casos Prácticos

### Caso Práctico 1: Cifrado de Archivos

#### Código del Script para Cifrar y Descifrar Archivos

Este script cifra y descifra el contenido de un archivo.

```python
from cryptography.fernet import Fernet

# Generar una clave de cifrado
clave = Fernet.generate_key()
cipher_suite = Fernet(clave)

# Ruta del archivo
archivo = "archivo_secreto.txt"

# Cifrar el contenido del archivo
with open(archivo, "rb") as file:
    contenido = file.read()
contenido_cifrado = cipher_suite.encrypt(contenido)

with open("archivo_cifrado.txt", "wb") as file:
    file.write(contenido_cifrado)
print("Archivo cifrado guardado como 'archivo_cifrado.txt'.")

# Descifrar el contenido del archivo cifrado
with open("archivo_cifrado.txt", "rb") as file:
    contenido_cifrado = file.read()
contenido_descifrado = cipher_suite.decrypt(contenido_cifrado)

with open("archivo_descifrado.txt", "wb") as file:
    file.write(contenido_descifrado)
print("Archivo descifrado guardado como 'archivo_descifrado.txt'.")
```

#### Guardar el Script

Guarda el script con el nombre `cifrar_descifrar_archivo.py`.

#### Crear un Archivo de Prueba y Ejecutar el Script

Crea un archivo `archivo_secreto.txt` con contenido de prueba y luego ejecuta el script.

```bash
echo "Este es el contenido secreto" > archivo_secreto.txt
python cifrar_descifrar_archivo.py
```

### Caso Práctico 2: Gestión Segura de Configuraciones

#### Código del Script para Leer Configuraciones desde un Archivo Cifrado

Este script lee configuraciones desde un archivo JSON cifrado.

```python
import json
from cryptography.fernet import Fernet

# Generar una clave de cifrado
clave = Fernet.generate_key()
cipher_suite = Fernet(clave)

# Configuración a cifrar
configuracion = {
    "db_host": "localhost",
    "db_user": "usuario",
    "db_password": "mi_contraseña_segura"
}

# Cifrar la configuración
configuracion_json = json.dumps(configuracion).encode()
configuracion_cifrada = cipher_suite.encrypt(configuracion_json)

with open("configuracion_cifrada.json", "wb") as file:
    file.write(configuracion_cifrada)
print("Configuración cifrada guardada como 'configuracion_cifrada.json'.")

# Descifrar la configuración
with open("configuracion_cifrada.json", "rb") as file:
    configuracion_cifrada = file.read()
configuracion_descifrada = cipher_suite.decrypt(configuracion_cifrada)

configuracion = json.loads(configuracion_descifrada.decode())
print("Configuración descifrada:", configuracion)
```

#### Guardar el Script

Guarda el script con el nombre `gestionar_configuracion.py`.

#### Ejecutar el Script

```bash
python gestionar_configuracion.py
```

## Conclusión

Implementar técnicas de cifrado y manejo seguro de contraseñas en scripts Python es crucial para proteger los datos sensibles y prevenir vulnerabilidades. Los ejemplos proporcionados en esta práctica te ayudarán a implementar estas técnicas en tus propios scripts, mejorando la seguridad y fiabilidad de tus aplicaciones y sistemas.
