### **Técnicas de Depuración en Bash**

Depurar scripts de Bash puede ser un proceso complejo, pero con las herramientas y técnicas adecuadas, se puede simplificar considerablemente. A continuación se presentan diversas estrategias y herramientas para depurar scripts de Bash.

#### **1. Uso de `set` para Depuración**

##### **Habilitar el Modo de Depuración**

- `set -x`: Muestra cada comando y su argumento mientras se ejecuta. Es útil para ver el flujo de ejecución y los valores de las variables.
- `set -e`: Hace que el script salga inmediatamente si un comando devuelve un estado de salida diferente de cero. Ayuda a detectar errores rápidamente.
- `set -u`: Tratar las variables no inicializadas como errores, lo que evita errores comunes debido a variables no definidas.
- `set -o pipefail`: Hace que un pipeline devuelva el estado de salida del último comando que falla (en lugar del último comando del pipeline).

```bash
#!/bin/bash
set -x  # Activa el modo de depuración
set -e  # Salir inmediatamente si un comando falla
set -u  # Error en caso de variables no definidas
set -o pipefail  # Detectar errores en pipelines

echo "Inicio del script"
mi_variable="Hola Mundo"
echo $mi_variable
```

##### **Desactivar el Modo de Depuración**

- `set +x`: Desactiva el modo de depuración.

```bash
#!/bin/bash
set -x
echo "Esta línea se muestra en el modo de depuración"
set +x
echo "Esta línea no se muestra en el modo de depuración"
```

#### **2. Uso de `trap` para Capturar Errores**

La función `trap` permite capturar señales y errores específicos durante la ejecución del script y ejecutar una función o comando en respuesta.

```bash
#!/bin/bash

# Función de manejo de errores
function handle_error {
    echo "Error en la línea $1"
}

# Configurar trap para errores (ERR) y salida (EXIT)
trap 'handle_error $LINENO' ERR
trap 'echo "Script terminado"; exit' EXIT

# Comandos del script
echo "Inicio del script"
mi_variable="Hola Mundo"
# Generar un error
false
echo $mi_variable
```

#### **3. Mensajes de Depuración Personalizados**

Insertar mensajes de depuración personalizados en el script ayuda a rastrear el flujo de ejecución y los valores de las variables.

```bash
#!/bin/bash

debug() {
    echo "DEBUG: $1"
}

echo "Inicio del script"
mi_variable="Hola Mundo"
debug "Valor de mi_variable: $mi_variable"
```

#### **4. Uso de `bash -x` y `bash -v`**

- `bash -x script.sh`: Ejecuta el script mostrando cada comando antes de ejecutarlo.
- `bash -v script.sh`: Ejecuta el script mostrando cada línea del script a medida que se lee.

```bash
# Ejecutar un script con bash -x
bash -x script.sh

# Ejecutar un script con bash -v
bash -v script.sh
```

#### **5. Ejemplo Completo**

A continuación, se muestra un ejemplo completo que utiliza varias técnicas de depuración.

```bash
#!/bin/bash
set -x  # Activar modo de depuración

# Función de manejo de errores
function handle_error {
    echo "Error en la línea $1"
}

# Configurar trap para errores (ERR) y salida (EXIT)
trap 'handle_error $LINENO' ERR
trap 'echo "Script terminado"; exit' EXIT

# Mensaje de inicio
echo "Inicio del script"

# Variable para depuración
mi_variable="Hola Mundo"
debug "Valor de mi_variable: $mi_variable"

# Comando que falla
false

# Fin del script
echo "Fin del script"
```

#### **6. Uso de `bashdb` para Depuración Interactiva**

`bashdb` es un depurador de scripts Bash que permite ejecutar el script paso a paso, inspeccionar variables y ejecutar comandos de depuración interactivos.

```bash
# Instalar bashdb (si no está instalado)
sudo apt-get install bashdb

# Ejecutar el script con bashdb
bashdb script.sh
```

En `bashdb`, se pueden usar comandos como `step` (para avanzar un paso), `next` (para avanzar al siguiente comando), `print` (para mostrar el valor de una variable), entre otros.

### **Conclusión**

Depurar scripts de Bash puede parecer desafiante, pero con las técnicas adecuadas, se puede hacer de manera efectiva. Utilizar `set` para habilitar modos de depuración, `trap` para manejar errores, mensajes de depuración personalizados y herramientas como `bashdb` son estrategias clave para identificar y corregir errores en tus scripts.