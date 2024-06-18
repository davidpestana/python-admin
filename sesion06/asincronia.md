### **Asincronía en Bash**

La asincronía en Bash permite ejecutar múltiples tareas en paralelo, lo que puede mejorar la eficiencia y el rendimiento de los scripts al permitir que varias operaciones se realicen simultáneamente. Esto es especialmente útil en tareas de administración de sistemas donde se pueden ejecutar varios comandos o scripts independientes al mismo tiempo.

#### **Objetivos:**
- Ejecutar comandos en segundo plano.
- Utilizar `wait` para sincronizar tareas.
- Capturar la salida de tareas asíncronas.
- Usar `&` y `wait` para manejar procesos en segundo plano.

### **Ejercicio: Script con Tareas Asíncronas**

Vamos a crear un script que realiza varias tareas en paralelo utilizando técnicas de asincronía en Bash.

#### **Paso 1: Ejecutar Comandos en Segundo Plano**

Para ejecutar un comando en segundo plano, se añade `&` al final del comando. Podemos capturar el PID del proceso en segundo plano y usar `wait` para sincronizarlo.

**Ejemplo Básico de Comando en Segundo Plano:**

```bash
#!/bin/bash

# Función para simular una tarea prolongada
tarea_larga() {
    echo "Iniciando tarea larga ($1)..."
    sleep $1
    echo "Tarea larga ($1) completada."
}

# Ejecutar tareas en segundo plano
tarea_larga 3 &
PID1=$!
tarea_larga 5 &
PID2=$!

# Esperar a que todas las tareas en segundo plano terminen
wait $PID1
wait $PID2

echo "Todas las tareas han terminado."
```

Guarda este código en un archivo llamado `asincronia.sh` y hazlo ejecutable:

```bash
chmod +x asincronia.sh
```

Ejecuta el script:

```bash
./asincronia.sh
```

#### **Paso 2: Capturar la Salida de Comandos en Segundo Plano**

Podemos redirigir la salida de los comandos en segundo plano a archivos para capturar su salida.

**Ejemplo de Captura de Salida:**

```bash
#!/bin/bash

# Función para simular una tarea prolongada
tarea_larga() {
    echo "Iniciando tarea larga ($1)..."
    sleep $1
    echo "Tarea larga ($1) completada."
}

# Ejecutar tareas en segundo plano y redirigir la salida a archivos
tarea_larga 3 > salida1.txt &
PID1=$!
tarea_larga 5 > salida2.txt &
PID2=$!

# Esperar a que todas las tareas en segundo plano terminen
wait $PID1
wait $PID2

echo "Todas las tareas han terminado."
echo "Salida de tarea 1:"
cat salida1.txt
echo "Salida de tarea 2:"
cat salida2.txt
```

Guarda y ejecuta el script:

```bash
./asincronia.sh
```

#### **Paso 3: Uso Avanzado de Asincronía en un Script Complejo**

Vamos a crear un script que realiza varias tareas comunes de administración de sistemas en paralelo, como análisis de logs, comprobación del estado de servicios y copia de seguridad de archivos.

**Script Complejo con Tareas Asíncronas:**

```bash
#!/bin/bash

# Función para analizar un archivo de logs
analizar_logs() {
    echo "Iniciando análisis de logs..."
    grep "error" /var/log/syslog > errores.txt
    echo "Análisis de logs completado."
}

# Función para verificar el estado de servicios
verificar_servicios() {
    echo "Verificando el estado de servicios..."
    for servicio in sshd cron apache2; do
        if systemctl is-active --quiet $servicio; then
            echo "El servicio $servicio está activo."
        else
            echo "El servicio $servicio está inactivo o no está instalado."
        fi
    done
    echo "Verificación de servicios completada."
}

# Función para realizar una copia de seguridad
copia_seguridad() {
    echo "Iniciando copia de seguridad..."
    tar -czf backup.tar.gz /etc /home
    echo "Copia de seguridad completada."
}

# Ejecutar tareas en segundo plano
analizar_logs &
PID1=$!
verificar_servicios &
PID2=$!
copia_seguridad &
PID3=$!

# Esperar a que todas las tareas en segundo plano terminen
wait $PID1
wait $PID2
wait $PID3

echo "Todas las tareas han terminado."
```

Guarda y ejecuta el script:

```bash
chmod +x asincronia.sh
./asincronia.sh
```

### **Explicación del Script**

1. **Función `analizar_logs`:**
   - Analiza el archivo de logs `/var/log/syslog` en busca de errores y guarda el resultado en `errores.txt`.

2. **Función `verificar_servicios`:**
   - Verifica el estado de servicios críticos (`sshd`, `cron`, `apache2`) y muestra su estado.

3. **Función `copia_seguridad`:**
   - Realiza una copia de seguridad de los directorios `/etc` y `/home`, comprimiéndolos en `backup.tar.gz`.

4. **Ejecución de Tareas en Segundo Plano:**
   - Cada función se ejecuta en segundo plano añadiendo `&` al final de su llamada.
   - Se capturan los PID de los procesos en segundo plano.

5. **Sincronización con `wait`:**
   - Se usa `wait` para esperar a que cada tarea en segundo plano termine antes de continuar.

### **Conclusión**

Hemos aprendido a ejecutar tareas en segundo plano en Bash utilizando técnicas de asincronía. Esto permite realizar múltiples operaciones simultáneamente, mejorando la eficiencia y el rendimiento de los scripts. Las técnicas de asincronía son especialmente útiles en tareas de administración de sistemas, donde se pueden ejecutar varios comandos o scripts independientes al mismo tiempo.