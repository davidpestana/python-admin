### Sesión 4: Gestión de Usuarios y Permisos

#### Objetivos:
1. Aprender a gestionar usuarios y permisos del sistema.
2. Utilizar módulos específicos de Python para la gestión de usuarios y grupos.
3. Manipular permisos de archivos utilizando `os.chmod`.

### Punto 1.b: Manipulación de Permisos de Archivos con `os.chmod`

### Introducción a los Permisos de Archivos en Unix

En sistemas Unix-like, cada archivo tiene un conjunto de permisos asociados que determinan quién puede leer, escribir o ejecutar el archivo. Estos permisos se dividen en tres categorías:
- **Usuario (Owner):** El propietario del archivo.
- **Grupo (Group):** Los miembros del grupo al que pertenece el archivo.
- **Otros (Others):** Todos los demás usuarios.

Cada categoría tiene tres tipos de permisos:
- **Lectura (Read - `r`):** Permite leer el contenido del archivo.
- **Escritura (Write - `w`):** Permite modificar el contenido del archivo.
- **Ejecución (Execute - `x`):** Permite ejecutar el archivo (si es un script o un programa).

Los permisos se representan comúnmente en formato octal, donde:
- `r` = 4
- `w` = 2
- `x` = 1

### Uso de `os.chmod` para Manipular Permisos de Archivos

El módulo `os` en Python proporciona la función `os.chmod()` para cambiar los permisos de archivos. La sintaxis básica es:

```python
import os

os.chmod(path, mode)
```

- `path`: La ruta al archivo cuyo permisos deseas cambiar.
- `mode`: El nuevo modo de permisos en formato octal.

### Ejemplos de Manipulación de Permisos

#### Cambiar Permisos de Lectura, Escritura y Ejecución

**Ejemplo: Dar Permisos de Lectura, Escritura y Ejecución al Propietario**

```python
import os

def cambiar_permisos_archivo(ruta_archivo):
    # Permisos de lectura, escritura y ejecución para el propietario
    permisos = 0o700
    os.chmod(ruta_archivo, permisos)
    print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")

# Ejemplo de uso
cambiar_permisos_archivo('mi_archivo.txt')
```

- `0o700` en octal representa permisos de lectura, escritura y ejecución para el propietario (usuario).

#### Cambiar Permisos para Grupo y Otros

**Ejemplo: Dar Permisos de Lectura al Grupo y Otros**

```python
import os

def cambiar_permisos_archivo(ruta_archivo):
    # Permisos de lectura para el grupo y otros
    permisos = 0o744
    os.chmod(ruta_archivo, permisos)
    print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")

# Ejemplo de uso
cambiar_permisos_archivo('mi_archivo.txt')
```

- `0o744` en octal representa permisos de lectura, escritura y ejecución para el propietario, y solo lectura para el grupo y otros.

### Combinando Permisos

**Ejemplo: Dar Permisos de Lectura y Ejecución al Grupo y Otros**

```python
import os

def cambiar_permisos_archivo(ruta_archivo):
    # Permisos de lectura y ejecución para el grupo y otros
    permisos = 0o755
    os.chmod(ruta_archivo, permisos)
    print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")

# Ejemplo de uso
cambiar_permisos_archivo('mi_archivo.txt')
```

- `0o755` en octal representa permisos de lectura, escritura y ejecución para el propietario, y permisos de lectura y ejecución para el grupo y otros.

### Leer Permisos Actuales del Archivo

Para verificar los permisos actuales de un archivo, puedes usar `os.stat()` y la función `stat`.

**Ejemplo: Leer Permisos Actuales del Archivo**

```python
import os
import stat

def leer_permisos_archivo(ruta_archivo):
    permisos = os.stat(ruta_archivo).st_mode
    print(f"Permisos actuales para {ruta_archivo}: {oct(permisos)}")

# Ejemplo de uso
leer_permisos_archivo('mi_archivo.txt')
```

- `os.stat(ruta_archivo).st_mode` devuelve los permisos actuales del archivo en formato octal.

### Ejemplo Completo: Cambiar y Verificar Permisos de Archivos

Combina todo lo aprendido en un script completo que permita cambiar y verificar los permisos de un archivo.

```python
import os
import stat

def cambiar_permisos_archivo(ruta_archivo, permisos):
    os.chmod(ruta_archivo, permisos)
    print(f"Permisos cambiados a {oct(permisos)} para {ruta_archivo}")

def leer_permisos_archivo(ruta_archivo):
    permisos = os.stat(ruta_archivo).st_mode
    print(f"Permisos actuales para {ruta_archivo}: {oct(permisos & 0o777)}")  # Solo mostramos los últimos tres dígitos

if __name__ == "__main__":
    archivo = 'mi_archivo.txt'
    
    # Leer permisos actuales
    leer_permisos_archivo(archivo)
    
    # Cambiar permisos a 755
    cambiar_permisos_archivo(archivo, 0o755)
    
    # Verificar cambios
    leer_permisos_archivo(archivo)
    
    # Cambiar permisos a 700
    cambiar_permisos_archivo(archivo, 0o700)
    
    # Verificar cambios
    leer_permisos_archivo(archivo)
```

### Ejecución del Script

1. **Guardar el script:**
   - Guarda el script en un archivo llamado `cambiar_permisos.py`.

2. **Ejecutar el script:**
   - Abre la terminal y navega al directorio donde guardaste `cambiar_permisos.py`.
   - Ejecuta el script:

     ```shell
     python cambiar_permisos.py
     ```

### Conclusión

En este punto, has aprendido a manipular permisos de archivos utilizando `os.chmod` en Python. Esta habilidad es crucial para la gestión de permisos en sistemas Unix-like, permitiendo a los administradores de sistemas automatizar la configuración de permisos de archivos y directorios de manera eficiente. Continúa practicando con diferentes combinaciones de permisos para familiarizarte con su uso y comportamiento.