### Práctica: Integración en Bash con `curl` y `jq` para Validar Health y Ping de Servicios

#### **Objetivos:**
- Aprender a utilizar `curl` para realizar solicitudes HTTP a servicios web.
- Aprender a utilizar `jq` para procesar y manipular respuestas JSON.
- Crear una interfaz visual en el terminal utilizando colores para mostrar el estado de los servicios, similar a `htop`.

### **Ejercicio: Validador de Health y Ping de Servicios**

**Descripción:** 
Crear un script que lea un archivo JSON con una lista de servicios web, realice solicitudes para verificar su estado de salud y ping, y muestre los resultados en una interfaz de terminal con colores.

1. **Preparar el archivo JSON con los servicios:**

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

2. **Script para validar health y ping de servicios:**

   Crear un script `service_health_check.sh`:
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
       local name=$2
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
       local name=$2
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
       check_health "$url" "$name"

       echo -n "Ping: "
       check_ping "$ping_url" "$name"
   done
   ```

3. **Dar permisos de ejecución al script:**
   ```bash
   chmod +x service_health_check.sh
   ```

4. **Ejecutar el script:**
   ```bash
   ./service_health_check.sh
   ```

### Explicación del Script:

1. **Colores para la Interfaz:**
   - Definimos variables para los colores (`GREEN`, `RED`, `YELLOW`, `NC`).
   - Estas variables se utilizan para colorear la salida del terminal.

2. **Leer el Archivo JSON:**
   - Utilizamos `jq` para leer y procesar el archivo JSON que contiene los servicios.
   - `jq -c '.[]' services.json` lee cada objeto en el archivo JSON y lo devuelve en una sola línea.

3. **Funciones de Verificación:**
   - `check_health` y `check_ping` son funciones que toman la URL y el nombre del servicio como argumentos y utilizan `curl` para realizar solicitudes HTTP.
   - `curl -o /dev/null -s -w "%{http_code}\n"` realiza una solicitud y devuelve solo el código de estado HTTP.
   - Basándonos en el código de estado, imprimimos "HEALTHY" o "UNHEALTHY" para el estado de salud y "REACHABLE" o "UNREACHABLE" para el ping, con el color correspondiente.

4. **Iteración sobre los Servicios:**
   - Iteramos sobre cada servicio en el archivo JSON, extraemos su nombre y URLs, y llamamos a las funciones de verificación.

5. **Interfaz de Terminal:**
   - La salida del script está diseñada para ser visualmente clara y fácil de leer, utilizando colores para indicar el estado de cada servicio.

Este ejercicio enseña cómo utilizar `curl` y `jq` para interactuar con APIs y procesar datos JSON, además de proporcionar una interfaz de usuario amigable en el terminal para la administración de sistemas.