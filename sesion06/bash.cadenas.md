### **Manipulación Avanzada de Cadenas en Bash**

La manipulación de cadenas en Bash es una habilidad esencial para el scripting y la automatización. A continuación, se detallan varias técnicas avanzadas para trabajar con cadenas en Bash, desde operaciones básicas hasta métodos más complejos.

#### **1. Operaciones Básicas con Cadenas**

##### **Concatenación de Cadenas**
La concatenación de cadenas en Bash se realiza simplemente colocando las cadenas una al lado de la otra.

```bash
cadena1="Hola"
cadena2="Mundo"
resultado="$cadena1 $cadena2"
echo $resultado  # Salida: Hola Mundo
```

##### **Obtener la Longitud de una Cadena**

```bash
cadena="Hola Mundo"
longitud=${#cadena}
echo $longitud  # Salida: 10
```

#### **2. Subcadenas**

##### **Extraer una Subcadena**
Para extraer una subcadena, se usa la sintaxis `${cadena:posicion:longitud}`.

```bash
cadena="Hola Mundo"
subcadena=${cadena:0:4}
echo $subcadena  # Salida: Hola
```

##### **Extraer desde una Posición hasta el Final**

```bash
cadena="Hola Mundo"
subcadena=${cadena:5}
echo $subcadena  # Salida: Mundo
```

#### **3. Reemplazo de Subcadenas**

##### **Reemplazo Simple**

```bash
cadena="Hola Mundo"
nueva_cadena=${cadena/Mundo/Amigo}
echo $nueva_cadena  # Salida: Hola Amigo
```

##### **Reemplazo Global**

```bash
cadena="Hola Mundo Mundo"
nueva_cadena=${cadena//Mundo/Amigo}
echo $nueva_cadena  # Salida: Hola Amigo Amigo
```

#### **4. Búsqueda en Cadenas**

##### **Encontrar una Subcadena**

```bash
cadena="Hola Mundo"
if [[ $cadena == *"Mundo"* ]]; then
  echo "Contiene 'Mundo'"
else
  echo "No contiene 'Mundo'"
fi
```

#### **5. Conversión de Cadenas**

##### **Convertir a Minúsculas**

```bash
cadena="HOLA MUNDO"
cadena_minusculas=${cadena,,}
echo $cadena_minusculas  # Salida: hola mundo
```

##### **Convertir a Mayúsculas**

```bash
cadena="hola mundo"
cadena_mayusculas=${cadena^^}
echo $cadena_mayusculas  # Salida: HOLA MUNDO
```

#### **6. Eliminación de Espacios en Blanco**

##### **Eliminar Espacios al Principio y al Final**

```bash
cadena="  Hola Mundo  "
cadena_sin_espacios=$(echo $cadena | xargs)
echo ">$cadena_sin_espacios<"  # Salida: >Hola Mundo<
```

#### **7. División de Cadenas**

##### **Dividir una Cadena en un Array**

```bash
cadena="uno,dos,tres"
IFS=',' read -r -a array <<< "$cadena"
for elemento in "${array[@]}"; do
  echo $elemento
done
# Salida:
# uno
# dos
# tres
```

#### **8. Uso de Expresiones Regulares**

##### **Extraer Patrones con `grep`**

```bash
cadena="Mi número de teléfono es 123-456-7890"
telefono=$(echo $cadena | grep -oE '[0-9]{3}-[0-9]{3}-[0-9]{4}')
echo $telefono  # Salida: 123-456-7890
```

#### **9. Ejemplo Completo**

```bash
#!/bin/bash

# Concatenación de cadenas
nombre="Juan"
apellido="Pérez"
nombre_completo="$nombre $apellido"
echo "Nombre completo: $nombre_completo"

# Longitud de la cadena
cadena="Bash Scripting"
echo "Longitud: ${#cadena}"

# Subcadenas
echo "Subcadena (0-4): ${cadena:0:4}"
echo "Subcadena (5-): ${cadena:5}"

# Reemplazo de subcadenas
cadena_reemplazada=${cadena/Scripting/Programming}
echo "Reemplazo: $cadena_reemplazada"

# Búsqueda en cadenas
if [[ $cadena == *"Bash"* ]]; then
  echo "Contiene 'Bash'"
fi

# Conversión de cadenas
echo "Minúsculas: ${cadena,,}"
echo "Mayúsculas: ${cadena^^}"

# Eliminación de espacios en blanco
cadena_con_espacios="  Espacios en Blanco  "
cadena_limpia=$(echo $cadena_con_espacios | xargs)
echo "Sin espacios: >$cadena_limpia<"

# División de cadenas
datos="nombre,apellido,edad"
IFS=',' read -r -a array <<< "$datos"
for elemento in "${array[@]}"; do
  echo $elemento
done

# Uso de expresiones regulares
texto="El código postal es 12345"
codigo_postal=$(echo $texto | grep -oE '[0-9]{5}')
echo "Código postal: $codigo_postal"
```

Este script muestra cómo realizar una amplia gama de manipulaciones de cadenas en Bash, desde operaciones básicas hasta técnicas más avanzadas como el uso de expresiones regulares y la eliminación de espacios en blanco. Estas técnicas son fundamentales para la creación de scripts Bash eficientes y robustos.