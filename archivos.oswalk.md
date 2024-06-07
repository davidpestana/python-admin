### Descripción del Laboratorio

En este laboratorio, aprenderemos a utilizar la función `os.walk()` de la biblioteca `os` en Python para administrar directorios y archivos. La función `os.walk()` permite recorrer directorios y subdirectorios de manera eficiente, lo que es especialmente útil para tareas de administración de sistemas. Exploraremos cómo listar archivos y directorios, filtrar archivos por extensión, y realizar operaciones de limpieza y organización.

### Paso 1: Preparativos

Asegúrate de tener Python instalado en tu sistema. Puedes descargarlo desde [python.org](https://www.python.org/).

### Paso 2: Crear la Estructura de Directorios

Crea una estructura de directorios y archivos de ejemplo para trabajar. Puedes hacerlo manualmente o mediante un script de Python.

```sh
mkdir -p lab/os_walk/{subdir1,subdir2}
touch lab/os_walk/{file1.txt,file2.log,subdir1/file3.txt,subdir2/file4.log}
```

### Paso 3: Usar `os.walk()` para Listar Directorios y Archivos

Crea un archivo Python `list_files.py` con el siguiente contenido:

```python
import os

def list_files(start_path):
    for dirpath, dirnames, filenames in os.walk(start_path):
        print(f'Directory: {dirpath}')
        for dirname in dirnames:
            print(f'  Subdirectory: {dirname}')
        for filename in filenames:
            print(f'  File: {filename}')

if __name__ == '__main__':
    start_path = 'lab/os_walk'
    list_files(start_path)
```

Ejecuta el script:

```sh
python list_files.py
```

### Paso 4: Filtrar Archivos por Extensión

Modifica el script para filtrar archivos por extensión:

```python
import os

def list_files(start_path, file_extension=None):
    for dirpath, dirnames, filenames in os.walk(start_path):
        print(f'Directory: {dirpath}')
        for dirname in dirnames:
            print(f'  Subdirectory: {dirname}')
        for filename in filenames:
            if file_extension and filename.endswith(file_extension):
                print(f'  File: {filename}')
            elif not file_extension:
                print(f'  File: {filename}')

if __name__ == '__main__':
    start_path = 'lab/os_walk'
    file_extension = '.txt'  # Cambia la extensión según sea necesario
    list_files(start_path, file_extension)
```

Ejecuta el script con la extensión que desees filtrar:

```sh
python list_files.py
```

### Paso 5: Realizar Operaciones de Limpieza

Agrega funcionalidad para eliminar archivos con una extensión específica:

```python
import os

def clean_files(start_path, file_extension):
    for dirpath, dirnames, filenames in os.walk(start_path):
        for filename in filenames:
            if filename.endswith(file_extension):
                file_path = os.path.join(dirpath, filename)
                print(f'Removing file: {file_path}')
                os.remove(file_path)

if __name__ == '__main__':
    start_path = 'lab/os_walk'
    file_extension = '.log'  # Extensión de archivos a eliminar
    clean_files(start_path, file_extension)
```

Ejecuta el script para eliminar los archivos con la extensión especificada:

```sh
python clean_files.py
```

### Paso 6: Mover Archivos a Otro Directorio

Agrega funcionalidad para mover archivos a otro directorio:

```python
import os
import shutil

def move_files(start_path, file_extension, destination_path):
    if not os.path.exists(destination_path):
        os.makedirs(destination_path)

    for dirpath, dirnames, filenames in os.walk(start_path):
        for filename in filenames:
            if filename.endswith(file_extension):
                source_file = os.path.join(dirpath, filename)
                destination_file = os.path.join(destination_path, filename)
                print(f'Moving file: {source_file} to {destination_file}')
                shutil.move(source_file, destination_file)

if __name__ == '__main__':
    start_path = 'lab/os_walk'
    file_extension = '.txt'  # Extensión de archivos a mover
    destination_path = 'lab/os_walk/moved_files'
    move_files(start_path, file_extension, destination_path)
```

Ejecuta el script para mover los archivos con la extensión especificada al directorio de destino:

```sh
python move_files.py
```

### Conclusión

En este laboratorio, hemos aprendido a utilizar la función `os.walk()` de la biblioteca `os` en Python para realizar tareas de administración de directorios y archivos. Hemos explorado cómo listar archivos y directorios, filtrar archivos por extensión, y realizar operaciones de limpieza y organización, como eliminar y mover archivos. Esta funcionalidad es extremadamente útil para administradores de sistemas y desarrolladores que necesitan gestionar estructuras de directorios complejas.