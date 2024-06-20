# Buenas Prácticas de Seguridad en Python

## Introducción

La seguridad en scripting Python es crucial para proteger datos sensibles y prevenir vulnerabilidades. Esta guía explora las mejores prácticas para implementar la seguridad en scripts Python, incluyendo el uso de bibliotecas como `cryptography` para cifrar datos y técnicas para manejar contraseñas de forma segura.

## Uso de la Biblioteca `cryptography`

La biblioteca `cryptography` proporciona herramientas robustas para cifrar y descifrar datos. Asegurarse de que los datos sensibles estén cifrados es esencial para proteger la información.

### Instalación de `cryptography`

Primero, instala la biblioteca `cryptography` utilizando `pip`.

```bash
pip install cryptography
```

### Cifrado y Descifrado de Datos

#### Ejemplo de Cifrado

```python
from cryptography.fernet import Fernet

# Generar una clave
clave = Fernet.generate_key()
cipher_suite = Fernet(clave)

# Mensaje a cifrar
mensaje = b"Este es un mensaje secreto"

# Cifrar el mensaje
mensaje_cifrado = cipher_suite.encrypt(mensaje)
print("Mensaje cifrado:", mensaje_cifrado)
```

#### Ejemplo de Descifrado

```python
# Descifrar el mensaje
mensaje_descifrado = cipher_suite.decrypt(mensaje_cifrado)
print("Mensaje descifrado:", mensaje_descifrado.decode())
```

*Solución:* Generamos una clave de cifrado, ciframos un mensaje y luego lo desciframos.

## Manejo Seguro de Contraseñas

El manejo seguro de contraseñas es esencial para evitar compromisos de seguridad. Nunca almacenes contraseñas en texto plano y utiliza técnicas seguras para almacenar y verificar contraseñas.

### Uso de `getpass` para Solicitar Contraseñas de Forma Segura

La biblioteca `getpass` permite solicitar contraseñas al usuario de manera que no se muestren en la pantalla.

#### Ejemplo de Uso de `getpass`

```python
import getpass

# Solicitar la contraseña al usuario
contrasena = getpass.getpass("Introduce la contraseña: ")
print("Contraseña introducida de forma segura.")
```

*Solución:* Utilizamos `getpass.getpass` para solicitar la contraseña al usuario sin mostrarla en la pantalla.

### Almacenamiento Seguro de Contraseñas con `bcrypt`

La biblioteca `bcrypt` se utiliza para hashear y verificar contraseñas de forma segura.

#### Instalación de `bcrypt`

Primero, instala la biblioteca `bcrypt` utilizando `pip`.

```bash
pip install bcrypt
```

#### Ejemplo de Hashing y Verificación de Contraseñas

```python
import bcrypt

# Contraseña a hashear
contrasena = b"mi_contraseña_segura"

# Generar el hash de la contraseña
hash_contrasena = bcrypt.hashpw(contrasena, bcrypt.gensalt())
print("Hash de la contraseña:", hash_contrasena)

# Verificar la contraseña
if bcrypt.checkpw(contrasena, hash_contrasena):
    print("La contraseña es correcta.")
else:
    print("La contraseña es incorrecta.")
```

*Solución:* Utilizamos `bcrypt` para generar un hash de la contraseña y luego verificarla de manera segura.

## Evitar Vulnerabilidades Comunes

### Inyecciones SQL

Las inyecciones SQL pueden ocurrir cuando se concatenan consultas SQL con datos de entrada del usuario. Utiliza siempre consultas parametrizadas para evitar estas vulnerabilidades.

#### Ejemplo de Consulta SQL Insegura

```python
import sqlite3

# Conexión a la base de datos
conn = sqlite3.connect('example.db')
cursor = conn.cursor()

# Entrada del usuario
usuario_id = input("Introduce el ID del usuario: ")

# Consulta SQL insegura
cursor.execute(f"SELECT * FROM usuarios WHERE id = {usuario_id}")

# Obtener resultados
resultados = cursor.fetchall()
print(resultados)
```

*Problema:* La consulta SQL es vulnerable a inyecciones si el usuario introduce una entrada maliciosa.

#### Ejemplo de Consulta SQL Segura

```python
import sqlite3

# Conexión a la base de datos
conn = sqlite3.connect('example.db')
cursor = conn.cursor()

# Entrada del usuario
usuario_id = input("Introduce el ID del usuario: ")

# Consulta SQL segura
cursor.execute("SELECT * FROM usuarios WHERE id = ?", (usuario_id,))

# Obtener resultados
resultados = cursor.fetchall()
print(resultados)
```

*Solución:* Utilizamos consultas parametrizadas para prevenir inyecciones SQL.

## Registro y Auditoría

Registrar las acciones de los scripts y mantener un historial de auditoría es crucial para la seguridad y el análisis de incidentes.

### Ejemplo de Registro con `logging`

#### Código del Script con Registro

```python
import logging

# Configurar el registro
logging.basicConfig(filename='/var/log/mi_script.log', level=logging.INFO)

# Registrar un mensaje
logging.info('El script ha comenzado.')

# Simular una acción del script
print("Haciendo algo importante...")
logging.info('Acción importante completada.')

logging.info('El script ha finalizado.')
```

*Solución:* Utilizamos la biblioteca `logging` para registrar mensajes en un archivo de log.

## Casos Prácticos

### Caso Práctico 1: Script Seguro para Cifrado de Archivos

#### Código del Script

```python
from cryptography.fernet import Fernet
import getpass

# Generar y guardar la clave en un archivo
clave = Fernet.generate_key()
with open("clave.key", "wb") as key_file:
    key_file.write(clave)

# Crear la suite de cifrado
cipher_suite = Fernet(clave)

# Solicitar la contraseña al usuario
contrasena = getpass.getpass("Introduce la contraseña para cifrar el archivo: ")

# Cifrar la contraseña
contrasena_cifrada = cipher_suite.encrypt(contrasena.encode())

# Guardar la contraseña cifrada en un archivo
with open("contrasena_cifrada.txt", "wb") as file:
    file.write(contrasena_cifrada)

print("Contraseña cifrada y guardada en contrasena_cifrada.txt.")
```

*Solución:* Este script cifra una contraseña introducida por el usuario y la guarda en un archivo de manera segura.

### Caso Práctico 2: Script Seguro para Validación de Usuario

#### Código del Script

```python
import bcrypt
import getpass

# Contraseña almacenada en la base de datos (previamente hasheada)
hash_contrasena_almacenada = b'$2b$12$eImiTXuWVxfM37uY4JANjQ=='

# Solicitar la contraseña al usuario
contrasena = getpass.getpass("Introduce tu contraseña: ")

# Verificar la contraseña
if bcrypt.checkpw(contrasena.encode(), hash_contrasena_almacenada):
    print("Acceso concedido.")
else:
    print("Acceso denegado.")
```

*Solución:* Este script verifica la contraseña del usuario contra un hash almacenado de manera segura.

## Conclusión

Implementar prácticas de seguridad en scripting Python es crucial para proteger los sistemas y los datos sensibles. El uso de bibliotecas para cifrar datos, el manejo seguro de contraseñas, la prevención de inyecciones SQL y la implementación de registros son pasos esenciales para crear scripts seguros y fiables.
