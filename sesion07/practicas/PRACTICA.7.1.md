Aquí tienes el script corregido para que la salida en Markdown sea correcta y el script funcione sin problemas:

### Práctica: Integración en Bash con `curl` y `jq` para Validar Health y Ping de Servicios

#### **Objetivos:**
- Aprender a utilizar `curl` para realizar solicitudes HTTP a servicios web.
- Aprender a utilizar `jq` para procesar y manipular respuestas JSON.
- Crear una interfaz visual en el terminal utilizando colores para mostrar el estado de los servicios, similar a `htop`.

### **Ejercicio: Validador de Health y Ping de Servicios**

**Descripción:** 
Crear un script que lea un archivo JSON con una lista de servicios web, realice solicitudes para verificar su estado de salud y ping, y muestre los resultados en una interfaz de terminal con colores. El ejercicio se desarrollará en 3 iteraciones, cada una agregando más funcionalidad y mejorando el script.

### Preparar el Archivo JSON con los Servicios

Crear un archivo `services.json` con la siguiente estructura:

```json
[
    {
        "name": "Google",
        "url": "https://www.google.com",
        "ping_url": "https://www.google.com"
    },
    {
        "name": "GitHub",
        "url": "https://api.github.com",
        "ping_url": "https://github.com"
    },
    {
        "name": "StackOverflow",
        "url": "https://api.stackexchange.com/2.2/info?site=stackoverflow",
        "ping_url": "https://stackoverflow.com"
    }
]
```

### Iteración 1: Validar Health y Ping de Servicios

1. **Objetivo:**
   Leer el archivo JSON, realizar solicitudes HTTP para verificar el estado de salud y ping de los servicios, y mostrar los resultados en la terminal.

2. **Código:**
   ```bash
   #!/bin/bash

   # Colores para la interfaz
   GREEN='\033[0;32m'
   RED='\033[0;31m'
   YELLOW='\033[0;33m'
   NC='\033[0m' # No Color

   # Leer el archivo JSON
   SERVICES=$(jq -c '.[]' services.json)

   # Función para verificar el estado de salud
   check_health() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}HEALTHY${NC}"
       else
           echo -e "${RED}UNHEALTHY${NC} (Status Code: $status)"
       fi
   }

   # Función para verificar el ping
   check_ping() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}REACHABLE${NC}"
       else
           echo -e "${RED}UNREACHABLE${NC} (Status Code: $status)"
       fi
   }

   # Mostrar cabecera
   echo -e "${YELLOW}Service Health and Ping Status${NC}"
   echo "================================="

   # Iterar sobre los servicios y verificar estado
   echo "$SERVICES" | while IFS= read -r service; do
       name=$(echo "$service" | jq -r '.name')
       url=$(echo "$service" | jq -r '.url')
       ping_url=$(echo "$service" | jq -r '.ping_url')

       echo -e "\nChecking ${YELLOW}$name${NC}:"

       echo -n "Health: "
       check_health "$url"

       echo -n "Ping: "
       check_ping "$ping_url"
   done
   ```

3. **Explicación:**
   - Definimos variables para los colores (`GREEN`, `RED`, `YELLOW`, `NC`).
   - Utilizamos `jq` para leer y procesar el archivo JSON que contiene los servicios.
   - Las funciones `check_health` y `check_ping` utilizan `curl` para realizar solicitudes HTTP y devolver el estado de salud y ping.
   - Iteramos sobre cada servicio en el archivo JSON, extrayendo su nombre y URLs, y llamando a las funciones de verificación.

### Iteración 2: Actualizar la Pantalla Dinámicamente

1. **Objetivo:**
   Hacer que el script se ejecute continuamente, actualizando la pantalla cada pocos segundos para mostrar el estado actual de los servicios.

2. **Código:**
   ```bash
   #!/bin/bash

   # Colores para la interfaz
   GREEN='\033[0;32m'
   RED='\033[0;31m'
   YELLOW='\033[0;33m'
   NC='\033[0m' # No Color

   # Leer el archivo JSON
   SERVICES=$(jq -c '.[]' services.json)

   # Función para verificar el estado de salud
   check_health() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}HEALTHY${NC}"
       else
           echo -e "${RED}UNHEALTHY${NC} (Status Code: $status)"
       fi
   }

   # Función para verificar el ping
   check_ping() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}REACHABLE${NC}"
       else
           echo -e "${RED}UNREACHABLE${NC} (Status Code: $status)"
       fi
   }

   # Función para mostrar el estado de los servicios
   display_status() {
       clear
       echo -e "${YELLOW}Service Health and Ping Status${NC}"
       echo "================================="

       echo "$SERVICES" | while IFS= read -r service; do
           name=$(echo "$service" | jq -r '.name')
           url=$(echo "$service" | jq -r '.url')
           ping_url=$(echo "$service" | jq -r '.ping_url')

           echo -e "\nChecking ${YELLOW}$name${NC}:"

           echo -n "Health: "
           check_health "$url"

           echo -n "Ping: "
           check_ping "$ping_url"
       done
   }

   # Loop infinito para actualizar la pantalla
   while true; do
       display_status
       sleep 5
   done
   ```

3. **Explicación:**
   - Añadimos una función `display_status` para actualizar la pantalla y mostrar el estado de los servicios.
   - Utilizamos `clear` para limpiar la pantalla antes de cada actualización.
   - Creamos un loop infinito con `while true` que llama a `display_status` y duerme durante 5 segundos antes de actualizar la pantalla de nuevo.

### Iteración 3: Crear una Interfaz Tipo `htop`

1. **Objetivo:**
   Mejorar la interfaz para que se vea más como `htop`, con una tabla organizada que muestre el estado de los servicios.

2. **Código:**
   ```bash
   #!/bin/bash

   # Colores para la interfaz
   GREEN='\033[0;32m'
   RED='\033[0;31m'
   YELLOW='\033[0;33m'
   NC='\033[0m' # No Color

   # Leer el archivo JSON
   SERVICES=$(jq -c '.[]' services.json)

   # Función para verificar el estado de salud
   check_health() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}HEALTHY${NC}"
       else
           echo -e "${RED}UNHEALTHY${NC} (Status Code: $status)"
       fi
   }

   # Función para verificar el ping
   check_ping() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}REACHABLE${NC}"
       else
           echo -e "${RED}UNREACHABLE${NC} (Status Code: $status)"
       fi
   }

   # Función para mostrar el estado de los servicios
   display_status() {
       clear
       echo -e "${YELLOW}Service Health and Ping Status${NC}"
       echo "================================="
       echo -e "${YELLOW}Service Name\t\tHealth\t\tPing${NC}"
       echo "================================="

       echo "$SERVICES" | while IFS= read -r service; do
           name=$(echo "$service" | jq -r '.name')
           url=$(echo "$service" | jq -r '.url')
           ping_url=$(echo "$service" | jq -r '.ping_url')

           echo -n -e "${YELLOW}$name${NC}\t\t"
           echo -n "$(check_health "$url")\t\t"


           echo "$(check_ping "$ping_url")"
       done
   }

   # Loop infinito para actualizar la pantalla
   while true; do
       display_status
       sleep 5
   done
   ```

3. **Explicación:**
   - Añadimos una tabla con encabezados para organizar mejor la información.
   - Utilizamos `-e` con `echo` para permitir los caracteres de escape y formatear la salida en columnas.
   - Actualizamos la pantalla cada 5 segundos con el loop infinito.

Vamos a corregir el problema de los tabuladores para alinear correctamente las columnas y añadir paralelismo para mejorar la velocidad del script.

### Iteración 4: Mejorar la Alineación y Añadir Paralelismo

1. **Objetivo:**
   Corregir la alineación de las columnas y usar `xargs` para ejecutar las comprobaciones en paralelo, mejorando la eficiencia del script.

2. **Código:**
   ```bash
   #!/bin/bash

   # Colores para la interfaz
   GREEN='\033[0;32m'
   RED='\033[0;31m'
   YELLOW='\033[0;33m'
   NC='\033[0m' # No Color

   # Leer el archivo JSON
   SERVICES=$(jq -c '.[]' services.json)

   # Función para verificar el estado de salud
   check_health() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}HEALTHY${NC}"
       else
           echo -e "${RED}UNHEALTHY${NC} (Status Code: $status)"
       fi
   }

   # Función para verificar el ping
   check_ping() {
       local url=$1
       local status

       status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

       if [ "$status" -eq 200 ]; then
           echo -e "${GREEN}REACHABLE${NC}"
       else
           echo -e "${RED}UNREACHABLE${NC} (Status Code: $status)"
       fi
   }

   # Función para mostrar el estado de los servicios
   display_status() {
       clear
       echo -e "${YELLOW}Service Health and Ping Status${NC}"
       echo "================================="
       printf "%-20s %-20s %-20s\n" "Service Name" "Health" "Ping"
       echo "================================="

       echo "$SERVICES" | while IFS= read -r service; do
           name=$(echo "$service" | jq -r '.name')
           url=$(echo "$service" | jq -r '.url')
           ping_url=$(echo "$service" | jq -r '.ping_url')

           health_status=$(check_health "$url" &)
           ping_status=$(check_ping "$ping_url" &)
           wait

           printf "%-20s %-20s %-20s\n" "$name" "$health_status" "$ping_status"
       done
   }

   # Loop infinito para actualizar la pantalla
   while true; do
       display_status
       sleep 5
   done
   ```

3. **Explicación:**
   - Utilizamos `printf` en lugar de `echo` para alinear correctamente las columnas.
   - Añadimos el uso de `&` para ejecutar `check_health` y `check_ping` en paralelo.
   - Utilizamos `wait` para asegurarnos de que ambas comprobaciones hayan terminado antes de imprimir el resultado.

### Dar Permisos de Ejecución al Script

```bash
chmod +x service_health_check.sh
```

### Ejecutar el Script

```bash
./service_health_check.sh
```

### Explicación del Script:

- **Colores para la Interfaz:**
  - Definimos variables para los colores (`GREEN`, `RED`, `YELLOW`, `NC`) para colorear la salida del terminal.
- **Leer el Archivo JSON:**
  - Utilizamos `jq` para leer y procesar el archivo JSON que contiene los servicios.
- **Funciones de Verificación:**
  - `check_health` y `check_ping` utilizan `curl` para realizar solicitudes HTTP y devolver el estado de salud y ping.
- **Iteración sobre los Servicios:**
  - Iteramos sobre cada servicio en el archivo JSON, extrayendo su nombre y URLs, y llamando a las funciones de verificación.
- **Interfaz de Terminal:**
  - La salida del script está diseñada para ser visualmente clara y fácil de leer, utilizando colores y una tabla organizada para mostrar el estado de cada servicio.
  - La pantalla se actualiza cada 5 segundos para mostrar el estado actual de los servicios.
- **Paralelismo:**
  - Ejecutamos las comprobaciones de salud y ping en paralelo para mejorar la eficiencia del script. Utilizamos `wait` para asegurarnos de que ambas comprobaciones hayan terminado antes de imprimir el resultado.

Este ejercicio enseña cómo utilizar `curl` y `jq` para interactuar con APIs y procesar datos JSON, además de proporcionar una interfaz de usuario amigable en el terminal para la administración de sistemas. La adición de paralelismo mejora la eficiencia y la velocidad del script.
