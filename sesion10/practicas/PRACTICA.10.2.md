# Práctica 10.2: Implementar Técnicas de Seguridad en la Automatización

## Objetivo

El objetivo de esta práctica es aprender a implementar técnicas de seguridad en scripts de automatización avanzados, utilizando Bash y Python. Esto incluye el manejo seguro de datos sensibles, la validación de entrada y la implementación de registros detallados para auditoría.

## Ejercicio

### 1. Manejo Seguro de Datos Sensibles

En esta sección, aprenderás a manejar datos sensibles, como contraseñas y claves API, de manera segura en tus scripts.

#### Parte 1: Uso de Variables de Entorno para Datos Sensibles en Bash

##### Script Bash para Leer Datos Sensibles desde Variables de Entorno

```bash
#!/bin/bash

# Leer contraseña desde una variable de entorno
if [ -z "$DB_PASSWORD" ]; then
  echo "La variable de entorno DB_PASSWORD no está configurada."
  exit 1
fi

# Usar la contraseña de manera segura
echo "La contraseña para la base de datos ha sido leída de forma segura."
```

##### Guardar el Script

Guarda el script con el nombre `seguridad_bash.sh`.

##### Configurar y Ejecutar el Script

```bash
export DB_PASSWORD='mi_contraseña_segura'
./seguridad_bash.sh
```

#### Parte 2: Uso de Variables de Entorno para Datos Sensibles en Python

##### Script Python para Leer Datos Sensibles desde Variables de Entorno

```python
import os

# Leer la contraseña desde la variable de entorno
db_password = os.getenv('DB_PASSWORD')

if db_password:
    print("La contraseña para la base de datos ha sido leída de forma segura.")
else:
    print("La variable de entorno DB_PASSWORD no está configurada.")
```

##### Guardar el Script

Guarda el script con el nombre `seguridad_python.py`.

##### Configurar y Ejecutar el Script

```bash
export DB_PASSWORD='mi_contraseña_segura'
python3 seguridad_python.py
```

### 2. Validación de Entrada

Es crucial validar las entradas del usuario para prevenir inyecciones y otras vulnerabilidades.

#### Validación de Entrada en Bash

##### Script Bash con Validación de Entrada

```bash
#!/bin/bash

echo "Introduce el nombre del archivo:"
read FILENAME

# Validar que el nombre del archivo solo contiene caracteres válidos
if [[ "$FILENAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
  echo "Nombre de archivo válido: $FILENAME"
else
  echo "Nombre de archivo no válido."
  exit 1
fi
```

##### Guardar el Script

Guarda el script con el nombre `validacion_bash.sh`.

##### Hacer el Script Ejecutable

```bash
chmod +x validacion_bash.sh
```

##### Ejecutar el Script

```bash
./validacion_bash.sh
```

#### Validación de Entrada en Python

##### Script Python con Validación de Entrada

```python
import re

# Solicitar el nombre del archivo al usuario
filename = input("Introduce el nombre del archivo: ")

# Validar que el nombre del archivo solo contiene caracteres válidos
if re.match(r'^[a-zA-Z0-9._-]+$', filename):
    print(f"Nombre de archivo válido: {filename}")
else:
    print("Nombre de archivo no válido.")
```

##### Guardar el Script

Guarda el script con el nombre `validacion_python.py`.

##### Ejecutar el Script

```bash
python3 validacion_python.py
```

### 3. Implementación de Registros para Auditoría

Registrar las acciones de los scripts es esencial para auditorías y monitoreo.

#### Registro en Bash

##### Script Bash con Registro

```bash
#!/bin/bash

LOGFILE="/var/log/script_audit.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

echo "Iniciando el script..."
registrar "Script iniciado."

# Simular una acción del script
echo "Realizando una acción..."
registrar "Acción realizada."

echo "Finalizando el script..."
registrar "Script finalizado."
```

##### Guardar el Script

Guarda el script con el nombre `registro_bash.sh`.

##### Hacer el Script Ejecutable

```bash
chmod +x registro_bash.sh
```

##### Ejecutar el Script

```bash
./registro_bash.sh
```

#### Registro en Python

##### Script Python con Registro

```python
import logging

# Configurar el registro
logging.basicConfig(filename='/var/log/script_audit.log', level=logging.INFO, format='%(asctime)s - %(message)s')

logging.info('Script iniciado.')

# Simular una acción del script
print("Realizando una acción...")
logging.info('Acción realizada.')

logging.info('Script finalizado.')
```

##### Guardar el Script

Guarda el script con el nombre `registro_python.py`.

##### Ejecutar el Script

```bash
python3 registro_python.py
```

### Caso Práctico Completo: Integración de Seguridad en un Flujo de Trabajo

#### Script Principal en Bash con Seguridad Integrada

```bash
#!/bin/bash

# Archivo de log
LOGFILE="/var/log/flujo_seguro.log"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

# Preparación
registrar "Iniciando el flujo de trabajo seguro."

# Leer contraseña desde una variable de entorno
if [ -z "$DB_PASSWORD" ]; then
  registrar "La variable de entorno DB_PASSWORD no está configurada."
  echo "La variable de entorno DB_PASSWORD no está configurada."
  exit 1
fi

registrar "Contraseña leída de forma segura."

# Recopilar datos del sistema
registrar "Recopilando datos del sistema..."
./recopilar_datos_sistema.sh

# Procesar los datos
registrar "Procesando datos..."
python3 procesar_datos.py

# Enviar el informe
registrar "Enviando informe por correo electrónico..."
python3 enviar_informe.py

registrar "Flujo de trabajo completado."
```

#### Guardar el Script

Guarda el script con el nombre `flujo_seguro.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x flujo_seguro.sh
```

#### Ejecutar el Script

```bash
export DB_PASSWORD='mi_contraseña_segura'
./flujo_seguro.sh
```

## Conclusión

Implementar técnicas de seguridad en la automatización es crucial para proteger datos sensibles y asegurar la integridad de los procesos automatizados. Esta práctica te proporciona las herramientas y conocimientos necesarios para integrar seguridad en tus scripts de Bash y Python, mejorando la confiabilidad y seguridad de tus flujos de trabajo.
