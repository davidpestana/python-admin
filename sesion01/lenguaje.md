## Lenguaje Python

### Índice

1. [Introducción](#1-introducción)
2. [Sintaxis Básica](#2-sintaxis-básica)
3. [Tipos de Datos](#3-tipos-de-datos)
4. [Estructuras de Datos](#4-estructuras-de-datos)
5. [Control de Flujo](#5-control-de-flujo)
6. [Funciones y Módulos](#6-funciones-y-módulos)
7. [Manejo de Excepciones](#7-manejo-de-excepciones)
8. [Programación Orientada a Objetos](#8-programación-orientada-a-objetos)
9. [Módulos y Paquetes](#9-módulos-y-paquetes)
10. [Entrada y Salida](#10-entrada-y-salida)
11. [Bibliotecas Estándar](#11-bibliotecas-estándar)
12. [Buenas Prácticas](#12-buenas-prácticas)
13. [Recursos Adicionales](#13-recursos-adicionales)

---

### 1. Introducción

Python es un lenguaje de programación de alto nivel, interpretado y de propósito general, que se destaca por su sintaxis clara y legible. Fue creado por Guido van Rossum y lanzado por primera vez en 1991. Python es conocido por su enfoque en la legibilidad del código y la productividad del desarrollador.

#### Características Principales

- **Sintaxis Simple y Clara:** Facilita la lectura y escritura del código.
- **Multiplataforma:** Disponible en varios sistemas operativos como Windows, macOS y Linux.
- **Gran Ecosistema de Bibliotecas:** Dispone de numerosas bibliotecas estándar y de terceros.
- **Soporte para Paradigmas Múltiples:** Incluye programación procedimental, orientada a objetos y funcional.
- **Comunidad Activa:** Gran cantidad de recursos y soporte comunitario.

---

### 2. Sintaxis Básica

La sintaxis de Python es limpia y fácil de entender. Aquí se presentan algunos elementos básicos.

#### Variables y Tipos de Datos

```python
# Declaración de variables
nombre = "Juan"
edad = 25
pi = 3.14159
es_estudiante = True

print(nombre, edad, pi, es_estudiante)
```

#### Operadores

```python
# Operadores aritméticos
suma = 10 + 5
resta = 10 - 5
multiplicacion = 10 * 5
division = 10 / 5

# Operadores de comparación
igual = (10 == 10)
mayor_que = (10 > 5)
menor_que = (10 < 5)

# Operadores lógicos
y = (True and False)
o = (True or False)
no = not True

print(suma, resta, multiplicacion, division, igual, mayor_que, menor_que, y, o, no)
```

#### Comentarios

```python
# Esto es un comentario de una sola línea

"""
Esto es un comentario
de múltiples líneas
"""

# Los comentarios no son ejecutados por el intérprete
```

#### Indentación

Python usa la indentación para definir bloques de código. La indentación incorrecta producirá errores.

```python
if es_estudiante:
    print("Es un estudiante.")
else:
    print("No es un estudiante.")
```

---

### 3. Tipos de Datos

Python soporta varios tipos de datos fundamentales.

#### Números

```python
entero = 10
flotante = 10.5
complejo = 1 + 2j

print(entero, flotante, complejo)
```

#### Cadenas

```python
cadena = "Hola, Mundo"
cadena_multilinea = """Esto es una cadena
de múltiples líneas"""

print(cadena)
print(cadena_multilinea)
```

#### Listas

```python
lista = [1, 2, 3, 4, 5]
lista.append(6)
print(lista)
```

#### Tuplas

```python
tupla = (1, 2, 3, 4, 5)
print(tupla)
```

#### Diccionarios

```python
diccionario = {"nombre": "Juan", "edad": 25}
diccionario["ocupacion"] = "Estudiante"
print(diccionario)
```

#### Conjuntos

```python
conjunto = {1, 2, 3, 4, 5}
conjunto.add(6)
print(conjunto)
```

---

### 4. Estructuras de Datos

Python proporciona varias estructuras de datos útiles.

#### Listas

Las listas son colecciones ordenadas y mutables.

```python
lista = [1, 2, 3, 4, 5]
print(lista[0])  # Acceder al primer elemento
print(lista[-1])  # Acceder al último elemento

# Cortes de listas
print(lista[1:3])  # Sublista desde el índice 1 hasta el 2
print(lista[:3])  # Sublista desde el inicio hasta el índice 2
print(lista[2:])  # Sublista desde el índice 2 hasta el final

# Modificar elementos
lista[0] = 10
print(lista)

# Añadir elementos
lista.append(6)
print(lista)
```

#### Diccionarios

Los diccionarios son colecciones no ordenadas de pares clave-valor.

```python
diccionario = {"nombre": "Juan", "edad": 25}
print(diccionario["nombre"])

# Añadir elementos
diccionario["ocupacion"] = "Estudiante"
print(diccionario)

# Modificar elementos
diccionario["edad"] = 26
print(diccionario)
```

#### Conjuntos

Los conjuntos son colecciones no ordenadas de elementos únicos.

```python
conjunto = {1, 2, 3, 4, 5}
print(conjunto)

# Añadir elementos
conjunto.add(6)
print(conjunto)

# Operaciones de conjuntos
otro_conjunto = {4, 5, 6, 7, 8}
print(conjunto.union(otro_conjunto))
print(conjunto.intersection(otro_conjunto))
print(conjunto.difference(otro_conjunto))
```

---

### 5. Control de Flujo

Python proporciona varias estructuras de control de flujo.

#### Condicionales

```python
edad = 18
if edad < 18:
    print("Menor de edad")
elif edad == 18:
    print("Justo en la mayoría de edad")
else:
    print("Mayor de edad")
```

#### Bucles

##### Bucle `for`

```python
for i in range(5):
    print(i)

# Iterar sobre una lista
frutas = ["manzana", "banana", "cereza"]
for fruta in frutas:
    print(fruta)
```

##### Bucle `while`

```python
i = 0
while i < 5:
    print(i)
    i += 1
```

#### Comprensiones de listas

```python
cuadrados = [x**2 for x in range(10)]
print(cuadrados)
```

---

### 6. Funciones y Módulos

#### Definición de Funciones

```python
def saludar(nombre):
    return f"Hola, {nombre}"

print(saludar("Juan"))
```

#### Parámetros Predeterminados

```python
def saludar(nombre="Mundo"):
    return f"Hola, {nombre}"

print(saludar())
print(saludar("Juan"))
```

#### Argumentos y Parámetros

```python
def sumar(a, b):
    return a + b

print(sumar(5, 10))
```

#### Funciones Anónimas (Lambdas)

```python
doble = lambda x: x * 2
print(doble(5))
```

#### Importar Módulos

```python
import math

print(math.sqrt(16))
```

```python
from math import sqrt

print(sqrt(16))
```

---

### 7. Manejo de Excepciones

Python usa excepciones para manejar errores durante la ejecución.

#### Bloque `try-except`

```python
try:
    x = 1 / 0
except ZeroDivisionError:
    print("No se puede dividir por cero")
```

#### Bloque `try-except-else-finally`

```python
try:
    x = 1 / 1
except ZeroDivisionError:
    print("No se puede dividir por cero")
else:
    print("División exitosa")
finally:
    print("Esto siempre se ejecuta")
```

---

### 8. Programación Orientada a Objetos

Python soporta la programación orientada a objetos.

#### Clases y Objetos

```python
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def saludar(self):
        return f"Hola, me llamo {self.nombre} y tengo {self.edad} años."

juan = Persona("Juan", 25)
print(juan.saludar())
```

#### Herencia

```python
class Estudiante(Persona):
    def __init__(self, nombre, edad, carrera):
        super().__init__(nombre