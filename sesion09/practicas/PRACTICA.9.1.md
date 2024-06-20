# Práctica 9.1: Seguridad en Bash

## Objetivo

El objetivo de esta práctica es aprender a escribir scripts en Bash que validen la entrada del usuario y manejen datos sensibles de manera segura. Esto es crucial para prevenir vulnerabilidades y proteger la información en sistemas de producción.

## Ejercicio

### 1. Validación de Entrada del Usuario

#### Código del Script

Este script solicita un nombre de archivo y verifica que solo contenga caracteres válidos.

```bash
#!/bin/bash

echo "Introduce el nombre del archivo:"
read FILENAME

# Validar que el nombre del archivo solo contiene caracteres válidos (letras, números, guiones y guiones bajos)
if [[ $FILENAME =~ ^[a-zA-Z0-9._-]+$ ]]; then
    echo "Nombre de archivo válido: $FILENAME"
else
    echo "Nombre de archivo no válido."
    exit 1
fi
```

#### Guardar el Script

Guarda el script con el nombre `validar_entrada.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x validar_entrada.sh
```

#### Ejecutar el Script

```bash
./validar_entrada.sh
```

### 2. Manejo Seguro de Contraseñas

#### Código del Script

Este script solicita una contraseña al usuario de manera segura y la guarda en una variable de entorno.

```bash
#!/bin/bash

echo "Introduce la contraseña:"
read -s PASSWORD

# Comprobar que la contraseña no está vacía
if [ -z "$PASSWORD" ]; then
    echo "La contraseña no puede estar vacía."
    exit 1
fi

# Exportar la contraseña como una variable de entorno
export PASSWORD

echo "La contraseña ha sido almacenada de forma segura en una variable de entorno."
```

#### Guardar el Script

Guarda el script con el nombre `manejar_contraseña.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x manejar_contraseña.sh
```

#### Ejecutar el Script

```bash
./manejar_contraseña.sh
```

### 3. Evitar Comandos Shell Inseguros

#### Código del Script

Este script acepta un comando limitado y lo ejecuta de manera segura.

```bash
#!/bin/bash

echo "Introduce un comando permitido (ls, pwd):"
read COMANDO

# Validar y ejecutar el comando
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

#### Guardar el Script

Guarda el script con el nombre `comando_seguro.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x comando_seguro.sh
```

#### Ejecutar el Script

```bash
./comando_seguro.sh
```

## Casos Prácticos

### Caso Práctico 1: Script Seguro para Copia de Seguridad

#### Código del Script

Este script realiza una copia de seguridad de un directorio a otro, validando que los directorios existen y registrando las acciones.

```bash
#!/bin/bash

LOGFILE="/var/log/backup.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

echo "Introduce el directorio de origen:"
read ORIGEN

echo "Introduce el directorio de destino:"
read DESTINO

# Validar que los directorios existen
if [ ! -d "$ORIGEN" ]; then
    registrar "El directorio de origen no existe: $ORIGEN"
    echo "El directorio de origen no existe: $ORIGEN"
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    registrar "El directorio de destino no existe: $DESTINO"
    echo "El directorio de destino no existe: $DESTINO"
    exit 1
fi

# Realizar la copia de seguridad
cp -r "$ORIGEN" "$DESTINO"
registrar "Copia de seguridad completada de $ORIGEN a $DESTINO"
echo "Copia de seguridad completada de $ORIGEN a $DESTINO"
```

#### Guardar el Script

Guarda el script con el nombre `backup_seguro.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x backup_seguro.sh
```

#### Ejecutar el Script

```bash
./backup_seguro.sh
```

### Caso Práctico 2: Script Seguro para Borrado de Archivos

#### Código del Script

Este script permite borrar un archivo de manera segura, validando el nombre del archivo y registrando las acciones.

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

#### Guardar el Script

Guarda el script con el nombre `borrar_archivo_seguro.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x borrar_archivo_seguro.sh
```

#### Ejecutar el Script

```bash
./borrar_archivo_seguro.sh
```

## Conclusión

La validación de entrada del usuario y el manejo seguro de datos sensibles son aspectos críticos en la creación de scripts Bash seguros. Los ejemplos proporcionados en esta práctica te ayudarán a implementar estas técnicas en tus propios scripts, mejorando la seguridad y fiabilidad de tus sistemas.