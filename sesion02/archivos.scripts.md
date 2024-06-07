### Scripts para Tareas Comunes (Copias de Seguridad, Limpieza de Directorios)

Automatizar tareas comunes de administración de sistemas es uno de los usos más poderosos de Python. En esta sección, vamos a desarrollar scripts detallados para dos tareas comunes: realizar copias de seguridad y limpiar directorios. Estos scripts pueden ser fácilmente adaptados y ampliados para satisfacer necesidades específicas.

#### Copias de Seguridad

Hacer copias de seguridad es esencial para proteger los datos importantes contra la pérdida. Aquí, crearemos un script que copie archivos de un directorio a otro, asegurando que los datos estén respaldados.

##### Paso 1: Importar Módulos Necesarios

Vamos a utilizar los módulos `os`, `shutil` y `datetime` para gestionar los archivos y directorios, y para manejar las fechas.

```python
import os
import shutil
from datetime import datetime
```

##### Paso 2: Definir la Función de Copia de Seguridad

Definimos una función `hacer_copia_de_seguridad` que tome como argumentos el directorio de origen y el directorio de destino.

```python
def hacer_copia_de_seguridad(origen, destino):
    # Crear el directorio de destino si no existe
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    # Iterar sobre los archivos en el directorio de origen
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            # Copiar archivo al directorio de destino
            shutil.copy(ruta_completa, destino)
            print(f"Copiado: {ruta_completa} a {destino}")
```

##### Paso 3: Configurar Directorios y Ejecutar la Función

Definimos el directorio de origen y creamos un directorio de destino con una marca de tiempo para identificar la copia de seguridad.

```python
origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino/copia_' + datetime.now().strftime('%Y%m%d_%H%M%S')

# Ejecutar la función de copia de seguridad
hacer_copia_de_seguridad(origen, destino)
```

##### Script Completo de Copia de Seguridad

```python
import os
import shutil
from datetime import datetime

def hacer_copia_de_seguridad(origen, destino):
    # Crear el directorio de destino si no existe
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    # Iterar sobre los archivos en el directorio de origen
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa):
            # Copiar archivo al directorio de destino
            shutil.copy(ruta_completa, destino)
            print(f"Copiado: {ruta_completa} a {destino}")

origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino/copia_' + datetime.now().strftime('%Y%m%d_%H%M%S')

# Ejecutar la función de copia de seguridad
hacer_copia_de_seguridad(origen, destino)
```

#### Limpieza de Directorios

Limpiar directorios implica eliminar archivos no deseados o antiguos para mantener el sistema organizado y liberar espacio en disco. Aquí crearemos un script que elimine archivos en un directorio que sean más antiguos de un cierto número de días.

##### Paso 1: Importar Módulos Necesarios

Utilizaremos los módulos `os` y `time` para manejar archivos y gestionar tiempos.

```python
import os
import time
```

##### Paso 2: Definir la Función de Limpieza

Definimos una función `limpiar_directorio` que tome como argumentos el directorio y el número de días. Los archivos que no hayan sido modificados en los últimos `n` días serán eliminados.

```python
def limpiar_directorio(directorio, dias):
    ahora = time.time()
    # Iterar sobre los archivos en el directorio
    for archivo in os.listdir(directorio):
        ruta_completa = os.path.join(directorio, archivo)
        if os.path.isfile(ruta_completa):
            tiempo_modificacion = os.path.getmtime(ruta_completa)
            # Calcular la diferencia en días
            if (ahora - tiempo_modificacion) // (24 * 3600) >= dias:
                os.remove(ruta_completa)
                print(f"Archivo eliminado: {ruta_completa}")
```

##### Paso 3: Configurar el Directorio y Ejecutar la Función

Definimos el directorio y el número de días para la limpieza.

```python
directorio = '/ruta/al/directorio/limpiar'
dias = 30

# Ejecutar la función de limpieza
limpiar_directorio(directorio, dias)
```

##### Script Completo de Limpieza de Directorios

```python
import os
import time

def limpiar_directorio(directorio, dias):
    ahora = time.time()
    # Iterar sobre los archivos en el directorio
    for archivo in os.listdir(directorio):
        ruta_completa = os.path.join(directorio, archivo)
        if os.path.isfile(ruta_completa):
            tiempo_modificacion = os.path.getmtime(ruta_completa)
            # Calcular la diferencia en días
            if (ahora - tiempo_modificacion) // (24 * 3600) >= dias:
                os.remove(ruta_completa)
                print(f"Archivo eliminado: {ruta_completa}")

directorio = '/ruta/al/directorio/limpiar'
dias = 30

# Ejecutar la función de limpieza
limpiar_directorio(directorio, dias)
```

#### Ejemplos Avanzados y Personalizaciones

1. **Copiar Archivos con Filtros Específicos**

Podemos extender el script de copia de seguridad para copiar solo archivos con ciertas extensiones.

```python
def hacer_copia_de_seguridad_con_filtro(origen, destino, extensiones):
    if not os.path.exists(destino):
        os.makedirs(destino)
    
    for archivo in os.listdir(origen):
        ruta_completa = os.path.join(origen, archivo)
        if os.path.isfile(ruta_completa) and archivo.split('.')[-1] in extensiones:
            shutil.copy(ruta_completa, destino)
            print(f"Copiado: {ruta_completa} a {destino}")

origen = '/ruta/al/directorio/origen'
destino = '/ruta/al/directorio/destino/copia_' + datetime.now().strftime('%Y%m%d_%H%M%S')
extensiones = ['txt', 'pdf']  # Copiar solo archivos de texto y PDF

hacer_copia_de_seguridad_con_filtro(origen, destino, extensiones)
```

2. **Enviar Notificaciones Después de la Limpieza**

Podemos agregar una funcionalidad para enviar notificaciones (por ejemplo, por correo electrónico) después de completar la limpieza de directorios.

```python
import smtplib
from email.mime.text import MIMEText

def enviar_notificacion(mensaje):
    remitente = 'tucorreo@example.com'
    destinatario = 'destinatario@example.com'
    msg = MIMEText(mensaje)
    msg['Subject'] = 'Notificación de Limpieza de Directorios'
    msg['From'] = remitente
    msg['To'] = destinatario

    with smtplib.SMTP('smtp.example.com') as servidor:
        servidor.login('tucorreo@example.com', 'tucontraseña')
        servidor.sendmail(remitente, destinatario, msg.as_string())
        print("Correo enviado")

def limpiar_directorio(directorio, dias):
    ahora = time.time()
    archivos_eliminados = []
    for archivo in os.listdir(directorio):
        ruta_completa = os.path.join(directorio, archivo)
        if os.path.isfile(ruta_completa):
            tiempo_modificacion = os.path.getmtime(ruta_completa)
            if (ahora - tiempo_modificacion) // (24 * 3600) >= dias:
                os.remove(ruta_completa)
                archivos_eliminados.append(ruta_completa)
                print(f"Archivo eliminado: {ruta_completa}")
    
    if archivos_eliminados:
        mensaje = "Se han eliminado los siguientes archivos:\n" + "\n".join(archivos_eliminados)
        enviar_notificacion(mensaje)

directorio = '/ruta/al/directorio/limpiar'
dias = 30

limpiar_directorio(directorio, dias)
```

### Conclusión

Automatizar tareas comunes como realizar copias de seguridad y limpiar directorios con Python no solo mejora la eficiencia, sino que también minimiza el riesgo de errores humanos. Al dominar estos scripts básicos, los administradores de sistemas pueden crear soluciones personalizadas para mantener sus entornos organizados y seguros. Continúa explorando y ampliando estos ejemplos para adaptarlos a tus necesidades específicas y mejorar tus habilidades de automatización.