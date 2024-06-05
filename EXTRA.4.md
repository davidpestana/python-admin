### Ejercicio Complementario: Auditoría y Corrección de Permisos en un Sistema de Archivos

#### Objetivo:
Desarrollar un script avanzado que realice una auditoría completa de permisos en un sistema de archivos, compare los permisos actuales con una configuración deseada, y genere un informe detallado con las discrepancias. Luego, el script debe ofrecer la opción de corregir automáticamente estos permisos.

### Descripción del Ejercicio:

El script tendrá las siguientes funcionalidades:
1. **Auditoría de Permisos:** Recorrerá un directorio especificado y sus subdirectorios, registrando los permisos actuales de todos los archivos y directorios.
2. **Comparación con Permisos Deseados:** Comparará los permisos actuales con un conjunto de permisos deseados especificados en un archivo de configuración.
3. **Generación de Informes:** Generará un informe detallado que enumere las discrepancias entre los permisos actuales y los deseados.
4. **Corrección de Permisos:** Ofrecerá la opción de corregir automáticamente los permisos para que coincidan con los permisos deseados.

### Paso 1: Crear el Archivo de Configuración de Permisos

El archivo de configuración, `permisos_deseados.json`, contendrá una lista de archivos y directorios junto con sus permisos deseados.

**Ejemplo de `permisos_deseados.json`:**

```json
{
    "/ruta/al/directorio1": "755",
    "/ruta/al/directorio1/archivo1.txt": "644",
    "/ruta/al/directorio2": "755",
    "/ruta/al/directorio2/archivo2.txt": "644"
}
```

### Paso 2: Crear el Script de Auditoría y Corrección de Permisos

**Script Completo: Auditoría y Corrección de Permisos**

```python
import os
import json
import subprocess

def cargar_permisos_deseados(ruta_archivo):
    with open(ruta_archivo, 'r') as archivo:
        return json.load(archivo)

def auditar_permisos(directorio, permisos_deseados):
    auditoria = {}
    for root, dirs, files in os.walk(directorio):
        for nombre in dirs + files:
            ruta = os.path.join(root, nombre)
            permisos_actuales = oct(os.stat(ruta).st_mode & 0o777)
            auditoria[ruta] = permisos_actuales
    return auditoria

def comparar_permisos(auditoria, permisos_deseados):
    diferencias = {}
    for ruta, permisos_deseados in permisos_deseados.items():
        permisos_actuales = auditoria.get(ruta, None)
        if permisos_actuales != oct(int(permisos_deseados, 8)):
            diferencias[ruta] = (permisos_actuales, oct(int(permisos_deseados, 8)))
    return diferencias

def generar_informe(diferencias, ruta_informe):
    with open(ruta_informe, 'w') as informe:
        for ruta, (permisos_actuales, permisos_deseados) in diferencias.items():
            informe.write(f"{ruta}: Actual = {permisos_actuales}, Deseado = {permisos_deseados}\n")

def corregir_permisos(diferencias):
    for ruta, (_, permisos_deseados) in diferencias.items():
        subprocess.run(['sudo', 'chmod', permisos_deseados[2:], ruta], check=True)
        print(f"Permisos corregidos para {ruta}: {permisos_deseados}")

if __name__ == "__main__":
    directorio = input("Introduce la ruta del directorio para auditar: ")
    ruta_permisos_deseados = input("Introduce la ruta del archivo de configuración de permisos deseados (JSON): ")
    ruta_informe = input("Introduce la ruta del archivo de informe de auditoría: ")

    permisos_deseados = cargar_permisos_deseados(ruta_permisos_deseados)
    auditoria = auditar_permisos(directorio, permisos_deseados)
    diferencias = comparar_permisos(auditoria, permisos_deseados)

    generar_informe(diferencias, ruta_informe)
    print(f"Auditoría completada. Informe generado en {ruta_informe}")

    corregir = input("¿Deseas corregir los permisos automáticamente? (s/n): ")
    if corregir.lower() == 's':
        corregir_permisos(diferencias)
        print("Permisos corregidos.")
    else:
        print("No se realizaron cambios en los permisos.")
```

### Desglose del Script:

1. **Carga de Permisos Deseados:**
   - `cargar_permisos_deseados(ruta_archivo)`: Carga los permisos deseados desde un archivo JSON.

2. **Auditoría de Permisos:**
   - `auditar_permisos(directorio, permisos_deseados)`: Recorre el directorio y subdirectorios, registrando los permisos actuales de todos los archivos y directorios.

3. **Comparación de Permisos:**
   - `comparar_permisos(auditoria, permisos_deseados)`: Compara los permisos actuales con los permisos deseados y registra las discrepancias.

4. **Generación de Informe:**
   - `generar_informe(diferencias, ruta_informe)`: Genera un informe detallado de las discrepancias entre los permisos actuales y los deseados.

5. **Corrección de Permisos:**
   - `corregir_permisos(diferencias)`: Ofrece la opción de corregir automáticamente los permisos para que coincidan con los permisos deseados.

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `auditoria_permisos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `auditoria_permisos.py`.
   - Ejecuta el script:

     ```shell
     sudo python auditoria_permisos.py
     ```

3. **Interacción con el script:**
   - Introduce las rutas del directorio a auditar, el archivo JSON de configuración de permisos deseados y la ruta del archivo de informe de auditoría cuando se te solicite.
   - Decide si deseas corregir automáticamente los permisos según las discrepancias encontradas.

### Conclusión

Este ejercicio complementario ofrece a los alumnos avanzados la oportunidad de desarrollar una herramienta completa y útil para la auditoría y corrección de permisos en un sistema de archivos. El script combina varios conceptos y técnicas, como el uso de JSON para la configuración, la manipulación de permisos de archivos y la generación de informes detallados, proporcionando una solución práctica para la administración de sistemas.