### **Práctica 2: Manipulación Avanzada de Arrays y Cadenas en Bash para Administradores de Sistemas**

Vamos a crear un script en Bash paso a paso que realiza varias tareas comunes de administración de sistemas utilizando arrays y manipulación avanzada de cadenas.

#### **Paso 1: Contar Ocurrencias de Errores en un Archivo de Logs**

Primero, escribiremos una función que cuente el número de ocurrencias de una cadena específica en un archivo de logs.

**Función `contar_ocurrencias`**

```bash
#!/bin/bash

# Función para contar ocurrencias de una cadena en un archivo
contar_ocurrencias() {
    local archivo=$1
    local cadena=$2
    grep -o "$cadena" "$archivo" | wc -l
}

# Prueba de la función
archivo_logs="/var/log/syslog"
cadena="error"
ocurrencias=$(contar_ocurrencias "$archivo_logs" "$cadena")
echo "La cadena '$cadena' aparece $ocurrencias veces en $archivo_logs."
```

Guarda este código en un archivo llamado `analizar_logs.sh` y hazlo ejecutable:

```bash
chmod +x analizar_logs.sh
```

Ejecuta el script:

```bash
./analizar_logs.sh
```

#### **Paso 2: Listar Usuarios del Sistema y Mostrar Información**

Ahora, agregaremos funciones para listar los usuarios del sistema y obtener información sobre cada usuario.

**Función `listar_usuarios`**

```bash
#!/bin/bash

# Función para contar ocurrencias de una cadena en un archivo
contar_ocurrencias() {
    local archivo=$1
    local cadena=$2
    grep -o "$cadena" "$archivo" | wc -l
}

# Función para listar usuarios del sistema
listar_usuarios() {
    awk -F: '{ print $1 }' /etc/passwd
}

# Prueba de la función
usuarios=($(listar_usuarios))
echo "Usuarios del sistema: ${usuarios[@]}"
```

Guarda el script y ejecútalo para ver la lista de usuarios:

```bash
./analizar_logs.sh
```

#### **Paso 3: Obtener Información del Usuario**

Añadimos una función para obtener información detallada de un usuario.

**Función `info_usuario`**

```bash
#!/bin/bash

# Función para contar ocurrencias de una cadena en un archivo
contar_ocurrencias() {
    local archivo=$1
    local cadena=$2
    grep -o "$cadena" "$archivo" | wc -l
}

# Función para listar usuarios del sistema
listar_usuarios() {
    awk -F: '{ print $1 }' /etc/passwd
}

# Función para obtener información del usuario
info_usuario() {
    local usuario=$1
    id $usuario
    lastlog -u $usuario
}

# Prueba de las funciones
usuarios=($(listar_usuarios))
echo "Usuarios del sistema: ${usuarios[@]}"

for usuario in "${usuarios[@]}"; do
    echo "Información del usuario: $usuario"
    info_usuario "$usuario"
    echo "-----------------------"
done
```

Guarda y ejecuta el script para ver la información de los usuarios:

```bash
./analizar_logs.sh
```

#### **Paso 4: Verificar el Estado de Servicios Críticos**

Añadimos una función para verificar si un servicio está activo.

**Función `verificar_servicio`**

```bash
#!/bin/bash

# Función para contar ocurrencias de una cadena en un archivo
contar_ocurrencias() {
    local archivo=$1
    local cadena=$2
    grep -o "$cadena" "$archivo" | wc -l
}

# Función para listar usuarios del sistema
listar_usuarios() {
    awk -F: '{ print $1 }' /etc/passwd
}

# Función para obtener información del usuario
info_usuario() {
    local usuario=$1
    id $usuario
    lastlog -u $usuario
}

# Función para verificar el estado de un servicio
verificar_servicio() {
    local servicio=$1
    if systemctl is-active --quiet $servicio; then
        echo "El servicio $servicio está activo."
    else
        echo "El servicio $servicio está inactivo o no está instalado."
    fi
}

# Prueba de las funciones
usuarios=($(listar_usuarios))
echo "Usuarios del sistema: ${usuarios[@]}"

for usuario in "${usuarios[@]}"; do
    echo "Información del usuario: $usuario"
    info_usuario "$usuario"
    echo "-----------------------"
done

servicios=("sshd" "cron" "apache2")
for servicio in "${servicios[@]}"; do
    verificar_servicio "$servicio"
done
```

Guarda y ejecuta el script para verificar el estado de los servicios:

```bash
./analizar_logs.sh
```

#### **Paso 5: Generar un Informe del Sistema**

Finalmente, añadimos código para generar un informe con todos los resultados anteriores.

```bash
#!/bin/bash

# Función para contar ocurrencias de una cadena en un archivo
contar_ocurrencias() {
    local archivo=$1
    local cadena=$2
    grep -o "$cadena" "$archivo" | wc -l
}

# Función para listar usuarios del sistema
listar_usuarios() {
    awk -F: '{ print $1 }' /etc/passwd
}

# Función para obtener información del usuario
info_usuario() {
    local usuario=$1
    id $usuario
    lastlog -u $usuario
}

# Función para verificar el estado de un servicio
verificar_servicio() {
    local servicio=$1
    if systemctl is-active --quiet $servicio; then
        echo "El servicio $servicio está activo."
    else
        echo "El servicio $servicio está inactivo o no está instalado."
    fi
}

# Script principal

# 1. Analizar archivo de logs y contar errores
echo "Analizando el archivo de logs..."
archivo_logs="/var/log/syslog"
errores=("error" "failed" "panic")
for error in "${errores[@]}"; do
    ocurrencias=$(contar_ocurrencias "$archivo_logs" "$error")
    echo "La cadena '$error' aparece $ocurrencias veces en $archivo_logs."
done

# 2. Listar usuarios del sistema y mostrar información
echo "Listando usuarios del sistema..."
usuarios=($(listar_usuarios))
for usuario in "${usuarios[@]}"; do
    echo "Información del usuario: $usuario"
    info_usuario "$usuario"
    echo "-----------------------"
done

# 3. Verificar el estado de servicios críticos
echo "Verificando el estado de servicios críticos..."
servicios=("sshd" "cron" "apache2")
for servicio in "${servicios[@]}"; do
    verificar_servicio "$servicio"
done

# Generar informe
informe="informe_sistema.txt"
{
    echo "Informe del Sistema"
    echo "-------------------"
    echo "Análisis de logs:"
    for error in "${errores[@]}"; do
        ocurrencias=$(contar_ocurrencias "$archivo_logs" "$error")
        echo "La cadena '$error' aparece $ocurrencias veces en $archivo_logs."
    done

    echo ""
    echo "Usuarios del sistema:"
    for usuario in "${usuarios[@]}"; do
        echo "Información del usuario: $usuario"
        info_usuario "$usuario"
        echo "-----------------------"
    done

    echo ""
    echo "Estado de servicios críticos:"
    for servicio in "${servicios[@]}"; do
        verificar_servicio "$servicio"
    done
} > "$informe"

echo "El informe ha sido generado en $informe."
```

Guarda y ejecuta el script para generar el informe completo del sistema:

```bash
./analizar_logs.sh
```

### **Conclusión**

Hemos desarrollado un script en Bash paso a paso que realiza varias tareas de administración de sistemas utilizando arrays y manipulación avanzada de cadenas. Este script cuenta ocurrencias de errores en archivos de logs, lista usuarios del sistema, muestra información sobre cada usuario, verifica el estado de servicios críticos y genera un informe completo del sistema. Estas técnicas y funciones son esenciales para automatizar y simplificar tareas administrativas en un entorno de sistemas.