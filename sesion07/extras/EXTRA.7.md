### Laboratorio: Automatización de Despliegue y Escalado con Docker y Bash

#### **Objetivo:**
Comprender el uso de herramientas externas en Bash para la automatización de despliegues y escalado de contenedores Docker, realizando iteraciones para mejorar un script de gestión hasta obtener una solución final.

#### **Descripción del Laboratorio:**
Este laboratorio está diseñado para guiar al practicante a través del proceso de desarrollo de un script de Bash que automatiza el despliegue y escalado de servidores Nginx utilizando Docker. Cada iteración introduce nuevas funcionalidades y mejoras, permitiendo al practicante comprender los conceptos y técnicas involucradas.

### Iteración 1: Configuración Inicial y Creación de Dockerfiles

**Objetivo:**
Crear los Dockerfiles necesarios para el balanceador de carga y los servidores Nginx backend.

1. Crear el archivo `Dockerfile` para el balanceador de carga:
   ```bash
   nano nginx_setup/Dockerfile
   ```

   Contenido:
   ```Dockerfile
   FROM nginx:latest
   COPY nginx.conf /etc/nginx/nginx.conf
   ```

2. Crear el archivo `nginx.conf` para el balanceador de carga:
   ```bash
   nano nginx_setup/nginx.conf
   ```

   Contenido:
   ```nginx
   events { }

   http {
       log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for"';
       access_log /var/log/nginx/access.log main;

       upstream app_servers {
           least_conn;
           server nginx_1:80;
           server nginx_2:80;
       }

       server {
           listen 80;
           location / {
               proxy_pass http://app_servers;
               proxy_set_header Host $host;
               proxy_set_header X-Real-IP $remote_addr;
               proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto $scheme;
           }
       }
   }
   ```

3. Crear los Dockerfiles para los servidores Nginx backend:
   ```bash
   mkdir -p nginx_setup/nginx_1
   mkdir -p nginx_setup/nginx_2

   nano nginx_setup/nginx_1/Dockerfile
   ```

   Contenido:
   ```Dockerfile
   FROM nginx:latest
   COPY index.html /usr/share/nginx/html/index.html
   ```

   Repetir para `nginx_2`.

4. Crear los archivos `index.html` para los servidores Nginx backend:
   ```bash
   nano nginx_setup/nginx_1/index.html
   ```

   Contenido:
   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <title>Nginx Server</title>
   </head>
   <body>
       <h1>Welcome to Nginx Server</h1>
       <p>Servido por el contenedor: nginx_1</p>
   </body>
   </html>
   ```

   Repetir para `nginx_2`, cambiando el contenido a `nginx_2`.

### Iteración 2: Creación del Archivo docker-compose.yml

**Objetivo:**
Crear un archivo `docker-compose.yml` para gestionar los contenedores del balanceador de carga y los servidores Nginx backend.

1. Crear el archivo `docker-compose.yml`:
   ```bash
   nano nginx_setup/docker-compose.yml
   ```

   Contenido:
   ```yaml
   version: '3.8'
   services:
     balancer:
       build: .
       container_name: nginx_balancer
       ports:
         - "80:80"
       depends_on:
         - nginx_1
         - nginx_2
       networks:
         - nginx_network

     nginx_1:
       build:
         context: ./nginx_1
       container_name: nginx_1
       networks:
         - nginx_network

     nginx_2:
       build:
         context: ./nginx_2
       container_name: nginx_2
       networks:
         - nginx_network

   networks:
     nginx_network:
       driver: bridge
   ```

### Iteración 3: Creación del Script Básico para Despliegue

**Objetivo:**
Crear un script básico de Bash para desplegar los contenedores utilizando Docker Compose.

1. Crear el archivo del script:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   COMPOSE_CMD="docker-compose"

   $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   ```

2. Dar permisos de ejecución al script:
   ```bash
   chmod +x manage_nginx.sh
   ```

3. Ejecutar el script para desplegar los contenedores:
   ```bash
   ./manage_nginx.sh
   ```

### Iteración 4: Añadir Funcionalidad de Escalado Básico

**Objetivo:**
Modificar el script para permitir el escalado básico de los servidores Nginx backend.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   COMPOSE_CMD="docker-compose"

   start() {
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       for i in $(seq 3 $NUM_CONTAINERS); do
           mkdir -p nginx_setup/nginx_$i
           cat <<EOF > nginx_setup/nginx_$i/Dockerfile
   FROM nginx:latest
   COPY index.html /usr/share/nginx/html/index.html
   EOF

           cat <<EOF > nginx_setup/nginx_$i/index.html
   <!DOCTYPE html>
   <html>
   <head>
       <title>Nginx Server</title>
   </head>
   <body>
       <h1>Welcome to Nginx Server</h1>
       <p>Servido por el contenedor: nginx_$i</p>
   </body>
   </html>
   EOF

           echo "  nginx_$i:" >> nginx_setup/docker-compose.yml
           echo "    build:" >> nginx_setup/docker-compose.yml
           echo "      context: ./nginx_$i" >> nginx_setup/docker-compose.yml
           echo "    container_name: nginx_$i" >> nginx_setup/docker-compose.yml
           echo "    networks:" >> nginx_setup/docker-compose.yml
           echo "      - nginx_network" >> nginx_setup/docker-compose.yml
       done
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       *)
           echo "Uso: $0 {start|scaleup} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 5: Añadir Funcionalidad de Escalado y Reducción

**Objetivo:**
Modificar el script para permitir el escalado y la reducción de los servidores Nginx backend.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   SETTINGS_FILE="nginx_setup/settings.conf"
   COMPOSE_CMD="docker-compose"

   load_settings() {
       if [ -f $SETTINGS_FILE ]; then
           source $SETTINGS_FILE
       else
           CURRENT_CONTAINERS=2
       fi
       echo "Cargando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   save_settings() {
       echo "CURRENT_CONTAINERS=$CURRENT_CONTAINERS" > $SETTINGS_FILE
       echo "Guardando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   start() {
       load_settings
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS + $NUM_CONTAINERS))
       save_settings
       start
   }

   scaledown() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS - $NUM_CONTAINERS))
       if [ $CURRENT_CONTAINERS -lt 1 ]; then
           CURRENT_CONTAINERS=1
       fi
       save_settings
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       scaledown)
           scaledown
           ;;
       *)
           echo "Uso: $0 {start|scaleup|scaledown} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 6: Mejorar la Gestión de Contenedores y Volúmenes

**Objetivo:**
Añadir funcionalidades para gestionar contenedores y volúmenes antiguos, y mejorar el proceso de despliegue.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   SETTINGS_FILE="nginx_setup/settings.conf"
   COMPOSE_CMD="docker-compose"

   load_settings() {
       if [ -f $SETTINGS_FILE ]; then
           source

 $SETTINGS_FILE
       else
           CURRENT_CONTAINERS=2
       fi
       echo "Cargando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   save_settings() {
       echo "CURRENT_CONTAINERS=$CURRENT_CONTAINERS" > $SETTINGS_FILE
       echo "Guardando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   remove_old_containers() {
       if [ -f nginx_setup/docker-compose.yml ]; then
           $COMPOSE_CMD -f nginx_setup/docker-compose.yml down --volumes --remove-orphans
       fi
       docker container prune -f
       docker volume prune -f
   }

   start() {
       load_settings
       remove_old_containers
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS + $NUM_CONTAINERS))
       save_settings
       start
   }

   scaledown() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS - $NUM_CONTAINERS))
       if [ $CURRENT_CONTAINERS -lt 1 ]; then
           CURRENT_CONTAINERS=1
       fi
       save_settings
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       scaledown)
           scaledown
           ;;
       *)
           echo "Uso: $0 {start|scaleup|scaledown} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 7: Añadir Mensajes de Depuración y Validaciones

**Objetivo:**
Añadir mensajes de depuración para verificar el comportamiento del script y validar las entradas.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   SETTINGS_FILE="nginx_setup/settings.conf"
   COMPOSE_CMD="docker-compose"

   load_settings() {
       if [ -f $SETTINGS_FILE ]; then
           source $SETTINGS_FILE
       else
           CURRENT_CONTAINERS=2
       fi
       echo "Cargando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   save_settings() {
       echo "CURRENT_CONTAINERS=$CURRENT_CONTAINERS" > $SETTINGS_FILE
       echo "Guardando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   remove_old_containers() {
       if [ -f nginx_setup/docker-compose.yml ]; then
           $COMPOSE_CMD -f nginx_setup/docker-compose.yml down --volumes --remove-orphans
       fi
       docker container prune -f
       docker volume prune -f
   }

   start() {
       load_settings
       echo "Iniciando con $CURRENT_CONTAINERS contenedores."
       remove_old_containers
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS + $NUM_CONTAINERS))
       save_settings
       echo "Escalando hacia arriba: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   scaledown() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS - $NUM_CONTAINERS))
       if [ $CURRENT_CONTAINERS -lt 1 ]; then
           CURRENT_CONTAINERS=1
       fi
       save_settings
       echo "Escalando hacia abajo: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       scaledown)
           scaledown
           ;;
       *)
           echo "Uso: $0 {start|scaleup|scaledown} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 8: Añadir Funcionalidad de Limpieza Completa

**Objetivo:**
Añadir una funcionalidad de limpieza completa para eliminar todos los recursos creados por el script.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   SETTINGS_FILE="nginx_setup/settings.conf"
   COMPOSE_CMD="docker-compose"

   load_settings() {
       if [ -f $SETTINGS_FILE ]; then
           source $SETTINGS_FILE
       else
           CURRENT_CONTAINERS=2
       fi
       echo "Cargando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   save_settings() {
       echo "CURRENT_CONTAINERS=$CURRENT_CONTAINERS" > $SETTINGS_FILE
       echo "Guardando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   remove_old_containers() {
       if [ -f nginx_setup/docker-compose.yml ]; then
           $COMPOSE_CMD -f nginx_setup/docker-compose.yml down --volumes --remove-orphans
       fi
       docker container prune -f
       docker volume prune -f
   }

   cleanup() {
       remove_old_containers
       docker container prune -f
       docker volume prune -f
       docker rmi $(docker images -f "dangling=true" -q)
       rm -rf nginx_setup
       echo "Limpieza completa realizada."
   }

   start() {
       load_settings
       echo "Iniciando con $CURRENT_CONTAINERS contenedores."
       remove_old_containers
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS + $NUM_CONTAINERS))
       save_settings
       echo "Escalando hacia arriba: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   scaledown() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS - $NUM_CONTAINERS))
       if [ $CURRENT_CONTAINERS -lt 1 ]; then
           CURRENT_CONTAINERS=1
       fi
       save_settings
       echo "Escalando hacia abajo: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       scaledown)
           scaledown
           ;;
       cleanup)
           cleanup
           ;;
       *)
           echo "Uso: $0 {start|scaleup|scaledown|cleanup} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 9: Añadir Validación de Argumentos y Mensajes de Ayuda

**Objetivo:**
Añadir validación de argumentos y mensajes de ayuda para mejorar la usabilidad del script.

1. Modificar el script `manage_nginx.sh`:
   ```bash
   nano manage_nginx.sh
   ```

   Contenido:
   ```bash
   #!/bin/bash

   ACTION=$1
   NUM_CONTAINERS=$2
   SETTINGS_FILE="nginx_setup/settings.conf"
   COMPOSE_CMD="docker-compose"

   if [ -z "$ACTION" ]; then
       echo "Uso: $0 {start|scaleup|scaledown|cleanup} NUM_CONTAINERS"
       exit 1
   fi

   if [ "$ACTION" != "cleanup" ] && [ -z "$NUM_CONTAINERS" ]; then
       echo "Uso: $0 {start|scaleup|scaledown} NUM_CONTAINERS"
       exit 1
   fi

   load_settings() {
       if [ -f $SETTINGS_FILE ]; then
           source $SETTINGS_FILE
       else
           CURRENT_CONTAINERS=2
       fi
       echo "Cargando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   save_settings() {
       echo "CURRENT_CONTAINERS=$CURRENT_CONTAINERS" > $SETTINGS_FILE
       echo "Guardando configuración: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
   }

   remove_old_containers() {
       if [ -f nginx_setup/docker-compose.yml ]; then
           $COMPOSE_CMD -f nginx_setup/docker-compose.yml down --volumes --remove-orphans
       fi
       docker container prune -f
       docker volume prune -f
   }

   cleanup() {
       remove_old_containers
       docker container prune -f
       docker volume prune -f
       docker rmi $(docker images -f "dangling=true" -q)
       rm -rf nginx_setup
       echo "Limpieza completa realizada."
   }

   start() {
       load_settings
       echo "Iniciando con $CURRENT_CONTAINERS contenedores."
       remove_old_containers
       $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
   }

   scaleup() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS + $NUM_CONTAINERS))
       save_settings
       echo "Escalando hacia arriba: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   scaledown() {
       load_settings
       CURRENT_CONTAINERS=$(($CURRENT_CONTAINERS - $NUM_CONTAINERS))
       if [ $CURRENT_CONTAINERS -lt 1 ]; then
           CURRENT_CONTAINERS=1
       fi
       save_settings
       echo "Escalando

 hacia abajo: CURRENT_CONTAINERS=$CURRENT_CONTAINERS"
       start
   }

   case "$ACTION" in
       start)
           start
           ;;
       scaleup)
           scaleup
           ;;
       scaledown)
           scaledown
           ;;
       cleanup)
           cleanup
           ;;
       *)
           echo "Uso: $0 {start|scaleup|scaledown|cleanup} NUM_CONTAINERS"
           ;;
   esac
   ```

### Iteración 10: Verificación y Documentación

**Objetivo:**
Verificar el funcionamiento completo del script y documentar el proceso y los resultados.

1. Ejecutar las siguientes pruebas para verificar el funcionamiento del script:

   - Desplegar los contenedores iniciales:
     ```bash
     ./manage_nginx.sh start 2
     ```

   - Escalar hacia arriba:
     ```bash
     ./manage_nginx.sh scaleup 1
     ```

   - Escalar hacia abajo:
     ```bash
     ./manage_nginx.sh scaledown 1
     ```

   - Limpiar todos los recursos:
     ```bash
     ./manage_nginx.sh cleanup
     ```

2. Documentar el proceso y los resultados de las pruebas realizadas.

#### **Conclusión:**
A través de estas iteraciones, el practicante ha aprendido a utilizar herramientas externas en Bash, como Docker y Docker Compose, para automatizar el despliegue y escalado de contenedores. Cada iteración introdujo nuevas funcionalidades y mejoras, permitiendo al practicante comprender los conceptos y técnicas involucradas en la gestión de contenedores y automatización de despliegues.