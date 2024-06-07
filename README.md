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
3. **Librerias especificas:**
   - [oswalk](archivos.oswalk.md)
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




### **Sesión 6: Uso Avanzado de Bash para Automatización**
#### **Objetivos:**
- Dominar técnicas avanzadas de scripting en Bash.
- Aplicar conceptos avanzados de Bash en scripts de automatización.

#### **Teoría:**
1. **Funciones en Bash:**
   - [Creación y uso de funciones en Bash](bash.funciones.md).
2. **Arrays y manipulación avanzada de cadenas:**
   - [Uso de arrays](bash.arrays.md).
   - [Manipulación de cadenas](bash.cadenas.md).
3. **Depuración de scripts:**
   - [Técnicas de depuración](bash.debugging.md).

#### **Práctica:**
1. [**Creación de funciones en Bash:**](PRACTICA.6.1.md)
   - Escribir scripts que utilicen funciones para modularidad.
2. [**Manipulación avanzada:**](PRACTICA.6.2.md)
   - Trabajar con arrays y cadenas complejas.
3. [**Depuración:**](PRACTICA.6.3.md)
   - Escribir scripts y aplicar técnicas de depuración.

#### **Tarea:**
- Crear un script Bash que automatice una tarea compleja utilizando funciones y arrays.

#### **Extra:**
- [Ejercicio Complementario: Análisis de Logs Complejo](EXTRA.6.md)

### **Sesión 7: Integración de Herramientas Externas en Bash y Python**
#### **Objetivos:**
- Aprender a integrar herramientas externas en scripts Bash y Python.
- Aplicar técnicas de integración en automatización.

#### **Teoría:**
1. **Uso de herramientas externas en Bash:**
   - [Integración con herramientas como `curl`, `jq`, etc.](bash.herramientas.md).
2. **Uso de bibliotecas externas en Python:**
   - [Integración con bibliotecas como `requests`, `BeautifulSoup`, etc.](python.bibliotecas.md).

#### **Práctica:**
1. [**Integración en Bash:**](PRACTICA.7.1.md)
   - Escribir scripts que utilicen `curl` y `jq` para consumir APIs y procesar JSON.
2. [**Integración en Python:**](PRACTICA.7.2.md)
   - Escribir scripts que usen `requests` y `BeautifulSoup` para scraping web.

#### **Tarea:**
- Crear un script que utilice una API externa para obtener datos y procesarlos.

#### **Extra:**
- [Ejercicio Complementario: Integración con Servicios en la Nube](EXTRA.7.md)

### **Sesión 8: Gestión de Servicios y Daemons con Python y Bash**
#### **Objetivos:**
- Administrar y controlar servicios del sistema.
- Crear y gestionar daemons.

#### **Teoría:**
1. **Gestión de servicios en Bash:**
   - [Uso de `systemctl`, `service`, etc.](bash.servicios.md).
2. **Creación de daemons en Python:**
   - [Uso del módulo `daemon` y técnicas para crear daemons](python.daemon.md).

#### **Práctica:**
1. [**Gestión de servicios en Bash:**](PRACTICA.8.1.md)
   - Escribir scripts para iniciar, detener y supervisar servicios del sistema.
2. [**Creación de daemons en Python:**](PRACTICA.8.2.md)
   - Escribir un daemon en Python para una tarea específica.

#### **Tarea:**
- Crear un script Bash para gestionar un servicio personalizado y un daemon en Python para monitorear un recurso del sistema.

#### **Extra:**
- [Ejercicio Complementario: Sistema de Notificación de Estado de Servicios](EXTRA.8.md)

### **Sesión 9: Seguridad en Scripting**
#### **Objetivos:**
- Implementar prácticas de seguridad en scripting.
- Proteger scripts y datos sensibles.

#### **Teoría:**
1. **Buenas prácticas de seguridad en Bash:**
   - [Validación de entrada, manejo seguro de contraseñas, etc.](bash.seguridad.md).
2. **Buenas prácticas de seguridad en Python:**
   - [Uso de bibliotecas como `cryptography`, manejo seguro de datos, etc.](python.seguridad.md).

#### **Práctica:**
1. [**Seguridad en Bash:**](PRACTICA.9.1.md)
   - Escribir scripts seguros que validen la entrada del usuario y manejen datos sensibles.
2. [**Seguridad en Python:**](PRACTICA.9.2.md)
   - Implementar técnicas de cifrado y manejo seguro de contraseñas en scripts.

#### **Tarea:**
- Crear un script que maneje datos sensibles de forma segura y proteja la información.

#### **Extra:**
- [Ejercicio Complementario: Auditoría de Seguridad en Scripts](EXTRA.9.md)

### **Sesión 10: Automatización de Tareas Complejas**
#### **Objetivos:**
- Aplicar conocimientos avanzados para automatizar tareas complejas.
- Integrar múltiples herramientas y lenguajes en un flujo de trabajo coherente.

#### **Teoría:**
1. **Automatización avanzada:**
   - [Integración de múltiples herramientas y lenguajes](automatizacion.avanzada.md).
   - [Diseño de flujos de trabajo eficientes](flujos.trabajo.md).

#### **Práctica:**
1. [**Automatización compleja:**](PRACTICA.10.1.md)
   - Desarrollar un script avanzado que integre Bash y Python para una tarea específica.
   - Documentar y probar el script.

#### **Tarea:**
- Completar la automatización de una tarea compleja y preparar una presentación de los resultados.

#### **Extra:**
- [Ejercicio Complementario: Despliegue de Automatización en Producción](EXTRA.10.md)

---

### **Materiales Adicionales:**
- **Documentación:** Documentación oficial de Python (https://docs.python.org/3/).
- **Libros recomendados:**
  - "Automate the Boring Stuff with Python" de Al Sweigart.
  - "Python for Unix and Linux System Administration" de Noah Gift y Jeremy M. Jones.
