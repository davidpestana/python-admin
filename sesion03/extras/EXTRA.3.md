### Ejercicio Extra: Escáner de Puertos

Este ejercicio consiste en crear un escáner de puertos que verifica qué puertos están abiertos en un servidor específico. Esta herramienta es útil para administradores de sistemas que necesitan comprobar la seguridad de sus redes y servidores.

### Objetivos:
1. Aprender a utilizar el módulo `socket` para realizar operaciones de red.
2. Crear un script que escanee un rango de puertos en un servidor y reporte cuáles están abiertos.
3. Aplicar conceptos de concurrencia para mejorar la eficiencia del escaneo.

### Recursos Necesarios:
- Un entorno de desarrollo Python.
- Conocimientos básicos de redes y puertos.
- Un servidor o IP para escanear.

### Paso 1: Instalación de Requerimientos

Para este ejercicio, necesitamos el módulo `socket` (que viene con Python) y el módulo `concurrent.futures` para manejar concurrencia.

### Paso 2: Crear un Escáner de Puertos Básico

Empezamos creando un escáner de puertos básico que verifica un puerto a la vez.

**Ejemplo Inicial: Escanear un Puerto**

```python
import socket

def escanear_puerto(ip, puerto):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    resultado = sock.connect_ex((ip, puerto))
    if resultado == 0:
        print(f"Puerto {puerto} está abierto")
    else:
        print(f"Puerto {puerto} está cerrado")
    sock.close()

# Ejemplo de uso
escanear_puerto('127.0.0.1', 80)
```

- `socket.connect_ex((ip, puerto))` devuelve 0 si el puerto está abierto, y otro valor si está cerrado o inaccesible.

### Paso 3: Escanear un Rango de Puertos

Extendemos el script para escanear un rango de puertos.

**Ejemplo: Escanear un Rango de Puertos**

```python
def escanear_rango_puertos(ip, inicio, fin):
    for puerto in range(inicio, fin + 1):
        escanear_puerto(ip, puerto)

# Ejemplo de uso
escanear_rango_puertos('127.0.0.1', 75, 85)
```

### Paso 4: Mejorar la Eficiencia con Concurrencia

Utilizamos `concurrent.futures.ThreadPoolExecutor` para escanear puertos concurrentemente, lo que acelera significativamente el proceso.

**Ejemplo: Escanear Puertos Concurrentemente**

```python
import concurrent.futures

def escanear_rango_puertos_concurrente(ip, inicio, fin):
    with concurrent.futures.ThreadPoolExecutor(max_workers=100) as executor:
        futures = {executor.submit(escanear_puerto, ip, puerto): puerto for puerto in range(inicio, fin + 1)}
        for future in concurrent.futures.as_completed(futures):
            puerto = futures[future]
            try:
                future.result()
            except Exception as exc:
                print(f"Puerto {puerto} generó una excepción: {exc}")

# Ejemplo de uso
escanear_rango_puertos_concurrente('127.0.0.1', 75, 85)
```

### Ejemplo Completo: Escáner de Puertos

Combina todo lo aprendido en un script completo.

```python
import socket
import concurrent.futures

def escanear_puerto(ip, puerto):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    resultado = sock.connect_ex((ip, puerto))
    if resultado == 0:
        print(f"Puerto {puerto} está abierto")
    sock.close()

def escanear_rango_puertos_concurrente(ip, inicio, fin):
    with concurrent.futures.ThreadPoolExecutor(max_workers=100) as executor:
        futures = {executor.submit(escanear_puerto, ip, puerto): puerto for puerto in range(inicio, fin + 1)}
        for future in concurrent.futures.as_completed(futures):
            puerto = futures[future]
            try:
                future.result()
            except Exception as exc:
                print(f"Puerto {puerto} generó una excepción: {exc}")

if __name__ == "__main__":
    ip = input("Introduce la dirección IP a escanear: ")
    inicio = int(input("Introduce el puerto de inicio del rango: "))
    fin = int(input("Introduce el puerto final del rango: "))
    escanear_rango_puertos_concurrente(ip, inicio, fin)
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `escaner_puertos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `escaner_puertos.py`.
   - Ejecuta el script:

     ```shell
     python escaner_puertos.py
     ```

3. **Interacción con el script:**
   - Introduce la dirección IP a escanear y el rango de puertos cuando se te solicite.

### Conclusión

Este ejercicio extra permite a los alumnos crear una herramienta útil para la seguridad y administración de redes. El escáner de puertos puede ayudar a identificar puertos abiertos que podrían ser vulnerables a ataques. Este ejercicio también introduce el uso de concurrencia para mejorar la eficiencia de las tareas de red, lo que es una habilidad importante para desarrolladores y administradores de sistemas. Continúa expandiendo este script con características adicionales como la generación de informes o la integración con otras herramientas de seguridad para crear una solución más robusta.