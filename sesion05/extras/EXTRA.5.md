### Práctica Complementaria: Sistema de Monitoreo y Notificación Completo

#### Objetivo:
Desarrollar un sistema de monitoreo y notificación más complejo y útil, que incluya:
1. Monitoreo continuo de CPU, memoria, disco y red.
2. Registro de eventos importantes y métricas en una base de datos.
3. Generación de informes diarios.
4. Envío de notificaciones por correo electrónico para alertas críticas.
5. Programación de tareas usando `cron`.

### Descripción del Ejercicio:

En esta práctica, los estudiantes desarrollarán un sistema integral de monitoreo del sistema que:
1. Registra continuamente las métricas del sistema en una base de datos SQLite.
2. Genera un informe diario de las métricas y envía este informe por correo electrónico.
3. Envía alertas inmediatas por correo electrónico si las métricas del sistema superan ciertos umbrales críticos.

### Parte 1: Configuración del Proyecto

#### Paso 1: Instalación de Dependencias

Asegúrate de tener las siguientes librerías instaladas:

```shell
pip install psutil sqlite3 smtplib
```

### Parte 2: Monitoreo Continuo y Registro en una Base de Datos

#### Paso 1: Configuración de la Base de Datos SQLite

**Script para Configurar la Base de Datos**

```python
import sqlite3

def configurar_bd():
    conexion = sqlite3.connect('sistema.db')
    cursor = conexion.cursor()

    # Crear tabla para métricas del sistema
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS metrica_sistema (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            cpu REAL,
            memoria REAL,
            disco REAL,
            bytes_enviados INTEGER,
            bytes_recibidos INTEGER
        )
    ''')

    conexion.commit()
    conexion.close()

if __name__ == "__main__":
    configurar_bd()
```

#### Paso 2: Monitoreo y Registro de Métricas

**Script para Monitorear y Registrar Métricas**

```python
import psutil
import sqlite3
import time

def registrar_metricas():
    conexion = sqlite3.connect('sistema.db')
    cursor = conexion.cursor()

    uso_cpu = psutil.cpu_percent(interval=1)
    memoria_virtual = psutil.virtual_memory().percent
    uso_disco = psutil.disk_usage('/').percent
    estadisticas_red = psutil.net_io_counters()

    cursor.execute('''
        INSERT INTO metrica_sistema (cpu, memoria, disco, bytes_enviados, bytes_recibidos)
        VALUES (?, ?, ?, ?, ?)
    ''', (uso_cpu, memoria_virtual, uso_disco, estadisticas_red.bytes_sent, estadisticas_red.bytes_recv))

    conexion.commit()
    conexion.close()

if __name__ == "__main__":
    while True:
        registrar_metricas()
        time.sleep(300)  # Esperar 5 minutos antes de registrar nuevamente
```

### Parte 3: Generación de Informes Diarios

**Script para Generar Informe Diario y Enviarlo por Correo Electrónico**

```python
import sqlite3
import smtplib
from email.mime.text import MIMEText
from datetime import datetime, timedelta

def generar_informe():
    conexion = sqlite3.connect('sistema.db')
    cursor = conexion.cursor()

    # Seleccionar métricas del último día
    cursor.execute('''
        SELECT * FROM metrica_sistema WHERE timestamp >= datetime('now', '-1 day')
    ''')
    registros = cursor.fetchall()

    informe = "Informe Diario de Métricas del Sistema\n\n"
    for registro in registros:
        informe += f"Timestamp: {registro[1]}, CPU: {registro[2]}%, Memoria: {registro[3]}%, Disco: {registro[4]}%, Bytes Enviados: {registro[5]}, Bytes Recibidos: {registro[6]}\n"

    conexion.close()
    return informe

def enviar_informe(informe):
    remitente = 'tu_correo@gmail.com'
    destinatario = 'destinatario@example.com'
    password = 'tu_contraseña'

    msg = MIMEText(informe)
    msg['Subject'] = "Informe Diario de Métricas del Sistema"
    msg['From'] = remitente
    msg['To'] = destinatario

    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login(remitente, password)
        server.sendmail(remitente, destinatario, msg.as_string())

if __name__ == "__main__":
    informe = generar_informe()
    enviar_informe(informe)
```

### Parte 4: Configuración de Alertas Críticas

**Script para Enviar Alertas Críticas**

```python
import psutil
import smtplib
from email.mime.text import MIMEText

def enviar_alerta(asunto, mensaje):
    remitente = 'tu_correo@gmail.com'
    destinatario = 'destinatario@example.com'
    password = 'tu_contraseña'

    msg = MIMEText(mensaje)
    msg['Subject'] = asunto
    msg['From'] = remitente
    msg['To'] = destinatario

    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login(remitente, password)
        server.sendmail(remitente, destinatario, msg.as_string())

def verificar_metricas():
    uso_cpu = psutil.cpu_percent(interval=1)
    memoria_virtual = psutil.virtual_memory().percent
    uso_disco = psutil.disk_usage('/').percent

    if uso_cpu > 90:
        enviar_alerta("Alerta de CPU Alta", f"El uso de la CPU es {uso_cpu}%")
    if memoria_virtual > 90:
        enviar_alerta("Alerta de Memoria Alta", f"El uso de la memoria es {memoria_virtual}%")
    if uso_disco > 95:
        enviar_alerta("Alerta de Disco Alto", f"El uso del disco es {uso_disco}%")

if __name__ == "__main__":
    while True:
        verificar_metricas()
        time.sleep(300)  # Verificar cada 5 minutos
```

### Parte 5: Automatización con `cron`

#### Paso 1: Configuración de Tareas en `crontab`

1. **Abrir `crontab`:**

```shell
crontab -e
```

2. **Añadir Entradas en `crontab`:**

- Para el script de monitoreo continuo:

```shell
@reboot /usr/bin/python3 /ruta/al/script/monitoreo_registro.py
```

- Para el script de generación y envío de informes diarios:

```shell
0 6 * * * /usr/bin/python3 /ruta/al/script/informe_diario.py
```

- Para el script de verificación de métricas y envío de alertas:

```shell
*/5 * * * * /usr/bin/python3 /ruta/al/script/verificar_metricas.py
```

### Conclusión

Esta práctica complementaria ofrece a los estudiantes avanzados la oportunidad de desarrollar un sistema integral de monitoreo y notificación del sistema. Este sistema no solo monitorea continuamente las métricas del sistema, sino que también registra eventos importantes en una base de datos, genera informes diarios y envía alertas críticas por correo electrónico. La integración de `cron` para la automatización de tareas asegura que el sistema se mantenga monitoreado y mantenido sin intervención manual constante.