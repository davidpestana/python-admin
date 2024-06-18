### **Práctica 1: Creación de Funciones en Bash**

En esta práctica, aprenderemos a escribir scripts en Bash utilizando funciones para modularizar el código. La modularidad ayuda a mantener el código limpio, fácil de mantener y reutilizable.

#### **Objetivos:**
- Escribir funciones para tareas específicas.
- Llamar a las funciones desde el script principal.
- Pasar parámetros a las funciones.
- Capturar y utilizar valores de retorno de las funciones.

#### **Ejercicio: Creación de un Script Modular**

Vamos a crear un script que realiza varias tareas comunes usando funciones. El script realizará las siguientes tareas:
1. Saludar al usuario.
2. Calcular el factorial de un número.
3. Convertir una temperatura de Celsius a Fahrenheit.
4. Verificar si un número es par o impar.

### **Script Completo con Funciones**

```bash
#!/bin/bash

# Función para saludar al usuario
saludar() {
    echo "Hola, $1! Bienvenido al script de funciones en Bash."
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

### **Explicación del Script**

#### **1. Función `saludar`**
Esta función toma un parámetro (nombre del usuario) y muestra un mensaje de saludo.
```bash
saludar() {
    echo "Hola, $1! Bienvenido al script de funciones en Bash."
}
```

#### **2. Función `factorial`**
Calcula el factorial de un número usando recursión. Si el número es 1 o menos, retorna 1. Si no, calcula el factorial llamándose a sí misma con el número decrecido en 1.
```bash
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local result=$(factorial $temp)
        echo $(( $1 * result ))
    fi
}
```

#### **3. Función `celsius_a_fahrenheit`**
Convierte una temperatura de Celsius a Fahrenheit usando la fórmula `(Celsius * 9/5) + 32`. Usa `bc` para realizar la operación con precisión de punto flotante.
```bash
celsius_a_fahrenheit() {
    local celsius=$1
    local fahrenheit=$(echo "scale=2; $celsius * 9 / 5 + 32" | bc)
    echo $fahrenheit
}
```

#### **4. Función `es_par`**
Verifica si un número es par o impar usando la operación módulo. Si el número es divisible por 2, es par; si no, es impar.
```bash
es_par() {
    local numero=$1
    if [ $(( numero % 2 )) -eq 0 ]; then
        echo "par"
    else
        echo "impar"
    fi
}
```

### **Ejecución del Script**

1. Guarda el script en un archivo, por ejemplo `script_funciones.sh`.
2. Haz que el script sea ejecutable:
   ```bash
   chmod +x script_funciones.sh
   ```
3. Ejecuta el script:
   ```bash
   ./script_funciones.sh
   ```

El script te pedirá ingresar tu nombre, un número para calcular el factorial, una temperatura en Celsius para convertir a Fahrenheit y un número para verificar si es par o impar. Cada tarea se realizará utilizando una función específica, demostrando cómo modularizar el código en Bash.

### **Conclusión**

Esta práctica muestra cómo escribir y utilizar funciones en Bash para crear scripts modulares y mantenibles. Las funciones permiten dividir el código en partes lógicas y reutilizables, mejorando la estructura y la legibilidad del script.