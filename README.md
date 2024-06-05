### **Sesión 1: Introducción a Python y Configuración del Entorno**
#### **Objetivos:**
- Familiarizarse con Python y su sintaxis básica.
- Configurar el entorno de desarrollo.

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
1. **[Configuración del entorno:](PRACTICA.1.1.md)**
   - Instalación de Python.
   - Configuración de un entorno virtual.
   - Instalación de paquetes básicos (`pip`, `venv`).
2. **[Primeros pasos en Python:](PRACTICA.1.2.md)**
   - Escribir y ejecutar un script simple.
   - Sintaxis básica: variables, tipos de datos, operadores.

#### **Tarea:**
- Escribir un script que tome un nombre y edad como entrada y muestre un saludo personalizado.

#### **Extra:**
- [Ejercicio Complementario: Calculadora Simple](EXTRA.1.md)

### **Sesión 2: Manejo de Archivos y Automatización de Tareas**
#### **Objetivos:**
- Aprender a leer y escribir archivos.
- Automatizar tareas comunes de administración de sistemas.

#### **Teoría:**
1. **Manejo de archivos en Python:**
   - [Operaciones básicas (leer, escribir, actualizar).](archivos.operaciones.md)
   - [Uso de context managers (`with` statement).](archivos.context.manager.md)
2. **Automatización de tareas:**
   - [Scripts para tareas comunes (copias de seguridad, limpieza de directorios).](archivos.scripts.md)

#### **Práctica:**
1. **[Manipulación de archivos:](PRACTICA.2.1.md)**
   - Leer y escribir archivos de texto.
   - Procesar archivos CSV.
2. **[Automatización:](PRACTICA.2.2.md)**
   - Escribir un script para mover archivos antiguos a un directorio de respaldo.
   - Automatizar la creación de directorios y la copia de archivos.

#### **Tarea:**
- Crear un script que lea un archivo de registro (log) y genere un informe resumido.

#### **Extra:**
- [Ejercicio Complementario: Sincronizar directorios](EXTRA.2.md)

### **Sesión 3: Interacción con el Sistema Operativo y Redes**
#### **Objetivos:**
- Aprender a interactuar con el sistema operativo.
- Manejar operaciones de red básicas.

#### **Teoría:**
1. **Interacción con el sistema operativo:**
   - [Uso del módulo `os` y `subprocess`.](interacciones.so.md)
2. **Operaciones de red:**
   - [Uso del módulo `socket`.](interacciones.red.socket.md)
   - [Realización de solicitudes HTTP con `requests`.](interacciones.red.http.md)

#### **Práctica:**
1. [**Interacción con el sistema operativo:**](PRACTICA.3.1.md)
   - Ejecución de comandos del sistema desde Python.
   - Gestión de procesos.
2. [**Operaciones de red:**](PRACTICA.3.2.md)
   - Crear un script que obtenga la dirección IP de un sitio web.
   - Escribir un script para realizar solicitudes HTTP y analizar respuestas.

#### **Tarea:**
- Desarrollar un script que monitoree el uso del CPU y memoria, y envíe una alerta si supera un umbral definido.

#### **Extra:**
- [Ejercicio Complementario: Escaner de puertos](EXTRA.3.md)

### **Sesión 4: Gestión de Usuarios y Permisos**
#### **Objetivos:**
- Gestionar usuarios y permisos del sistema.

#### **Teoría:**
1. **Gestión de usuarios y grupos:**
   - [Uso de módulos como `pwd` y `grp`.](usuarios.grupos.md)
   - [Manipulación de permisos de archivos con `os.chmod`.](usuarios.permisos.md)
2. **Automatización de tareas de administración:**
   - [Scripts para agregar/eliminar usuarios.](usuarios.automatizacion.operaciones.md)
   - [Cambio de permisos y propiedades de archivos.](usuarios.automatizacion.permisos.md)

#### **Práctica:**
1. [**Gestión de usuarios:**](PRACTICA.4.1.md)
   - Escribir un script para listar todos los usuarios del sistema.
   - Automatizar la creación de nuevos usuarios y la asignación de grupos.
2. [**Permisos:**](PRACTICA.4.2.md)
   - Crear un script para cambiar permisos de archivos en un directorio.
   - Escribir un script que verifique y ajuste los permisos según un criterio predefinido.

#### **Tarea:**
- Escribir un script que revise los permisos de archivos críticos y envíe un reporte por correo electrónico.

#### **Extra:**
- [Ejercicio Complementario: Auditoría y Corrección de Permisos en un Sistema de Archivos](EXTRA.4.md)

### **Sesión 5: Monitoreo y Mantenimiento del Sistema**
#### **Objetivos:**
- Implementar scripts de monitoreo y mantenimiento del sistema.

#### **Teoría:**
1. **Monitoreo del sistema:**
   - [Uso de módulos como `psutil`.](monitoreo.psutil.md)
   - [Registro y alerta de eventos del sistema.](monitoreo.eventos.md)
2. **Mantenimiento:**
   - [Scripts para la limpieza del sistema.](mantenimiento.limpieza.md)
   - [Programación de tareas con `cron`.](mantenimiento.cron.md)

#### **Práctica:**
1. [**Monitoreo del sistema:**](PRACTICA.5.1.md)
   - Crear un script que registre el uso del sistema en un archivo de log.
   - Configurar alertas para eventos específicos (p.ej., uso de disco).
2. [**Mantenimiento:**](PRACTICA.5.2.md)
   - Escribir un script para limpiar archivos temporales y logs antiguos.
   - Automatizar la ejecución de scripts de mantenimiento usando `cron`.

#### **Tarea:**
- Configurar un script de monitoreo que ejecute tareas de mantenimiento automáticamente y genere informes periódicos.

#### **Extra:**
- [Ejercicio Complementario: Sistema de Monitoreo y Notificación Completo](EXTRA.5.md)


---

### **Materiales Adicionales:**
- **Documentación:** Documentación oficial de Python (https://docs.python.org/3/).
- **Libros recomendados:**
  - "Automate the Boring Stuff with Python" de Al Sweigart.
  - "Python for Unix and Linux System Administration" de Noah Gift y Jeremy M. Jones.