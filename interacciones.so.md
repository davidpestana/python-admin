### Sesión 3: Interacción con el Sistema Operativo

#### Objetivos:
1. Aprender a interactuar con el sistema operativo usando Python.
2. Manejar operaciones del sistema operativo mediante los módulos `os` y `subprocess`.

---

### Interacción con el Sistema Operativo

Python proporciona varios módulos para interactuar con el sistema operativo. Dos de los módulos más utilizados son `os` y `subprocess`. Estos módulos permiten realizar tareas como manipular archivos y directorios, ejecutar comandos del sistema y gestionar procesos.

---

### Uso del Módulo `os`

El módulo `os` proporciona una forma portátil de usar funcionalidades dependientes del sistema operativo como la manipulación de archivos y directorios. Aquí veremos las funciones más comunes y útiles del módulo `os`.

#### 1. Trabajando con Directorios

**Obtener el Directorio de Trabajo Actual:**

```python
import os

directorio_actual = os.getcwd()
print(f"Directorio de trabajo actual: {directorio_actual}")
```

**Cambiar el Directorio de Trabajo:**

```python
os.chdir('/ruta/al/nuevo/directorio')
print(f"Nuevo directorio de trabajo: {os.getcwd()}")
```

**Listar Archivos en un Directorio:**

```python
archivos = os.listdir('/ruta/al/directorio')
print("Archivos en el directorio:")
for archivo in archivos:
    print(archivo)
```

**Crear un Nuevo Directorio:**

```python
os.mkdir('/ruta/al/nuevo/directorio')
print("Directorio creado.")
```

**Eliminar un Directorio:**

```python
os.rmdir('/ruta/al/directorio/a/eliminar')
print("Directorio eliminado.")
```

**Crear Directorios Anidados:**

```python
os.makedirs('/ruta/al/nuevo/directorio/anidado')
print("Directorios anidados creados.")
```

**Eliminar Directorios Anidados:**

```python
os.removedirs('/ruta/al/directorio/anidado/a/eliminar')
print("Directorios anidados eliminados.")
```

#### 2. Trabajando con Archivos

**Renombrar un Archivo:**

```python
os.rename('/ruta/al/archivo.txt', '/ruta/al/nuevo_nombre.txt')
print("Archivo renombrado.")
```

**Eliminar un Archivo:**

```python
os.remove('/ruta/al/archivo/a/eliminar.txt')
print("Archivo eliminado.")
```

**Obtener Información de un Archivo:**

```python
informacion_archivo = os.stat('/ruta/al/archivo.txt')
print(f"Información del archivo: {informacion_archivo}")
```

#### 3. Variables de Entorno

**Obtener una Variable de Entorno:**

```python
usuario = os.getenv('USER')
print(f"Usuario: {usuario}")
```

**Establecer una Variable de Entorno:**

```python
os.environ['MI_VARIABLE'] = 'valor'
print(f"MI_VARIABLE: {os.getenv('MI_VARIABLE')}")
```

**Eliminar una Variable de Entorno:**

```python
del os.environ['MI_VARIABLE']
print("Variable de entorno eliminada.")
```

---

### Uso del Módulo `subprocess`

El módulo `subprocess` permite ejecutar nuevos programas y comandos del sistema operativo desde un script de Python. Es útil para tareas como la automatización de comandos de terminal y la ejecución de scripts externos.

#### 1. Ejecutar Comandos Simples

**Ejecutar un Comando y Obtener la Salida:**

```python
import subprocess

resultado = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(f"Salida del comando:\n{resultado.stdout}")
```

**Capturar la Salida y Errores:**

```python
resultado = subprocess.run(['ls', '-l', '/directorio/que/no/existe'], capture_output=True, text=True)
print(f"Salida del comando:\n{resultado.stdout}")
print(f"Errores del comando:\n{resultado.stderr}")
```

#### 2. Ejecutar Comandos con Entradas

**Pasar Entrada al Comando:**

```python
resultado = subprocess.run(['grep', 'texto'], input='Este es un texto de ejemplo\nOtra línea de texto', capture_output=True, text=True)
print(f"Salida del comando:\n{resultado.stdout}")
```

#### 3. Ejecutar Comandos en el Shell

**Ejecutar un Comando en el Shell:**

```python
resultado = subprocess.run('echo $USER', shell=True, capture_output=True, text=True)
print(f"Salida del comando:\n{resultado.stdout}")
```

#### 4. Gestionar Procesos

**Ejecutar un Comando en Segundo Plano:**

```python
proceso = subprocess.Popen(['sleep', '5'])
print("Proceso iniciado.")
proceso.wait()
print("Proceso terminado.")
```

**Comunicación con un Proceso en Ejecución:**

```python
proceso = subprocess.Popen(['cat'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
salida, _ = proceso.communicate(input='Hola, Mundo!')
print(f"Salida del proceso:\n{salida}")
```

---

### Ejemplo Completo: Crear un Script de Administración

Vamos a crear un script que utilice ambos módulos, `os` y `subprocess`, para realizar una tarea de administración: listar los archivos de un directorio, crear un nuevo directorio, copiar archivos y verificar el resultado.

#### Paso 1: Importar Módulos Necesarios

```python
import os
import shutil
import subprocess
```

#### Paso 2: Definir Funciones de Administración

**Función para Listar Archivos:**

```python
def listar_archivos(directorio):
    try:
        archivos = os.listdir(directorio)
        print(f"Archivos en {directorio}:")
        for archivo in archivos:
            print(archivo)
    except Exception as e:
        print(f"Error al listar archivos: {e}")
```

**Función para Crear un Nuevo Directorio:**

```python
def crear_directorio(directorio):
    try:
        os.makedirs(directorio, exist_ok=True)
        print(f"Directorio {directorio} creado.")
    except Exception as e:
        print(f"Error al crear directorio: {e}")
```

**Función para Copiar Archivos:**

```python
def copiar_archivos(origen, destino):
    try:
        for archivo in os.listdir(origen):
            ruta_completa = os.path.join(origen, archivo)
            if os.path.isfile(ruta_completa):
                shutil.copy(ruta_completa, destino)
                print(f"Copiado: {ruta_completa} a {destino}")
    except Exception as e:
        print(f"Error al copiar archivos: {e}")
```

**Función para Verificar el Contenido del Directorio:**

```python
def verificar_contenido(directorio):
    try:
        resultado = subprocess.run(['ls', '-l', directorio], capture_output=True, text=True)
        print(f"Contenido de {directorio}:\n{resultado.stdout}")
    except Exception as e:
        print(f"Error al verificar contenido: {e}")
```

#### Paso 3: Ejecución del Script

**Configurar Directorios:**

```python
directorio_origen = '/ruta/al/directorio/origen'
directorio_destino = '/ruta/al/nuevo/directorio'
```

**Ejecutar Funciones:**

```python
listar_archivos(directorio_origen)
crear_directorio(directorio_destino)
copiar_archivos(directorio_origen, directorio_destino)
verificar_contenido(directorio_destino)
```

**Script Completo:**

```python
import os
import shutil
import subprocess

def listar_archivos(directorio):
    try:
        archivos = os.listdir(directorio)
        print(f"Archivos en {directorio}:")
        for archivo in archivos:
            print(archivo)
    except Exception as e:
        print(f"Error al listar archivos: {e}")

def crear_directorio(directorio):
    try:
        os.makedirs(directorio, exist_ok=True)
        print(f"Directorio {directorio} creado.")
    except Exception as e:
        print(f"Error al crear directorio: {e}")

def copiar_archivos(origen, destino):
    try:
        for archivo in os.listdir(origen):
            ruta_completa = os.path.join(origen, archivo)
            if os.path.isfile(ruta_completa):
                shutil.copy(ruta_completa, destino)
                print(f"Copiado: {ruta_completa} a {destino}")
    except Exception as e:
        print(f"Error al copiar archivos: {e}")

def verificar_contenido(directorio):
    try:
        resultado = subprocess.run(['ls', '-l', directorio], capture_output=True, text=True)
        print(f"Contenido de {directorio}:\n{resultado.stdout}")
    except Exception as e:
        print(f"Error al verificar contenido: {e}")

directorio_origen = '/ruta/al/directorio/origen'
directorio_destino = '/ruta/al/nuevo/directorio'

listar_archivos(directorio_origen)
crear_directorio(directorio_destino)
copiar_archivos(directorio_origen, directorio_destino)
verificar_contenido(directorio_destino)
```

### Conclusión

La interacción con el sistema operativo utilizando Python y los módulos `os` y `subprocess` es una habilidad poderosa para automatizar tareas de administración de sistemas. Desde la gestión de archivos y directorios hasta la ejecución de comandos del sistema, estas herramientas permiten crear scripts eficientes y robustos para facilitar la administración y el mantenimiento del sistema