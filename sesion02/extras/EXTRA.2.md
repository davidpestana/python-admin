### Ejercicio Extra: Sincronización de Directorios

Para aquellos alumnos que terminan rápidamente y buscan un desafío adicional, aquí hay un ejercicio más complejo. Este ejercicio implica escribir un script para sincronizar dos directorios. La sincronización debe asegurarse de que ambos directorios contengan los mismos archivos, copiando nuevos archivos desde el directorio de origen al directorio de destino y eliminando archivos del destino que ya no estén presentes en el origen.

#### Objetivos:
1. Sincronizar dos directorios para que contengan los mismos archivos.
2. Copiar archivos nuevos desde el directorio de origen al directorio de destino.
3. Eliminar archivos en el directorio de destino que no estén presentes en el directorio de origen.

### Paso 1: Importar Módulos Necesarios

Usaremos los módulos `os` y `shutil` para manejar archivos y directorios, y `filecmp` para comparar directorios.

```python
import os
import shutil
import filecmp
```

### Paso 2: Definir la Función de Sincronización

1. **Comparar Archivos y Directorios:**
   - Utilizaremos el módulo `filecmp` para comparar los contenidos de dos directorios y obtener listas de archivos únicos en cada directorio.

2. **Copiar Nuevos Archivos:**
   - Si un archivo está presente en el directorio de origen pero no en el de destino, se copiará al destino.

3. **Eliminar Archivos Obsoletos:**
   - Si un archivo está presente en el directorio de destino pero no en el de origen, se eliminará del destino.

```python
def sincronizar_directorios(origen, destino):
    # Crear el directorio de destino si no existe
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    # Comparar directorios
    comparacion = filecmp.dircmp(origen, destino)
    
    # Copiar archivos únicos al destino
    for archivo in comparacion.left_only:
        ruta_origen = os.path.join(origen, archivo)
        ruta_destino = os.path.join(destino, archivo)
        if os.path.isfile(ruta_origen):
            shutil.copy2(ruta_origen, ruta_destino)
            print(f"Copiado: {ruta_origen} a {ruta_destino}")
        elif os.path.isdir(ruta_origen):
            shutil.copytree(ruta_origen, ruta_destino)
            print(f"Copiado directorio: {ruta_origen} a {ruta_destino}")
    
    # Eliminar archivos únicos del destino
    for archivo in comparacion.right_only:
        ruta_destino = os.path.join(destino, archivo)
        if os.path.isfile(ruta_destino):
            os.remove(ruta_destino)
            print(f"Eliminado: {ruta_destino}")
        elif os.path.isdir(ruta_destino):
            shutil.rmtree(ruta_destino)
            print(f"Eliminado directorio: {ruta_destino}")
    
    # Sincronizar archivos comunes recursivamente
    for archivo in comparacion.common_dirs:
        sincronizar_directorios(os.path.join(origen, archivo), os.path.join(destino, archivo))

origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino'

# Ejecutar la sincronización de directorios
sincronizar_directorios(origen, destino)
```

### Paso 3: Ejecutar el Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `sincronizar_directorios.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `sincronizar_directorios.py`.
   - Ejecuta el script:

     ```shell
     python sincronizar_directorios.py
     ```

### Recursos Adicionales

- [Documentación oficial del módulo `filecmp`](https://docs.python.org/3/library/filecmp.html)
- [Documentación oficial del módulo `shutil`](https://docs.python.org/3/library/shutil.html)
- [Documentación oficial del módulo `os`](https://docs.python.org/3/library/os.html)

### Conclusión

Este ejercicio avanzado desafía a los alumnos a implementar un sistema de sincronización de directorios que puede ser extremadamente útil en la administración de sistemas. La tarea no solo involucra la copia y eliminación de archivos, sino también la gestión de directorios recursivos, lo que añade un nivel adicional de complejidad y utilidad. Este ejercicio ayudará a los alumnos a mejorar significativamente sus habilidades en la automatización de tareas y la manipulación de archivos y directorios con Python.