### Sesión 4: Gestión de Usuarios y Permisos

#### Objetivos:
1. Aprender a gestionar usuarios y permisos del sistema.
2. Utilizar scripts en Python para automatizar la gestión de usuarios.

### Punto 2: Automatización de Tareas de Administración

En esta sesión, nos enfocaremos en cómo utilizar Python para automatizar la administración de usuarios en sistemas Unix-like. Específicamente, crearemos scripts para agregar y eliminar usuarios.

### Scripts para Agregar/Eliminar Usuarios

Python puede interactuar con el sistema operativo para ejecutar comandos que gestionen usuarios. Utilizaremos el módulo `subprocess` para ejecutar comandos del sistema operativo desde Python.

### Importancia de los Permisos

Para ejecutar comandos que agregan o eliminan usuarios, el script debe tener permisos de superusuario. Esto se puede lograr ejecutando el script como root o usando `sudo`.

### Paso 1: Agregar Usuarios

Para agregar un usuario en sistemas Unix-like, generalmente se utiliza el comando `useradd` o `adduser`.

#### Script para Agregar un Usuario

**Ejemplo: Agregar un Usuario**

```python
import subprocess

def agregar_usuario(nombre_usuario, contrasena):
    try:
        # Crear el usuario
        subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)
        
        # Establecer la contraseña del usuario
        subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)
        
        print(f"Usuario {nombre_usuario} agregado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al agregar el usuario {nombre_usuario}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    nombre_usuario = input("Introduce el nombre del nuevo usuario: ")
    contrasena = input("Introduce la contraseña del nuevo usuario: ")
    agregar_usuario(nombre_usuario, contrasena)
```

- `subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)` ejecuta el comando `useradd` para crear un nuevo usuario.
- `subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)` establece la contraseña del nuevo usuario.

### Paso 2: Eliminar Usuarios

Para eliminar un usuario en sistemas Unix-like, se utiliza el comando `userdel`.

#### Script para Eliminar un Usuario

**Ejemplo: Eliminar un Usuario**

```python
import subprocess

def eliminar_usuario(nombre_usuario):
    try:
        # Eliminar el usuario
        subprocess.run(['sudo', 'userdel', nombre_usuario], check=True)
        print(f"Usuario {nombre_usuario} eliminado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al eliminar el usuario {nombre_usuario}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    nombre_usuario = input("Introduce el nombre del usuario a eliminar: ")
    eliminar_usuario(nombre_usuario)
```

- `subprocess.run(['sudo', 'userdel', nombre_usuario], check=True)` ejecuta el comando `userdel` para eliminar un usuario.

### Combinación de Ambos Scripts en un Solo Script

Para mayor utilidad, combinaremos ambos scripts en un solo script que permita al administrador elegir entre agregar o eliminar un usuario.

**Script Completo: Agregar y Eliminar Usuarios**

```python
import subprocess

def agregar_usuario(nombre_usuario, contrasena):
    try:
        # Crear el usuario
        subprocess.run(['sudo', 'useradd', nombre_usuario], check=True)
        
        # Establecer la contraseña del usuario
        subprocess.run(['sudo', 'chpasswd'], input=f"{nombre_usuario}:{contrasena}".encode(), check=True)
        
        print(f"Usuario {nombre_usuario} agregado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al agregar el usuario {nombre_usuario}: {e}")

def eliminar_usuario(nombre_usuario):
    try:
        # Eliminar el usuario
        subprocess.run(['sudo', 'userdel', nombre_usuario], check=True)
        print(f"Usuario {nombre_usuario} eliminado con éxito.")
    except subprocess.CalledProcessError as e:
        print(f"Error al eliminar el usuario {nombre_usuario}: {e}")

if __name__ == "__main__":
    while True:
        print("\nMenú de Gestión de Usuarios")
        print("1. Agregar un usuario")
        print("2. Eliminar un usuario")
        print("3. Salir")
        
        opcion = input("Selecciona una opción: ")
        
        if opcion == '1':
            nombre_usuario = input("Introduce el nombre del nuevo usuario: ")
            contrasena = input("Introduce la contraseña del nuevo usuario: ")
            agregar_usuario(nombre_usuario, contrasena)
        elif opcion == '2':
            nombre_usuario = input("Introduce el nombre del usuario a eliminar: ")
            eliminar_usuario(nombre_usuario)
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

En esta sesión, has aprendido cómo automatizar la gestión de usuarios en sistemas Unix-like utilizando Python. Crear scripts para agregar y eliminar usuarios puede ahorrar tiempo y reducir errores en la administración del sistema. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como la gestión de grupos de usuarios y la configuración de permisos.