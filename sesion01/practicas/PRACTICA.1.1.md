### Práctica 1: Configuración del Entorno y Primeros Pasos en Python

#### Objetivos:
1. Instalar Python en tu sistema.
2. Configurar un entorno virtual.
3. Instalar paquetes básicos.
4. Escribir y ejecutar un script simple en Python.

### Paso 1: Instalación de Python

#### Instalación en Windows

1. **Descarga del instalador de Python:**
   - Visita el sitio web oficial de Python: [Descargar Python](https://www.python.org/downloads/)
   - Descarga la versión más reciente de Python para Windows.

2. **Ejecución del instalador:**
   - Abre el archivo descargado.
   - Selecciona **"Add Python to PATH"** para agregar Python a las variables de entorno del sistema.
   - Haz clic en **"Install Now"** o **"Customize installation"** si deseas personalizar la instalación.

3. **Verificación de la instalación:**
   - Abre la terminal de Windows (Command Prompt o PowerShell).
   - Escribe los siguientes comandos y presiona Enter para verificar que Python y `pip` se hayan instalado correctamente:

     ```shell
     python --version
     pip --version
     ```

#### Instalación en macOS

1. **Uso de Homebrew:**
   - Instala Homebrew si no lo tienes:

     ```shell
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

   - Instala Python usando Homebrew:

     ```shell
     brew install python
     ```

2. **Verificación de la instalación:**
   - Abre la Terminal.
   - Escribe los siguientes comandos y presiona Enter para verificar que Python y `pip` se hayan instalado correctamente:

     ```shell
     python3 --version
     pip3 --version
     ```

#### Instalación en Linux

1. **Instalación usando el gestor de paquetes del sistema:**

   - **Ubuntu/Debian:**

     ```shell
     sudo apt update
     sudo apt install python3 python3-pip
     ```

   - **CentOS/RHEL:**

     ```shell
     sudo yum install python3
     ```

   - **Arch Linux:**

     ```shell
     sudo pacman -S python python-pip
     ```

2. **Verificación de la instalación:**
   - Abre la Terminal.
   - Escribe los siguientes comandos y presiona Enter para verificar que Python y `pip` se hayan instalado correctamente:

     ```shell
     python3 --version
     pip3 --version
     ```

### Paso 2: Configuración de un Entorno Virtual

Un entorno virtual permite crear un entorno aislado para tus proyectos de Python, donde puedes gestionar dependencias y versiones de paquetes sin afectar el entorno global.

1. **Crear un entorno virtual:**
   - Abre la terminal y navega al directorio de tu proyecto.
   - Ejecuta el siguiente comando para crear un entorno virtual llamado `venv`:

     ```shell
     python -m venv venv
     ```

2. **Activar el entorno virtual:**

   - **Windows:**

     ```shell
     venv\Scripts\activate
     ```

   - **macOS/Linux:**

     ```shell
     source venv/bin/activate
     ```

   - Una vez activado, verás el nombre del entorno virtual precediendo el prompt de tu terminal, algo como `(venv)`.

3. **Instalar paquetes básicos:**
   - Con el entorno virtual activado, usa `pip` para instalar paquetes. Como ejemplo, instalaremos el paquete `requests`:

     ```shell
     pip install requests
     ```

4. **Desactivar el entorno virtual:**
   - Para desactivar el entorno virtual y volver al entorno global, ejecuta el siguiente comando:

     ```shell
     deactivate
     ```

### Paso 3: Escribir y Ejecutar un Script Simple

Ahora vamos a escribir un script de Python que tome un nombre y edad como entrada y muestre un saludo personalizado.

1. **Crear un archivo de script:**
   - Abre tu editor de texto o IDE favorito (como VSCode, PyCharm, etc.).
   - Crea un nuevo archivo y guárdalo con el nombre `saludo.py`.

2. **Escribir el script:**
   - Escribe el siguiente código en `saludo.py`:

     ```python
     # Solicitar el nombre y la edad del usuario
     nombre = input("Introduce tu nombre: ")
     edad = input("Introduce tu edad: ")

     # Mostrar un saludo personalizado
     print(f"Hola, {nombre}! Tienes {edad} años.")
     ```

3. **Ejecutar el script:**
   - Asegúrate de que tu entorno virtual esté activado.
   - En la terminal, navega al directorio donde guardaste `saludo.py`.
   - Ejecuta el script escribiendo:

     ```shell
     python saludo.py
     ```

4. **Interactuar con el script:**
   - Cuando se te solicite, introduce tu nombre y edad.
   - Observa cómo el script muestra un saludo personalizado basado en tu entrada.

### Recursos Adicionales

- [Documentación oficial de Python](https://docs.python.org/3/)
- [Instalación de Python en Windows](https://docs.python.org/3/using/windows.html)
- [Instalación de Python en macOS](https://docs.python.org/3/using/mac.html)
- [Instalación de Python en Linux](https://docs.python.org/3/using/unix.html)
- [Uso de entornos virtuales](https://docs.python.org/3/library/venv.html)
- [Editor de código Visual Studio Code](https://code.visualstudio.com/)
- [PyCharm IDE](https://www.jetbrains.com/pycharm/download/)
- [Guía de Homebrew](https://brew.sh/)

### Conclusión

Con estos pasos, has configurado tu entorno de desarrollo, creado un entorno virtual, instalado paquetes y escrito tu primer script en Python. Este es el primer paso en el aprendizaje de Python y en la automatización de tareas de administración de sistemas. Continúa explorando y practicando para familiarizarte más con Python y sus capacidades.