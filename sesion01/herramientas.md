### **1.3 Herramientas de Desarrollo**

Para aprovechar al máximo Python y mejorar la eficiencia en el desarrollo de scripts y aplicaciones, es fundamental contar con las herramientas adecuadas. En este apartado, exploraremos los IDEs (Entornos de Desarrollo Integrado) y editores de texto más populares, así como el uso de entornos virtuales para gestionar dependencias.

#### **1.3.1 IDEs y Editores de Texto**

Existen varias opciones para escribir código en Python, cada una con sus propias ventajas. A continuación, se describen algunas de las herramientas más utilizadas.

##### **IDEs Populares para Python**

1. **PyCharm**
   - **Descripción:** PyCharm es un IDE desarrollado por JetBrains, especializado en Python. Ofrece una versión gratuita (Community Edition) y una versión de pago (Professional Edition).
   - **Características:**
     - Autocompletado de código y refactorización.
     - Depurador integrado y pruebas unitarias.
     - Integración con control de versiones (Git, SVN).
     - Soporte para Django y otras tecnologías web.
   - **Instalación:**
     - Visita [https://www.jetbrains.com/pycharm/download/](https://www.jetbrains.com/pycharm/download/) y descarga la versión adecuada para tu sistema operativo.
     - Sigue las instrucciones de instalación proporcionadas en el sitio web.
   
   ```python
   # Ejemplo de configuración de proyecto en PyCharm
   # Crear un nuevo proyecto -> Elegir ubicación -> Configurar intérprete de Python
   ```

2. **Visual Studio Code (VSCode)**
   - **Descripción:** VSCode es un editor de código fuente desarrollado por Microsoft. Es gratuito y altamente extensible mediante extensiones.
   - **Características:**
     - Ligero y rápido.
     - Soporte para múltiples lenguajes de programación.
     - Extensiones para Python que proporcionan autocompletado, linting y depuración.
     - Integración con Git y terminal integrada.
   - **Instalación:**
     - Visita [https://code.visualstudio.com/](https://code.visualstudio.com/) y descarga la versión adecuada para tu sistema operativo.
     - Instala la extensión de Python desde el Marketplace de VSCode.
   
   ```python
   # Instalación de la extensión de Python en VSCode
   # Abre VSCode -> Extensiones (Ctrl+Shift+X) -> Busca "Python" -> Instalar
   ```

3. **Spyder**
   - **Descripción:** Spyder es un IDE orientado a la ciencia de datos y el análisis. Es parte del ecosistema Anaconda.
   - **Características:**
     - Editor de texto avanzado con resaltado de sintaxis.
     - Consola interactiva de Python/IPython.
     - Explorador de variables y depurador.
     - Integración con herramientas de análisis y visualización de datos.
   - **Instalación:**
     - Instala Anaconda (recomendado) desde [https://www.anaconda.com/products/distribution](https://www.anaconda.com/products/distribution).
     - Spyder viene preinstalado con Anaconda. También puedes instalarlo por separado usando `conda` o `pip`.
   
   ```python
   # Instalación de Spyder usando conda
   conda install spyder
   ```

##### **Editores de Texto Populares**

1. **Sublime Text**
   - **Descripción:** Sublime Text es un editor de texto ligero y altamente personalizable.
   - **Características:**
     - Resaltado de sintaxis y autocompletado básico.
     - Múltiples cursores y selección de bloques.
     - Extensiones para mejorar la funcionalidad.
   - **Instalación:**
     - Visita [https://www.sublimetext.com/](https://www.sublimetext.com/) y descarga la versión adecuada para tu sistema operativo.
     - Instala el paquete `Sublime Text 3` y el paquete `Anaconda` para soporte de Python.
   
   ```python
   # Instalación del paquete Anaconda para Python en Sublime Text
   # Abre Sublime Text -> View -> Show Console
   # En la consola, pega:
   import urllib.request,os,hashlib; h = '6f50fedb224d4f06e7fcf6e78b9a57183c7d37529adca325f8d7b4a7e31e48d0'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener(urllib.request.build_opener(urllib.request.ProxyHandler())); by = urllib.request.urlopen('http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open(os.path.join(ipp, pf), 'wb').write(by) if dh == h else print('Error in file download')
   # Instalar Anaconda desde el menú de paquetes
   ```

2. **Atom**
   - **Descripción:** Atom es un editor de texto de código abierto desarrollado por GitHub.
   - **Características:**
     - Personalizable con paquetes y temas.
     - Resaltado de sintaxis y autocompletado básico.
     - Integración con Git y GitHub.
   - **Instalación:**
     - Visita [https://atom.io/](https://atom.io/) y descarga la versión adecuada para tu sistema operativo.
     - Instala el paquete `ide-python` para soporte de Python.
   
   ```python
   # Instalación del paquete ide-python en Atom
   # Abre Atom -> Settings -> Install -> Busca "ide-python" -> Instalar
   ```

#### **1.3.2 Uso de Entornos Virtuales**

Los entornos virtuales permiten crear espacios aislados para proyectos de Python, donde se pueden gestionar dependencias y versiones de paquetes sin afectar el sistema global. Esto es especialmente útil para evitar conflictos entre paquetes de diferentes proyectos.

##### **Creación y Uso de Entornos Virtuales con venv**

`venv` es un módulo incluido en la biblioteca estándar de Python que permite crear entornos virtuales.

1. **Creación de un entorno virtual:**
   - Abre una terminal y navega al directorio de tu proyecto.
   - Ejecuta el siguiente comando para crear un entorno virtual:

   ```shell
   python -m venv myenv
   ```

   Esto creará un directorio llamado `myenv` que contendrá los archivos del entorno virtual.

2. **Activación del entorno virtual:**
   - **Windows:**

   ```shell
   myenv\Scripts\activate
   ```

   - **macOS/Linux:**

   ```shell
   source myenv/bin/activate
   ```

   Una vez activado, verás el nombre del entorno virtual precediendo el prompt de tu terminal.

3. **Instalación de paquetes en el entorno virtual:**
   - Con el entorno virtual activado, usa `pip` para instalar los paquetes necesarios:

   ```shell
   pip install package_name
   ```

   Los paquetes se instalarán en el entorno virtual, sin afectar el entorno global de Python.

4. **Desactivación del entorno virtual:**
   - Para desactivar el entorno virtual y volver al entorno global, ejecuta el comando:

   ```shell
   deactivate
   ```

##### **Uso de Entornos Virtuales con virtualenv**

`virtualenv` es una herramienta alternativa a `venv` que ofrece funcionalidades adicionales.

1. **Instalación de virtualenv:**
   - Primero, asegúrate de tener `pip` instalado.
   - Luego, instala `virtualenv`:

   ```shell
   pip install virtualenv
   ```

2. **Creación de un entorno virtual con virtualenv:**
   - Navega al directorio de tu proyecto y ejecuta el siguiente comando:

   ```shell
   virtualenv myenv
   ```

3. **Activación y desactivación del entorno virtual:**
   - La activación y desactivación del entorno virtual funciona de la misma manera que con `venv`.

##### **Uso de Entornos Virtuales con Conda**

Conda es un gestor de paquetes y entornos que viene incluido con Anaconda y Miniconda.

1. **Creación de un entorno virtual con Conda:**
   - Ejecuta el siguiente comando para crear un entorno virtual con una versión específica de Python:

   ```shell
   conda create --name myenv python=3.8
   ```

2. **Activación del entorno virtual:**

   ```shell
   conda activate myenv
   ```

3. **Instalación de paquetes en el entorno virtual:**

   ```shell
   conda install package_name
   ```

4. **Desactivación del entorno virtual:**

   ```shell
   conda deactivate
   ```

5. **Eliminación de un entorno virtual:**

   ```shell
   conda remove --name myenv --all
   ```

#### **1.3.3 Gestión de Dependencias con requirements.txt**

Para facilitar la gestión de dependencias y compartir proyectos con otros desarrolladores, es útil utilizar un archivo `requirements.txt` que liste todas las dependencias necesarias para el proyecto.

1. **Creación de un archivo requirements.txt:**
   - Con el entorno virtual activado, guarda las dependencias instaladas en un archivo `requirements.txt` ejecutando:

   ```shell
   pip freeze > requirements.txt
   ```

2. **Instalación de dependencias desde requirements

.txt:**
   - Para instalar todas las dependencias listadas en un archivo `requirements.txt`, ejecuta:

   ```shell
   pip install -r requirements.txt
   ```

#### **Conclusión**

Contar con las herramientas de desarrollo adecuadas es crucial para trabajar eficientemente con Python. Elegir un buen IDE o editor de texto, junto con la gestión adecuada de entornos virtuales, puede mejorar significativamente tu flujo de trabajo y la calidad de tus proyectos. Con estas herramientas, estarás bien equipado para abordar las tareas de administración de sistemas y desarrollar scripts y aplicaciones de manera efectiva.