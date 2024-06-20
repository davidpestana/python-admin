# Práctica 10.1: Automatización Compleja

## Objetivo

El objetivo de esta práctica es desarrollar un script avanzado que integre Bash y Python para automatizar una tarea específica. Se busca que el script esté bien documentado, probado y eficiente.

## Ejercicio

### 1. Desarrollar un Script Avanzado que Integre Bash y Python

En este ejercicio, crearemos un script que realiza las siguientes tareas:

1. **Recopila datos del sistema** utilizando Bash.
2. **Procesa los datos** utilizando Python.
3. **Genera un informe** y lo envía por correo electrónico.

#### Parte 1: Recopilación de Datos del Sistema con Bash

El primer paso es recopilar datos del sistema, como uso de CPU, memoria y disco.

##### Script de Bash para Recopilar Datos

```bash
#!/bin/bash

# Archivo de salida
OUTPUT_FILE="/tmp/system_stats.txt"

# Recopilar uso de CPU
echo "Uso de CPU:" > $OUTPUT_FILE
mpstat >> $OUTPUT_FILE

# Recopilar uso de memoria
echo -e "\nUso de Memoria:" >> $OUTPUT_FILE
free -h >> $OUTPUT_FILE

# Recopilar uso de disco
echo -e "\nUso de Disco:" >> $OUTPUT_FILE
df -h >> $OUTPUT_FILE

echo "Datos del sistema recopilados en $OUTPUT_FILE"
```

##### Guardar el Script

Guarda el script con el nombre `recopilar_datos_sistema.sh`.

##### Hacer el Script Ejecutable

```bash
chmod +x recopilar_datos_sistema.sh
```

### 2. Procesar los Datos con Python

El siguiente paso es procesar los datos recopilados para generar un informe.

##### Script de Python para Procesar los Datos

```python
import os

# Archivo de entrada y salida
input_file = "/tmp/system_stats.txt"
output_file = "/tmp/system_report.html"

# Leer los datos del archivo
with open(input_file, 'r') as file:
    data = file.read()

# Crear el informe HTML
html_content = f"""
<html>
<head>
    <title>Informe del Sistema</title>
</head>
<body>
    <h1>Informe del Sistema</h1>
    <pre>{data}</pre>
</body>
</html>
"""

# Escribir el informe HTML en el archivo de salida
with open(output_file, 'w') as file:
    file.write(html_content)

print(f"Informe HTML generado en {output_file}")
```

##### Guardar el Script

Guarda el script con el nombre `procesar_datos.py`.

### 3. Generar el Informe y Enviarlo por Correo Electrónico

El último paso es enviar el informe generado por correo electrónico.

##### Script de Python para Enviar el Correo Electrónico

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Configuración del correo electrónico
sender_email = "tu_correo@example.com"
receiver_email = "destinatario@example.com"
password = "tu_contraseña"
subject = "Informe del Sistema"
body = "Adjunto el informe del sistema en formato HTML."

# Leer el contenido del informe HTML
with open("/tmp/system_report.html", "r") as file:
    report_content = file.read()

# Crear el mensaje
msg = MIMEMultipart()
msg['From'] = sender_email
msg['To'] = receiver_email
msg['Subject'] = subject

msg.attach(MIMEText(body, 'plain'))
msg.attach(MIMEText(report_content, 'html'))

# Enviar el correo electrónico
with smtplib.SMTP('smtp.example.com', 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, msg.as_string())

print("Correo electrónico enviado con el informe del sistema.")
```

##### Guardar el Script

Guarda el script con el nombre `enviar_informe.py`.

### 4. Automatizar Todo el Proceso con un Script Principal en Bash

Finalmente, crearemos un script principal que ejecute todos los pasos anteriores en secuencia.

##### Script Principal en Bash

```bash
#!/bin/bash

# Archivo de log
LOGFILE="/var/log/automatizacion_compleja.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Preparación
registrar "Iniciando la automatización compleja."

# Recopilar datos del sistema
registrar "Recopilando datos del sistema..."
./recopilar_datos_sistema.sh

# Procesar los datos
registrar "Procesando datos..."
python3 procesar_datos.py

# Enviar el informe
registrar "Enviando informe por correo electrónico..."
python3 enviar_informe.py

registrar "Automatización completada."
```

##### Guardar el Script

Guarda el script con el nombre `automatizacion_compleja.sh`.

##### Hacer el Script Ejecutable

```bash
chmod +x automatizacion_compleja.sh
```

##### Ejecutar el Script Principal

```bash
./automatizacion_compleja.sh
```

## Documentación del Script

Es importante documentar el script para facilitar su comprensión y mantenimiento. Asegúrate de incluir comentarios explicativos y una guía de uso.

### Ejemplo de Documentación

#### Script de Recopilación de Datos (recopilar_datos_sistema.sh)

```bash
#!/bin/bash

# Script para recopilar datos del sistema (CPU, memoria, disco)
# y guardarlos en un archivo de texto.

# Archivo de salida
OUTPUT_FILE="/tmp/system_stats.txt"

# Recopilar uso de CPU
echo "Uso de CPU:" > $OUTPUT_FILE
mpstat >> $OUTPUT_FILE

# Recopilar uso de memoria
echo -e "\nUso de Memoria:" >> $OUTPUT_FILE
free -h >> $OUTPUT_FILE

# Recopilar uso de disco
echo -e "\nUso de Disco:" >> $OUTPUT_FILE
df -h >> $OUTPUT_FILE

echo "Datos del sistema recopilados en $OUTPUT_FILE"
```

#### Script de Procesamiento de Datos (procesar_datos.py)

```python
# Script para procesar los datos del sistema recopilados y generar un informe HTML.

import os

# Archivo de entrada y salida
input_file = "/tmp/system_stats.txt"
output_file = "/tmp/system_report.html"

# Leer los datos del archivo
with open(input_file, 'r') as file:
    data = file.read()

# Crear el informe HTML
html_content = f"""
<html>
<head>
    <title>Informe del Sistema</title>
</head>
<body>
    <h1>Informe del Sistema</h1>
    <pre>{data}</pre>
</body>
</html>
"""

# Escribir el informe HTML en el archivo de salida
with open(output_file, 'w') as file:
    file.write(html_content)

print(f"Informe HTML generado en {output_file}")
```

#### Script de Envío de Correo (enviar_informe.py)

```python
# Script para enviar el informe del sistema por correo electrónico.

import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Configuración del correo electrónico
sender_email = "tu_correo@example.com"
receiver_email = "destinatario@example.com"
password = "tu_contraseña"
subject = "Informe del Sistema"
body = "Adjunto el informe del sistema en formato HTML."

# Leer el contenido del informe HTML
with open("/tmp/system_report.html", "r") as file:
    report_content = file.read()

# Crear el mensaje
msg = MIMEMultipart()
msg['From'] = sender_email
msg['To'] = receiver_email
msg['Subject'] = subject

msg.attach(MIMEText(body, 'plain'))
msg.attach(MIMEText(report_content, 'html'))

# Enviar el correo electrónico
with smtplib.SMTP('smtp.example.com', 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, msg.as_string())

print("Correo electrónico enviado con el informe del sistema.")
```

#### Script Principal (automatizacion_compleja.sh)

```bash
#!/bin/bash

# Script principal para automatizar la recopilación de datos del sistema,
# procesamiento de los datos y generación de un informe que se envía por correo electrónico.

# Archivo de log
LOGFILE="/var/log/automatizacion_compleja.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Preparación
registrar "Iniciando la automatización compleja."

# Recopilar datos del sistema
registrar "Recopilando datos del sistema..."
./recopilar_datos_sistema.sh

# Procesar los datos
registrar "Procesando datos..."
python3 procesar_datos.py

# Enviar el informe
registrar "Enviando informe por correo electrónico..."
python3 enviar_informe.py

registrar "Automatización completada."
```

## Conclusión

La integración de Bash y Python permite aprovechar las fortalezas de ambos lenguajes para automatizar tareas complejas de manera eficiente. Este ejercicio proporciona una guía completa para desarrollar, documentar y probar un
