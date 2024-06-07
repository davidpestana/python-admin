### Práctica: Monitoreo del Sistema

En esta práctica, vamos a escribir un script que registre el uso del sistema en un archivo de log y configure alertas para eventos específicos, como el uso elevado del disco. Utilizaremos el módulo `psutil` para obtener información del sistema y el módulo `logging` para registrar los eventos.

### Parte 1: Crear un Script que Registre el Uso del Sistema en un Archivo de Log

#### Paso 1: Configurar el Registro

Utilizaremos el módulo `logging` para registrar la información del sistema en un archivo de log.

**Ejemplo de Configuración de `logging`**

```python
import logging

# Configurar el registro
logging.basicConfig(filename='sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
```

#### Paso 2: Registrar el Uso del Sistema

Crearemos funciones para registrar el uso de la CPU, la memoria, el disco y la red.

**Ejemplo de Registro del Uso del Sistema**

```python
import psutil
import logging

# Configurar el registro
logging.basicConfig(filename='sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def registrar_uso_cpu():
    uso_cpu = psutil.cpu_percent(interval=1)
    logging.info(f"Uso de la CPU: {uso_cpu}%")

def registrar_uso_memoria():
    memoria_virtual = psutil.virtual_memory()
    logging.info(f"Uso de la memoria virtual: {memoria_virtual.percent}%")

def registrar_uso_disco():
    uso_disco = psutil.disk_usage('/')
    logging.info(f"Uso del disco: {uso_disco.percent}%")

def registrar_uso_red():
    estadisticas_red = psutil.net_io_counters()
    logging.info(f"Bytes enviados: {estadisticas_red.bytes_sent}, Bytes recibidos: {estadisticas_red.bytes_recv}")

if __name__ == "__main__":
    registrar_uso_cpu()
    registrar_uso_memoria()
    registrar_uso_disco()
    registrar_uso_red()
```

### Parte 2: Configurar Alertas para Eventos Específicos

#### Paso 1: Configurar el Envío de Correos Electrónicos

Usaremos el módulo `smtplib` para enviar alertas por correo electrónico cuando se detecten eventos específicos.

**Ejemplo de Configuración de Alertas**

```python
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
        logging.info(f"Alerta enviada: {asunto}")
```

#### Paso 2: Implementar Funciones de Monitoreo con Alertas

Agregaremos lógica a las funciones de monitoreo para enviar alertas cuando se excedan ciertos umbrales.

**Ejemplo Completo con Alertas**

```python
import psutil
import logging
import smtplib
from email.mime.text import MIMEText

# Configurar el registro
logging.basicConfig(filename='sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Configurar el correo electrónico
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
        logging.info(f"Alerta enviada: {asunto}")

def registrar_uso_cpu():
    uso_cpu = psutil.cpu_percent(interval=1)
    logging.info(f"Uso de la CPU: {uso_cpu}%")
    if uso_cpu > 80:
        enviar_alerta("Alerta de CPU alta", f"El uso de la CPU es {uso_cpu}%")

def registrar_uso_memoria():
    memoria_virtual = psutil.virtual_memory()
    logging.info(f"Uso de la memoria virtual: {memoria_virtual.percent}%")
    if memoria_virtual.percent > 80:
        enviar_alerta("Alerta de memoria alta", f"El uso de la memoria es {memoria_virtual.percent}%")

def registrar_uso_disco():
    uso_disco = psutil.disk_usage('/')
    logging.info(f"Uso del disco: {uso_disco.percent}%")
    if uso_disco.percent > 90:
        enviar_alerta("Alerta de uso de disco alto", f"El uso del disco es {uso_disco.percent}%")

def registrar_uso_red():
    estadisticas_red = psutil.net_io_counters()
    logging.info(f"Bytes enviados: {estadisticas_red.bytes_sent}, Bytes recibidos: {estadisticas_red.bytes_recv}")

if __name__ == "__main__":
    registrar_uso_cpu()
    registrar_uso_memoria()
    registrar_uso_disco()
    registrar_uso_red()
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `monitoreo_alertas.py`.

2. **Configurar las Credenciales del Correo:**
   - Reemplaza `"tu_correo@gmail.com"`, `"tu_contraseña"` y `"destinatario@example.com"` con tus credenciales y el destinatario deseado.

3. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `monitoreo_alertas.py`.
   - Ejecuta el script:

     ```shell
     python monitoreo_alertas.py
     ```

### Conclusión

En esta práctica, has aprendido cómo crear un script para registrar el uso del sistema en un archivo de log y configurar alertas para eventos específicos utilizando Python. Estas habilidades son cruciales para el monitoreo y la administración efectiva de sistemas, permitiéndote mantener un registro detallado del rendimiento del sistema y detectar problemas a tiempo. Continúa practicando y expandiendo estos scripts para incluir más características y mejorar la funcionalidad de monitoreo.