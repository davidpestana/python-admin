### Práctica: Integración en Python con `requests` y `BeautifulSoup` para Obtener y Comparar Reportes de Servicios Cloud

#### **Objetivos:**
- Aprender a utilizar `requests` para realizar solicitudes HTTP a APIs de monitoreo de servicios cloud.
- Aprender a utilizar `BeautifulSoup` para analizar y extraer datos de páginas web de monitoreo de servicios cloud.
- Aplicar estos conocimientos en tareas de administración de sistemas para obtener y comparar reportes de estado.

### **Ejercicio: Obtener y Comparar Reportes de Estado de Servicios Cloud**

**Descripción:** 
Crear un script que obtenga reportes de estado de servicios cloud desde APIs o páginas web de monitoreo y compare los resultados para detectar cambios o anomalías. El ejercicio se desarrollará en 5 iteraciones, cada una agregando más funcionalidad y mejorando el script.

### Iteración 1: Realizar una Solicitud HTTP y Obtener el Contenido de la Página de Monitoreo de AWS

1. **Objetivo:**
   Realizar una solicitud HTTP a la página de monitoreo de estado de AWS y obtener el contenido HTML.

2. **Código:**
   ```python
   import requests

   # URL de la página de monitoreo de AWS
   url = 'https://status.aws.amazon.com/'

   # Realizar una solicitud GET
   response = requests.get(url)

   if response.status_code == 200:
       # Mostrar el contenido HTML de la página
       print(response.text)
   else:
       print(f'Error: {response.status_code}')
   ```

3. **Explicación:**
   - Utilizamos la biblioteca `requests` para realizar una solicitud GET a la URL de la página de monitoreo de AWS.
   - Verificamos que la solicitud fue exitosa (código de estado 200) y mostramos el contenido HTML de la página.

### Iteración 2: Analizar el Contenido HTML y Extraer Datos Relevantes de AWS

1. **Objetivo:**
   Utilizar `BeautifulSoup` para analizar el contenido HTML y extraer los mensajes de estado de la página de monitoreo de AWS.

2. **Código:**
   ```python
   import requests
   from bs4 import BeautifulSoup

   # URL de la página de monitoreo de AWS
   url = 'https://status.aws.amazon.com/'

   # Realizar una solicitud GET
   response = requests.get(url)

   if response.status_code == 200:
       # Analizar el contenido HTML
       soup = BeautifulSoup(response.text, 'html.parser')
       
       # Extraer los mensajes de estado
       messages = soup.find_all('div', class_='bb-status-page')
       for message in messages:
           timestamp = message.find('div', class_='date').get_text().strip()
           content = message.find('div', class_='message-body').get_text().strip()
           print(f"Time: {timestamp}, Message: {content}")
   else:
       print(f'Error: {response.status_code}')
   ```

3. **Explicación:**
   - Utilizamos `BeautifulSoup` para analizar el contenido HTML de la página.
   - Buscamos todas las etiquetas `<div>` con la clase `bb-status-page` y extraemos la marca de tiempo y el contenido de cada mensaje.

### Iteración 3: Obtener Reportes de Múltiples Fuentes de Servicios Cloud

1. **Objetivo:**
   Extender el script para obtener reportes de estado de múltiples fuentes de monitoreo de servicios cloud.

2. **Código:**
   ```python
   import requests
   from bs4 import BeautifulSoup

   # URLs de las páginas de monitoreo de servicios cloud
   urls = [
       'https://status.aws.amazon.com/',
       'https://status.azure.com/en-us/status'
   ]

   def get_status_from_aws(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           messages = soup.find_all('div', class_='bb-status-page')
           return [(msg.find('div', class_='date').get_text().strip(), msg.find('div', class_='message-body').get_text().strip()) for msg in messages]
       else:
           print(f'Error fetching data from {url}: {response.status_code}')
           return []

   def get_status_from_azure(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           incidents = soup.find_all('div', class_='status-event')
           return [(inc.find('div', class_='status-event-timestamp').get_text().strip(), inc.find('div', class_='status-event-description').get_text().strip()) for inc in incidents]
       else:
           print(f'Error fetching data from {url}: {response.status_code}')
           return []

   statuses = []
   statuses.extend(get_status_from_aws(urls[0]))
   statuses.extend(get_status_from_azure(urls[1]))

   for status in statuses:
       print(f"Time: {status[0]}, Message: {status[1]}")
   ```

3. **Explicación:**
   - Definimos funciones para obtener el estado de múltiples fuentes de servicios cloud.
   - `get_status_from_aws` y `get_status_from_azure` manejan la lógica para extraer los mensajes de estado de AWS y Azure, respectivamente.
   - Iteramos sobre las URLs, llamamos a las funciones correspondientes y mostramos los resultados.

### Iteración 4: Comparar Reportes Actuales con Reportes Anteriores

1. **Objetivo:**
   Comparar los reportes de estado actuales con los reportes almacenados anteriormente para detectar cambios o anomalías.

2. **Código:**
   ```python
   import requests
   from bs4 import BeautifulSoup
   import json

   # URLs de las páginas de monitoreo de servicios cloud
   urls = [
       'https://status.aws.amazon.com/',
       'https://status.azure.com/en-us/status'
   ]

   def get_status_from_aws(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           messages = soup.find_all('div', class_='bb-status-page')
           return [(msg.find('div', class_='date').get_text().strip(), msg.find('div', class_='message-body').get_text().strip()) for msg in messages]
       else:
           print(f'Error fetching data from {url}: {response.status_code}')
           return []

   def get_status_from_azure(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           incidents = soup.find_all('div', class_='status-event')
           return [(inc.find('div', class_='status-event-timestamp').get_text().strip(), inc.find('div', class_='status-event-description').get_text().strip()) for inc in incidents]
       else:
           print(f'Error fetching data from {url}: {response.status_code}')
           return []

   def load_previous_reports(filepath):
       try:
           with open(filepath, 'r') as file:
               return json.load(file)
       except FileNotFoundError:
           return []

   def save_reports(filepath, reports):
       with open(filepath, 'w') as file:
           json.dump(reports, file)

   current_reports = []
   current_reports.extend(get_status_from_aws(urls[0]))
   current_reports.extend(get_status_from_azure(urls[1]))

   previous_reports = load_previous_reports('previous_reports.json')

   # Comparar reportes
   new_reports = [report for report in current_reports if report not in previous_reports]

   # Guardar los reportes actuales
   save_reports('previous_reports.json', current_reports)

   print("Nuevos reportes:")
   for report in new_reports:
       print(f"Time: {report[0]}, Message: {report[1]}")
   ```

3. **Explicación:**
   - Definimos funciones para cargar y guardar reportes desde un archivo JSON.
   - Comparamos los reportes actuales con los reportes anteriores y mostramos los nuevos reportes detectados.
   - Guardamos los reportes actuales para futuras comparaciones.

### Iteración 5: Crear un Reporte Resumido y Notificar Anomalías

1. **Objetivo:**
   Crear un reporte resumido con los resultados de la comparación y enviar notificaciones si se detectan anomalías.

2. **Código:**
   ```python
   import requests
   from bs4 import BeautifulSoup
   import json
   import smtplib
   from email.mime.text import MIMEText
   from email.mime.multipart import MIMEMultipart

   # Configuración del correo
   EMAIL_ADDRESS = 'tu_email@example.com'
   EMAIL_PASSWORD = 'tu_contraseña'
   RECIPIENT_EMAIL = 'destinatario@example.com'

   # URLs de las páginas de monitoreo de servicios cloud
   urls = [
       'https://status.aws.amazon.com/',
       'https://status.azure.com/en-us/status'
   ]

   def get_status_from_aws(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           messages = soup.find_all('div', class_='bb-status-page')
           return [(msg.find('div', class_='date').get_text().strip(), msg.find('div', class_='message-body').get_text().strip()) for msg in messages]
       else:
           print(f'

Error fetching data from {url}: {response.status_code}')
           return []

   def get_status_from_azure(url):
       response = requests.get(url)
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           incidents = soup.find_all('div', class_='status-event')
           return [(inc.find('div', class_='status-event-timestamp').get_text().strip(), inc.find('div', class_='status-event-description').get_text().strip()) for inc in incidents]
       else:
           print(f'Error fetching data from {url}: {response.status_code}')
           return []

   def load_previous_reports(filepath):
       try:
           with open(filepath, 'r') as file:
               return json.load(file)
       except FileNotFoundError:
           return []

   def save_reports(filepath, reports):
       with open(filepath, 'w') as file:
           json.dump(reports, file)

   def send_email(subject, body):
       msg = MIMEMultipart()
       msg['From'] = EMAIL_ADDRESS
       msg['To'] = RECIPIENT_EMAIL
       msg['Subject'] = subject

       msg.attach(MIMEText(body, 'plain'))

       try:
           with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
               server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
               server.sendmail(EMAIL_ADDRESS, RECIPIENT_EMAIL, msg.as_string())
               print('Email sent successfully')
       except Exception as e:
           print(f'Failed to send email: {e}')

   current_reports = []
   current_reports.extend(get_status_from_aws(urls[0]))
   current_reports.extend(get_status_from_azure(urls[1]))

   previous_reports = load_previous_reports('previous_reports.json')

   # Comparar reportes
   new_reports = [report for report in current_reports if report not in previous_reports]

   # Guardar los reportes actuales
   save_reports('previous_reports.json', current_reports)

   # Crear el cuerpo del correo
   if new_reports:
       body = "Nuevos reportes:\n\n"
       for report in new_reports:
           body += f"Time: {report[0]}, Message: {report[1]}\n\n"

       # Enviar correo
       send_email('Nuevos Reportes de Estado de Servicios Cloud', body)
   else:
       print('No hay nuevos reportes')
   ```

3. **Explicación:**
   - Definimos una función `send_email` para enviar notificaciones por correo electrónico utilizando SMTP.
   - Si se detectan nuevos reportes, creamos el cuerpo del correo con los detalles de los reportes y enviamos el correo.
   - Utilizamos las funciones de comparación y guardado de reportes de las iteraciones anteriores.

### Conclusión

A través de estas cinco iteraciones, hemos construido un script completo de obtención y comparación de reportes de estado de servicios cloud utilizando `requests` y `BeautifulSoup`. El script realiza solicitudes HTTP, analiza el contenido HTML, extrae datos útiles (mensajes de estado), compara los reportes actuales con los anteriores, guarda los reportes y envía notificaciones por correo electrónico si se detectan nuevas anomalías. Este ejercicio proporciona una base sólida para realizar tareas de monitoreo y administración de sistemas en un entorno de servicios cloud.
