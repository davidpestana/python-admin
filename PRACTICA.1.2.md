### Práctica 1.2: Primeros Pasos en Python

#### Objetivos:
1. Escribir y ejecutar un script simple en Python.
2. Aprender la sintaxis básica de Python: variables, tipos de datos y operadores.

### Paso 1: Escribir un Script Simple

#### Crear un Archivo de Script

1. **Abrir un editor de texto o IDE:**
   - Puedes utilizar cualquier editor de texto o IDE, como Visual Studio Code, PyCharm, Sublime Text, o el Bloc de Notas.
   - Abre tu editor de preferencia.

2. **Crear un nuevo archivo:**
   - Crea un nuevo archivo y guárdalo con el nombre `script_simple.py`.

#### Escribir el Código del Script

1. **Declarar Variables:**
   - Las variables son nombres que se utilizan para referirse a valores almacenados en la memoria. En Python, no necesitas declarar el tipo de la variable explícitamente; el tipo se infiere del valor asignado.

   ```python
   nombre = "Juan"
   edad = 30
   altura = 1.75
   es_estudiante = True
   ```

2. **Utilizar Tipos de Datos:**
   - Los tipos de datos comunes en Python incluyen cadenas (`str`), enteros (`int`), flotantes (`float`) y booleanos (`bool`).

   ```python
   print(f"Nombre: {nombre}")
   print(f"Edad: {edad}")
   print(f"Altura: {altura} metros")
   print(f"Es estudiante: {es_estudiante}")
   ```

3. **Operadores Básicos:**
   - Los operadores te permiten realizar operaciones sobre variables y valores. Los operadores aritméticos incluyen suma (`+`), resta (`-`), multiplicación (`*`), y división (`/`). Los operadores de comparación incluyen igualdad (`==`), desigualdad (`!=`), mayor que (`>`), y menor que (`<`).

   ```python
   suma = edad + 5
   resta = altura - 0.1
   multiplicacion = edad * 2
   division = edad / 2

   print(f"Suma: {suma}")
   print(f"Resta: {resta}")
   print(f"Multiplicación: {multiplicacion}")
   print(f"División: {division}")

   es_mayor_de_edad = edad > 18
   print(f"Es mayor de edad: {es_mayor_de_edad}")
   ```

4. **Entrada del Usuario:**
   - Puedes solicitar la entrada del usuario utilizando la función `input()`. Los valores introducidos se consideran cadenas, por lo que puede ser necesario convertirlos a otro tipo de datos utilizando funciones como `int()` o `float()`.

   ```python
   nombre_usuario = input("Introduce tu nombre: ")
   edad_usuario = int(input("Introduce tu edad: "))

   print(f"Hola, {nombre_usuario}. Tienes {edad_usuario} años.")
   ```

#### Código Completo del Script

```python
# Declarar variables
nombre = "Juan"
edad = 30
altura = 1.75
es_estudiante = True

# Imprimir valores de las variables
print(f"Nombre: {nombre}")
print(f"Edad: {edad}")
print(f"Altura: {altura} metros")
print(f"Es estudiante: {es_estudiante}")

# Operadores básicos
suma = edad + 5
resta = altura - 0.1
multiplicacion = edad * 2
division = edad / 2

print(f"Suma: {suma}")
print(f"Resta: {resta}")
print(f"Multiplicación: {multiplicacion}")
print(f"División: {division}")

# Operadores de comparación
es_mayor_de_edad = edad > 18
print(f"Es mayor de edad: {es_mayor_de_edad}")

# Entrada del usuario
nombre_usuario = input("Introduce tu nombre: ")
edad_usuario = int(input("Introduce tu edad: "))

print(f"Hola, {nombre_usuario}. Tienes {edad_usuario} años.")
```

### Paso 2: Ejecutar el Script

#### Ejecutar el Script en la Terminal

1. **Abrir la terminal:**
   - Abre la terminal de tu sistema operativo (Command Prompt, PowerShell, Terminal, etc.).

2. **Navegar al directorio del script:**
   - Utiliza el comando `cd` para cambiar al directorio donde guardaste `script_simple.py`.

   ```shell
   cd /ruta/al/directorio/del/script
   ```

3. **Ejecutar el script:**
   - Ejecuta el script utilizando el comando `python` seguido del nombre del archivo del script.

   ```shell
   python script_simple.py
   ```

4. **Interactuar con el script:**
   - El script solicitará la entrada del usuario. Introduce tu nombre y edad cuando se te solicite.
   - Observa los resultados impresos en la terminal.

### Recursos Adicionales

- [Documentación oficial de Python](https://docs.python.org/3/)
- [Tutorial de Python para principiantes](https://docs.python.org/3/tutorial/index.html)
- [Guía de estilo de Python (PEP 8)](https://www.python.org/dev/peps/pep-0008/)

### Conclusión

Con estos pasos, has aprendido a escribir y ejecutar un script simple en Python, utilizando variables, tipos de datos y operadores. Este ejercicio te proporciona una base sólida para comprender la sintaxis básica de Python y te prepara para escribir scripts más complejos en el futuro. Continúa practicando y explorando Python para mejorar tus habilidades de programación.