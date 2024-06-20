# Ejercicio Complementario: Despliegue de Automatización en Producción

## Objetivo

El objetivo de este ejercicio complementario es aprender a desplegar scripts de automatización en un entorno de producción de manera segura y eficiente. Esto incluye la configuración del entorno, la implementación de mecanismos de monitoreo y notificación, y la integración con herramientas de CI/CD.

## Pasos para el Despliegue de Automatización en Producción

### 1. Preparación del Entorno

Antes de desplegar scripts de automatización en producción, es crucial preparar el entorno adecuadamente. Esto incluye la configuración de servidores, la instalación de dependencias y la creación de usuarios y permisos necesarios.

#### Configuración del Servidor

##### Actualización del Sistema

Mantén el sistema actualizado para asegurar que todas las dependencias estén en su última versión.

```bash
sudo apt update && sudo apt upgrade -y
```

##### Creación de Usuarios y Permisos

Crea un usuario dedicado para ejecutar los scripts de automatización.

```bash
sudo adduser automation
sudo usermod -aG sudo automation
```

#### Instalación de Dependencias

Instala todas las dependencias necesarias, como Python, pip y las bibliotecas requeridas.

```bash
sudo apt install python3 python3-pip -y
pip3 install -r requirements.txt
```

### 2. Implementación de Monitoreo y Notificación

El monitoreo y la notificación son cruciales para detectar y responder rápidamente a cualquier problema que pueda surgir durante la ejecución de los scripts de automatización.

#### Configuración de Monitoreo con Cron y Logrotate

##### Configuración de Cron

Programa la ejecución regular de los scripts de automatización usando cron.

```bash
crontab -e
```

Añade una entrada para ejecutar el script principal cada noche a la medianoche.

```bash
0 0 * * * /home/automation/scripts/flujo_seguro.sh
```

##### Configuración de Logrotate

Configura Logrotate para gestionar los archivos de log generados por los scripts.

```bash
sudo nano /etc/logrotate.d/automation

# Añadir la siguiente configuración
/home/automation/logs/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 automation automation
    sharedscripts
    postrotate
        /usr/bin/systemctl reload rsyslog > /dev/null 2>&1 || true
    endscript
}
```

#### Configuración de Notificaciones por Correo Electrónico

Usa `mail` para enviar notificaciones por correo electrónico en caso de errores.

##### Instalación de mailutils

```bash
sudo apt install mailutils -y
```

##### Configuración del Script para Enviar Notificaciones

Añade notificaciones por correo electrónico al script principal.

```bash
#!/bin/bash

LOGFILE="/var/log/flujo_seguro.log"
EMAIL="admin@example.com"

registrar() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

notificar_error() {
    local message=$1
    echo "$message" | mail -s "Error en Automatización" $EMAIL
}

# Preparación
registrar "Iniciando el flujo de trabajo seguro."

if [ -z "$DB_PASSWORD" ]; then
    mensaje="La variable de entorno DB_PASSWORD no está configurada."
    registrar "$mensaje"
    notificar_error "$mensaje"
    exit 1
fi

registrar "Contraseña leída de forma segura."

# Recopilar datos del sistema
registrar "Recopilando datos del sistema..."
./recopilar_datos_sistema.sh || { registrar "Error al recopilar datos del sistema."; notificar_error "Error al recopilar datos del sistema."; exit 1; }

# Procesar los datos
registrar "Procesando datos..."
python3 procesar_datos.py || { registrar "Error al procesar datos."; notificar_error "Error al procesar datos."; exit 1; }

# Enviar el informe
registrar "Enviando informe por correo electrónico..."
python3 enviar_informe.py || { registrar "Error al enviar el informe."; notificar_error "Error al enviar el informe."; exit 1; }

registrar "Flujo de trabajo completado."
```

### 3. Integración con Herramientas de CI/CD

Integrar los scripts de automatización con herramientas de CI/CD como Jenkins facilita la ejecución automática y controlada de los scripts, asegurando que se ejecuten en un entorno controlado y auditado.

#### Configuración de Jenkins

##### Instalación de Jenkins

Sigue las instrucciones de instalación de Jenkins para tu sistema operativo. Aquí hay un ejemplo para Ubuntu.

```bash
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

##### Configuración de un Pipeline en Jenkins

1. **Crear un nuevo trabajo de Pipeline en Jenkins.**
2. **Configurar el pipeline para ejecutar el script principal.**

```groovy
pipeline {
    agent any

    environment {
        DB_PASSWORD = credentials('db-password')
    }

    stages {
        stage('Preparación') {
            steps {
                script {
                    sh './recopilar_datos_sistema.sh'
                }
            }
        }
        stage('Ejecución de tareas') {
            steps {
                script {
                    sh 'python3 procesar_datos.py'
                    sh 'python3 enviar_informe.py'
                }
            }
        }
        stage('Finalización') {
            steps {
                script {
                    sh 'rm /tmp/datos_temp.txt'
                    sh 'echo "Flujo de trabajo completado."'
                }
            }
        }
    }

    post {
        failure {
            mail to: 'admin@example.com',
                 subject: "Jenkins Job Failed: ${currentBuild.fullDisplayName}",
                 body: "The Jenkins job has failed. Please check the logs for details."
        }
        success {
            mail to: 'admin@example.com',
                 subject: "Jenkins Job Succeeded: ${currentBuild.fullDisplayName}",
                 body: "The Jenkins job has completed successfully."
        }
    }
}
```

### 4. Pruebas y Validación

Es esencial probar el flujo de trabajo de automatización en un entorno de prueba antes de desplegarlo en producción. Realiza pruebas exhaustivas para asegurarte de que todo funciona como se espera.

#### Pruebas de Integración

Realiza pruebas para verificar que todas las partes del flujo de trabajo funcionan correctamente juntas.

#### Pruebas de Error

Simula errores para asegurarte de que el sistema de notificación funciona correctamente.

```bash
export DB_PASSWORD=''
./flujo_seguro.sh
```

## Conclusión

El despliegue de scripts de automatización en producción requiere una preparación meticulosa, implementación de monitoreo y notificación, y pruebas exhaustivas. Integrar herramientas de CI/CD como Jenkins facilita la gestión y ejecución de estos scripts en un entorno controlado y auditado. Los ejemplos proporcionados en esta guía te ayudarán a desplegar tus propios scripts de automatización de manera segura y eficiente, mejorando la fiabilidad y seguridad de tus operaciones de TI.
