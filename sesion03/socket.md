### ¿Qué es un Socket?

Un **socket** es un punto de conexión en una red de computadoras utilizado para enviar y recibir datos. Puedes imaginar un socket como un "enchufe" en el que dos dispositivos pueden conectarse para comunicarse entre sí.

### Componentes de un Socket

Un socket tiene dos componentes principales:
1. **Dirección IP**: Identifica de manera única a un dispositivo en la red.
2. **Número de Puerto**: Identifica una aplicación o servicio específico en el dispositivo.

Piensa en un socket como un teléfono con un número único (dirección IP) y una extensión (puerto) específica para cada departamento o servicio en una empresa.

### ¿Para Qué Sirve un Socket?

Un socket sirve para:
1. **Conexión entre Dispositivos**: Permite que dos dispositivos se comuniquen entre sí.
2. **Transferencia de Datos**: Facilita el envío y recepción de datos entre aplicaciones.
3. **Intercambio de Mensajes**: Permite que los programas intercambien mensajes en tiempo real.

### Tipos de Sockets

1. **Socket de Flujo (Stream Socket)**:
   - **Protocolo**: TCP (Transmission Control Protocol).
   - **Uso**: Conexiones fiables y continuas, como navegar por Internet o transferir archivos.
   - **Ejemplo**: Navegar en un sitio web.

2. **Socket de Datagramas (Datagram Socket)**:
   - **Protocolo**: UDP (User Datagram Protocol).
   - **Uso**: Comunicación rápida y sin garantía de entrega, como en juegos en línea o streaming.
   - **Ejemplo**: Videollamadas.

### Ejemplo Práctico

#### 1. Servidor HTTP

Un servidor HTTP utiliza sockets para escuchar solicitudes en un puerto (como el puerto 80) y responder a ellas.

```python
import http.server
import socketserver

PORT = 8000

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP sirviendo en el puerto {PORT}")
    httpd.serve_forever()
```

#### 2. Cliente HTTP

Un navegador web actúa como un cliente que usa sockets para conectarse al servidor, solicitar páginas web y recibirlas.

### Conclusión

Los sockets son esenciales para la comunicación en red, permitiendo la transferencia de datos entre dispositivos de manera eficiente y estructurada. Son fundamentales en la mayoría de las aplicaciones de red, desde la navegación web hasta el intercambio de mensajes en tiempo real.
