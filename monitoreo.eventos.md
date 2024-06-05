### Sesión 5: Monitoreo y Mantenimiento del Sistema

#### Objetivos:
1. Aprender a monitorear los recursos del sistema utilizando Python.
2. Utilizar módulos como `psutil` para obtener información sobre el uso del sistema.
3. Implementar el registro y la alerta de eventos del sistema.

### Monitoreo del Sistema con `psutil`

### Registro y Alerta de Eventos del Sistema

Registrar y alertar eventos del sistema es una tarea crucial para los administradores de sistemas. Permite mantener un registro histórico del rendimiento del sistema y detectar problemas a tiempo para tomar acciones correctivas.

### Funcionalidades Clave para Registro y Alerta

#### 1. Registro de Eventos

Para registrar eventos del sistema, podemos escribir los datos en un archivo de registro. Usaremos el módulo `logging` de Python para manejar los registros de manera eficiente.

#### 2. Alerta de Eventos

Para alertar eventos del sistema, podemos enviar correos electrónicos cuando ciertos umbrales se exceden. Utilizaremos el módulo `smtplib` para enviar correos electrónicos.

### Paso 1: Configurar el Registro de Eventos

**Ejemplo: Configurar el Módulo `logging`**

```python
import logging

# Configurar el registro
logging.basicConfig(filename='sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Ejemplo de uso
logging.info("Este es un mensaje de información")
logging.warning("Este es un mensaje de advertencia")
logging.error("Este es un mensaje de error")
```

### Paso 2: Implementar el Registro y la Alerta en el Monitoreo del Sistema

**Script Completo: Registro y Alerta de Eventos del Sistema**

```python
import psutil
import logging
import smtplib
from email.mime.text import MIMEText

# Configuración del registro
logging.basicConfig(filename='sistema.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Configuración del correo electrónico
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

def monitorear_cpu():
    uso_cpu = psutil.cpu_percent(interval=1)
    if uso_cpu > 80:  # Umbral de alerta para la CPU
        asunto = "Alerta de CPU alta"
        mensaje = f"Uso de la CPU es {uso_cpu}%"
        enviar_alerta(asunto, mensaje)
    logging.info(f"Uso de la CPU: {uso_cpu}%")

def monitorear_memoria():
    memoria_virtual = psutil.virtual_memory()
    if memoria_virtual.percent > 80:  # Umbral de alerta para la memoria
        asunto = "Alerta de memoria alta"
        mensaje = f"Uso de la memoria es {memoria_virtual.percent}%"
        enviar_alerta(asunto, mensaje)
    logging.info(f"Uso de la memoria virtual: {memoria_virtual.percent}%")

def monitorear_disco():
    uso_disco = psutil.disk_usage('/')
    if uso_disco.percent > 90:  # Umbral de alerta para el disco
        asunto = "Alerta de uso de disco alto"
        mensaje = f"Uso del disco es {uso_disco.percent}%"
        enviar_alerta(asunto, mensaje)
    logging.info(f"Uso del disco: {uso_disco.percent}%")

def monitorear_red():
    estadisticas_red = psutil.net_io_counters()
    logging.info(f"Bytes enviados: {estadisticas_red.bytes_sent}, Bytes recibidos: {estadisticas_red.bytes_recv}")

if __name__ == "__main__":
    print("Monitoreo del sistema:")
    print("\nMonitoreo de la CPU:")
    monitorear_cpu()
    print("\nMonitoreo de la Memoria:")
    monitorear_memoria()
    print("\nMonitoreo del Disco:")
    monitorear_disco()
    print("\nMonitoreo de la Red:")
    monitorear_red()
```

### Desglose del Script

1. **Configuración del Registro:**
   - `logging.basicConfig()`: Configura el módulo de registro para escribir los eventos en un archivo `sistema.log`.

2. **Configuración del Correo Electrónico:**
   - `enviar_alerta(asunto, mensaje)`: Configura y envía una alerta por correo electrónico utilizando `smtplib`.

3. **Monitoreo de la CPU:**
   - `monitorear_cpu()`: Monitorea el uso de la CPU y envía una alerta si el uso supera el 80%. También registra el uso de la CPU.

4. **Monitoreo de la Memoria:**
   - `monitorear_memoria()`: Monitorea el uso de la memoria y envía una alerta si el uso supera el 80%. También registra el uso de la memoria.

5. **Monitoreo del Disco:**
   - `monitorear_disco()`: Monitorea el uso del disco y envía una alerta si el uso supera el 90%. También registra el uso del disco.

6. **Monitoreo de la Red:**
   - `monitorear_red()`: Monitorea las estadísticas de la red y las registra.

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

En esta sesión, has aprendido cómo utilizar `psutil` para monitorear varios aspectos del sistema y cómo implementar el registro y la alerta de eventos del sistema. Estas habilidades son cruciales para la administración y el mantenimiento eficiente de sistemas, permitiéndote detectar y responder a problemas de manera proactiva. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como el monitoreo de procesos específicos y la integración con otras herramientas de monitoreo y alerta.