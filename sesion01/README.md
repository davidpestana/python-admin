### **Sesión 01: Introducción a Python y Configuración del Entorno**

#### **Prólogo:**

En esta sección, exploraremos en profundidad los fundamentos de Python y cómo configurar un entorno de desarrollo adecuado para trabajar con este lenguaje versátil. Empezaremos con una introducción detallada sobre la historia de Python, sus características y aplicaciones en la administración de sistemas. Luego, pasaremos a los aspectos prácticos de la instalación y configuración del entorno, y finalmente, abordaremos la escritura de scripts básicos que sentarán las bases para proyectos más complejos en el futuro. Acompáñanos en este viaje para descubrir cómo Python puede simplificar y potenciar tus tareas diarias en la administración de sistemas.

#### **Objetivos:**
- Familiarizarse con Python y su sintaxis básica.
- Configurar el entorno de desarrollo.
- Aprender a escribir scripts básicos en Python.
- Comprender las ventajas de utilizar Python para la administración del sistema.

#### **Teoría:**
1. **Introducción a Python:**
    - [Historia de Python](introduccion.md#historia-de-python)
    - [Características de Python](introduccion.md#características-de-python)
    - [Aplicaciones en Administración de Sistemas](introduccion.md#aplicaciones-en-administración-de-sistemas)
    - [Aprender el Lenguaje de Programación Python](lenguaje.md#aprender-el-lenguaje-de-programación-python)
        - Sintaxis básica
        - Tipos de datos
        - Estructuras de datos
        - Control de flujo
        - Funciones y módulos
        - Manejo de excepciones

2. **Instalación de Python:**
   - [Instalación en Windows](instalacion.md#instalación-en-windows)
   - [Instalación en macOS](instalacion.md#instalación-en-macos)
   - [Instalación en Linux](instalacion.md#instalación-en-linux)
   - [Uso con Docker](docker.md#uso-con-docker)

3. **Herramientas de desarrollo:**
   - [IDEs y Editores de Texto](herramientas.md#ides-y-editores-de-texto)
   - [Uso de Entornos Virtuales](herramientas.md#uso-de-entornos-virtuales)
   - [Gestión de Dependencias con `requirements.txt`](herramientas.md#gestión-de-dependencias-con-requirementstxt)

#### **Práctica:**
1. **Configuración del entorno:**
   - Instalación de Python.
   - Configuración de un entorno virtual.
   - Instalación de paquetes básicos (`pip`, `venv`).

2. **Primeros pasos en Python:**
   - Escribir y ejecutar un script simple.
   - Sintaxis básica: variables, tipos de datos, operadores.

#### **Tarea:**
- Escribir un script que tome un nombre y edad como entrada y muestre un saludo personalizado.

#### **Extra:**
- [Ejercicio Complementario: Calculadora Simple](EXTRA.1.md)

---

### **Material de Apoyo:**
- [Historia de Python](https://docs.python.org/3/tutorial/appetite.html)
- [Características de Python](https://www.python.org/doc/essays/blurb/)
- [Aplicaciones de Python en la Industria](https://www.python.org/about/apps/)
- [Tutorial de Python](https://docs.python.org/3/tutorial/)


### Script en Python para Generar Imágenes

A continuación, se presenta un script en Python que utiliza la biblioteca `matplotlib` para generar algunas imagenes sobre los conceptos mencionados en la sección.

```python
import matplotlib.pyplot as plt
import matplotlib.patches as patches

def crear_cronograma_lenguajes():
    fig, ax = plt.subplots(figsize=(15, 8))
    ax.set_title("Historia de los Lenguajes de Programación", fontsize=20, pad=20)
    ax.axis('off')

    # Definir décadas y lenguajes
    decadas = ['1950', '1960', '1970', '1980', '1990', '2000', '2010', '2020']
    lenguajes = [
        ['RAL', 'AUTOCODER', 'IPL', 'FLOW-MATIC', 'FORTRAN', 'COMTRAN', 'LISP', 'FACT', 'COBOL', 'RPG'],
        ['APL', 'SIMULA', 'SNOBOL', 'CPL', 'BASIC', 'PL/I', 'BCPL', 'LOGO', 'B'],
        ['PASCAL', 'FORTH', 'C', 'SMALLTALK', 'PROLOG', 'ML', 'SCHEME', 'SQL', 'MODULA-2'],
        ['C++', 'ADA', 'C-LISP', 'MATLAB', 'EIFFEL', 'OBJECTIVE-C', 'ERLANG', 'PERL', 'TCL', 'MATHEMATICA'],
        ['HASKELL', 'PYTHON', 'VISUAL BASIC', 'HTML', 'RUBY', 'LUA', 'R', 'JAVA', 'DELPHI', 'JAVASCRIPT', 'PHP', 'WEBDNA', 'REBOL', 'CLOS'],
        ['ACTIONSCRIPT', 'C#', 'VBASIC .NET', 'F#', 'GROOVY', 'SCALA', 'FACTOR', 'SCRATCH', 'CLOJURE', 'GO'],
        ['RUST', 'DART', 'KOTLIN', 'ELIXIR', 'TYPESCRIPT', 'JULIA', 'SWIFT', 'RAKU'],
        ['CARBON', 'MOJO']
    ]
    
    # Colores para cada década
    colores = ['lightcoral', 'lightpink', 'lightgreen', 'lightblue', 'lightcyan', 'lightyellow', 'lightsteelblue', 'lightcoral']

    # Añadir flechas y bloques de texto
    for i, decada in enumerate(decadas):
        # Flecha de la década
        ax.add_patch(patches.FancyArrowPatch((i * 0.1 + 0.05, 0.9), (i * 0.1 + 0.15, 0.9), connectionstyle="arc3,rad=0.2", 
                                             color=colores[i], mutation_scale=60))
        ax.text(i * 0.1 + 0.1, 0.95, decada, horizontalalignment='center', fontsize=12, fontweight='bold')

        # Bloques de lenguajes
        for j, lenguaje in enumerate(lenguajes[i]):
            ax.text(i * 0.1 + 0.1, 0.8 - j * 0.05, lenguaje, horizontalalignment='center', fontsize=10, 
                    bbox=dict(facecolor=colores[i], alpha=0.5))

    plt.savefig("cronograma_lenguajes.png")
    plt.close()

def crear_cronograma_historia():
    fig, ax = plt.subplots(figsize=(14, 7))
    ax.set_title("Historia de Python", fontsize=20)
    ax.axis('off')

    # Línea de tiempo
    ax.plot([0.1, 0.9], [0.5, 0.5], color='black', lw=2)

    # Eventos en la línea de tiempo
    eventos = [
        (0.1, '1991: Primera versión de Python'),
        (0.3, '2000: Python 2.0'),
        (0.5, '2008: Python 3.0'),
        (0.7, '2021: Python 3.9'),
        (0.9, '2024: Python 3.12')
    ]
    
    # Añadir eventos y etiquetas
    for x, evento in eventos:
        ax.plot(x, 0.5, 'ro')
        ax.text(x, 0.55, evento, horizontalalignment='center', fontsize=12, wrap=True, bbox=dict(facecolor='lightblue', alpha=0.5))

    # Flechas y detalles adicionales
    arrowprops = dict(facecolor='blue', edgecolor='black', arrowstyle='->')
    for i, (x, evento) in enumerate(eventos):
        ax.annotate(evento, xy=(x, 0.5), xytext=(x, 0.75 - 0.1*i), textcoords='axes fraction', arrowprops=arrowprops, fontsize=10, horizontalalignment='center', verticalalignment='center')

    plt.savefig("cronograma_historia_python.png")
    plt.close()

# Crear la imagen del cronograma
crear_cronograma_historia()
print("Imagen de cronograma creada con éxito.")

# Crear la imagen del cronograma de lenguajes
crear_cronograma_lenguajes()
print("Imagen de cronograma de lenguajes creada con éxito.")

```
