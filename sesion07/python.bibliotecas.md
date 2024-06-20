### **Sesión 7: Integración de Herramientas Externas en Bash y Python**

#### **Objetivos:**
- Aprender a integrar herramientas externas en scripts Bash y Python.
- Aplicar técnicas de integración en automatización.

#### **Teoría:**
1. **Uso de herramientas externas en Bash:**
   - **`curl`:** Herramienta de línea de comandos para transferir datos con URL.
     - **Descripción:** `curl` se utiliza para realizar solicitudes HTTP, FTP y otras. Es útil para interactuar con APIs y descargar contenido web.
     - **Ejemplo básico:**
       ```bash
       # Realizar una solicitud GET a la API de JSONPlaceholder
       curl -X GET "https://jsonplaceholder.typicode.com/posts/1"
       ```
   - **`jq`:** Herramienta de línea de comandos para procesar JSON.
     - **Descripción:** `jq` permite filtrar, transformar y consultar datos JSON desde la línea de comandos, facilitando la manipulación de respuestas JSON.
     - **Ejemplo básico:**
       ```bash
       # Filtrar un campo específico de un JSON de JSONPlaceholder
       curl -X GET "https://jsonplaceholder.typicode.com/posts/1" | jq '.title'
       ```

2. **Uso de bibliotecas externas en Python:**
   - **`requests`:** Biblioteca para realizar solicitudes HTTP.
     - **Descripción:** `requests` facilita la interacción con servicios web y APIs. Permite enviar solicitudes HTTP/1.1 con métodos como GET, POST, PUT, DELETE, etc.
     - **Ejemplo básico:**
       ```python
       import requests

       # Realizar una solicitud GET a la API de JSONPlaceholder
       response = requests.get('https://jsonplaceholder.typicode.com/posts/1')
       if response.status_code == 200:
           data = response.json()
           print(data)
       else:
           print('Error:', response.status_code)
       ```
   
   - **`BeautifulSoup`:** Biblioteca para analizar y extraer datos de archivos HTML y XML.
     - **Descripción:** `BeautifulSoup` facilita el análisis de documentos HTML y XML. Es útil para web scraping, permitiendo extraer información de páginas web.
     - **Ejemplo básico:**
       ```python
       import requests
       from bs4 import BeautifulSoup

       # Realizar una solicitud GET a la página de Wikipedia
       response = requests.get('https://en.wikipedia.org/wiki/Web_scraping')
       if response.status_code == 200:
           soup = BeautifulSoup(response.text, 'html.parser')
           
           # Extraer todos los encabezados de la página
           headers = soup.find_all(['h1', 'h2', 'h3'])
           for header in headers:
               print(header.get_text())
       else:
           print('Error:', response.status_code)
       ```

   - **`pandas`:** Biblioteca para análisis y manipulación de datos.
     - **Descripción:** `pandas` proporciona estructuras de datos y herramientas de análisis de datos de alto rendimiento y fáciles de usar. Es ideal para trabajar con datos tabulares como hojas de cálculo.
     - **Ejemplo básico:**
       ```python
       import pandas as pd

       # Crear un DataFrame a partir de un diccionario
       data = {
           'Nombre': ['Alice', 'Bob', 'Charlie'],
           'Edad': [25, 30, 35]
       }
       df = pd.DataFrame(data)
       print(df)

       # Leer datos desde un archivo CSV (suponiendo que existe un archivo 'data.csv')
       df = pd.read_csv('data.csv')
       print(df)
       ```

   - **`matplotlib`:** Biblioteca para la visualización de datos.
     - **Descripción:** `matplotlib` es una biblioteca de trazado 2D en Python que produce figuras de calidad en una variedad de formatos impresos y entornos interactivos de plataformas cruzadas.
     - **Ejemplo básico:**
       ```python
       import matplotlib.pyplot as plt

       # Datos de ejemplo
       x = [1, 2, 3, 4, 5]
       y = [10, 20, 25, 30, 35]

       # Crear un gráfico de líneas
       plt.plot(x, y)
       plt.xlabel('Eje X')
       plt.ylabel('Eje Y')
       plt.title('Gráfico de líneas de ejemplo')
       plt.show()
       ```

   - **`numpy`:** Biblioteca para operaciones matemáticas y manipulación de matrices.
     - **Descripción:** `numpy` es el paquete fundamental para la computación científica en Python. Proporciona un objeto de matriz multidimensional de alto rendimiento y herramientas para trabajar con estas matrices.
     - **Ejemplo básico:**
       ```python
       import numpy as np

       # Crear un arreglo numpy
       arr = np.array([1, 2, 3, 4, 5])
       print(arr)

       # Operaciones matemáticas
       print('Suma:', np.sum(arr))
       print('Media:', np.mean(arr))
       ```



### Ejemplos Prácticos para la Integración de Herramientas Externas en Bash y Python

#### Bash

1. **Descargar y procesar datos de una API REST con `curl` y `jq`**

   ```bash
   # Obtener una lista de usuarios y filtrar solo los nombres
   curl -X GET "https://jsonplaceholder.typicode.com/users" | jq '.[].name'
   ```

2. **Automatizar la descarga de un archivo y verificar su integridad**

   ```bash
   # Descargar archivo y verificar checksum
   curl -O http://example.com/file.zip
   curl -O http://example.com/file.zip.sha256
   sha256sum -c file.zip.sha256
   ```

3. **Monitorear el estado de una página web**

   ```bash
   # Revisar si una página está activa
   URL="http://example.com"
   STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)
   if [ $STATUS -eq 200 ]; then
     echo "La página está activa."
   else
     echo "La página no está activa. Código de estado: $STATUS"
   fi
   ```

4. **Interactuar con una API y guardar la respuesta en un archivo**

   ```bash
   # Obtener y guardar datos de una API
   curl -X GET "https://jsonplaceholder.typicode.com/posts" -o posts.json
   ```

5. **Extraer información específica de un archivo JSON**

   ```bash
   # Filtrar títulos de posts
   cat posts.json | jq '.[].title'
   ```

#### Python

6. **Enviar una solicitud POST a una API**

   ```python
   import requests

   # Datos para enviar
   payload = {'title': 'foo', 'body': 'bar', 'userId': 1}
   response = requests.post('https://jsonplaceholder.typicode.com/posts', json=payload)
   if response.status_code == 201:
       print('Post creado:', response.json())
   else:
       print('Error:', response.status_code)
   ```

7. **Scraping de datos de una página web y guardarlos en un archivo CSV**

   ```python
   import requests
   from bs4 import BeautifulSoup
   import csv

   url = 'https://en.wikipedia.org/wiki/Web_scraping'
   response = requests.get(url)
   if response.status_code == 200:
       soup = BeautifulSoup(response.text, 'html.parser')
       headers = soup.find_all(['h1', 'h2', 'h3'])
       
       with open('headers.csv', 'w', newline='') as file:
           writer = csv.writer(file)
           writer.writerow(['Header'])
           for header in headers:
               writer.writerow([header.get_text()])
   else:
       print('Error:', response.status_code)
   ```

8. **Análisis de datos y visualización con `pandas` y `matplotlib`**

   ```python
   import pandas as pd
   import matplotlib.pyplot as plt

   # Leer datos desde un archivo CSV
   df = pd.read_csv('data.csv')

   # Visualizar los datos
   df.plot(kind='bar', x='Nombre', y='Edad')
   plt.title('Edades de Personas')
   plt.show()
   ```

9. **Realizar operaciones matemáticas avanzadas con `numpy`**

   ```python
   import numpy as np

   # Crear un arreglo numpy y calcular la desviación estándar
   arr = np.array([1, 2, 3, 4, 5])
   print('Desviación estándar:', np.std(arr))
   ```

10. **Automatizar tareas de red con `subprocess` en Python**

    ```python
    import subprocess

    # Ejecutar un comando ping y capturar la salida
    result = subprocess.run(['ping', '-c', '4', 'google.com'], stdout=subprocess.PIPE)
    print(result.stdout.decode('utf-8'))
    ```

Estos ejemplos prácticos muestran cómo integrar diversas herramientas y bibliotecas en scripts Bash y Python para automatizar tareas comunes de sistemas, mejorar la eficiencia y facilitar la gestión de datos.
