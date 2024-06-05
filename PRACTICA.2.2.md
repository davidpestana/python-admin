### Laboratorio: Automatización de Tareas con Python

#### Práctica: Escribir Scripts para Automatizar la Gestión de Archivos

En este laboratorio, aprenderás a escribir scripts en Python para mover archivos antiguos a un directorio de respaldo y para automatizar la creación de directorios y la copia de archivos. Estas tareas son comunes en la administración de sistemas y la automatización de estas puede ahorrar tiempo y reducir errores.

### Objetivos:
1. Escribir un script para mover archivos antiguos a un directorio de respaldo.
2. Automatizar la creación de directorios y la copia de archivos.

---

### Parte 1: Mover Archivos Antiguos a un Directorio de Respaldo

#### Paso 1: Importar Módulos Necesarios

Utilizaremos los módulos `os`, `shutil` y `time` para gestionar archivos y directorios y para manejar tiempos.

```python
import os
import shutil
import time
```

#### Paso 2: Definir la Función para Mover Archivos Antiguos

Definiremos una función `mover_archivos_antiguos` que tome como argumentos el directorio de origen, el directorio de respaldo y el número de días. Los archivos que no hayan sido modificados en los últimos `n` días serán movidos al directorio de respaldo.

```python
def mover_archivos_antiguos(origen, respaldo, dias):
    # Crear el directorio de respaldo si no existe
    if not os.path.exists(respaldo):
        os.makedirs(respaldo)
    
    ahora = time.time()
    
    # Iterar sobre los archivos en el directorio de origen
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            tiempo_modificacion = os.path.getmtime(ruta_completa)
            # Calcular la diferencia en días
            if (ahora - tiempo_modificacion) // (24 * 3600) >= dias:
                shutil.move(ruta_completa, respaldo)
                print(f"Movido: {ruta_completa} a {respaldo}")
```

#### Paso 3: Configurar Directorios y Ejecutar la Función

Definimos el directorio de origen, el directorio de respaldo y el número de días para determinar qué archivos mover.

```python
origen = '/ruta/al/directorio/origen'
respaldo = '/ruta/al/directorio/respaldo'
dias = 30

# Ejecutar la función para mover archivos antiguos
mover_archivos_antiguos(origen, respaldo, dias)
```

#### Script Completo para Mover Archivos Antiguos

```python
import os
import shutil
import time

def mover_archivos_antiguos(origen, respaldo, dias):
    if not os.path.exists(respaldo):
        os.makedirs(respaldo)
    
    ahora = time.time()
    
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            tiempo_modificacion = os.path.getmtime(ruta_completa)
            if (ahora - tiempo_modificacion) // (24 * 3600) >= dias:
                shutil.move(ruta_completa, respaldo)
                print(f"Movido: {ruta_completa} a {respaldo}")

origen = '/ruta/al/directorio/origen'
respaldo = '/ruta/al/directorio/respaldo'
dias = 30

mover_archivos_antiguos(origen, respaldo, dias)
```

#### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `mover_archivos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `mover_archivos.py`.
   - Ejecuta el script:

     ```shell
     python mover_archivos.py
     ```

---

### Parte 2: Automatizar la Creación de Directorios y la Copia de Archivos

#### Paso 1: Importar Módulos Necesarios

Utilizaremos los módulos `os` y `shutil` para gestionar archivos y directorios.

```python
import os
import shutil
```

#### Paso 2: Definir la Función para Crear Directorios y Copiar Archivos

Definiremos una función `copiar_archivos` que tome como argumentos el directorio de origen y el directorio de destino. Si el directorio de destino no existe, se creará. Luego, los archivos del directorio de origen serán copiados al directorio de destino.

```python
def copiar_archivos(origen, destino):
    # Crear el directorio de destino si no existe
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    # Iterar sobre los archivos en el directorio de origen
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            shutil.copy(ruta_completa, destino)
            print(f"Copiado: {ruta_completa} a {destino}")
```

#### Paso 3: Configurar Directorios y Ejecutar la Función

Definimos el directorio de origen y el directorio de destino para la copia de archivos.

```python
origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino'

# Ejecutar la función para copiar archivos
copiar_archivos(origen, destino)
```

#### Script Completo para Copiar Archivos

```python
import os
import shutil

def copiar_archivos(origen, destino):
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            shutil.copy(ruta_completa, destino)
            print(f"Copiado: {ruta_completa} a {destino}")

origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino'

copiar_archivos(origen, destino)
```

#### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `copiar_archivos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `copiar_archivos.py`.
   - Ejecuta el script:

     ```shell
     python copiar_archivos.py
     ```

---

### Recursos Adicionales

- [Documentación oficial del módulo `shutil`](https://docs.python.org/3/library/shutil.html)
- [Documentación oficial del módulo `os`](https://docs.python.org/3/library/os.html)

### Conclusión

En este laboratorio, has aprendido a escribir scripts para mover archivos antiguos a un directorio de respaldo y para automatizar la creación de directorios y la copia de archivos en Python. Estas habilidades son esenciales para la automatización de tareas de administración de sistemas, lo que puede ahorrar tiempo y reducir la posibilidad de errores humanos. Continúa practicando y adaptando estos scripts a tus necesidades específicas para mejorar tu eficiencia y competencia en la administración de sistemas.