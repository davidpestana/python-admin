# Ejercicio Complementario: Sistema de Notificación de Estado de Servicios

## Objetivo

El objetivo de este ejercicio complementario es crear un sistema que notifique el estado de un servicio específico por correo electrónico. Esto es útil para asegurar que los administradores de sistemas estén informados de manera oportuna sobre cualquier problema con los servicios críticos.

## Requisitos

Para completar este ejercicio, necesitarás:
- Acceso a un servidor de correo SMTP.
- Conocimientos básicos de Bash.
- Permisos de administrador en el sistema para gestionar servicios y enviar correos electrónicos.

## Pasos

### 1. Crear un Script Bash para Verificar el Estado del Servicio

Este script verificará el estado de un servicio y enviará una notificación por correo electrónico si el servicio está detenido.

#### Código del Script

```bash
#!/bin/bash

# Nombre del servicio
SERVICIO="apache2"

# Dirección de correo electrónico para notificaciones
EMAIL="admin@example.com"

# Asunto del correo
ASUNTO="Alerta: Servicio $SERVICIO Detenido"

# Comprobar el estado del servicio
ESTADO=$(systemctl is-active $SERVICIO)

# Enviar una notificación si el servicio está detenido
if [ "$ESTADO" != "active" ]; then
    echo "El servicio $SERVICIO está detenido." | mail -s "$ASUNTO" $EMAIL
fi
```

#### Guardar el Script

Guarda el script con el nombre `notificar_estado_servicio.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x notificar_estado_servicio.sh
```

#### Ejecutar el Script Manualmente

```bash
./notificar_estado_servicio.sh
```

### 2. Programar el Script con `cron`

Para asegurarte de que el estado del servicio se verifique regularmente, puedes programar el script para que se ejecute periódicamente utilizando `cron`.

#### Editar el Crontab

Abre el archivo crontab del usuario actual para editarlo.

```bash
crontab -e
```

#### Añadir una Entrada para Ejecutar el Script Cada 10 Minutos

Añade la siguiente línea al archivo crontab para que el script se ejecute cada 10 minutos.

```bash
*/10 * * * * /ruta/al/script/notificar_estado_servicio.sh
```

#### Guardar y Salir

Guarda los cambios y sal del editor. El script ahora se ejecutará automáticamente cada 10 minutos.

## Casos Prácticos

### Caso Práctico 1: Monitoreo de Múltiples Servicios

Supongamos que necesitas monitorear varios servicios críticos. Puedes modificar el script para comprobar el estado de múltiples servicios y enviar una notificación si alguno de ellos está detenido.

#### Código del Script para Múltiples Servicios

```bash
#!/bin/bash

# Lista de servicios a monitorear
SERVICIOS=("apache2" "mysql" "ssh")

# Dirección de correo electrónico para notificaciones
EMAIL="admin@example.com"

# Función para comprobar el estado de un servicio y enviar notificación si está detenido
comprobar_servicio() {
    local servicio=$1
    local estado=$(systemctl is-active $servicio)
    local asunto="Alerta: Servicio $servicio Detenido"

    if [ "$estado" != "active" ]; then
        echo "El servicio $servicio está detenido." | mail -s "$asunto" $EMAIL
    fi
}

# Comprobar el estado de cada servicio
for servicio in "${SERVICIOS[@]}"; do
    comprobar_servicio $servicio
done
```

#### Guardar el Script

Guarda el script con el nombre `notificar_estado_multiples_servicios.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x notificar_estado_multiples_servicios.sh
```

#### Programar el Script con `cron`

Edita el crontab para programar el script a ejecutarse cada 10 minutos.

```bash
crontab -e
```

Añade la siguiente línea:

```bash
*/10 * * * * /ruta/al/script/notificar_estado_multiples_servicios.sh
```

### Caso Práctico 2: Registro de Notificaciones

Es útil mantener un registro de las notificaciones enviadas para auditorías y diagnósticos. Puedes modificar el script para registrar las notificaciones en un archivo de log.

#### Código del Script con Registro

```bash
#!/bin/bash

# Lista de servicios a monitorear
SERVICIOS=("apache2" "mysql" "ssh")

# Dirección de correo electrónico para notificaciones
EMAIL="admin@example.com"

# Archivo de log
LOGFILE="/var/log/estado_servicios.log"

# Función para comprobar el estado de un servicio y enviar notificación si está detenido
comprobar_servicio() {
    local servicio=$1
    local estado=$(systemctl is-active $servicio)
    local asunto="Alerta: Servicio $servicio Detenido"

    if [ "$estado" != "active" ]; then
        echo "El servicio $servicio está detenido." | mail -s "$asunto" $EMAIL
        echo "$(date +'%Y-%m-%d %H:%M:%S') - $servicio detenido y notificación enviada a $EMAIL" >> $LOGFILE
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') - $servicio activo" >> $LOGFILE
    fi
}

# Comprobar el estado de cada servicio
for servicio in "${SERVICIOS[@]}"; do
    comprobar_servicio $servicio
done
```

#### Guardar el Script

Guarda el script con el nombre `notificar_estado_servicios_log.sh`.

#### Hacer el Script Ejecutable

```bash
chmod +x notificar_estado_servicios_log.sh
```

#### Programar el Script con `cron`

Edita el crontab para programar el script a ejecutarse cada 10 minutos.

```bash
crontab -e
```

Añade la siguiente línea:

```bash
*/10 * * * * /ruta/al/script/notificar_estado_servicios_log.sh
```

## Conclusión

Crear un sistema de notificación para el estado de los servicios es una práctica esencial para la administración proactiva de sistemas. Los scripts proporcionados en este ejercicio complementario permiten monitorear el estado de uno o múltiples servicios y enviar notificaciones por correo electrónico en caso de interrupciones. Además, la integración con `cron` asegura que las verificaciones se realicen de manera regular y automática, proporcionando una solución robusta y confiable para la supervisión de servicios.