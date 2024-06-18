### **Diferencias entre `sh` y `bash`**

Tanto `sh` (Bourne Shell) como `bash` (Bourne Again Shell) son intérpretes de comandos utilizados en sistemas Unix y Linux. Sin embargo, existen diferencias significativas entre ambos, tanto en características como en uso. A continuación, se detallan estas diferencias.

#### **1. Historia y Orígenes**

- **`sh` (Bourne Shell):** Creado por Stephen Bourne en 1979, `sh` es el shell original en Unix. Fue diseñado como un intérprete de comandos básico con capacidades de scripting.
- **`bash` (Bourne Again Shell):** Desarrollado por Brian Fox para el Proyecto GNU en 1989, `bash` es una mejora de `sh` que incluye muchas características adicionales.

#### **2. Características Adicionales en `bash`**

##### **Funciones de Programación Avanzadas**

- **Arreglos:**
  - `bash` soporta arreglos unidimensionales, mientras que `sh` no.
  - Ejemplo en `bash`:
    ```bash
    # Declaración de un array
    array=("uno" "dos" "tres")
    echo ${array[0]}  # Salida: uno
    ```

- **Expansión de Llaves:**
  - `bash` permite la expansión de llaves para generar múltiples cadenas.
  - Ejemplo en `bash`:
    ```bash
    echo {A..Z}  # Salida: A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
    ```

- **Expansión Aritmética Mejorada:**
  - `bash` soporta una sintaxis aritmética mejorada con `((...))`.
  - Ejemplo en `bash`:
    ```bash
    ((a = 5 + 3))
    echo $a  # Salida: 8
    ```

##### **Funciones de Scripting Mejoradas**

- **Sentencias Condicionales Mejoradas:**
  - `bash` soporta `[[...]]` para pruebas condicionales más avanzadas.
  - Ejemplo en `bash`:
    ```bash
    if [[ -f "archivo.txt" ]]; then
        echo "El archivo existe"
    fi
    ```

- **Mejor Manejo de Variables:**
  - `bash` tiene características adicionales para el manejo de variables, como `${var,,}` para convertir a minúsculas.
  - Ejemplo en `bash`:
    ```bash
    var="TEXTO"
    echo ${var,,}  # Salida: texto
    ```

##### **Historia y Autocompletar**

- **Historial de Comandos:**
  - `bash` guarda un historial de comandos que se puede navegar con las teclas de flechas.
  - `sh` no tiene esta funcionalidad por defecto.

- **Autocompletado:**
  - `bash` ofrece autocompletado de comandos y nombres de archivos presionando `Tab`.
  - `sh` no soporta autocompletado.

#### **3. Compatibilidad**

- **Compatibilidad hacia Atrás:**
  - `bash` es compatible con los scripts escritos para `sh`, ya que hereda sus características básicas.
  - Sin embargo, scripts escritos para `bash` que utilicen sus características avanzadas no serán compatibles con `sh`.

- **Ejecutar Scripts en `sh` con `bash`:**
  - Puedes ejecutar scripts de `sh` en `bash` sin problemas, pero no al revés si el script utiliza características específicas de `bash`.

#### **4. Interactividad y Uso**

- **Interactividad:**
  - `bash` está diseñado para ser más interactivo y amigable para los usuarios con características como autocompletado, historial de comandos y comandos de edición de línea.
  - `sh` es más minimalista y carece de muchas de las características interactivas que se encuentran en `bash`.

#### **5. Ejemplo Comparativo**

A continuación, se presenta un ejemplo comparativo de un script que utiliza características específicas de `bash` que no serían compatibles con `sh`.

##### **Script en `bash`:**

```bash
#!/bin/bash

# Declaración de un array
nombres=("Juan" "Pedro" "Maria")

# Uso de expansión de llaves
for letra in {A..C}; do
    echo "Letra: $letra"
done

# Prueba condicional avanzada
archivo="ejemplo.txt"
if [[ -f $archivo && -r $archivo ]]; then
    echo "El archivo $archivo existe y es legible"
fi

# Manejo de variables avanzado
cadena="TEXTO EN MAYÚSCULAS"
echo ${cadena,,}  # Convertir a minúsculas
```

##### **Script en `sh` Equivalente (con limitaciones):**

```sh
#!/bin/sh

# Declaración de un array (no soportado)
# nombres=("Juan" "Pedro" "Maria")

# Uso de expansión de llaves (no soportado)
# for letra in {A..C}; do
#     echo "Letra: $letra"
# done

# Prueba condicional básica
archivo="ejemplo.txt"
if [ -f $archivo ] && [ -r $archivo ]; then
    echo "El archivo $archivo existe y es legible"
fi

# Manejo de variables básico (no hay conversión a minúsculas)
cadena="TEXTO EN MAYÚSCULAS"
# echo ${cadena,,}  # No soportado en sh
```

### **Conclusión**

Aunque `sh` y `bash` comparten muchas similitudes, `bash` ofrece muchas características adicionales que facilitan la escritura de scripts complejos y la interacción con el sistema. Si bien `sh` es adecuado para scripts simples y entornos donde la compatibilidad es crucial, `bash` es más potente y adecuado para la mayoría de las tareas de scripting en sistemas modernos.