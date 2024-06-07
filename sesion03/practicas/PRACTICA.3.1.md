### Laboratorio: Interacción con el Sistema Operativo

#### Práctica 1: Ejecución de Comandos del Sistema desde Python

### Objetivos:
1. Aprender a ejecutar comandos del sistema operativo desde Python.
2. Comprender cómo capturar y manejar la salida de estos comandos.

### Recursos Necesarios:
- Un entorno de desarrollo Python.
- Conocimientos básicos de comandos del sistema operativo.

### Paso 1: Introducción a `subprocess.run()`

El módulo `subprocess` proporciona una interfaz para ejecutar comandos del sistema operativo desde Python. Comenzaremos con la función `subprocess.run()`, que es una forma sencilla y directa de ejecutar un comando.

**Ejemplo Inicial: Ejecutar un Comando Simple**

```python
import subprocess

# Ejecutar un comando simple
resultado = subprocess.run(['ls', '-l'])

# Verificar el código de retorno
print(f"Código de retorno: {resultado.returncode}")
```

- `subprocess.run()` ejecuta el comando especificado y espera a que termine.
- El argumento es una lista que contiene el comando y sus argumentos.
- `returncode` es el código de retorno del comando ejecutado (0 significa éxito).

### Paso 2: Capturar la Salida del Comando

Para capturar la salida de un comando, utilizamos los parámetros `capture_output=True` y `text=True`.

**Ejemplo: Capturar la Salida del Comando**

```python
import subprocess

# Ejecutar el comando y capturar la salida
resultado = subprocess.run(['ls', '-l'], capture_output=True, text=True)

# Imprimir la salida estándar y los errores
print(f"Salida estándar:\n{resultado.stdout}")
print(f"Errores estándar:\n{resultado.stderr}")
```

- `capture_output=True` indica que queremos capturar la salida estándar (stdout) y los errores estándar (stderr).
- `text=True` convierte la salida capturada de bytes a string.

### Paso 3: Manejo de Errores

Es importante manejar errores al ejecutar comandos. Podemos usar `try-except` para capturar excepciones.

**Ejemplo: Manejo de Errores**

```python
import subprocess

try:
    resultado = subprocess.run(['ls', '/directorio/que/no/existe'], capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"Error al ejecutar el comando: {e}")
    print(f"Salida estándar:\n{e.stdout}")
    print(f"Errores estándar:\n{e.stderr}")
```

- `check=True` lanza una excepción `CalledProcessError` si el comando devuelve un código de error distinto de cero.
- Capturamos la excepción y podemos acceder a la salida y los errores del comando fallido.

### Ejemplo Completo de Ejecución de Comandos

Combinar todo lo aprendido en un script completo.

```python
import subprocess

def ejecutar_comando(comando):
    try:
        resultado = subprocess.run(comando, capture_output=True, text=True, check=True)
        print(f"Comando ejecutado: {' '.join(comando)}")
        print(f"Salida estándar:\n{resultado.stdout}")
        print(f"Errores estándar:\n{resultado.stderr}")
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar el comando: {e}")
        print(f"Salida estándar:\n{e.stdout}")
        print(f"Errores estándar:\n{e.stderr}")

# Ejemplo de uso
comando = ['ls', '-l']
ejecutar_comando(comando)
```

### Práctica 2: Gestión de Procesos

### Objetivos:
1. Aprender a gestionar procesos utilizando el módulo `subprocess`.
2. Ejecutar comandos en segundo plano y comunicarse con procesos en ejecución.

### Paso 1: Ejecutar Comandos en Segundo Plano

Utilizamos `subprocess.Popen` para ejecutar comandos en segundo plano, lo que permite continuar con la ejecución del script mientras el comando se ejecuta.

**Ejemplo Inicial: Ejecutar un Comando en Segundo Plano**

```python
import subprocess

# Ejecutar un comando en segundo plano
proceso = subprocess.Popen(['sleep', '5'])
print("Proceso iniciado.")
```

- `subprocess.Popen` ejecuta el comando y retorna inmediatamente, sin esperar a que termine.

### Paso 2: Comunicar con el Proceso

Podemos comunicarnos con un proceso en ejecución utilizando `communicate()`, que permite enviar datos al proceso y leer su salida.

**Ejemplo: Comunicar con un Proceso**

```python
import subprocess

# Ejecutar un comando y comunicarse con él
proceso = subprocess.Popen(['cat'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)

# Enviar datos al proceso y obtener la salida
salida, _ = proceso.communicate(input='Hola, Mundo!')
print(f"Salida del proceso:\n{salida}")
```

- `stdin=subprocess.PIPE` permite enviar datos al proceso.
- `stdout=subprocess.PIPE` permite capturar la salida del proceso.
- `text=True` convierte la entrada y salida de bytes a string.

### Paso 3: Verificar el Estado del Proceso

Podemos verificar si un proceso ha terminado y obtener su código de retorno utilizando `poll()` y `wait()`.

**Ejemplo: Verificar el Estado del Proceso**

```python
import subprocess
import time

# Ejecutar un comando en segundo plano
proceso = subprocess.Popen(['sleep', '5'])
print("Proceso iniciado.")

# Verificar si el proceso ha terminado
while proceso.poll() is None:
    print("El proceso sigue en ejecución...")
    time.sleep(1)

# Obtener el código de retorno
codigo_retorno = proceso.wait()
print(f"Proceso terminado con código de retorno: {codigo_retorno}")
```

- `poll()` retorna `None` si el proceso sigue en ejecución.
- `wait()` espera a que el proceso termine y retorna su código de retorno.

### Ejemplo Completo de Gestión de Procesos

Combinar todo lo aprendido en un script completo.

```python
import subprocess
import time

def ejecutar_comando_en_segundo_plano(comando):
    proceso = subprocess.Popen(comando, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    print(f"Comando ejecutado en segundo plano: {' '.join(comando)}")
    return proceso

def verificar_proceso(proceso):
    while proceso.poll() is None:
        print("El proceso sigue en ejecución...")
        time.sleep(1)
    stdout, stderr = proceso.communicate()
    print(f"Proceso terminado con código de retorno: {proceso.returncode}")
    print(f"Salida estándar:\n{stdout}")
    print(f"Errores estándar:\n{stderr}")

# Ejemplo de uso
comando = ['sleep', '5']
proceso = ejecutar_comando_en_segundo_plano(comando)
verificar_proceso(proceso)
```

### Conclusión

En estas prácticas, has aprendido cómo ejecutar comandos del sistema operativo desde Python y cómo gestionar procesos en ejecución. Estas habilidades son esenciales para automatizar tareas y construir scripts eficientes en la administración de sistemas. Continúa practicando y experimentando con diferentes comandos y procesos para profundizar tu comprensión y mejorar tus habilidades.