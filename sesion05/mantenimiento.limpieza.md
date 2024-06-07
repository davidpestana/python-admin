### Sesión 5: Monitoreo y Mantenimiento del Sistema

#### Objetivos:
1. Aprender a monitorear los recursos del sistema utilizando Python.
2. Implementar scripts para la limpieza y mantenimiento del sistema.

### Mantenimiento del Sistema con Scripts de Limpieza

Los scripts de limpieza son esenciales para mantener el sistema operativo libre de archivos innecesarios que pueden ocupar espacio valioso en el disco y afectar el rendimiento del sistema. A continuación, veremos cómo crear scripts de limpieza del sistema utilizando Python.

### Limpieza del Sistema

#### Paso 1: Limpieza de Archivos Temporales

Los archivos temporales se generan durante el uso normal del sistema y aplicaciones, pero no siempre se eliminan automáticamente.

**Script para Limpiar Archivos Temporales**

```python
import os
import shutil

def limpiar_archivos_temporales(directorios_temporales):
    for directorio in directorios_temporales:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    print(f"Eliminado archivo temporal: {file_path}")
                except Exception as e:
                    print(f"Error al eliminar {file_path}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    directorios_temporales = ['/tmp', '/var/tmp']
    limpiar_archivos_temporales(directorios_temporales)
```

- `os.walk(directorio)`: Recorre el directorio y sus subdirectorios.
- `os.remove(file_path)`: Elimina un archivo.

#### Paso 2: Limpieza de Archivos de Registro (Logs)

Los archivos de registro pueden crecer significativamente con el tiempo y deben ser gestionados adecuadamente.

**Script para Limpiar Archivos de Registro Antiguos**

```python
import os
import time

def limpiar_archivos_registro(directorio_logs, dias_maximos):
    tiempo_actual = time.time()
    for root, dirs, files in os.walk(directorio_logs):
        for file in files:
            file_path = os.path.join(root, file)
            if file.endswith('.log'):
                tiempo_modificacion = os.path.getmtime(file_path)
                if (tiempo_actual - tiempo_modificacion) // (24 * 3600) >= dias_maximos:
                    try:
                        os.remove(file_path)
                        print(f"Eliminado archivo de registro: {file_path}")
                    except Exception as e:
                        print(f"Error al eliminar {file_path}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    directorio_logs = '/var/log'
    dias_maximos = 30
    limpiar_archivos_registro(directorio_logs, dias_maximos)
```

- `os.path.getmtime(file_path)`: Obtiene el tiempo de la última modificación del archivo.
- `(tiempo_actual - tiempo_modificacion) // (24 * 3600) >= dias_maximos`: Calcula la antigüedad del archivo en días.

#### Paso 3: Limpieza de Cachés del Sistema

Las cachés del sistema y de aplicaciones pueden ocupar mucho espacio y deben ser limpiadas periódicamente.

**Script para Limpiar Cachés del Sistema**

```python
import os

def limpiar_caches(directorios_caches):
    for directorio in directorios_caches:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    print(f"Eliminado archivo de caché: {file_path}")
                except Exception as e:
                    print(f"Error al eliminar {file_path}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    directorios_caches = ['/var/cache', os.path.expanduser('~/.cache')]
    limpiar_caches(directorios_caches)
```

- `os.path.expanduser('~/.cache')`: Expande la ruta al directorio de caché del usuario.

### Ejemplo Completo: Script de Limpieza del Sistema

Combina todas las tareas de limpieza en un solo script.

**Script Completo: Limpieza del Sistema**

```python
import os
import shutil
import time

def limpiar_archivos_temporales(directorios_temporales):
    for directorio in directorios_temporales:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    print(f"Eliminado archivo temporal: {file_path}")
                except Exception as e:
                    print(f"Error al eliminar {file_path}: {e}")

def limpiar_archivos_registro(directorio_logs, dias_maximos):
    tiempo_actual = time.time()
    for root, dirs, files in os.walk(directorio_logs):
        for file in files:
            file_path = os.path.join(root, file)
            if file.endswith('.log'):
                tiempo_modificacion = os.path.getmtime(file_path)
                if (tiempo_actual - tiempo_modificacion) // (24 * 3600) >= dias_maximos:
                    try:
                        os.remove(file_path)
                        print(f"Eliminado archivo de registro: {file_path}")
                    except Exception as e:
                        print(f"Error al eliminar {file_path}: {e}")

def limpiar_caches(directorios_caches):
    for directorio in directorios_caches:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    print(f"Eliminado archivo de caché: {file_path}")
                except Exception as e:
                    print(f"Error al eliminar {file_path}: {e}")

if __name__ == "__main__":
    print("Limpieza del sistema iniciada...")

    directorios_temporales = ['/tmp', '/var/tmp']
    limpiar_archivos_temporales(directorios_temporales)

    directorio_logs = '/var/log'
    dias_maximos = 30
    limpiar_archivos_registro(directorio_logs, dias_maximos)

    directorios_caches = ['/var/cache', os.path.expanduser('~/.cache')]
    limpiar_caches(directorios_caches)

    print("Limpieza del sistema completada.")
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `limpieza_sistema.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `limpieza_sistema.py`.
   - Ejecuta el script con privilegios de superusuario:

     ```shell
     sudo python limpieza_sistema.py
     ```

### Conclusión

En esta sesión, has aprendido cómo implementar scripts de limpieza del sistema utilizando Python. Estos scripts son esenciales para mantener el sistema libre de archivos innecesarios y asegurar un rendimiento óptimo. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como la limpieza de archivos de usuarios específicos y la integración con herramientas de monitoreo y mantenimiento del sistema.