### Sesión 5: Monitoreo y Mantenimiento del Sistema

#### Objetivos:
1. Aprender a monitorear los recursos del sistema utilizando Python.
2. Utilizar módulos como `psutil` para obtener información sobre el uso del sistema.

### Monitoreo del Sistema con `psutil`

#### Introducción a `psutil`

`psutil` (Python System and Process Utilities) es un módulo de Python que proporciona una interfaz para recuperar información sobre los procesos en ejecución y la utilización del sistema (CPU, memoria, discos, red, sensores) en una manera portable utilizando Python. Es muy útil para escribir scripts de monitoreo y administración del sistema.

### Instalación de `psutil`

Antes de comenzar a usar `psutil`, necesitas instalarlo. Puedes hacerlo utilizando `pip`:

```shell
pip install psutil
```

### Funcionalidades Clave de `psutil`

A continuación, se describen algunas de las funcionalidades clave de `psutil` que son útiles para el monitoreo del sistema.

#### 1. Monitoreo de la CPU

`psutil` proporciona varias funciones para obtener información sobre el uso de la CPU.

**Obtener el porcentaje de uso de la CPU:**

```python
import psutil

uso_cpu = psutil.cpu_percent(interval=1)
print(f"Uso de la CPU: {uso_cpu}%")
```

- `psutil.cpu_percent(interval=1)`: Mide el uso de la CPU durante un intervalo de 1 segundo.

**Obtener el porcentaje de uso de la CPU por núcleo:**

```python
uso_cpu_por_nucleo = psutil.cpu_percent(interval=1, percpu=True)
print(f"Uso de la CPU por núcleo: {uso_cpu_por_nucleo}")
```

- `psutil.cpu_percent(interval=1, percpu=True)`: Mide el uso de la CPU por núcleo durante un intervalo de 1 segundo.

#### 2. Monitoreo de la Memoria

`psutil` también proporciona funciones para obtener información sobre el uso de la memoria.

**Obtener el uso de la memoria virtual:**

```python
memoria_virtual = psutil.virtual_memory()
print(f"Uso de la memoria virtual: {memoria_virtual.percent}%")
```

- `psutil.virtual_memory()`: Devuelve un objeto con varias estadísticas sobre la memoria virtual, como el porcentaje de uso, la memoria total, la memoria disponible, etc.

**Obtener el uso de la memoria swap:**

```python
memoria_swap = psutil.swap_memory()
print(f"Uso de la memoria swap: {memoria_swap.percent}%")
```

- `psutil.swap_memory()`: Devuelve un objeto con varias estadísticas sobre la memoria swap, como el porcentaje de uso, la memoria total, la memoria usada, etc.

#### 3. Monitoreo del Disco

`psutil` proporciona funciones para obtener información sobre el uso del disco.

**Obtener el uso del disco:**

```python
uso_disco = psutil.disk_usage('/')
print(f"Uso del disco: {uso_disco.percent}%")
```

- `psutil.disk_usage('/')`: Devuelve un objeto con varias estadísticas sobre el uso del disco, como el porcentaje de uso, el espacio total, el espacio usado, etc.

**Obtener las particiones del disco:**

```python
particiones = psutil.disk_partitions()
for particion in particiones:
    print(f"Dispositivo: {particion.device}, Punto de montaje: {particion.mountpoint}, Tipo de sistema de archivos: {particion.fstype}")
```

- `psutil.disk_partitions()`: Devuelve una lista de todas las particiones montadas en el sistema.

#### 4. Monitoreo de la Red

`psutil` también proporciona funciones para obtener información sobre la red.

**Obtener estadísticas de la red:**

```python
estadisticas_red = psutil.net_io_counters()
print(f"Bytes enviados: {estadisticas_red.bytes_sent}, Bytes recibidos: {estadisticas_red.bytes_recv}")
```

- `psutil.net_io_counters()`: Devuelve un objeto con estadísticas de entrada/salida de la red, como bytes enviados, bytes recibidos, paquetes enviados, paquetes recibidos, etc.

**Obtener conexiones de red:**

```python
conexiones_red = psutil.net_connections()
for conexion in conexiones_red:
    print(f"Tipo: {conexion.type}, Dirección local: {conexion.laddr}, Dirección remota: {conexion.raddr}, Estado: {conexion.status}")
```

- `psutil.net_connections()`: Devuelve una lista de todas las conexiones de red actuales.

### Ejemplo Completo: Monitoreo del Sistema

Combina todo lo aprendido en un script completo que monitoree varios aspectos del sistema.

**Script Completo: Monitoreo del Sistema**

```python
import psutil

def monitorear_cpu():
    uso_cpu = psutil.cpu_percent(interval=1)
    uso_cpu_por_nucleo = psutil.cpu_percent(interval=1, percpu=True)
    print(f"Uso de la CPU: {uso_cpu}%")
    print(f"Uso de la CPU por núcleo: {uso_cpu_por_nucleo}")

def monitorear_memoria():
    memoria_virtual = psutil.virtual_memory()
    memoria_swap = psutil.swap_memory()
    print(f"Uso de la memoria virtual: {memoria_virtual.percent}%")
    print(f"Uso de la memoria swap: {memoria_swap.percent}%")

def monitorear_disco():
    uso_disco = psutil.disk_usage('/')
    particiones = psutil.disk_partitions()
    print(f"Uso del disco: {uso_disco.percent}%")
    for particion in particiones:
        print(f"Dispositivo: {particion.device}, Punto de montaje: {particion.mountpoint}, Tipo de sistema de archivos: {particion.fstype}")

def monitorear_red():
    estadisticas_red = psutil.net_io_counters()
    conexiones_red = psutil.net_connections()
    print(f"Bytes enviados: {estadisticas_red.bytes_sent}, Bytes recibidos: {estadisticas_red.bytes_recv}")
    for conexion in conexiones_red:
        print(f"Tipo: {conexion.type}, Dirección local: {conexion.laddr}, Dirección remota: {conexion.raddr}, Estado: {conexion.status}")

if __name__ == "__main__":
    print("Monitoreo del sistema:")
    print("\nMonitoreo de la CPU:")
    monitorear_cpu()
    print("\nMonitoreo de la Memoria:")
    monitorear_memoria()
    print("\nMonitoreo del Disco:")
    monitorear_disco()
    print("\nMonitoreo de la Red:")
    monitorear_red()
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `monitoreo_sistema.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `monitoreo_sistema.py`.
   - Ejecuta el script:

     ```shell
     python monitoreo_sistema.py
     ```

### Conclusión

En esta sesión, has aprendido cómo utilizar el módulo `psutil` para monitorear varios aspectos del sistema, como la CPU, la memoria, el disco y la red. Estas habilidades son esenciales para la administración y el mantenimiento eficiente de sistemas. Continúa practicando y expandiendo estos scripts para incluir características adicionales, como alertas y registros automatizados, para crear soluciones de monitoreo más robustas.