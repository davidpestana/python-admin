### Laboratorio: Manipulación de Archivos en Python

#### Práctica: Leer y Escribir Archivos de Texto y Procesar Archivos CSV

En este laboratorio, aprenderás a leer y escribir archivos de texto, así como a procesar archivos CSV. Python proporciona módulos y métodos que facilitan estas tareas. Vamos a explorar cada uno de estos aspectos paso a paso.

### Objetivos:
1. Leer y escribir archivos de texto.
2. Procesar archivos CSV.

---

### Parte 1: Leer y Escribir Archivos de Texto

#### Paso 1: Leer Archivos de Texto

Primero, aprenderemos a leer archivos de texto utilizando Python.

1. **Crear un archivo de texto:**
   - Abre tu editor de texto o IDE favorito.
   - Crea un nuevo archivo llamado `archivo_texto.txt` y añade el siguiente contenido:

     ```
     Hola, este es un archivo de texto.
     Contiene varias líneas de texto.
     Cada línea puede ser procesada por Python.
     ```

2. **Leer el contenido del archivo:**
   - Crea un nuevo archivo Python llamado `leer_archivo.py`.
   - Escribe el siguiente código para leer el contenido del archivo:

     ```python
     # Abrir el archivo en modo lectura
     with open('archivo_texto.txt', 'r') as archivo:
         contenido = archivo.read()
         print(contenido)
     ```

3. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `leer_archivo.py`.
   - Ejecuta el script:

     ```shell
     python leer_archivo.py
     ```

   - Deberías ver el contenido del archivo `archivo_texto.txt` impreso en la terminal.

#### Paso 2: Escribir Archivos de Texto

A continuación, aprenderemos a escribir en archivos de texto.

1. **Escribir en un archivo de texto:**
   - Crea un nuevo archivo Python llamado `escribir_archivo.py`.
   - Escribe el siguiente código para escribir contenido en un archivo:

     ```python
     # Abrir el archivo en modo escritura
     with open('nuevo_archivo.txt', 'w') as archivo:
         archivo.write("Esta es la primera línea del archivo.\n")
         archivo.write("Y esta es la segunda línea.\n")
     ```

2. **Ejecutar el script:**
   - En la terminal, ejecuta el siguiente comando:

     ```shell
     python escribir_archivo.py
     ```

   - Deberías ver un nuevo archivo llamado `nuevo_archivo.txt` en tu directorio con el contenido escrito.

3. **Leer el archivo escrito:**
   - Usa el script `leer_archivo.py` para leer el contenido de `nuevo_archivo.txt` para verificar que se ha escrito correctamente.

---

### Parte 2: Procesar Archivos CSV

#### Paso 1: Leer Archivos CSV

CSV (Comma-Separated Values) es un formato comúnmente utilizado para almacenar datos tabulares. Python proporciona el módulo `csv` para trabajar con estos archivos.

1. **Crear un archivo CSV:**
   - Crea un archivo llamado `datos.csv` con el siguiente contenido:

     ```csv
     nombre,edad,ocupacion
     Juan,30,Ingeniero
     María,25,Doctora
     Pedro,35,Profesor
     ```

2. **Leer el contenido del archivo CSV:**
   - Crea un nuevo archivo Python llamado `leer_csv.py`.
   - Escribe el siguiente código para leer el archivo CSV:

     ```python
     import csv

     with open('datos.csv', 'r') as archivo:
         lector_csv = csv.reader(archivo)
         for fila in lector_csv:
             print(fila)
     ```

3. **Ejecutar el script:**
   - En la terminal, ejecuta el siguiente comando:

     ```shell
     python leer_csv.py
     ```

   - Deberías ver las filas del archivo `datos.csv` impresas en la terminal.

#### Paso 2: Escribir Archivos CSV

Ahora, aprenderemos a escribir datos en archivos CSV.

1. **Escribir en un archivo CSV:**
   - Crea un nuevo archivo Python llamado `escribir_csv.py`.
   - Escribe el siguiente código para escribir datos en un archivo CSV:

     ```python
     import csv

     with open('nuevo_datos.csv', 'w', newline='') as archivo:
         escritor_csv = csv.writer(archivo)
         escritor_csv.writerow(['nombre', 'edad', 'ocupacion'])
         escritor_csv.writerow(['Ana', 28, 'Abogada'])
         escritor_csv.writerow(['Luis', 22, 'Estudiante'])
     ```

   - El parámetro `newline=''` se usa para evitar líneas en blanco adicionales en algunos sistemas.

2. **Ejecutar el script:**
   - En la terminal, ejecuta el siguiente comando:

     ```shell
     python escribir_csv.py
     ```

   - Deberías ver un nuevo archivo llamado `nuevo_datos.csv` en tu directorio con el contenido escrito.

3. **Leer el archivo CSV escrito:**
   - Usa el script `leer_csv.py` para leer el contenido de `nuevo_datos.csv` y verificar que se ha escrito correctamente.

---

### Recursos Adicionales

- [Documentación oficial del módulo `csv`](https://docs.python.org/3/library/csv.html)
- [Guía de lectura y escritura de archivos en Python](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files)

### Conclusión

En este laboratorio, has aprendido a manipular archivos de texto y CSV en Python. Estas habilidades son fundamentales para manejar datos de manera eficiente y automatizar tareas de administración de sistemas. Continúa practicando y explorando para mejorar tus habilidades en la manipulación de archivos y la automatización de tareas en Python.