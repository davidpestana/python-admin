# Ejercicio Complementario: Auditoría de Seguridad en Scripts

## Objetivo

El objetivo de este ejercicio complementario es realizar una auditoría de seguridad en scripts existentes para identificar y corregir vulnerabilidades comunes. Aprenderás a revisar scripts en Bash y Python, detectar posibles fallos de seguridad y aplicar buenas prácticas para mitigarlos.

## Pasos para la Auditoría de Seguridad

### 1. Revisión de Scripts Bash

#### Ejemplo de Script Inseguro

```bash
#!/bin/bash

# Script para realizar copias de seguridad

echo "Introduce el directorio de origen:"
read ORIGEN

echo "Introduce el directorio de destino:"
read DESTINO

# Realizar la copia de seguridad
cp -r $ORIGEN $DESTINO
echo "Copia de seguridad completada de $ORIGEN a $DESTINO"
```

#### Problemas Identificados

1. **Falta de validación de entrada:** Los nombres de directorios no se validan.
2. **Inyección de comandos:** El script es vulnerable a inyecciones de comandos si los usuarios ingresan datos maliciosos.

#### Script Seguro

```bash
#!/bin/bash

# Script para realizar copias de seguridad de manera segura

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

*Solución:* Este script valida los directorios de entrada y registra las acciones, evitando inyecciones de comandos y asegurando la existencia de los directorios.

### 2. Revisión de Scripts Python

#### Ejemplo de Script Inseguro

```python
import os

# Script para leer una variable de entorno y conectarse a una base de datos

DB_PASSWORD = os.getenv('DB_PASSWORD')
print(f"Conectando a la base de datos con la contraseña: {DB_PASSWORD}")
```

#### Problemas Identificados

1. **Exposición de contraseñas:** La contraseña se imprime en la salida estándar, lo que puede ser un riesgo de seguridad.
2. **Falta de manejo de errores:** El script no maneja el caso en el que la variable de entorno `DB_PASSWORD` no esté configurada.

#### Script Seguro

```python
import os
import logging

# Configurar el registro
logging.basicConfig(filename='/var/log/db_connect.log', level=logging.INFO)

# Leer la contraseña desde la variable de entorno
DB_PASSWORD = os.getenv('DB_PASSWORD')

if DB_PASSWORD:
    logging.info("Conectando a la base de datos de manera segura.")
    # Conectar a la base de datos usando la contraseña (lógica de conexión aquí)
else:
    logging.error("La variable de entorno DB_PASSWORD no está configurada.")
    print("Error: La variable de entorno DB_PASSWORD no está configurada.")
```

*Solución:* Este script evita exponer la contraseña en la salida estándar y maneja el caso en el que la variable de entorno no esté configurada, registrando los eventos importantes.

### 3. Caso Práctico: Auditoría Completa de un Script Bash

#### Ejemplo de Script Complejo Inseguro

```bash
#!/bin/bash

# Script para gestionar usuarios en el sistema

echo "Introduce el nombre del usuario a crear:"
read USERNAME

useradd $USERNAME
echo "Usuario $USERNAME creado."

echo "Introduce la contraseña para $USERNAME:"
read PASSWORD

echo "$USERNAME:$PASSWORD" | chpasswd
echo "Contraseña establecida para $USERNAME."
```

#### Problemas Identificados

1. **Falta de validación de entrada:** El nombre de usuario y la contraseña no se validan.
2. **Exposición de contraseñas:** La contraseña se maneja de manera insegura.
3. **Inyección de comandos:** El script es vulnerable a inyecciones de comandos a través del nombre de usuario.

#### Script Seguro

```bash
#!/bin/bash

# Script para gestionar usuarios en el sistema de manera segura

LOGFILE="/var/log/user_management.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

echo "Introduce el nombre del usuario a crear:"
read USERNAME

# Validar el nombre de usuario
if [[ ! "$USERNAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
    registrar "Nombre de usuario no válido: $USERNAME"
    echo "Nombre de usuario no válido."
    exit 1
fi

useradd "$USERNAME"
registrar "Usuario $USERNAME creado."
echo "Usuario $USERNAME creado."

echo "Introduce la contraseña para $USERNAME:"
read -s PASSWORD

# Validar la contraseña
if [ -z "$PASSWORD" ]; then
    registrar "La contraseña no puede estar vacía."
    echo "La contraseña no puede estar vacía."
    exit 1
fi

echo "$USERNAME:$PASSWORD" | chpasswd
registrar "Contraseña establecida para $USERNAME."
echo "Contraseña establecida para $USERNAME."
```

*Solución:* Este script valida la entrada del nombre de usuario y la contraseña, maneja la contraseña de manera segura y registra todas las acciones importantes.

## Conclusión

Realizar auditorías de seguridad en scripts es una práctica esencial para identificar y corregir vulnerabilidades. La revisión cuidadosa y la implementación de buenas prácticas de seguridad mejoran significativamente la protección de los sistemas y los datos. Los ejemplos proporcionados en este ejercicio complementario te ayudarán a auditar y asegurar tus propios scripts, fortaleciendo la seguridad en tu entorno de trabajo.
