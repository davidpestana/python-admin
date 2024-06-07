### 2. Instalación y Uso con Docker

#### Instalación

Si prefieres trabajar con Python utilizando contenedores Docker, puedes instalar Docker en tu sistema operativo siguiendo las instrucciones específicas para tu plataforma en [Docker Documentation](https://docs.docker.com/get-docker/).

Una vez que Docker esté instalado, puedes descargar una imagen de Python desde Docker Hub ejecutando el siguiente comando en tu terminal:

```bash
docker pull python:latest
```

Esto descargará la última imagen de Python disponible en Docker Hub.

#### Uso Básico

Para ejecutar un contenedor de Python interactivo, puedes utilizar el siguiente comando:

```bash
docker run -it --rm python
```

Este comando ejecutará un contenedor interactivo de Python y se eliminará automáticamente cuando salgas del intérprete de Python.

#### Montaje de Volumen

Si necesitas acceder a archivos desde tu sistema de archivos local dentro del contenedor, puedes montar un volumen utilizando la opción `-v`:

```bash
docker run -it --rm -v /ruta/a/tu/carpeta:/mnt python
```

Esto montará la carpeta `/ruta/a/tu/carpeta` de tu sistema de archivos local en `/mnt` dentro del contenedor.

#### Uso con Docker Compose

Para simplificar la gestión de contenedores Docker, puedes utilizar Docker Compose. Aquí tienes un ejemplo de archivo `docker-compose.yml` para ejecutar un contenedor de Python:

```yaml
version: '3'
services:
  python:
    image: python:latest
    volumes:
      - /ruta/a/tu/carpeta:/mnt
    command: ["python", "/mnt/tu_script.py"]
```

Puedes ejecutar este servicio utilizando el siguiente comando:

```bash
docker-compose up
```

Este comando iniciará un contenedor de Python y ejecutará el script `tu_script.py` ubicado en la carpeta montada `/ruta/a/tu/carpeta`.