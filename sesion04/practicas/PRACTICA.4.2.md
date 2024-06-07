### Práctica: Gestión de Permisos

En esta práctica, vamos a escribir scripts para cambiar los permisos de archivos en un directorio y para verificar y ajustar los permisos según un criterio predefinido. Estos scripts son útiles para la administración de sistemas en entornos Unix-like.

### Parte 1: Cambiar Permisos de Archivos en un Directorio

#### Paso 1: Uso del Módulo `os`

El módulo `os` en Python proporciona funciones para interactuar con el sistema operativo, incluyendo la manipulación de permisos de archivos.

#### Script para Cambiar Permisos de Archivos en un Directorio

**Ejemplo: Cambiar Permisos de Archivos en un Directorio**

```python
import os

def cambiar_permisos_en_directorio(directorio, permisos):
    try:
        for root, dirs, files in os.walk(directorio):
            for nombre in files:
                ruta_archivo = os.path.join(root, nombre)
                os.chmod(ruta_archivo, permisos)
                print(f"Cambiados permisos a {oct(permisos)} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar los permisos: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    directorio = input("Introduce la ruta del directorio: ")
    permisos = int(input("Introduce los permisos en formato octal (p.ej., 755): "), 8)
    cambiar_permisos_en_directorio(directorio, permisos)
```

- `os.walk(directorio)`: Genera los nombres de archivos en el árbol de directorios, comenzando desde el directorio superior.
- `os.chmod(ruta_archivo, permisos)`: Cambia los permisos del archivo especificado.

### Parte 2: Verificar y Ajustar Permisos Según un Criterio Predefinido

#### Paso 1: Definir los Criterios de Permisos

Podemos definir los criterios de permisos que deseamos verificar y ajustar. Por ejemplo, asegurarnos de que todos los archivos tengan permisos 644 y los directorios tengan permisos 755.

#### Script para Verificar y Ajustar Permisos

**Ejemplo: Verificar y Ajustar Permisos de Archivos y Directorios**

```python
import os

def verificar_y_ajustar_permisos(directorio, permisos_archivos, permisos_directorios):
    try:
        for root, dirs, files in os.walk(directorio):
            for nombre in files:
                ruta_archivo = os.path.join(root, nombre)
                permisos_actuales = os.stat(ruta_archivo).st_mode & 0o777
                if permisos_actuales != permisos_archivos:
                    os.chmod(ruta_archivo, permisos_archivos)
                    print(f"Cambiados permisos a {oct(permisos_archivos)} para archivo {ruta_archivo}")
            
            for nombre in dirs:
                ruta_directorio = os.path.join(root, nombre)
                permisos_actuales = os.stat(ruta_directorio).st_mode & 0o777
                if permisos_actuales != permisos_directorios:
                    os.chmod(ruta_directorio, permisos_directorios)
                    print(f"Cambiados permisos a {oct(permisos_directorios)} para directorio {ruta_directorio}")
    except Exception as e:
        print(f"Error al verificar y ajustar los permisos: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    directorio = input("Introduce la ruta del directorio: ")
    permisos_archivos = int(input("Introduce los permisos deseados para archivos en formato octal (p.ej., 644): "), 8)
    permisos_directorios = int(input("Introduce los permisos deseados para directorios en formato octal (p.ej., 755): "), 8)
    verificar_y_ajustar_permisos(directorio, permisos_archivos, permisos_directorios)
```

- `os.stat(ruta_archivo).st_mode & 0o777`: Obtiene los permisos actuales del archivo en formato octal.
- `os.chmod(ruta_archivo, permisos_archivos)`: Cambia los permisos del archivo si no coinciden con los permisos deseados.

### Ejemplo Completo: Cambiar y Verificar Permisos

Combina todo lo aprendido en un script completo que permita cambiar y verificar permisos de archivos y directorios.

**Script Completo**

```python
import os

def cambiar_permisos_en_directorio(directorio, permisos):
    try:
        for root, dirs, files in os.walk(directorio):
            for nombre in files:
                ruta_archivo = os.path.join(root, nombre)
                os.chmod(ruta_archivo, permisos)
                print(f"Cambiados permisos a {oct(permisos)} para {ruta_archivo}")
    except Exception as e:
        print(f"Error al cambiar los permisos: {e}")

def verificar_y_ajustar_permisos(directorio, permisos_archivos, permisos_directorios):
    try:
        for root, dirs, files in os.walk(directorio):
            for nombre in files:
                ruta_archivo = os.path.join(root, nombre)
                permisos_actuales = os.stat(ruta_archivo).st_mode & 0o777
                if permisos_actuales != permisos_archivos:
                    os.chmod(ruta_archivo, permisos_archivos)
                    print(f"Cambiados permisos a {oct(permisos_archivos)} para archivo {ruta_archivo}")
            
            for nombre in dirs:
                ruta_directorio = os.path.join(root, nombre)
                permisos_actuales = os.stat(ruta_directorio).st_mode & 0o777
                if permisos_actuales != permisos_directorios:
                    os.chmod(ruta_directorio, permisos_directorios)
                    print(f"Cambiados permisos a {oct(permisos_directorios)} para directorio {ruta_directorio}")
    except Exception as e:
        print(f"Error al verificar y ajustar los permisos: {e}")

if __name__ == "__main__":
    while True:
        print("\nMenú de Gestión de Permisos")
        print("1. Cambiar permisos de archivos en un directorio")
        print("2. Verificar y ajustar permisos según un criterio predefinido")
        print("3. Salir")
        
        opcion = input("Selecciona una opción: ")
        
        if opcion == '1':
            directorio = input("Introduce la ruta del directorio: ")
            permisos = int(input("Introduce los permisos en formato octal (p.ej., 755): "), 8)
            cambiar_permisos_en_directorio(directorio, permisos)
        elif opcion == '2':
            directorio = input("Introduce la ruta del directorio: ")
            permisos_archivos = int(input("Introduce los permisos deseados para archivos en formato octal (p.ej., 644): "), 8)
            permisos_directorios = int(input("Introduce los permisos deseados para directorios en formato octal (p.ej., 755): "), 8)
            verificar_y_ajustar_permisos(directorio, permisos_archivos, permisos_directorios)
        elif opcion == '3':
            break
        else:
            print("Opción no válida, por favor intenta de nuevo.")
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `gestion_permisos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `gestion_permisos.py`.
   - Ejecuta el script:

     ```shell
     sudo python gestion_permisos.py
     ```

### Conclusión

En esta práctica, has aprendido cómo cambiar los permisos de archivos en un directorio y cómo verificar y ajustar permisos según un criterio predefinido utilizando Python. Estas habilidades son esenciales para la administración eficiente de permisos en sistemas Unix-like. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como la gestión recursiva de permisos en directorios y la generación de informes de permisos.