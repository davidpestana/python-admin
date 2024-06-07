### Sesión 4: Gestión de Usuarios y Permisos

#### Objetivos:
1. Aprender a gestionar usuarios y permisos del sistema.
2. Utilizar módulos específicos de Python para la gestión de usuarios y grupos.

---

### Punto 1: Gestión de Usuarios y Grupos

En esta sesión, nos enfocaremos en cómo utilizar Python para gestionar usuarios y grupos en sistemas Unix-like. Python proporciona módulos como `pwd` y `grp` que permiten interactuar con la base de datos de usuarios y grupos del sistema.

### Punto 1.a: Uso de Módulos como `pwd` y `grp`

#### Introducción a los Módulos `pwd` y `grp`

- **Módulo `pwd`:** Proporciona acceso a la base de datos de contraseñas (passwd) que almacena información sobre los usuarios del sistema.
- **Módulo `grp`:** Proporciona acceso a la base de datos de grupos (group) que almacena información sobre los grupos del sistema.

Estos módulos permiten obtener información detallada sobre usuarios y grupos, tales como nombres de usuario, ID de usuario (UID), ID de grupo (GID), y otros atributos.

### Uso del Módulo `pwd`

El módulo `pwd` permite acceder a la base de datos de contraseñas del sistema. A continuación, se presentan las funciones más comunes de este módulo.

#### Obtener Información del Usuario Actual

**Ejemplo: Obtener Información del Usuario Actual**

```python
import pwd

def obtener_usuario_actual():
    usuario_actual = pwd.getpwuid(os.getuid())
    print(f"Nombre de usuario: {usuario_actual.pw_name}")
    print(f"UID: {usuario_actual.pw_uid}")
    print(f"GID: {usuario_actual.pw_gid}")
    print(f"Directorio de inicio: {usuario_actual.pw_dir}")
    print(f"Intérprete de comandos: {usuario_actual.pw_shell}")

# Ejemplo de uso
if __name__ == "__main__":
    import os
    obtener_usuario_actual()
```

- `pwd.getpwuid(uid)`: Devuelve una tupla con la información del usuario para el UID dado.
- `os.getuid()`: Obtiene el UID del usuario actual.

#### Obtener Información de un Usuario por Nombre

**Ejemplo: Obtener Información de un Usuario por Nombre**

```python
import pwd

def obtener_informacion_usuario(nombre_usuario):
    try:
        usuario = pwd.getpwnam(nombre_usuario)
        print(f"Nombre de usuario: {usuario.pw_name}")
        print(f"UID: {usuario.pw_uid}")
        print(f"GID: {usuario.pw_gid}")
        print(f"Directorio de inicio: {usuario.pw_dir}")
        print(f"Intérprete de comandos: {usuario.pw_shell}")
    except KeyError:
        print(f"El usuario {nombre_usuario} no existe.")

# Ejemplo de uso
if __name__ == "__main__":
    nombre_usuario = input("Introduce el nombre de usuario: ")
    obtener_informacion_usuario(nombre_usuario)
```

- `pwd.getpwnam(nombre_usuario)`: Devuelve una tupla con la información del usuario para el nombre de usuario dado.
- Manejo de la excepción `KeyError` en caso de que el usuario no exista.

#### Listar Todos los Usuarios del Sistema

**Ejemplo: Listar Todos los Usuarios del Sistema**

```python
import pwd

def listar_usuarios():
    usuarios = pwd.getpwall()
    for usuario in usuarios:
        print(f"Nombre de usuario: {usuario.pw_name}, UID: {usuario.pw_uid}, GID: {usuario.pw_gid}")

# Ejemplo de uso
if __name__ == "__main__":
    listar_usuarios()
```

- `pwd.getpwall()`: Devuelve una lista de todas las entradas en la base de datos de contraseñas.

### Uso del Módulo `grp`

El módulo `grp` permite acceder a la base de datos de grupos del sistema. A continuación, se presentan las funciones más comunes de este módulo.

#### Obtener Información del Grupo Actual

**Ejemplo: Obtener Información del Grupo Actual**

```python
import grp

def obtener_grupo_actual():
    grupo_actual = grp.getgrgid(os.getgid())
    print(f"Nombre del grupo: {grupo_actual.gr_name}")
    print(f"GID: {grupo_actual.gr_gid}")
    print(f"Miembros: {', '.join(grupo_actual.gr_mem)}")

# Ejemplo de uso
if __name__ == "__main__":
    import os
    obtener_grupo_actual()
```

- `grp.getgrgid(gid)`: Devuelve una tupla con la información del grupo para el GID dado.
- `os.getgid()`: Obtiene el GID del grupo actual.

#### Obtener Información de un Grupo por Nombre

**Ejemplo: Obtener Información de un Grupo por Nombre**

```python
import grp

def obtener_informacion_grupo(nombre_grupo):
    try:
        grupo = grp.getgrnam(nombre_grupo)
        print(f"Nombre del grupo: {grupo.gr_name}")
        print(f"GID: {grupo.gr_gid}")
        print(f"Miembros: {', '.join(grupo.gr_mem)}")
    except KeyError:
        print(f"El grupo {nombre_grupo} no existe.")

# Ejemplo de uso
if __name__ == "__main__":
    nombre_grupo = input("Introduce el nombre del grupo: ")
    obtener_informacion_grupo(nombre_grupo)
```

- `grp.getgrnam(nombre_grupo)`: Devuelve una tupla con la información del grupo para el nombre de grupo dado.
- Manejo de la excepción `KeyError` en caso de que el grupo no exista.

#### Listar Todos los Grupos del Sistema

**Ejemplo: Listar Todos los Grupos del Sistema**

```python
import grp

def listar_grupos():
    grupos = grp.getgrall()
    for grupo in grupos:
        print(f"Nombre del grupo: {grupo.gr_name}, GID: {grupo.gr_gid}, Miembros: {', '.join(grupo.gr_mem)}")

# Ejemplo de uso
if __name__ == "__main__":
    listar_grupos()
```

- `grp.getgrall()`: Devuelve una lista de todas las entradas en la base de datos de grupos.

### Ejemplo Completo: Gestión de Usuarios y Grupos

Combina todo lo aprendido en un script completo que permita al usuario elegir diferentes opciones para obtener información sobre usuarios y grupos.

```python
import os
import pwd
import grp

def obtener_usuario_actual():
    usuario_actual = pwd.getpwuid(os.getuid())
    print(f"Nombre de usuario: {usuario_actual.pw_name}")
    print(f"UID: {usuario_actual.pw_uid}")
    print(f"GID: {usuario_actual.pw_gid}")
    print(f"Directorio de inicio: {usuario_actual.pw_dir}")
    print(f"Intérprete de comandos: {usuario_actual.pw_shell}")

def obtener_informacion_usuario(nombre_usuario):
    try:
        usuario = pwd.getpwnam(nombre_usuario)
        print(f"Nombre de usuario: {usuario.pw_name}")
        print(f"UID: {usuario.pw_uid}")
        print(f"GID: {usuario.pw_gid}")
        print(f"Directorio de inicio: {usuario.pw_dir}")
        print(f"Intérprete de comandos: {usuario.pw_shell}")
    except KeyError:
        print(f"El usuario {nombre_usuario} no existe.")

def listar_usuarios():
    usuarios = pwd.getpwall()
    for usuario in usuarios:
        print(f"Nombre de usuario: {usuario.pw_name}, UID: {usuario.pw_uid}, GID: {usuario.pw_gid}")

def obtener_grupo_actual():
    grupo_actual = grp.getgrgid(os.getgid())
    print(f"Nombre del grupo: {grupo_actual.gr_name}")
    print(f"GID: {grupo_actual.gr_gid}")
    print(f"Miembros: {', '.join(grupo_actual.gr_mem)}")

def obtener_informacion_grupo(nombre_grupo):
    try:
        grupo = grp.getgrnam(nombre_grupo)
        print(f"Nombre del grupo: {grupo.gr_name}")
        print(f"GID: {grupo.gr_gid}")
        print(f"Miembros: {', '.join(grupo.gr_mem)}")
    except KeyError:
        print(f"El grupo {nombre_grupo} no existe.")

def listar_grupos():
    grupos = grp.getgrall()
    for grupo in grupos:
        print(f"Nombre del grupo: {grupo.gr_name}, GID: {grupo.gr_gid}, Miembros: {', '.join(grupo.gr_mem)}")

if __name__ == "__main__":
    while True:
        print("\nMenú de Gestión de Usuarios y Grupos")
        print("1. Obtener información del usuario actual")
        print("2. Obtener información de un usuario por nombre")
        print("3. Listar todos los usuarios del sistema")
        print("4. Obtener información del grupo actual")
        print("5. Obtener información de un grupo por nombre")
        print("6. Listar todos los grupos del sistema")
        print("7. Salir")

        opcion = input("Selecciona una opción: ")

        if opcion == '1':
            obtener_usuario_actual()
        elif opcion == '2':
            nombre_usuario = input("Introduce el nombre de usuario: ")
            obtener_informacion_usuario(nombre_usuario)
        elif opcion == '3':
            listar_usuarios()
        elif opcion == '4':
            obtener_grupo_actual()
        elif opcion == '5':
            nombre_grupo = input("Introduce el nombre del grupo: ")
            obtener_informacion_grupo(nombre_grupo)
        elif opcion