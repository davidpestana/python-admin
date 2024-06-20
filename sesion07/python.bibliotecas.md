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

Estos ejemplos muestran cómo integrar diversas bibliotecas externas en scripts Python para realizar tareas comunes como solicitudes HTTP, análisis de HTML, manipulación de datos y visualización de datos utilizando APIs públicas confiables y funcionales.