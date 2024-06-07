import os
import shutil

# Eliminar el directorio docs si existe
if os.path.exists("docs"):
    shutil.rmtree("docs")

# Diccionario para renombrar los directorios de sesiones
session_dirs = {
    "sesion1": "sesion01",
    "sesion2": "sesion02",
    "sesion3": "sesion03",
    "sesion4": "sesion04",
    "sesion5": "sesion05",
    "sesion6": "sesion06",
    "sesion7": "sesion07",
    "sesion8": "sesion08",
    "sesion9": "sesion09",
    "sesion10": "sesion10"
}

# Renombrar los directorios de sesiones
for old_name, new_name in session_dirs.items():
    if os.path.exists(old_name):
        os.rename(old_name, new_name)

print("Directorio docs eliminado y directorios de sesiones renombrados exitosamente.")
