### Sesión 4: Gestión de Usuarios y Permisos

#### Objetivos:
1. Aprender a gestionar usuarios y permisos del sistema.
2. Utilizar scripts en Python para automatizar la gestión de permisos y propiedades de archivos.

### Automatización de Tareas de Administración: Cambio de Permisos y Propiedades de Archivos

### Introducción

Automatizar el cambio de permisos y propiedades de archivos es una tarea común en la administración de sistemas. Con Python, podemos utilizar módulos como `os` y `subprocess` para manipular permisos y propiedades de archivos de manera eficiente.

### Uso de `os.chmod` para Cambiar Permisos de Archivos

El módulo `os` en Python proporciona la función `os.chmod` para cambiar los permisos de archivos. 

**Sintaxis básica:**

```python
import os

os.chmod(path, mode)
```

- `path`: La ruta al archivo cuyo permisos deseas cambiar.
- `mode`: El nuevo modo de permisos en formato octal.

### Cambiar Propiedades de Archivos con `os.chown`

Para cambiar el propietario y el grupo de un archivo, utilizamos `os.chown`.

**Sintaxis básica:**

```python
import os

os.chown(path, uid, gid)
```

- `path`: La ruta al archivo cuyo propietario y grupo deseas cambiar.
- `uid`: El nuevo ID de usuario.
- `gid`: El nuevo ID de grupo.

### Cambiar Propiedades de Archivos con `subprocess`

A veces, necesitamos usar comandos del sistema para cambiar propiedades de archivos, especialmente cuando requerimos funcionalidades específicas del sistema operativo.

**Comando `chmod`:**

```python
import subprocess

subprocess.run(['chmod', '755', 'ruta/al/archivo'])
```

**Comando `chown`:**

```python
import subprocess

subprocess.run(['chown', 'usuario:grupo', 'ruta/al/archivo'])
```

### Ejemplo: Script para Cambiar Permisos de Archivos

Vamos a crear un script que cambie los permisos de un archivo.

**Ejemplo: Cambiar Permisos de Archivos**

```python
import os

def cambiar_permisos_archivo(ruta_archivo, permisos):
    try:
        os.chmod(ruta_archivo, permisos)
        print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar los permisos: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    archivo = input("Introduce la ruta del archivo: ")
    permisos = int(input("Introduce los permisos en formato octal (p.ej., 755): "), 8)
    cambiar_permisos_archivo(archivo, permisos)
```

### Ejemplo: Script para Cambiar Propietario y Grupo de Archivos

Vamos a crear un script que cambie el propietario y el grupo de un archivo.

**Ejemplo: Cambiar Propietario y Grupo de Archivos**

```python
import os

def cambiar_propietario_archivo(ruta_archivo, uid, gid):
    try:
        os.chown(ruta_archivo, uid, gid)
        print(f"Propietario cambiado a UID: {uid}, GID: {gid} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar el propietario: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    archivo = input("Introduce la ruta del archivo: ")
    uid = int(input("Introduce el nuevo UID: "))
    gid = int(input("Introduce el nuevo GID: "))
    cambiar_propietario_archivo(archivo, uid, gid)
```

### Ejemplo Completo: Cambiar Permisos y Propietario de Archivos

Combina todo lo aprendido en un script completo que permita cambiar permisos y propietario de archivos.

**Script Completo: Cambiar Permisos y Propietario de Archivos**

```python
import os
import subprocess

def cambiar_permisos_archivo(ruta_archivo, permisos):
    try:
        os.chmod(ruta_archivo, permisos)
        print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar los permisos: {e}")

def cambiar_propietario_archivo(ruta_archivo, uid, gid):
    try:
        os.chown(ruta_archivo, uid, gid)
        print(f"Propietario cambiado a UID: {uid}, GID: {gid} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar el propietario: {e}")

def cambiar_propietario_grupo(ruta_archivo, propietario, grupo):
    try:
        subprocess.run(['chown', f'{propietario}:{grupo}', ruta_archivo], check=True)
        print(f"Propietario y grupo cambiados a {propietario}:{grupo} para {ruta_archivo}")
    except subprocess.CalledProcessError as e:
        print(f"Error al cambiar el propietario y grupo: {e}")

if __name__ == "__main__":
    while True:
        print("\nMenú de Gestión de Permisos y Propiedades de Archivos")
        print("1. Cambiar permisos de un archivo")
        print("2. Cambiar propietario y grupo de un archivo")
        print("3. Cambiar propietario y grupo de un archivo usando `chown`")
        print("4. Salir")
        
        opcion = input("Selecciona una opción: ")
        
        if opcion == '1':
            archivo = input("Introduce la ruta del archivo: ")
            permisos = int(input("Introduce los permisos en formato octal (p.ej., 755): "), 8)
            cambiar_permisos_archivo(archivo, permisos)
        elif opcion == '2':
            archivo = input("Introduce la ruta del archivo: ")
            uid = int(input("Introduce el nuevo UID: "))
            gid = int(input("Introduce el nuevo GID: "))
            cambiar_propietario_archivo(archivo, uid, gid)
        elif opcion == '3':
            archivo = input("Introduce la ruta del archivo: ")
            propietario = input("Introduce el nombre del nuevo propietario: ")
            grupo = input("Introduce el nombre del nuevo grupo: ")
            cambiar_propietario_grupo(archivo, propietario, grupo)
        elif opcion == '4':
            break
        else:
            print("Opción no válida, por favor intenta de nuevo.")
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `gestion_permisos_propiedades.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `gestion_permisos_propiedades.py`.
   - Ejecuta el script:

     ```shell
     sudo python gestion_permisos_propiedades.py
     ```

### Conclusión

En esta sesión, has aprendido cómo automatizar el cambio de permisos y propiedades de archivos utilizando Python. Crear scripts para gestionar estos aspectos puede ahorrar tiempo y reducir errores en la administración del sistema. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como la gestión recursiva de permisos en directorios.