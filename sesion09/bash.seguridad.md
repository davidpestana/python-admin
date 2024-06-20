# Buenas Prácticas de Seguridad en Bash

## Introducción

Los scripts en Bash son una herramienta poderosa para la automatización de tareas en sistemas Unix/Linux. Sin embargo, si no se manejan con cuidado, pueden introducir vulnerabilidades de seguridad significativas. Esta guía explora buenas prácticas de seguridad en scripting Bash, centrándose en la validación de entrada, el manejo seguro de contraseñas y otros datos sensibles.

## Validación de Entrada

La validación de entrada es fundamental para prevenir ataques de inyección y otros problemas de seguridad. Siempre debemos suponer que la entrada del usuario es potencialmente peligrosa.

### Ejemplo de Validación de Entrada

#### Script Inseguro

```bash
#!/bin/bash

echo "Introduce el nombre del archivo:"
read FILENAME
cat $FILENAME
```

*Problema:* Este script es vulnerable a ataques de inyección si el usuario introduce caracteres especiales o comandos maliciosos.

#### Script Seguro

```bash
#!/bin/bash

echo "Introduce el nombre del archivo:"
read FILENAME

# Validar que el nombre del archivo solo contiene caracteres válidos (letras, números, guiones y guiones bajos)
if [[ $FILENAME =~ ^[a-zA-Z0-9_-]+$ ]]; then
    cat "$FILENAME"
else
    echo "Nombre de archivo no válido."
    exit 1
fi
```

*Solución:* Validamos la entrada del usuario utilizando una expresión regular para asegurarnos de que solo contiene caracteres válidos.

## Manejo Seguro de Contraseñas

Nunca debemos almacenar contraseñas en texto plano dentro de scripts. En su lugar, utilizaremos técnicas de almacenamiento seguro y evitaremos exponer contraseñas en la línea de comandos.

### Ejemplo de Manejo de Contraseñas

#### Script Inseguro

```bash
#!/bin/bash

# Contraseña en texto plano
PASSWORD="mi_contraseña_segura"

# Usar la contraseña
echo "Usando la contraseña: $PASSWORD"
```

*Problema:* La contraseña está expuesta en el script y puede ser leída por cualquier persona con acceso al archivo.

#### Script Seguro

```bash
#!/bin/bash

# Solicitar la contraseña al usuario de forma segura
echo "Introduce la contraseña:"
read -s PASSWORD

# Usar la contraseña (ejemplo: conexión a base de datos)
echo "Usando la contraseña de forma segura."
```

*Solución:* Solicitamos la contraseña al usuario en tiempo de ejecución utilizando `read -s` para que no se muestre en pantalla.

### Uso de Variables de Entorno

Otra técnica es utilizar variables de entorno para manejar contraseñas y otros datos sensibles.

#### Ejemplo de Variables de Entorno

```bash
#!/bin/bash

# Verificar que la variable de entorno PASSWORD esté configurada
if [ -z "$PASSWORD" ]; then
    echo "La variable de entorno PASSWORD no está configurada."
    exit 1
fi

# Usar la contraseña de la variable de entorno
echo "Usando la contraseña desde la variable de entorno."
```

*Solución:* Configuramos la contraseña en una variable de entorno antes de ejecutar el script:

```bash
export PASSWORD="mi_contraseña_segura"
./mi_script.sh
```

## Evitar Comandos Shell Inseguros

El uso de `eval` y otras construcciones peligrosas puede introducir vulnerabilidades si se utilizan con datos no validados.

### Ejemplo de Uso Inseguro de `eval`

#### Script Inseguro

```bash
#!/bin/bash

echo "Introduce un comando para ejecutar:"
read COMANDO
eval $COMANDO
```

*Problema:* El uso de `eval` puede ejecutar cualquier comando, incluidos comandos maliciosos.

#### Script Seguro

```bash
#!/bin/bash

echo "Introduce un comando permitido (ls, pwd):"
read COMANDO

case $COMANDO in
    ls|pwd)
        $COMANDO
        ;;
    *)
        echo "Comando no permitido."
        exit 1
        ;;
esac
```

*Solución:* Limitamos los comandos que se pueden ejecutar mediante un caso condicional.

## Registro y Auditoría

Registrar las acciones de los scripts y mantener un historial de auditoría es crucial para la seguridad y el análisis de incidentes.

### Ejemplo de Registro

#### Código del Script con Registro

```bash
#!/bin/bash

LOGFILE="/var/log/mi_script.log"

# Función para registrar mensajes
registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Ejemplo de uso del registro
registrar "Script iniciado."

# Simular una acción del script
echo "Haciendo algo importante..."
registrar "Acción importante completada."

registrar "Script finalizado."
```

*Solución:* Utilizamos una función para registrar mensajes en un archivo de log con marcas de tiempo.

## Casos Prácticos

### Caso Práctico 1: Script Seguro para Copia de Seguridad

#### Código del Script

```bash
#!/bin/bash

LOGFILE="/var/log/backup.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

DIRECTORIO_ORIGEN="/home/usuario/datos"
DIRECTORIO_DESTINO="/home/usuario/backup"

# Validar que los directorios existen
if [ ! -d "$DIRECTORIO_ORIGEN" ]; then
    registrar "El directorio de origen no existe: $DIRECTORIO_ORIGEN"
    exit 1
fi

if [ ! -d "$DIRECTORIO_DESTINO" ]; then
    registrar "El directorio de destino no existe: $DIRECTORIO_DESTINO"
    exit 1
fi

# Realizar la copia de seguridad
cp -r "$DIRECTORIO_ORIGEN" "$DIRECTORIO_DESTINO"
registrar "Copia de seguridad completada de $DIRECTORIO_ORIGEN a $DIRECTORIO_DESTINO"
```

*Solución:* Este script realiza una copia de seguridad de un directorio a otro, validando que los directorios existen y registrando las acciones.

### Caso Práctico 2: Script Seguro para Borrado de Archivos

#### Código del Script

```bash
#!/bin/bash

LOGFILE="/var/log/borrado.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

echo "Introduce el nombre del archivo a borrar:"
read FILENAME

# Validar el nombre del archivo
if [[ $FILENAME =~ ^[a-zA-Z0-9._-]+$ ]]; then
    if [ -f "$FILENAME" ]; then
        rm "$FILENAME"
        registrar "Archivo borrado: $FILENAME"
        echo "Archivo borrado: $FILENAME"
    else
        registrar "El archivo no existe: $FILENAME"
        echo "El archivo no existe: $FILENAME"
    fi
else
    registrar "Nombre de archivo no válido: $FILENAME"
    echo "Nombre de archivo no válido."
    exit 1
fi
```

*Solución:* Este script permite borrar un archivo de manera segura, validando el nombre del archivo y registrando las acciones.

## Conclusión

Implementar prácticas de seguridad en scripting Bash es crucial para proteger los sistemas y los datos sensibles. La validación de entrada, el manejo seguro de contraseñas, la evitación de comandos inseguros y el registro de acciones son pasos esenciales para crear scripts seguros y fiables.
