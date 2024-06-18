### **Ejercicio Complementario: Análisis de Logs Complejo**

En este ejercicio, vamos a crear un script avanzado de Bash para el análisis de archivos de logs. Este tipo de tarea es común en la administración de sistemas y es esencial para la monitorización y solución de problemas en un entorno de producción.

#### **Objetivos:**
- Leer y analizar archivos de logs grandes.
- Extraer información relevante y generar reportes.
- Aplicar técnicas avanzadas de manipulación de cadenas y arrays.
- Utilizar funciones y técnicas de depuración para asegurar la fiabilidad del script.

### **Ejercicio: Script para Análisis de Logs**

Vamos a desarrollar un script que realice las siguientes tareas:
1. Leer un archivo de logs y extraer líneas que contengan errores.
2. Contar el número de errores por tipo.
3. Identificar los usuarios que generaron los errores.
4. Generar un reporte con la información extraída.

### **Paso 1: Crear la Estructura del Script**

Primero, creamos la estructura básica del script y las funciones necesarias para cada tarea.

**Script Inicial `analisis_logs.sh`:**

```bash
#!/bin/bash

set -e  # Salir inmediatamente si un comando falla

# Función para manejo de errores
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

# Función para leer el archivo de logs y extraer líneas con errores
extraer_errores() {
    local archivo=$1
    grep -i "error" "$archivo"
}

# Función para contar el número de errores por tipo
contar_errores_por_tipo() {
    local errores=$1
    declare -A tipos_errores

    while IFS= read -r linea; do
        tipo=$(echo "$linea" | grep -oP '(?<=error: ).*?(?=:)' | tr '[:upper:]' '[:lower:]')
        ((tipos_errores["$tipo"]++))
    done <<< "$errores"

    for tipo in "${!tipos_errores[@]}"; do
        echo "$tipo: ${tipos_errores[$tipo]}"
    done
}

# Función para identificar los usuarios que generaron los errores
identificar_usuarios() {
    local errores=$1
    declare -A usuarios_errores

    while IFS= read -r linea; do
        usuario=$(echo "$linea" | grep -oP '(?<=user: ).*?(?= )')
        ((usuarios_errores["$usuario"]++))
    done <<< "$errores"

    for usuario in "${!usuarios_errores[@]}"; do
        echo "$usuario: ${usuarios_errores[$usuario]}"
    done
}

# Script principal
archivo_logs="/var/log/syslog"
errores=$(extraer_errores "$archivo_logs")
debug "Errores extraídos"

echo "Contando errores por tipo..."
contar_errores_por_tipo "$errores"

echo "Identificando usuarios que generaron errores..."
identificar_usuarios "$errores"

echo "Análisis de logs completado."
```

### **Paso 2: Probar y Depurar el Script**

Guarda el script y hazlo ejecutable:

```bash
chmod +x analisis_logs.sh
```

Ejecuta el script:

```bash
./analisis_logs.sh
```

### **Paso 3: Mejorar la Función de Conteo de Errores por Tipo**

Vamos a mejorar la función `contar_errores_por_tipo` para que sea más precisa.

**Función Mejorada `contar_errores_por_tipo`:**

```bash
# Función para contar el número de errores por tipo
contar_errores_por_tipo() {
    local errores=$1
    declare -A tipos_errores

    while IFS= read -r linea; do
        tipo=$(echo "$linea" | grep -oP '(?<=error: )[A-Za-z]+' | tr '[:upper:]' '[:lower:]')
        ((tipos_errores["$tipo"]++))
    done <<< "$errores"

    for tipo in "${!tipos_errores[@]}"; do
        echo "$tipo: ${tipos_errores[$tipo]}"
    done
}
```

### **Paso 4: Mejorar la Identificación de Usuarios**

Mejoramos la función `identificar_usuarios` para manejar casos donde la cadena de usuario no esté presente.

**Función Mejorada `identificar_usuarios`:**

```bash
# Función para identificar los usuarios que generaron los errores
identificar_usuarios() {
    local errores=$1
    declare -A usuarios_errores

    while IFS= read -r linea; do
        usuario=$(echo "$linea" | grep -oP '(?<=user: )[A-Za-z0-9]+' || echo "desconocido")
        ((usuarios_errores["$usuario"]++))
    done <<< "$errores"

    for usuario in "${!usuarios_errores[@]}"; do
        echo "$usuario: ${usuarios_errores[$usuario]}"
    done
}
```

### **Paso 5: Generar un Reporte Completo**

Finalmente, vamos a generar un reporte completo con toda la información extraída.

**Generar Reporte `generar_reporte`:**

```bash
# Función para generar el reporte
generar_reporte() {
    local archivo=$1
    local errores=$2

    echo "Generando reporte..."
    {
        echo "Reporte de Análisis de Logs"
        echo "---------------------------"
        echo ""
        echo "Errores por Tipo:"
        contar_errores_por_tipo "$errores"
        echo ""
        echo "Usuarios que Generaron Errores:"
        identificar_usuarios "$errores"
    } > "$archivo"
    echo "Reporte generado en $archivo"
}

# Script principal
archivo_logs="/var/log/syslog"
errores=$(extraer_errores "$archivo_logs")
debug "Errores extraídos"

reporte="reporte_analisis_logs.txt"
generar_reporte "$reporte" "$errores"

echo "Análisis de logs completado."
```

Guarda y ejecuta el script para generar el reporte completo:

```bash
./analisis_logs.sh
```

### **Conclusión**

Hemos creado un script avanzado de Bash para el análisis de archivos de logs. Utilizamos técnicas avanzadas de manipulación de cadenas y arrays para extraer y procesar información relevante. También aplicamos técnicas de depuración para asegurar la fiabilidad del script. Este tipo de herramientas es esencial para la administración de sistemas, permitiendo monitorizar y solucionar problemas de manera eficiente.
