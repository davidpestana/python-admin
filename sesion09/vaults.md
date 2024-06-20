# Uso e Integración de Soluciones VAULT

## Introducción

La gestión de secretos es una parte crucial de la seguridad en la administración de sistemas y desarrollo de aplicaciones. Los secretos, como contraseñas, claves API y certificados, deben ser gestionados de manera segura para prevenir accesos no autorizados. Las soluciones VAULT, como HashiCorp Vault, proporcionan una forma segura de almacenar, acceder y gestionar estos secretos. En esta guía, exploraremos cómo usar e integrar soluciones VAULT en tus scripts y aplicaciones.

## Instalación y Configuración de HashiCorp Vault

### Instalación

Para instalar HashiCorp Vault, sigue estos pasos:

1. **Descargar Vault:**

   ```bash
   curl -O https://releases.hashicorp.com/vault/1.9.0/vault_1.9.0_linux_amd64.zip
   ```

2. **Descomprimir el archivo descargado:**

   ```bash
   unzip vault_1.9.0_linux_amd64.zip
   ```

3. **Mover el binario a un directorio en el PATH:**

   ```bash
   sudo mv vault /usr/local/bin/
   ```

4. **Verificar la instalación:**

   ```bash
   vault --version
   ```

### Configuración Básica

#### Iniciar Vault en modo de desarrollo

El modo de desarrollo es adecuado para pruebas y aprendizaje, pero no debe usarse en producción.

```bash
vault server -dev
```

#### Configurar la variable de entorno VAULT_ADDR

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
```

### Autenticación en Vault

Obten el token de root que se muestra al iniciar Vault en modo de desarrollo y exporta la variable de entorno VAULT_TOKEN:

```bash
export VAULT_TOKEN='s.mytoken1234'
```

## Uso de Vault para Gestionar Secretos

### Almacenar Secretos en Vault

#### Usar la línea de comandos para escribir un secreto

```bash
vault kv put secret/myapp contraseña='mi_contraseña_segura'
```

### Leer Secretos desde Vault

#### Usar la línea de comandos para leer un secreto

```bash
vault kv get secret/myapp
```

#### Integración en Scripts Bash

Puedes usar comandos Vault dentro de scripts Bash para obtener secretos de manera segura.

```bash
#!/bin/bash

# Leer el secreto desde Vault
CONTRASENA=$(vault kv get -field=contraseña secret/myapp)

# Usar la contraseña
echo "La contraseña obtenida desde Vault es: $CONTRASENA"
```

### Integración en Scripts Python

#### Instalación de la Biblioteca hvac

La biblioteca `hvac` es una biblioteca cliente de Vault para Python.

```bash
pip install hvac
```

#### Ejemplo de Uso en un Script Python

```python
import hvac

# Conectar al servidor Vault
cliente = hvac.Client(url='http://127.0.0.1:8200', token='s.mytoken1234')

# Leer el secreto
secreto = cliente.secrets.kv.v2.read_secret_version(path='myapp')
contrasena = secreto['data']['data']['contraseña']

# Usar la contraseña
print(f"La contraseña obtenida desde Vault es: {contrasena}")
```

## Casos Prácticos

### Caso Práctico 1: Gestión de Claves API

Supongamos que tienes varias aplicaciones que necesitan acceder a diferentes servicios externos utilizando claves API. Puedes almacenar estas claves en Vault y acceder a ellas de manera segura desde tus scripts.

#### Almacenar Claves API en Vault

```bash
vault kv put secret/apis servicio1_api_key='clave1' servicio2_api_key='clave2'
```

#### Script Bash para Obtener Claves API

```bash
#!/bin/bash

# Obtener las claves API desde Vault
SERVICIO1_API_KEY=$(vault kv get -field=servicio1_api_key secret/apis)
SERVICIO2_API_KEY=$(vault kv get -field=servicio2_api_key secret/apis)

# Usar las claves API
echo "Clave API del Servicio 1: $SERVICIO1_API_KEY"
echo "Clave API del Servicio 2: $SERVICIO2_API_KEY"
```

#### Script Python para Obtener Claves API

```python
import hvac

# Conectar al servidor Vault
cliente = hvac.Client(url='http://127.0.0.1:8200', token='s.mytoken1234')

# Leer las claves API
secreto = cliente.secrets.kv.v2.read_secret_version(path='apis')
servicio1_api_key = secreto['data']['data']['servicio1_api_key']
servicio2_api_key = secreto['data']['data']['servicio2_api_key']

# Usar las claves API
print(f"Clave API del Servicio 1: {servicio1_api_key}")
print(f"Clave API del Servicio 2: {servicio2_api_key}")
```

### Caso Práctico 2: Rotación de Secretos

La rotación regular de secretos es una buena práctica de seguridad. Puedes automatizar la rotación de contraseñas o claves almacenadas en Vault.

#### Script para Rotar Claves API en Vault

```bash
#!/bin/bash

# Generar nuevas claves API (ejemplo simple)
NUEVA_SERVICIO1_API_KEY=$(openssl rand -hex 16)
NUEVA_SERVICIO2_API_KEY=$(openssl rand -hex 16)

# Almacenar las nuevas claves API en Vault
vault kv put secret/apis servicio1_api_key="$NUEVA_SERVICIO1_API_KEY" servicio2_api_key="$NUEVA_SERVICIO2_API_KEY"

# Confirmar la actualización
echo "Las claves API han sido rotadas y actualizadas en Vault."
```

#### Integración con Scripts Python

Puedes integrar la rotación de secretos en tus scripts Python para asegurarte de que siempre estás usando las claves más recientes.

```python
import hvac
import os

# Conectar al servidor Vault
cliente = hvac.Client(url='http://127.0.0.1:8200', token='s.mytoken1234')

# Generar nuevas claves API
nueva_servicio1_api_key = os.urandom(16).hex()
nueva_servicio2_api_key = os.urandom(16).hex()

# Almacenar las nuevas claves API en Vault
cliente.secrets.kv.v2.create_or_update_secret(
    path='apis',
    secret={
        'servicio1_api_key': nueva_servicio1_api_key,
        'servicio2_api_key': nueva_servicio2_api_key,
    }
)

# Confirmar la actualización
print("Las claves API han sido rotadas y actualizadas en Vault.")
```

## Conclusión

El uso de soluciones VAULT para la gestión de secretos proporciona una forma segura y eficiente de manejar datos sensibles en tus aplicaciones y scripts. HashiCorp Vault es una herramienta poderosa que permite almacenar, acceder y rotar secretos de manera segura, reduciendo el riesgo de compromisos de seguridad. Los ejemplos y casos prácticos proporcionados en esta guía te ayudarán a integrar Vault en tus flujos de trabajo de administración de sistemas y desarrollo de software.