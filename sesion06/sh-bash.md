### **Estructuras Algorítmicas en Bash**

En Bash, puedes utilizar diversas estructuras de control para escribir algoritmos complejos. Estas estructuras incluyen condicionales, bucles y funciones. A continuación, se detallan estas estructuras junto con ejemplos para ilustrar su uso.

#### **1. Condicionales**

##### **Sentencia `if-else`**

```bash
#!/bin/bash

echo "Ingrese un número:"
read numero

if [ $numero -gt 10 ]; then
    echo "El número es mayor que 10"
elif [ $numero -eq 10 ]; then
    echo "El número es igual a 10"
else
    echo "El número es menor que 10"
fi
```

##### **Operadores de Comparación**

- `-eq`: Igual a
- `-ne`: No igual a
- `-lt`: Menor que
- `-le`: Menor o igual que
- `-gt`: Mayor que
- `-ge`: Mayor o igual que

##### **Condiciones Compuestas**

```bash
#!/bin/bash

echo "Ingrese un número:"
read numero

if [ $numero -gt 10 ] && [ $numero -lt 20 ]; then
    echo "El número está entre 10 y 20"
fi
```

#### **2. Bucles**

##### **Bucle `for`**

```bash
#!/bin/bash

for i in {1..5}; do
    echo "Iteración $i"
done
```

##### **Bucle `while`**

```bash
#!/bin/bash

contador=1

while [ $contador -le 5 ]; do
    echo "Contador: $contador"
    ((contador++))
done
```

##### **Bucle `until`**

```bash
#!/bin/bash

contador=1

until [ $contador -gt 5 ]; do
    echo "Contador: $contador"
    ((contador++))
done
```

##### **Bucle `select`**

```bash
#!/bin/bash

echo "Seleccione una opción:"
select opcion in "Opción 1" "Opción 2" "Salir"; do
    case $opcion in
        "Opción 1")
            echo "Elegiste Opción 1"
            ;;
        "Opción 2")
            echo "Elegiste Opción 2"
            ;;
        "Salir")
            break
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac
done
```

#### **3. Funciones**

Las funciones permiten modularizar el código, haciéndolo más legible y reutilizable.

```bash
#!/bin/bash

# Definición de una función
mi_funcion() {
    echo "Hola, esta es una función"
}

# Llamada a la función
mi_funcion
```

##### **Funciones con Parámetros**

```bash
#!/bin/bash

# Definición de una función con parámetros
saludar() {
    echo "Hola, $1 $2"
}

# Llamada a la función con argumentos
saludar "Juan" "Pérez"
```

##### **Retorno de Valores**

```bash
#!/bin/bash

# Función para sumar dos números
sumar() {
    local resultado=$(( $1 + $2 ))
    echo $resultado
}

# Llamada a la función y captura del resultado
resultado=$(sumar 3 5)
echo "La suma es: $resultado"
```

#### **4. Manejo de Archivos**

##### **Lectura de Archivos**

```bash
#!/bin/bash

# Leer un archivo línea por línea
while IFS= read -r linea; do
    echo $linea
done < "archivo.txt"
```

##### **Escritura en Archivos**

```bash
#!/bin/bash

# Escribir en un archivo
echo "Este es un texto de ejemplo" > "salida.txt"

# Añadir texto a un archivo existente
echo "Este es otro texto de ejemplo" >> "salida.txt"
```

#### **5. Estructuras Algorítmicas Complejas**

##### **Ejemplo: Script para Calcular Factorial**

```bash
#!/bin/bash

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

echo "Ingrese un número:"
read numero

# Verificar que el número es positivo
if [ $numero -lt 0 ]; then
    echo "Por favor ingrese un número positivo"
else
    resultado=$(factorial $numero)
    echo "El factorial de $numero es $resultado"
fi
```

##### **Ejemplo: Script para Ordenar Números (Método Burbuja)**

```bash
#!/bin/bash

# Función para ordenar un array usando el método burbuja
burbuja() {
    local arr=("$@")
    local n=${#arr[@]}
    for ((i = 0; i < n; i++)); do
        for ((j = 0; j < n-i-1; j++)); do
            if [ ${arr[j]} -gt ${arr[$((j+1))]} ]; then
                # Intercambiar
                local temp=${arr[j]}
                arr[j]=${arr[$((j+1))]}
                arr[$((j+1))]=$temp
            fi
        done
    done
    echo "${arr[@]}"
}

echo "Ingrese los números separados por espacio:"
read -a numeros

# Ordenar los números
numeros_ordenados=($(burbuja "${numeros[@]}"))
echo "Números ordenados: ${numeros_ordenados[@]}"
```

### **Conclusión**

Bash ofrece una amplia variedad de estructuras algorítmicas que te permiten escribir scripts potentes y flexibles. Entender y dominar estas estructuras es fundamental para desarrollar soluciones de automatización eficientes. Con el uso adecuado de condicionales, bucles, funciones y manejo de archivos, puedes abordar problemas complejos de manera efectiva en tus scripts de Bash.