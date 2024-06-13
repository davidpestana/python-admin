Crear un servidor HTTP en Python es sencillo utilizando la biblioteca estándar `http.server`. 

### Ejemplo de Servidor HTTP

```python
import http.server
import socketserver

# Definir el puerto en el que el servidor escuchará
PORT = 8000

# Crear un manejador que sirva archivos del directorio actual
Handler = http.server.SimpleHTTPRequestHandler

# Configurar el servidor con el manejador y el puerto especificado
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP sirviendo en el puerto {PORT}")
    # Mantener el servidor corriendo hasta que se interrumpa manualmente
    httpd.serve_forever()
```

### Instrucciones

1. **Guardar el archivo**: Guarda el script anterior en un archivo, por ejemplo, `servidor_http.py`.
2. **Ejecutar el servidor**: Corre el script usando Python desde la terminal o línea de comandos:

    ```sh
    python servidor_http.py
    ```

3. **Acceder al servidor**: Abre un navegador web y navega a `http://localhost:8000`. Verás una lista de los archivos en el directorio donde se ejecutó el script. Si hay un archivo `index.html`, se mostrará como la página de inicio.

### Características Adicionales

Para personalizar el servidor, puedes crear tu propia clase de manejador que herede de `http.server.SimpleHTTPRequestHandler` y sobreescriba métodos para manejar diferentes tipos de solicitudes (GET, POST, etc.). Aquí hay un ejemplo de cómo hacerlo:

```python
import http.server
import socketserver

PORT = 8000

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Aquí puedes personalizar la respuesta GET
        if self.path == '/':
            self.path = '/index.html'  # Redirigir a un archivo específico
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        # Aquí puedes manejar solicitudes POST
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        print(f"POST data: {post_data.decode('utf-8')}")

        # Responder al cliente
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"POST request received!")

Handler = CustomHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP sirviendo en el puerto {PORT}")
    httpd.serve_forever()
```

### Instrucciones Adicionales

1. **Crear archivos HTML**: Puedes crear un archivo `index.html` en el mismo directorio que el script para probar la personalización del manejador.
2. **Enviar solicitudes POST**: Puedes usar herramientas como `curl` o Postman para enviar solicitudes POST y ver cómo las maneja el servidor.