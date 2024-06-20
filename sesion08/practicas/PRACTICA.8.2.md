# Práctica 8.2: Creación de Daemons en Python

## Objetivo

El objetivo de esta práctica es aprender a escribir daemons en Python para ejecutar tareas en segundo plano de manera eficiente y fiable. Esta habilidad es esencial para automatizar tareas repetitivas y continuas en un entorno de servidor.

## Ejercicio

### 1. Crear un archivo Python para el daemon

En este ejercicio, escribiremos un daemon que registre un mensaje en un archivo de log cada minuto.

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

#### Guardar el archivo

Guarda el código anterior en un archivo llamado `daemon_example.py`.

#### Hacer el archivo ejecutable

```bash
chmod +x daemon_example.py
```

#### Ejecutar el daemon

```bash
./daemon_example.py
```

### 2. Crear un daemon para monitorear el uso de la CPU

En este ejercicio, escribiremos un daemon que monitoree el uso de la CPU y registre los datos en un archivo de log.

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

#### Guardar el archivo

Guarda el código anterior en un archivo llamado `daemon_cpu.py`.

#### Hacer el archivo ejecutable

```bash
chmod +x daemon_cpu.py
```

#### Ejecutar el daemon

```bash
./daemon_cpu.py
```

### 3. Crear un daemon para monitorear el espacio en disco

En este ejercicio, escribiremos un daemon que monitoree el espacio en disco disponible y envíe una alerta por correo electrónico si el espacio disponible cae por debajo de un umbral definido.

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

#### Guardar el archivo

Guarda el código anterior en un archivo llamado `daemon_espacio_disco.py`.

#### Hacer el archivo ejecutable

```bash
chmod +x daemon_espacio_disco.py
```

#### Ejecutar el daemon

```bash
./daemon_espacio_disco.py
```

### 4. Crear un daemon para realizar backups automáticos

En este ejercicio, escribiremos un daemon que realice copias de seguridad automáticas de un directorio específico a otro.

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

#### Guardar el archivo

Guarda el código anterior en un archivo llamado `daemon_backup.py`.

#### Hacer el archivo ejecutable

```bash
chmod +x daemon_backup.py
```

#### Ejecutar el daemon

```bash
./daemon_backup.py
```

## Casos Prácticos

### Caso Práctico 1: Automatización de Tareas de Supervisión

Como administrador de sistemas, a menudo necesitas supervisar varios aspectos del sistema. Vamos a crear un daemon que combine múltiples funciones de supervisión.

#### Código del Daemon de Supervisión Combinada

```python
import daemon
import time
import psutil
import shutil
import smtplib
from email.mime.text import MIMEText

def enviar_alerta(mensaje):
    msg = MIMEText(mensaje)
    msg['Subject'] = 'Alerta del Sistema'
    msg['From'] = 'alerta@example.com'
    msg['To'] = 'admin@example.com'

    with smtplib.SMTP('localhost') as s:
        s.send_message(msg)

def monitorear_sistema():
    umbral_disco = 20  # porcentaje de espacio libre mínimo
    while True:
        # Monitoreo de CPU
        uso_cpu = psutil.cpu_percent(interval=1)
        with open("/var/log/daemon_sistema.log", "a") as log:
            log.write(f"Uso de CPU a las {time.ctime()}: {uso_cpu}%\n")
            log.flush()

        # Monitoreo de Espacio en Disco
        total, usado, libre = shutil.disk_usage("/")
        porcentaje_libre = (libre / total) * 100
        if porcentaje_libre < umbral_disco:
            enviar_alerta(f"Alerta: Espacio en disco bajo. Espacio disponible: {porcentaje_libre}%")
        time.sleep(3600)

with daemon.DaemonContext():
    monitorear_sistema()
```

#### Guardar el archivo

Guarda el código anterior en un archivo llamado `daemon_sistema.py`.

#### Hacer el archivo ejecutable

```bash
chmod +x daemon_sistema.py
```

#### Ejecutar el daemon

```bash
./daemon_sistema.py
```

## Conclusión

La creación de daemons en Python permite automatizar tareas críticas que deben ejecutarse en segundo plano de manera continua. Los ejemplos y casos prácticos proporcionados en esta práctica te ayudarán a implementar soluciones efectivas para la supervisión, notificación y automatización de tareas esenciales en tu entorno de TI.