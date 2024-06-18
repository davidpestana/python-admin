### **Uso de Arrays en Bash**

Los arrays en Bash son estructuras que permiten almacenar múltiples valores bajo un solo nombre de variable. Pueden ser muy útiles para gestionar listas de datos de manera eficiente.

#### **1. Declaración de Arrays**

En Bash, hay dos tipos principales de arrays:
- Arrays indexados por enteros
- Arrays asociativos

##### **Arrays Indexados por Enteros**
Estos arrays utilizan índices numéricos para acceder a los elementos.

```bash
# Declarar un array
mi_array=(valor1 valor2 valor3)

# Otra forma de declarar un array
mi_array[0]=valor1
mi_array[1]=valor2
mi_array[2]=valor3

# Declarar un array vacío
mi_array=()
```

##### **Arrays Asociativos**
Estos arrays utilizan claves para acceder a los elementos. Necesitan ser declarados explícitamente como asociativos.

```bash
# Declarar un array asociativo
declare -A mi_array_asociativo

# Asignar valores
mi_array_asociativo[clave1]=valor1
mi_array_asociativo[clave2]=valor2
```

#### **2. Acceso a Elementos del Array**

##### **Arrays Indexados por Enteros**

```bash
# Acceder a un elemento
echo ${mi_array[0]}  # Salida: valor1

# Acceder a todos los elementos
echo ${mi_array[@]}  # Salida: valor1 valor2 valor3
```

##### **Arrays Asociativos**

```bash
# Acceder a un elemento
echo ${mi_array_asociativo[clave1]}  # Salida: valor1

# Acceder a todos los valores
echo ${mi_array_asociativo[@]}  # Salida: valor1 valor2

# Acceder a todas las claves
echo ${!mi_array_asociativo[@]}  # Salida: clave1 clave2
```

#### **3. Operaciones con Arrays**

##### **Agregar Elementos**

```bash
# Agregar un nuevo elemento a un array indexado
mi_array+=(valor4)
```

##### **Eliminar Elementos**

```bash
# Eliminar un elemento específico
unset mi_array[1]

# Eliminar todo el array
unset mi_array
```

##### **Longitud del Array**

```bash
# Longitud de un array indexado
echo ${#mi_array[@]}  # Salida: 3 (si el array tiene 3 elementos)

# Longitud de un array asociativo
echo ${#mi_array_asociativo[@]}  # Salida: 2 (si el array tiene 2 elementos)
```

#### **4. Iteración sobre Arrays**

##### **Arrays Indexados por Enteros**

```bash
# Iterar sobre todos los elementos
for elemento in "${mi_array[@]}"; do
  echo $elemento
done
```

##### **Arrays Asociativos**

```bash
# Iterar sobre todas las claves y valores
for clave in "${!mi_array_asociativo[@]}"; do
  echo "Clave: $clave, Valor: ${mi_array_asociativo[$clave]}"
done
```

#### **5. Ejemplo Completo**

```bash
#!/bin/bash

# Declarar un array indexado
frutas=("manzana" "banana" "cereza")

# Declarar un array asociativo
declare -A capitales
capitales["España"]="Madrid"
capitales["Francia"]="París"

# Acceso y manipulación de arrays indexados
echo "Fruta en el índice 1: ${frutas[1]}"
frutas[3]="naranja"
echo "Todas las frutas: ${frutas[@]}"

# Acceso y manipulación de arrays asociativos
echo "Capital de España: ${capitales["España"]}"
capitales["Italia"]="Roma"
echo "Todas las capitales: ${capitales[@]}"
echo "Todas las claves de capitales: ${!capitales[@]}"

# Iteración sobre arrays indexados
echo "Iteración sobre frutas:"
for fruta in "${frutas[@]}"; do
  echo $fruta
done

# Iteración sobre arrays asociativos
echo "Iteración sobre capitales:"
for pais in "${!capitales[@]}"; do
  echo "La capital de $pais es ${capitales[$pais]}"
done
```

Este script muestra cómo declarar, acceder, manipular e iterar sobre arrays tanto indexados por enteros como asociativos en Bash. Puedes usar este conocimiento para manejar listas de datos y realizar operaciones más complejas en tus scripts de Bash.