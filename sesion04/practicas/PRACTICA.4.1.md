### Práctica: Gestión de Usuarios

En esta práctica, vamos a escribir scripts para listar todos los usuarios del sistema y automatizar la creación de nuevos usuarios y la asignación de grupos. Estos scripts son útiles para la administración de sistemas en entornos Unix-like.

### Parte 1: Listar Todos los Usuarios del Sistema

#### Paso 1: Introducción al Módulo `pwd`

El módulo `pwd` en Python proporciona una interfaz para acceder a la base de datos de contraseñas del sistema, que contiene información sobre los usuarios del sistema.

#### Script para Listar Todos los Usuarios del Sistema

**Ejemplo: Listar Todos los Usuarios**

```python
import pwd

def listar_usuarios():
    usuarios = pwd.getpwall()
    print("Usuarios del sistema:")
    for usuario in usuarios:
        print(f"Nombre de usuario: {usuario.pw_name}, UID: {usuario.pw_uid}, GID: {usuario.pw_gid}, Directorio de inicio: {usuario.pw_dir}, Intérprete de comandos: {usuario.pw_shell}")

if __name__ == "__main__":
    listar_usuarios()
```

### Parte 2: Automatizar la Creación de Nuevos Usuarios y la Asignación de Grupos

#### Paso 1: Uso del Módulo `subprocess`

El módulo `subprocess` permite ejecutar comandos del sistema desde un script de Python, lo que es esencial para crear usuarios y asignar grupos.

#### Script para Crear Nuevos Usuarios

**Ejemplo: Crear un Nuevo Usuario**

```python
import subprocess

def crear_usuario(nombre_usuario, contrasena, grupo=None):
    try:
        # Crear el usuario
        subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)
        
        # Establecer la contraseña del usuario
        subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)
        
        if grupo:
            # Asignar el grupo al usuario
            subprocess.run(['sudo', 'usermod', '-aG', grupo, nombre_usuario], check=True)
        
        print(f"Usuario {nombre_usuario} creado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al crear el usuario {nombre_usuario}: {e}")

if __name__ == "__main__":
    nombre_usuario = input("Introduce el nombre del nuevo usuario: ")
    contrasena = input("Introduce la contraseña del nuevo usuario: ")
    grupo = input("Introduce el grupo del nuevo usuario (opcional): ")
    grupo = grupo if grupo else None
    crear_usuario(nombre_usuario, contrasena, grupo)
```

- `subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)`: Ejecuta el comando `useradd` para crear un nuevo usuario.
- `subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)`: Establece la contraseña del nuevo usuario.
- `subprocess.run(['sudo', 'usermod', '-aG', grupo, nombre_usuario], check=True)`: Asigna el grupo al nuevo usuario.

### Ejemplo Completo: Listar Usuarios y Crear Nuevos Usuarios con Asignación de Grupos

Combina todo lo aprendido en un script completo que permita listar usuarios, crear nuevos usuarios y asignar grupos.

**Script Completo**

```python
import pwd
import subprocess

def listar_usuarios():
    usuarios = pwd.getpwall()
    print("Usuarios del sistema:")
    for usuario in usuarios:
        print(f"Nombre de usuario: {usuario.pw_name}, UID: {usuario.pw_uid}, GID: {usuario.pw_gid}, Directorio de inicio: {usuario.pw_dir}, Intérprete de comandos: {usuario.pw_shell}")

def crear_usuario(nombre_usuario, contrasena, grupo=None):
    try:
        # Crear el usuario
        subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)
        
        # Establecer la contraseña del usuario
        subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)
        
        if grupo:
            # Asignar el grupo al usuario
            subprocess.run(['sudo', 'usermod', '-aG', grupo, nombre_usuario], check=True)
        
        print(f"Usuario {nombre_usuario} creado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al crear el usuario {nombre_usuario}: {e}")

if __name__ == "__main__":
    while True:
        print("\nMenú de Gestión de Usuarios")
        print("1. Listar todos los usuarios del sistema")
        print("2. Crear un nuevo usuario y asignar grupo")
        print("3. Salir")
        
        opcion = input("Selecciona una opción: ")
        
        if opcion == '1':
            listar_usuarios()
        elif opcion == '2':
            nombre_usuario = input("Introduce el nombre del nuevo usuario: ")
            contrasena = input("Introduce la contraseña del nuevo usuario: ")
            grupo = input("Introduce el grupo del nuevo usuario (opcional): ")
            grupo = grupo if grupo else None
            crear_usuario(nombre_usuario, contrasena, grupo)
        elif opcion == '3':
            break
        else:
            print("Opción no válida, por favor intenta de nuevo.")
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `gestion_usuarios.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `gestion_usuarios.py`.
   - Ejecuta el script con privilegios de superusuario:

     ```shell
     sudo python gestion_usuarios.py
     ```

### Conclusión

En esta práctica, has aprendido a listar todos los usuarios del sistema y a crear nuevos usuarios, incluyendo la asignación de grupos, utilizando Python. Estas habilidades son esenciales para la administración eficiente de usuarios en sistemas Unix-like. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como la eliminación de usuarios y la modificación de sus propiedades.