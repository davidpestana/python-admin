# Creación de Daemons en Python

## Introducción

Un daemon es un proceso que se ejecuta en segundo plano, a menudo iniciándose con el sistema operativo y ejecutándose sin intervención del usuario. Los daemons son esenciales para tareas como la supervisión de sistemas, la recolección de datos, y la ejecución de tareas programadas. En esta guía, exploraremos cómo crear daemons en Python utilizando el módulo `daemon`, con ejemplos prácticos y casos de uso comunes.

## Uso del módulo `daemon`

El módulo `daemon` en Python facilita la creación de daemons siguiendo el estándar PEP 3143. Este módulo asegura que el proceso se desacople del terminal y se ejecute en segundo plano correctamente.

### Instalación del módulo `daemon`

Primero, asegúrate de tener el módulo `daemon` instalado. Puedes instalarlo utilizando `pip` si aún no lo tienes.

```bash
pip install python-daemon
```

### Ejemplo básico de un daemon en Python

Aquí tienes un ejemplo básico de un daemon que simplemente escribe un mensaje en un archivo de log cada cierto intervalo de tiempo.

#### Código del Daemon Básico

```python
import daemon
import time

def tarea_del_daemon():
    with open("/var/log/daemon_example.log", "a") as log:
        while True:
            log.write(f"Daemon ejecutándose a las {time.ctime()}\n")
            log.flush()
            time.sleep(60)

with daemon.DaemonContext():
    tarea_del_daemon()
```

### Ejecución del Daemon

Guarda el código en un archivo, por ejemplo `daemon_example.py`, y ejecútalo desde la línea de comandos.

```bash
python daemon_example.py
```

*Ejemplo práctico:* Este daemon escribe una entrada en el log cada minuto, útil para verificar que el daemon está funcionando correctamente.

## Casos Prácticos

### Caso Práctico 1: Monitoreo de Uso de CPU

Vamos a crear un daemon que monitoree el uso de la CPU y registre los datos en un archivo de log. Esto es útil para detectar picos de uso y potenciales problemas de rendimiento.

#### Código del Daemon de Monitoreo de CPU

```python
import daemon
import time
import psutil

def monitorear_cpu():
    with open("/var/log/daemon_cpu.log", "a") as log:
        while True:
            uso_cpu = psutil.cpu_percent(interval=1)
            log.write(f"Uso de CPU a las {time.ctime()}: {uso_cpu}%\n")
            log.flush()
            time.sleep(5)

with daemon.DaemonContext():
    monitorear_cpu()
```

#### Instalación del Módulo `psutil`

Asegúrate de tener el módulo `psutil` instalado.

```bash
pip install psutil
```

*Ejemplo práctico:* Este daemon monitorea y registra el uso de la CPU cada 5 segundos, ayudando a identificar patrones de uso intensivo del procesador.

### Caso Práctico 2: Monitoreo de Espacio en Disco

Crea un daemon que monitoree el espacio en disco disponible y envíe una alerta por correo electrónico si el espacio disponible cae por debajo de un umbral definido.

#### Código del Daemon de Monitoreo de Espacio en Disco

```python
import daemon
import time
import shutil
import smtplib
from email.mime.text import MIMEText

def enviar_alerta(espacio_libre):
    msg = MIMEText(f"Alerta: Espacio en disco bajo. Espacio disponible: {espacio_libre}%")
    msg['Subject'] = 'Alerta de Espacio en Disco'
    msg['From'] = 'alerta@example.com'
    msg['To'] = 'admin@example.com'

    with smtplib.SMTP('localhost') as s:
        s.send_message(msg)

def monitorear_espacio_disco():
    umbral = 20  # porcentaje de espacio libre mínimo
    while True:
        total, usado, libre = shutil.disk_usage("/")
        porcentaje_libre = (libre / total) * 100
        if porcentaje_libre < umbral:
            enviar_alerta(porcentaje_libre)
        time.sleep(3600)

with daemon.DaemonContext():
    monitorear_espacio_disco()
```

#### Configuración del Servidor SMTP

Asegúrate de tener un servidor SMTP configurado localmente o ajusta el código para usar un servidor SMTP externo.

*Ejemplo práctico:* Este daemon monitorea el espacio en disco cada hora y envía una alerta por correo electrónico si el espacio disponible cae por debajo del 20%.

### Caso Práctico 3: Automatización de Backups

Crea un daemon que realice copias de seguridad automáticas de un directorio específico a otro.

#### Código del Daemon de Backups

```python
import daemon
import time
import shutil

def realizar_backup():
    origen = "/path/to/source"
    destino = "/path/to/backup"
    while True:
        shutil.copytree(origen, destino, dirs_exist_ok=True)
        time.sleep(86400)  # 24 horas

with daemon.DaemonContext():
    realizar_backup()
```

*Ejemplo práctico:* Este daemon realiza una copia de seguridad del directorio `/path/to/source` al directorio `/path/to/backup` cada 24 horas, asegurando que los datos estén siempre respaldados.

## Consideraciones de Seguridad

Al ejecutar daemons, es importante considerar las prácticas de seguridad:

1. **Permisos de Archivo:** Asegúrate de que los archivos y directorios a los que accede el daemon tengan los permisos adecuados para evitar accesos no autorizados.
2. **Configuración del Contexto del Daemon:** Utiliza las opciones del `DaemonContext` para establecer el entorno de ejecución seguro, como usuario, grupo, y directorios de trabajo.
3. **Manejo de Errores:** Implementa un manejo robusto de errores para asegurarte de que el daemon maneje las excepciones de manera adecuada y no termine inesperadamente.

#### Configuración Avanzada del Contexto del Daemon

```python
import daemon
import pwd
import grp

context = daemon.DaemonContext(
    working_directory='/var/lib/daemon',
    umask=0o002,
    uid=pwd.getpwnam('daemonuser').pw_uid,
    gid=grp.getgrnam('daemongroup').gr_gid,
    stdout=open('/var/log/daemon_stdout.log', 'w+'),
    stderr=open('/var/log/daemon_stderr.log', 'w+')
)

with context:
    # Código del daemon aquí
    pass
```

*Ejemplo práctico:* Esta configuración asegura que el daemon se ejecute en un entorno controlado con los permisos adecuados.

## Conclusión

Crear daemons en Python es una tarea poderosa y relativamente sencilla gracias al módulo `daemon`. Los daemons permiten ejecutar tareas en segundo plano de manera eficiente y fiable, lo que es crucial para muchas operaciones de administración de sistemas. Los ejemplos y casos prácticos proporcionados te ayudarán a implementar soluciones efectivas para la supervisión, notificación y automatización de tareas críticas en tu entorno de TI.
