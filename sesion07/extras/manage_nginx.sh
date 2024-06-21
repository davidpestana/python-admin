#!/bin/bash

ACTION=$1
NUM_CONTAINERS=$2
SETTINGS_FILE="nginx_setup/settings.conf"

check_compose_command() {
    if command -v docker-compose &> /dev/null
    then
        COMPOSE_CMD="docker-compose"
    elif command -v docker &> /dev/null && docker compose version &> /dev/null
    then
        COMPOSE_CMD="docker compose"
    else
        echo "Docker Compose no está instalado. Por favor, instálalo y vuelve a intentarlo."
        exit 1
    fi
}

load_settings() {
    if [ -f $SETTINGS_FILE ]; then
        source $SETTINGS_FILE
    else
        CURRENT_CONTAINERS=0
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

create_files() {
    mkdir -p nginx_setup

    # Crear Dockerfile para balanceador
    cat <<EOF > nginx_setup/Dockerfile
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
EOF

    # Crear archivo de configuración de Nginx para el balanceador
    cat <<EOF > nginx_setup/nginx.conf
events { }

http {
    log_format main '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';
    access_log /var/log/nginx/access.log main;

    upstream app_servers {
        least_conn;
EOF

    for i in $(seq 1 $CURRENT_CONTAINERS); do
        echo "        server nginx_$i:80;" >> nginx_setup/nginx.conf
    done

    cat <<EOF >> nginx_setup/nginx.conf
    }

    server {
        listen 80;
        location / {
            proxy_pass http://app_servers;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOF

    # Crear carpetas y archivos HTML por servidor
    for i in $(seq 1 $CURRENT_CONTAINERS); do
        mkdir -p nginx_setup/nginx_$i
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

        # Crear Dockerfile para servidores backend
        cat <<EOF > nginx_setup/nginx_$i/Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF
    done

    # Crear archivo docker-compose.yml
    cat <<EOF > nginx_setup/docker-compose.yml
version: '3.8'
services:
  balancer:
    build: .
    container_name: nginx_balancer
    ports:
      - "80:80"
    depends_on:
EOF

    for i in $(seq 1 $CURRENT_CONTAINERS); do
        echo "      - nginx_$i" >> nginx_setup/docker-compose.yml
    done

    cat <<EOF >> nginx_setup/docker-compose.yml
    networks:
      - nginx_network

EOF

    for i in $(seq 1 $CURRENT_CONTAINERS); do
        cat <<EOF >> nginx_setup/docker-compose.yml
  nginx_$i:
    build:
      context: ./nginx_$i
    container_name: nginx_$i
    networks:
      - nginx_network

EOF
    done

    cat <<EOF >> nginx_setup/docker-compose.yml
networks:
  nginx_network:
    driver: bridge
EOF
}

build_image() {
    create_files
    $COMPOSE_CMD -f nginx_setup/docker-compose.yml build --no-cache
}

deploy_containers() {
    $COMPOSE_CMD -f nginx_setup/docker-compose.yml up -d
}

update_balancer() {
    UPSTREAM=""
    for i in $(seq 1 $CURRENT_CONTAINERS); do
        UPSTREAM="${UPSTREAM}        server nginx_$i:80;"
    done

    cat <<EOF > nginx_setup/nginx.conf
events { }

http {
    log_format main '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';
    access_log /var/log/nginx/access.log main;

    upstream app_servers {
        least_conn;
$UPSTREAM
    }

    server {
        listen 80;
        location / {
            proxy_pass http://app_servers;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOF

    echo "Contenido de nginx.conf:"
    cat nginx_setup/nginx.conf

    docker cp nginx_setup/nginx.conf nginx_balancer:/etc/nginx/nginx.conf
    docker exec -it nginx_balancer nginx -s reload
}

start_logging() {
    docker logs -f nginx_balancer &
}

start() {
    load_settings
    echo "Iniciando con $CURRENT_CONTAINERS contenedores."
    remove_old_containers
    build_image
    deploy_containers
    update_balancer
    start_logging
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

cleanup() {
    remove_old_containers
    docker container prune -f
    docker volume prune -f
    docker rmi $(docker images -f "dangling=true" -q)
    rm -rf nginx_setup
}

check_compose_command

case "$ACTION" in
    start)
        if [ -n "$NUM_CONTAINERS" ]; then
            CURRENT_CONTAINERS=$NUM_CONTAINERS
            save_settings
        fi
        start
        ;;
    stop)
        remove_old_containers
        ;;
    scaleup)
        if [ -n "$NUM_CONTAINERS" ]; then
            scaleup
        else
            echo "Uso: $0 scaleup NUM_CONTAINERS"
        fi
        ;;
    scaledown)
        if [ -n "$NUM_CONTAINERS" ]; then
            scaledown
        else
            echo "Uso: $0 scaledown NUM_CONTAINERS"
        fi
        ;;
    cleanup)
        cleanup
        ;;
    *)
        echo "Uso: $0 {start|stop|scaleup|scaledown|cleanup} NUM_CONTAINERS"
        ;;
esac
