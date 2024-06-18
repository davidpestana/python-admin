### **Laboratorio de Depuración de Scripts en Bash**

En este laboratorio, vamos a partir de una aplicación Bash que no está funcionando como se esperaba. A través de diferentes técnicas de depuración, identificaremos y corregiremos los errores en el script.

#### **Objetivos:**
- Escribir un script Bash con errores intencionales.
- Aplicar técnicas de depuración para identificar y corregir los errores.
- Utilizar `set`, `trap`, y mensajes de depuración personalizados para mejorar el script.

### **Paso 1: Crear un Script con Errores**

Primero, crearemos un script que intenta realizar varias tareas, pero contiene errores intencionales.

**Script `app_errores.sh` con errores:**

```bash
#!/bin/bash

# Función para saludar al usuario
saludar() {
    echo "Hola, $1! Bienvenido al script de depuración."
}

# Función para calcular el factorial de un número
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local result=$(factorial $temp)
        echo $(( $1 * result ))
    fi
}

# Función para convertir Celsius a Fahrenheit
celsius_a_fahrenheit() {
    local celsius=$1
    local fahrenheit=$(echo "scale=2; $celsius * 9 / 5 + 32" | bc)
    echo $fahrenheit
}

# Función para verificar si un número es par o impar
es_par() {
    local numero=$1
    if [ $(( numero % 2 )) -eq 0 ]; then
        echo "par"
    else
        echo "impar"
    fi
}

# Script principal
echo "Ingrese su nombre:"
read nombre
saludar $nombre

echo "Ingrese un número para calcular su factorial:"
read numero
resultado_factorial=$(factorial $numero)
echo "El factorial de $numero es $resultado_factorial"

echo "Ingrese una temperatura en Celsius para convertir a Fahrenheit:"
read celsius
fahrenheit=$(celsius_a_fahrenheit $celsius)
echo "$celsius grados Celsius son $fahrenheit grados Fahrenheit"

echo "Ingrese un número para verificar si es par o impar:"
read numero
resultado_par=$(es_par $numero)
echo "El número $numero es $resultado_par"
```

### **Paso 2: Ejecutar el Script y Observar los Errores**

Guarda el script en un archivo llamado `app_errores.sh`, hazlo ejecutable y ejecútalo para observar los errores.

```bash
chmod +x app_errores.sh
./app_errores.sh
```

### **Paso 3: Aplicar Técnicas de Depuración**

#### **Técnica 1: Usar `set -x` y `set -e`**

Añadimos `set -x` para habilitar el modo de depuración y `set -e` para salir inmediatamente si un comando falla.

```bash
#!/bin/bash

set -x  # Modo de depuración
set -e  # Salir inmediatamente si un comando falla

# Función para saludar al usuario
saludar() {
    echo "Hola, $1! Bienvenido al script de depuración."
}

# Función para calcular el factorial de un número
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local result=$(factorial $temp)
        echo $(( $1 * result ))
    fi
}

# Función para convertir Celsius a Fahrenheit
celsius_a_fahrenheit() {
    local celsius=$1
    local fahrenheit=$(echo "scale=2; $celsius * 9 / 5 + 32" | bc)
    echo $fahrenheit
}

# Función para verificar si un número es par o impar
es_par() {
    local numero=$1
    if [ $(( numero % 2 )) -eq 0 ]; then
        echo "par"
    else
        echo "impar"
    fi
}

# Script principal
echo "Ingrese su nombre:"
read nombre
saludar $nombre

echo "Ingrese un número para calcular su factorial:"
read numero
resultado_factorial=$(factorial $numero)
echo "El factorial de $numero es $resultado_factorial"

echo "Ingrese una temperatura en Celsius para convertir a Fahrenheit:"
read celsius
fahrenheit=$(celsius_a_fahrenheit $celsius)
echo "$celsius grados Celsius son $fahrenheit grados Fahrenheit"

echo "Ingrese un número para verificar si es par o impar:"
read numero
resultado_par=$(es_par $numero)
echo "El número $numero es $resultado_par"
```

Ejecuta el script de nuevo y observa la salida detallada para identificar posibles errores.

### **Paso 4: Usar `trap` para Capturar Errores**

Añadimos una función de manejo de errores y `trap` para capturar errores y ejecutar la función correspondiente.

```bash
#!/bin/bash

set -e  # Salir inmediatamente si un comando falla

# Función de manejo de errores
handle_error() {
    echo "Error en la línea $1"
}

# Configurar trap para errores (ERR) y salida (EXIT)
trap 'handle_error $LINENO' ERR
trap 'echo "Script terminado"; exit' EXIT

# Función para saludar al usuario
saludar() {
    echo "Hola, $1! Bienvenido al script de depuración."
}

# Función para calcular el factorial de un número
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local result=$(factorial $temp)
        echo $(( $1 * result ))
    fi
}

# Función para convertir Celsius a Fahrenheit
celsius_a_fahrenheit() {
    local celsius=$1
    local fahrenheit=$(echo "scale=2; $celsius * 9 / 5 + 32" | bc)
    echo $fahrenheit
}

# Función para verificar si un número es par o impar
es_par() {
    local numero=$1
    if [ $(( numero % 2 )) -eq 0 ]; then
        echo "par"
    else
        echo "impar"
    fi
}

# Script principal
echo "Ingrese su nombre:"
read nombre
saludar $nombre

echo "Ingrese un número para calcular su factorial:"
read numero
resultado_factorial=$(factorial $numero)
echo "El factorial de $numero es $resultado_factorial"

echo "Ingrese una temperatura en Celsius para convertir a Fahrenheit:"
read celsius
fahrenheit=$(celsius_a_fahrenheit $celsius)
echo "$celsius grados Celsius son $fahrenheit grados Fahrenheit"

echo "Ingrese un número para verificar si es par o impar:"
read numero
resultado_par=$(es_par $numero)
echo "El número $numero es $resultado_par"
```

Ejecuta el script de nuevo para observar cómo se capturan y manejan los errores.

### **Paso 5: Añadir Mensajes de Depuración Personalizados**

Añadimos mensajes de depuración personalizados para rastrear el flujo de ejecución y los valores de las variables.

```bash
#!/bin/bash

set -e  # Salir inmediatamente si un comando falla

# Función de manejo de errores
handle_error() {
    echo "Error en la línea $1"
}

# Configurar trap para errores (ERR) y salida (EXIT)
trap 'handle_error $LINENO' ERR
trap 'echo "Script terminado"; exit' EXIT

# Función de depuración personalizada
debug() {
    echo "DEBUG: $1"
}

# Función para saludar al usuario
saludar() {
    echo "Hola, $1! Bienvenido al script de depuración."
}

# Función para calcular el factorial de un número
factorial() {
    debug "Calculando el factorial de $1"
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local result=$(factorial $temp)
        echo $(( $1 * result ))
    fi
}

# Función para convertir Celsius a Fahrenheit
celsius_a_fahrenheit() {
    local celsius=$1
    local fahrenheit=$(echo "scale=2; $celsius * 9 / 5 + 32" | bc)
    debug "Convirtiendo $celsius°C a $fahrenheit°F"
    echo $fahrenheit
}

# Función para verificar si un número es par o impar
es_par() {
    local numero=$1
    debug "Verificando si $numero es par o impar"
    if [ $(( numero % 2 )) -eq 0 ]; then
        echo "par"
    else
        echo "impar"
    fi
}

# Script principal
echo "Ingrese su nombre:"
read nombre
saludar $nombre

echo "Ingrese un número para calcular su factorial:"
read numero
resultado_factorial=$(factorial $numero)
echo "El factorial de $numero es $resultado_factorial"

echo "Ingrese una temperatura en Celsius para convertir a Fahrenheit:"
read celsius
fahrenheit=$(celsius_a_fahrenheit $celsius)
echo "$celsius grados Celsius son $fahrenheit grados Fahrenheit"

echo "Ingrese un número para verificar si es par o impar:"
read numero
resultado_par=$(es_par $numero)
echo "El número $numero es $resultado_par"
```

### **Conclusión**

Hemos pasado por varios pasos para depurar un script en

 Bash, identificando y corrigiendo errores utilizando diferentes técnicas de depuración. Estas técnicas incluyen el uso de `set -x`, `set -e`, `trap` y mensajes de depuración personalizados. Al aplicar estas técnicas, hemos mejorado la fiabilidad y el rendimiento del script, asegurando que funcione correctamente y maneje errores de manera eficiente.
