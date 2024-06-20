Lo siento por la confusión anterior. Aquí tienes el bloque final con la estructura y los ejemplos completos:

---

# Integración con Herramientas Externas en Bash

## Introducción

En esta sección, aprenderás a utilizar herramientas externas como `curl`, `jq`, `wget`, `sed`, `awk`, y `parallel` para consumir APIs, procesar datos JSON, descargar archivos, y ejecutar comandos de manera sincrónica y asincrónica en scripts de Bash. Estas herramientas son muy útiles para automatizar tareas que requieren interacción con servicios web y procesamiento de datos.

## Herramientas Externas

### 1. `curl`

`curl` es una herramienta de línea de comandos para transferir datos desde o hacia un servidor utilizando varios protocolos. Es comúnmente utilizada para realizar solicitudes HTTP y obtener respuestas desde APIs.

#### Instalación

En la mayoría de las distribuciones de Linux, `curl` se instala por defecto. Si no es así, puedes instalarlo usando el siguiente comando:

```bash
sudo apt-get install curl      # Para distribuciones basadas en Debian/Ubuntu
sudo yum install curl          # Para distribuciones basadas en Red Hat/Fedora
```

#### Uso Básico

El siguiente comando realiza una solicitud GET simple a una API pública:

```bash
curl https://api.coindesk.com/v1/bpi/currentprice.json
```

### 2. `jq`

`jq` es una herramienta de línea de comandos para procesar y manipular datos JSON. Permite extraer datos específicos de una respuesta JSON de manera sencilla.

#### Instalación

Al igual que `curl`, `jq` se puede instalar fácilmente usando los siguientes comandos:

```bash
sudo apt-get install jq        # Para distribuciones basadas en Debian/Ubuntu
sudo yum install jq            # Para distribuciones basadas en Red Hat/Fedora
```

#### Uso Básico

El siguiente comando extrae el valor del campo `USD` desde una respuesta JSON obtenida por `curl`:

```bash
curl -s https://api.coindesk.com/v1/bpi/currentprice.json | jq '.bpi.USD.rate'
```

### 3. `wget`

`wget` es una herramienta de línea de comandos para descargar archivos desde la web. Soporta descargas a través de HTTP, HTTPS, y FTP.

#### Instalación

`wget` generalmente viene preinstalado en muchas distribuciones de Linux. Si no es así, puedes instalarlo usando:

```bash
sudo apt-get install wget      # Para distribuciones basadas en Debian/Ubuntu
sudo yum install wget          # Para distribuciones basadas en Red Hat/Fedora
```

#### Uso Básico

El siguiente comando descarga un archivo desde una URL especificada:

```bash
wget http://example.com/file.zip
```

### 4. `sed`

`sed` es una herramienta de línea de comandos utilizada para realizar operaciones básicas de edición de texto en un flujo de datos.

#### Instalación

`sed` viene preinstalado en la mayoría de las distribuciones de Linux.

#### Uso Básico

El siguiente comando reemplaza todas las ocurrencias de "foo" con "bar" en un archivo:

```bash
sed -i 's/foo/bar/g' archivo.txt
```

### 5. `awk`

`awk` es una herramienta de línea de comandos utilizada para la manipulación y análisis de datos en archivos de texto.

#### Instalación

`awk` viene preinstalado en la mayoría de las distribuciones de Linux.

#### Uso Básico

El siguiente comando imprime la primera y la tercera columna de un archivo de texto:

```bash
awk '{print $1, $3}' archivo.txt
```

### 6. `parallel`

`parallel` es una herramienta para ejecutar trabajos en paralelo utilizando una o más computadoras. Es útil para realizar tareas de manera asincrónica.

#### Instalación

Puedes instalar `parallel` usando el siguiente comando:

```bash
sudo apt-get install parallel      # Para distribuciones basadas en Debian/Ubuntu
sudo yum install parallel          # Para distribuciones basadas en Red Hat/Fedora
```

#### Uso Básico

El siguiente comando ejecuta múltiples comandos en paralelo:

```bash
echo -e "comando1\ncomando2\ncomando3" | parallel
```

## Ejemplos Prácticos

### 1. Uso Básico de `curl`

Realizar una solicitud GET a una API pública:

```bash
curl https://api.coindesk.com/v1/bpi/currentprice.json
```

### 2. Uso de `jq` para Procesar JSON

Extraer un valor específico desde la respuesta JSON obtenida por `curl`:

```bash
curl -s https://api.coindesk.com/v1/bpi/currentprice.json | jq '.bpi.USD.rate'
```

### 3. Uso de `wget` para Descargar Archivos

Descargar un archivo desde una URL:

```bash
wget https://example.com/archivo.zip
```

### 4. Uso de `sed` para Editar Archivos de Texto

Reemplazar todas las ocurrencias de "foo" con "bar" en un archivo:

```bash
sed -i 's/foo/bar/g' archivo.txt
```

### 5. Uso de `awk` para Manipular Datos

Imprimir la primera y tercera columna de un archivo de texto:

```bash
awk '{print $1, $3}' archivo.txt
```

### 6. Uso de `parallel` para Ejecución Asincrónica

Ejecutar múltiples comandos en paralelo:

```bash
echo -e "comando1\ncomando2\ncomando3" | parallel
```

### 7. Ejercicio Completo: Obtener Datos Meteorológicos y Procesarlos

1. **Obtener una API Key:**
   - Regístrate en [OpenWeatherMap](https://home.openweathermap.org/users/sign_up) y obtén una API key.

2. **Escribir el Script:**

   ```bash
   #!/bin/bash
   # Obtener datos de la API de OpenWeatherMap
   api_key="tu_api_key_aqui"
   ciudad="Madrid"
   response=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=$api_key&units=metric")
   
   # Procesar y mostrar la temperatura actual
   temperatura=$(echo $response | jq '.main.temp')
   echo "La temperatura actual en $ciudad es: $temperatura °C"
   ```

### 8. Uso Avanzado: Descargar, Procesar y Análisis en Paralelo

1. **Descargar Múltiples Archivos:**

   ```bash
   #!/bin/bash
   urls=("https://example.com/file1.zip" "https://example.com/file2.zip" "https://example.com/file3.zip")
   for url in "${urls[@]}"; do
       wget $url &
   done
   wait
   ```

2. **Procesar Archivos JSON en Paralelo:**

   ```bash
   #!/bin/bash
   urls=("https://api.coindesk.com/v1/bpi/currentprice.json" "https://api.coindesk.com/v1/bpi/historical/close.json")
   echo "${urls[@]}" | tr ' ' '\n' | parallel 'curl -s {} | jq .'
   ```

3. **Editar y Analizar Archivos de Texto:**

   ```bash
   #!/bin/bash
   files=("file1.txt" "file2.txt" "file3.txt")
   for file in "${files[@]}"; do
       sed -i 's/foo/bar/g' $file &
   done
   wait

   for file in "${files[@]}"; do
       awk '{print $1, $3}' $file &
   done
   wait
   ```

## Conclusión

El uso de herramientas externas como `curl`, `jq`, `wget`, `sed`, `awk`, y `parallel` en scripts de Bash permite realizar tareas complejas de forma sencilla y eficiente. Estas herramientas son esenciales para interactuar con APIs, procesar datos en formato JSON, descargar archivos, y ejecutar comandos de manera sincrónica y asincrónica, facilitando la automatización de numerosas tareas en el entorno de administración de sistemas.