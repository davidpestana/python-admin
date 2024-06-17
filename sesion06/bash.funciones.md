### Creación y uso de funciones en Bash

Las funciones en Bash son bloques de código reutilizables que permiten modularizar scripts, mejorando su organización y legibilidad. A continuación, se presenta una explicación detallada sobre cómo crear y usar funciones en Bash, incluyendo ejemplos prácticos.

#### Definición de una Función

Para definir una función en Bash, se pueden usar dos sintaxis principales:

1. Usando la palabra clave `function`:

   ```bash
   function nombre_funcion {
       # Código de la función
   }
   ```

2. Sin la palabra clave `function` (sintaxis más común):

   ```bash
   nombre_funcion() {
       # Código de la función
   }
   ```

Ambas sintaxis son equivalentes y permiten definir una función que puede ser llamada en cualquier parte del script después de su definición.

#### Ejemplo Básico de Función

A continuación, se muestra un ejemplo simple de una función que imprime un saludo:

```bash
#!/bin/bash

# Definición de la función
saludar() {
    echo "Hola, $1"
}

# Llamada a la función con un argumento
saludar "Mundo"
```

Este script define una función llamada `saludar` que toma un argumento y lo imprime junto con un mensaje de saludo.

#### Funciones con Múltiples Argumentos

Las funciones pueden aceptar múltiples argumentos, los cuales se acceden mediante `$1`, `$2`, ..., `$N`. Aquí tienes un ejemplo:

```bash
#!/bin/bash

# Definición de la función
sumar() {
    local resultado=$(( $1 + $2 ))
    echo "La suma de $1 y $2 es: $resultado"
}

# Llamada a la función con dos argumentos
sumar 5 7
```

En este caso, la función `sumar` recibe dos argumentos, los suma y luego imprime el resultado.

#### Retorno de Valores

En Bash, las funciones no pueden devolver valores directamente como en otros lenguajes de programación. En su lugar, se usa la instrucción `return` para devolver un estado de salida (un número entre 0 y 255) y se pueden usar variables globales o la salida estándar para devolver otros tipos de valores.

```bash
#!/bin/bash

# Definición de la función
calcular_area() {
    local base=$1
    local altura=$2
    local area=$(( base * altura / 2 ))
    echo $area
}

# Llamada a la función y captura del valor retornado
resultado=$(calcular_area 10 5)
echo "El área del triángulo es: $resultado"
```

En este ejemplo, la función `calcular_area` calcula el área de un triángulo y devuelve el resultado usando `echo`, que luego se captura en la variable `resultado`.

#### Variables Locales

Para evitar conflictos con variables globales, es buena práctica usar variables locales dentro de las funciones. Esto se hace usando la palabra clave `local`.

```bash
#!/bin/bash

# Definición de la función
contar() {
    local inicio=$1
    local fin=$2
    for (( i=inicio; i<=fin; i++ )); do
        echo $i
    done
}

# Llamada a la función
contar 1 5
```

En este caso, las variables `inicio` y `fin` son locales a la función `contar`, lo que significa que no afectarán el valor de las variables fuera de la función.

#### Funciones Anidadas

Bash permite definir funciones dentro de otras funciones, aunque esto no es muy común. Aquí tienes un ejemplo:

```bash
#!/bin/bash

# Función externa
externa() {

    # Función interna
    interna() {
        echo "Esta es una función interna"
    }

    echo "Esta es una función externa"
    interna  # Llamada a la función interna
}

# Llamada a la función externa
externa
```

En este ejemplo, `interna` está definida dentro de `externa` y solo puede ser llamada desde dentro de `externa`.

#### Ejemplo Completo: Script de Copia de Seguridad

A continuación se presenta un ejemplo completo de un script que utiliza funciones para realizar una copia de seguridad de archivos:

```bash
#!/bin/bash

# Función para mostrar el uso del script
mostrar_uso() {
    echo "Uso: $0 origen destino"
    exit 1
}

# Función para verificar la existencia de un directorio
verificar_directorio() {
    if [ ! -d "$1" ]; then
        echo "Error: el directorio $1 no existe."
        exit 1
    fi
}

# Función para realizar la copia de seguridad
copiar_archivos() {
    local origen=$1
    local destino=$2
    cp -r "$origen"/* "$destino"
    echo "Copia de seguridad completada de $origen a $destino"
}

# Verificación de argumentos
if [ "$#" -ne 2 ]; then
    mostrar_uso
fi

# Variables de los directorios
dir_origen=$1
dir_destino=$2

# Verificación de la existencia de los directorios
verificar_directorio "$dir_origen"
verificar_directorio "$dir_destino"

# Realizar la copia de seguridad
copiar_archivos "$dir_origen" "$dir_destino"
```

Este script realiza una copia de seguridad de todos los archivos de un directorio origen a un directorio destino. Utiliza funciones para modularizar las tareas de verificación y copia, lo que mejora la claridad y mantenibilidad del script.

#### Conclusión

Las funciones en Bash son herramientas poderosas para escribir scripts más organizados y reutilizables. Al aprender a crear y usar funciones, puedes mejorar significativamente tus habilidades de scripting y automatización en Bash.
