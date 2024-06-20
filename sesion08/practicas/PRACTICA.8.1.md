# Práctica 8.1: Gestión de Servicios en Bash

## Objetivo

El objetivo de esta práctica es aprender a escribir scripts en Bash para iniciar, detener, reiniciar y supervisar servicios del sistema. Esta habilidad es fundamental para administrar servicios de manera eficiente y automatizar tareas comunes en un entorno de servidor.

## Ejercicio

### 1. Crear un script para iniciar un servicio

Este script iniciará un servicio específico usando `systemctl`.

#### Código del script

```bash
#!/bin/bash

# Nombre del servicio
SERVICIO="apache2"

# Iniciar el servicio
sudo systemctl start $SERVICIO

# Verificar el estado del servicio
sudo systemctl status $SERVICIO
```

#### Guardar el script

Guarda el script con el nombre `iniciar_servicio.sh`.

#### Hacer el script ejecutable

```bash
chmod +x iniciar_servicio.sh
```

#### Ejecutar el script

```bash
./iniciar_servicio.sh
```

### 2. Crear un script para detener un servicio

Este script detendrá un servicio específico usando `systemctl`.

#### Código del script

```bash
#!/bin/bash

# Nombre del servicio
SERVICIO="apache2"

# Detener el servicio
sudo systemctl stop $SERVICIO

# Verificar el estado del servicio
sudo systemctl status $SERVICIO
```

#### Guardar el script

Guarda el script con el nombre `detener_servicio.sh`.

#### Hacer el script ejecutable

```bash
chmod +x detener_servicio.sh
```

#### Ejecutar el script

```bash
./detener_servicio.sh
```

### 3. Crear un script para reiniciar un servicio

Este script reiniciará un servicio específico usando `systemctl`.

#### Código del script

```bash
#!/bin/bash

# Nombre del servicio
SERVICIO="apache2"

# Reiniciar el servicio
sudo systemctl restart $SERVICIO

# Verificar el estado del servicio
sudo systemctl status $SERVICIO
```

#### Guardar el script

Guarda el script con el nombre `reiniciar_servicio.sh`.

#### Hacer el script ejecutable

```bash
chmod +x reiniciar_servicio.sh
```

#### Ejecutar el script

```bash
./reiniciar_servicio.sh
```

### 4. Crear un script para verificar el estado de un servicio

Este script verificará el estado de un servicio específico usando `systemctl`.

#### Código del script

```bash
#!/bin/bash

# Nombre del servicio
SERVICIO="apache2"

# Verificar el estado del servicio
sudo systemctl status $SERVICIO
```

#### Guardar el script

Guarda el script con el nombre `estado_servicio.sh`.

#### Hacer el script ejecutable

```bash
chmod +x estado_servicio.sh
```

#### Ejecutar el script

```bash
./estado_servicio.sh
```

## Casos Prácticos

### Caso Práctico 1: Automatización de Gestión de Servicios

Como administrador de sistemas, a menudo necesitas gestionar múltiples servicios. Vamos a crear un script que acepte argumentos para iniciar, detener, reiniciar o verificar el estado de un servicio.

#### Código del script

```bash
#!/bin/bash

# Comprobar que se ha proporcionado el nombre del servicio y la acción
if [ $# -ne 2 ]; then
    echo "Uso: $0 {nombre_del_servicio} {start|stop|restart|status}"
    exit 1
fi

SERVICIO=$1
ACCION=$2

# Ejecutar la acción correspondiente
case $ACCION in
    start)
        echo "Iniciando el servicio $SERVICIO..."
        sudo systemctl start $SERVICIO
        ;;
    stop)
        echo "Deteniendo el servicio $SERVICIO..."
        sudo systemctl stop $SERVICIO
        ;;
    restart)
        echo "Reiniciando el servicio $SERVICIO..."
        sudo systemctl restart $SERVICIO
        ;;
    status)
        echo "Estado del servicio $SERVICIO:"
        sudo systemctl status $SERVICIO
        ;;
    *)
        echo "Acción no válida. Uso: $0 {nombre_del_servicio} {start|stop|restart|status}"
        exit 1
        ;;
esac
```

#### Guardar el script

Guarda el script con el nombre `gestionar_servicio.sh`.

#### Hacer el script ejecutable

```bash
chmod +x gestionar_servicio.sh
```

#### Ejecutar el script

```bash
./gestionar_servicio.sh apache2 start
./gestionar_servicio.sh apache2 stop
./gestionar_servicio.sh apache2 restart
./gestionar_servicio.sh apache2 status
```

### Caso Práctico 2: Programación de Tareas con cron

Vamos a programar una tarea cron para verificar el estado de un servicio cada 10 minutos y registrar el resultado en un archivo de log.

#### Editar el archivo crontab

```bash
crontab -e
```

#### Añadir la tarea cron

```bash
*/10 * * * * /path/to/estado_servicio.sh >> /var/log/estado_servicio.log 2>&1
```

*Ejemplo práctico:* Esta entrada en el crontab ejecuta el script `estado_servicio.sh` cada 10 minutos y guarda la salida en `/var/log/estado_servicio.log`.

## Conclusión

La gestión de servicios utilizando scripts en Bash es una habilidad esencial para los administradores de sistemas. Los scripts proporcionados en esta práctica permiten iniciar, detener, reiniciar y verificar el estado de los servicios de manera eficiente y automatizada. Además, la integración con `cron` permite la automatización completa de estas tareas, asegurando que los servicios se supervisen y gestionen adecuadamente.