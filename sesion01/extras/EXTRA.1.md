ejercicio complementario para aquellos alumnos que terminen rápidamente y quieran un desafío adicional.

### Ejercicio Complementario: Calculadora Simple

En este ejercicio, los alumnos crearán una calculadora simple que puede realizar operaciones básicas: suma, resta, multiplicación y división. Además, el programa deberá manejar entradas no válidas y evitar errores de división por cero.

#### Objetivos:
1. Practicar el uso de variables, tipos de datos y operadores.
2. Aprender a manejar entradas del usuario y errores comunes.
3. Mejorar la comprensión de los conceptos básicos de Python.

### Paso 1: Crear el Archivo de Script

1. **Abrir el editor de texto o IDE:**
   - Utiliza tu editor de texto o IDE favorito (como VSCode, PyCharm, Sublime Text, etc.).

2. **Crear un nuevo archivo:**
   - Crea un nuevo archivo y guárdalo con el nombre `calculadora.py`.

### Paso 2: Escribir el Código del Script

1. **Solicitar entrada del usuario:**
   - Solicita al usuario que introduzca dos números y la operación que desea realizar.

2. **Realizar la operación seleccionada:**
   - Usa una estructura condicional para realizar la operación seleccionada.

3. **Manejar errores comunes:**
   - Utiliza bloques `try-except` para manejar entradas no válidas y errores de división por cero.

#### Código del Script

```python
def calculadora():
    print("Bienvenido a la Calculadora Simple")
    
    try:
        # Solicitar números al usuario
        num1 = float(input("Introduce el primer número: "))
        num2 = float(input("Introduce el segundo número: "))
        
        # Solicitar la operación al usuario
        print("Operaciones disponibles: suma, resta, multiplicación, división")
        operacion = input("Introduce la operación que deseas realizar: ").lower()
        
        # Realizar la operación seleccionada
        if operacion == "suma":
            resultado = num1 + num2
            print(f"El resultado de la suma es: {resultado}")
        elif operacion == "resta":
            resultado = num1 - num2
            print(f"El resultado de la resta es: {resultado}")
        elif operacion == "multiplicación":
            resultado = num1 * num2
            print(f"El resultado de la multiplicación es: {resultado}")
        elif operacion == "división":
            try:
                resultado = num1 / num2
                print(f"El resultado de la división es: {resultado}")
            except ZeroDivisionError:
                print("Error: No se puede dividir por cero.")
        else:
            print("Operación no válida. Por favor, elige suma, resta, multiplicación o división.")
    
    except ValueError:
        print("Error: Entrada no válida. Por favor, introduce números válidos.")

# Ejecutar la función de la calculadora
calculadora()
```

### Paso 3: Ejecutar el Script

1. **Abrir la terminal:**
   - Abre la terminal de tu sistema operativo.

2. **Navegar al directorio del script:**
   - Utiliza el comando `cd` para cambiar al directorio donde guardaste `calculadora.py`.

   ```shell
   cd /ruta/al/directorio/del/script
   ```

3. **Ejecutar el script:**
   - Ejecuta el script utilizando el comando `python` seguido del nombre del archivo del script.

   ```shell
   python calculadora.py
   ```

4. **Interactuar con el script:**
   - El script solicitará la entrada del usuario. Introduce los números y la operación cuando se te solicite.
   - Observa los resultados impresos en la terminal y asegúrate de probar diferentes operaciones y entradas no válidas.

### Recursos Adicionales

- [Documentación oficial de Python: manejo de excepciones](https://docs.python.org/3/tutorial/errors.html)
- [Manejo de excepciones en Python](https://realpython.com/python-exceptions/)

### Conclusión

Este ejercicio complementario desafía a los alumnos a aplicar los conceptos básicos de Python en un programa más complejo y útil. Los alumnos aprenderán a manejar entradas del usuario, realizar operaciones aritméticas y gestionar errores comunes. Este ejercicio les proporciona una experiencia práctica valiosa y les ayuda a consolidar su comprensión de los conceptos fundamentales de Python.