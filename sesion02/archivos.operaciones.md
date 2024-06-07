### Operaciones Básicas con Archivos (Leer, Escribir, Actualizar)

En esta sección, nos centraremos en cómo realizar operaciones básicas con archivos en Python, que incluyen la lectura, escritura y actualización de archivos. Python proporciona una serie de funciones y métodos para manejar archivos de manera eficiente. A continuación, se describe cada una de estas operaciones en detalle.

#### Abrir Archivos

Para trabajar con archivos, primero debemos abrirlos utilizando la función `open()`. Esta función toma dos parámetros principales:
1. El nombre del archivo.
2. El modo en que queremos abrir el archivo.

Modos comunes de apertura:
- `'r'`: Modo de lectura. Abre un archivo para lectura (predeterminado).
- `'w'`: Modo de escritura. Crea un archivo nuevo o sobrescribe uno existente.
- `'a'`: Modo de agregado (append). Agrega contenido al final de un archivo.
- `'b'`: Modo binario. Utilizado para archivos binarios como imágenes.
- `'t'`: Modo de texto (predeterminado). Utilizado para archivos de texto.

Ejemplo de apertura de un archivo:
```python
archivo = open('ejemplo.txt', 'r')  # Abrir en modo lectura
```

#### Leer Archivos

Python ofrece varias formas de leer archivos:
- `read()`: Lee todo el contenido del archivo.
- `readline()`: Lee una sola línea del archivo.
- `readlines()`: Lee todas las líneas del archivo y las devuelve como una lista.

**Ejemplo: Leer todo el contenido de un archivo**

```python
with open('ejemplo.txt', 'r') as archivo:
    contenido = archivo.read()
    print(contenido)
```

**Ejemplo: Leer el archivo línea por línea**

```python
with open('ejemplo.txt', 'r') as archivo:
    linea = archivo.readline()
    while linea:
        print(linea, end='')  # end='' evita la doble nueva línea
        linea = archivo.readline()
```

**Ejemplo: Leer todas las líneas y almacenarlas en una lista**

```python
with open('ejemplo.txt', 'r') as archivo:
    lineas = archivo.readlines()
    for linea in lineas:
        print(linea, end='')
```

#### Escribir Archivos

Para escribir en archivos, utilizamos los modos `'w'` o `'a'` con `open()`. Los métodos más comunes son:
- `write()`: Escribe una cadena en el archivo.
- `writelines()`: Escribe una lista de cadenas en el archivo.

**Ejemplo: Escribir en un archivo (sobrescribir)**

```python
with open('ejemplo.txt', 'w') as archivo:
    archivo.write("Hola, Mundo!\n")
    archivo.write("Esta es una nueva línea.\n")
```

**Ejemplo: Agregar contenido a un archivo**

```python
with open('ejemplo.txt', 'a') as archivo:
    archivo.write("Esta línea se agrega al final del archivo.\n")
```

**Ejemplo: Escribir una lista de líneas en un archivo**

```python
lineas = ["Primera línea\n", "Segunda línea\n", "Tercera línea\n"]
with open('ejemplo.txt', 'w') as archivo:
    archivo.writelines(lineas)
```

#### Actualizar Archivos

Actualizar un archivo puede implicar tanto leer su contenido como modificarlo y luego escribir los cambios de vuelta en el archivo.

**Ejemplo: Leer y actualizar un archivo**

```python
# Leer el contenido del archivo
with open('ejemplo.txt', 'r') as archivo:
    lineas = archivo.readlines()

# Modificar el contenido
lineas.append("Esta es una nueva línea agregada.\n")

# Escribir el contenido modificado de vuelta en el archivo
with open('ejemplo.txt', 'w') as archivo:
    archivo.writelines(lineas)
```

### Ejemplo Completo de Operaciones Básicas

Vamos a crear un ejemplo completo que demuestre todas las operaciones básicas (leer, escribir, actualizar) en un solo flujo de trabajo.

1. **Crear un archivo y escribir contenido inicial:**

```python
with open('mi_archivo.txt', 'w') as archivo:
    archivo.write("Línea 1: Este es un archivo de prueba.\n")
    archivo.write("Línea 2: Python es divertido.\n")
    archivo.write("Línea 3: Vamos a aprender a manejar archivos.\n")
```

2. **Leer el contenido del archivo:**

```python
with open('mi_archivo.txt', 'r') as archivo:
    contenido = archivo.read()
    print("Contenido inicial del archivo:")
    print(contenido)
```

3. **Actualizar el archivo agregando una nueva línea:**

```python
with open('mi_archivo.txt', 'a') as archivo:
    archivo.write("Línea 4: Esta es una nueva línea agregada.\n")
```

4. **Leer y mostrar el contenido actualizado:**

```python
with open('mi_archivo.txt', 'r') as archivo:
    contenido_actualizado = archivo.read()
    print("Contenido actualizado del archivo:")
    print(contenido_actualizado)
```

### Conclusión

El manejo de archivos es una habilidad fundamental en Python que permite interactuar con el sistema de archivos, leer datos de entradas externas, almacenar resultados y mantener registros. Comprender cómo abrir, leer, escribir y actualizar archivos de manera eficiente es crucial para la automatización de tareas y el desarrollo de aplicaciones robustas.

Al practicar estas operaciones, te familiarizarás con las herramientas necesarias para manipular archivos y podrás aplicarlas a una variedad de tareas de administración de sistemas, análisis de datos y desarrollo de software.