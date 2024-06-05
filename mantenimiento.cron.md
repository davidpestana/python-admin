### Sesión 5: Monitoreo y Mantenimiento del Sistema

#### Objetivos:
1. Aprender a monitorear los recursos del sistema utilizando Python.
2. Implementar scripts para la limpieza y mantenimiento del sistema.
3. Programar tareas periódicas utilizando `cron`.

### Programación de Tareas con `cron`

`cron` es una utilidad de Unix/Linux que permite a los usuarios programar tareas para que se ejecuten automáticamente en intervalos regulares (por ejemplo, diariamente, semanalmente o mensualmente). Los trabajos programados se definen en un archivo denominado `crontab`.

### Sintaxis de `crontab`

La sintaxis básica de una entrada en `crontab` es:

```
* * * * * comando a ejecutar
- - - - -
| | | | |
| | | | +--- Día de la semana (0 - 7) (Domingo=0 o 7)
| | | +----- Mes (1 - 12)
| | +------- Día del mes (1 - 31)
| +--------- Hora (0 - 23)
+----------- Minuto (0 - 59)
```

### Ejemplos Comunes de `crontab`

- Ejecutar un script todos los días a las 2:30 AM:
  ```
  30 2 * * * /ruta/al/script.sh
  ```
- Ejecutar un script todos los lunes a las 3:00 PM:
  ```
  0 15 * * 1 /ruta/al/script.sh
  ```
- Ejecutar un script cada hora:
  ```
  0 * * * * /ruta/al/script.sh
  ```

### Uso de `crontab` para Programar Tareas

#### Paso 1: Crear un Script de Limpieza

Primero, crea un script de limpieza del sistema que queremos programar.

**Script de Limpieza del Sistema (`limpieza_sistema.py`)**

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

#### Paso 2: Crear un Archivo `crontab`

Para programar la ejecución de este script, necesitamos añadir una entrada en `crontab`. Primero, abrimos el archivo `crontab` para el usuario actual con el comando:

```shell
crontab -e
```

#### Paso 3: Añadir una Entrada en `crontab`

Añade la siguiente línea para programar la ejecución del script de limpieza diariamente a las 2:00 AM:

```shell
0 2 * * * /usr/bin/python3 /ruta/al/script/limpieza_sistema.py
```

**Desglose de la Línea de `crontab`:**
- `0 2 * * *`: Ejecuta el comando a las 2:00 AM todos los días.
- `/usr/bin/python3`: Ruta al intérprete de Python.
- `/ruta/al/script/limpieza_sistema.py`: Ruta al script de limpieza.

### Verificar las Entradas de `crontab`

Para listar todas las tareas programadas en `crontab` para el usuario actual, usa el comando:

```shell
crontab -l
```

### Ejemplo Completo de Uso de `crontab`

**1. Crear el Script de Limpieza:**

Guarda el siguiente código en un archivo llamado `limpieza_sistema.py`.

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

**2. Añadir el Script a `crontab`:**

Abre el archivo `crontab` con:

```shell
crontab -e
```

Añade la siguiente línea para programar la ejecución diaria a las 2:00 AM:

```shell
0 2 * * * /usr/bin/python3 /ruta/al/script/limpieza_sistema.py
```

### Verificar la Configuración de `crontab`

Para verificar que la entrada se añadió correctamente, usa:

```shell
crontab -l
```

### Conclusión

En esta sesión, has aprendido cómo utilizar `cron` para programar tareas periódicas, como la ejecución de scripts de limpieza del sistema. La capacidad de automatizar tareas de mantenimiento es crucial para mantener un sistema operativo limpio y funcionando de manera eficiente. Continúa practicando y expandiendo estos scripts para incluir otras tareas de mantenimiento y monitoreo, asegurando así un entorno de sistema optimizado y libre de problemas.