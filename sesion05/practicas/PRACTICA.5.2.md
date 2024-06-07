### Práctica: Mantenimiento del Sistema

En esta práctica, vamos a escribir un script para limpiar archivos temporales y logs antiguos y automatizar su ejecución utilizando `cron`.

### Parte 1: Escribir un Script para Limpiar Archivos Temporales y Logs Antiguos

#### Paso 1: Limpieza de Archivos Temporales

Escribiremos una función para limpiar archivos temporales de directorios como `/tmp` y `/var/tmp`.

**Script para Limpiar Archivos Temporales**

```python
import os
import logging

def limpiar_archivos_temporales(directorios_temporales):
    for directorio in directorios_temporales:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    logging.info(f"Eliminado archivo temporal: {file_path}")
                except Exception as e:
                    logging.error(f"Error al eliminar {file_path}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    logging.basicConfig(filename='limpieza_sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    directorios_temporales = ['/tmp', '/var/tmp']
    limpiar_archivos_temporales(directorios_temporales)
```

#### Paso 2: Limpieza de Archivos de Registro (Logs) Antiguos

Escribiremos una función para limpiar archivos de registro que son más antiguos que un número específico de días.

**Script para Limpiar Archivos de Registro Antiguos**

```python
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
                        logging.info(f"Eliminado archivo de registro: {file_path}")
                    except Exception as e:
                        logging.error(f"Error al eliminar {file_path}: {e}")

# Ejemplo de uso
if __name__ == "__main__":
    logging.basicConfig(filename='limpieza_sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    directorio_logs = '/var/log'
    dias_maximos = 30
    limpiar_archivos_registro(directorio_logs, dias_maximos)
```

### Parte 2: Script Completo para la Limpieza del Sistema

Combina ambas funciones en un script completo que limpie archivos temporales y logs antiguos.

**Script Completo: Limpieza del Sistema**

```python
import os
import time
import logging

def limpiar_archivos_temporales(directorios_temporales):
    for directorio in directorios_temporales:
        for root, dirs, files in os.walk(directorio):
            for file in files:
                file_path = os.path.join(root, file)
                try:
                    os.remove(file_path)
                    logging.info(f"Eliminado archivo temporal: {file_path}")
                except Exception as e:
                    logging.error(f"Error al eliminar {file_path}: {e}")

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
                        logging.info(f"Eliminado archivo de registro: {file_path}")
                    except Exception as e:
                        logging.error(f"Error al eliminar {file_path}: {e}")

if __name__ == "__main__":
    logging.basicConfig(filename='limpieza_sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    logging.info("Inicio de la limpieza del sistema")

    directorios_temporales = ['/tmp', '/var/tmp']
    limpiar_archivos_temporales(directorios_temporales)

    directorio_logs = '/var/log'
    dias_maximos = 30
    limpiar_archivos_registro(directorio_logs, dias_maximos)

    logging.info("Limpieza del sistema completada")
```

### Parte 3: Automatizar la Ejecución del Script con `cron`

#### Paso 1: Añadir el Script a `crontab`

Para programar la ejecución del script de limpieza utilizando `cron`, sigue los siguientes pasos:

1. **Abrir `crontab`:**

```shell
crontab -e
```

2. **Añadir una Entrada en `crontab`:**

Añade la siguiente línea para programar la ejecución diaria a las 3:00 AM:

```shell
0 3 * * * /usr/bin/python3 /ruta/al/script/limpieza_sistema.py
```

**Desglose de la Línea de `crontab`:**
- `0 3 * * *`: Ejecuta el comando a las 3:00 AM todos los días.
- `/usr/bin/python3`: Ruta al intérprete de Python.
- `/ruta/al/script/limpieza_sistema.py`: Ruta al script de limpieza.

#### Paso 2: Verificar las Entradas de `crontab`

Para listar todas las tareas programadas en `crontab` para el usuario actual, usa el comando:

```shell
crontab -l
```

### Conclusión

En esta práctica, has aprendido cómo escribir un script para limpiar archivos temporales y logs antiguos, y cómo automatizar su ejecución utilizando `cron`. Estas habilidades son esenciales para el mantenimiento eficiente del sistema, asegurando que el sistema operativo se mantenga limpio y funcionando de manera óptima. Continúa practicando y expandiendo estos scripts para incluir otras tareas de mantenimiento y monitoreo, asegurando así un entorno de sistema optimizado y libre de problemas.