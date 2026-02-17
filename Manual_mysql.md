# Manual de Instalación y Configuración

## Descarga del Instalador

Abrir el navegador web, buscar en Google:
instalador mysql server

Seleccionar el resultado oficial:
“Download MySQL Installer” del sitio dev.mysql.com.

![alt text](<img/Captura de pantalla 2026-01-25 203848.png>)

## Descargar el instalador versión Community.

El archivo debe llamarse similar a:

mysql-installer-community-8.0.xx.x.msi

![alt text](<img/Captura de pantalla 2026-01-25 203932.png>)

![alt text](<img/Captura de pantalla 2026-01-25 203937.png>)

Al ejecutar el instalador, se abrirá la ventana de configuración.

Seleccionar: Custom (Personalizada)

Permite elegir solo los componentes necesarios.

Clic en Next >

![alt text](<img/Captura de pantalla 2026-01-25 204004.png>)

## Selección de Productos

En la pantalla Select Products:

Mover desde Available Products a Products To Be Installed:

Clic en Next >

![alt text](<img/Captura de pantalla 2026-01-25 205043.png>)


## Verificación de Requisitos

El instalador comprobará dependencias como:

Microsoft Visual C++ Redistributable

Si aparece “Failing requirements”:

El instalador intentará solucionarlo automáticamente

O pedirá instalar componentes manualmente, cuando todo esté correcto:
Clic en Next > o Execute

![alt text](<img/Captura de pantalla 2026-01-25 204037.png>)

![alt text](<img/Captura de pantalla 2026-01-25 204045.png>)

## Instalación

Aparecerá la lista de productos con estado Ready to Install.

Clic en Execute.

Esperar hasta ver ✔️ verde en todos los componentes.

Clic en Next >

![alt text](<img/Captura de pantalla 2026-01-25 204142.png>)

![alt text](<img/Captura de pantalla 2026-01-25 204212.png>)

## Configuración del Producto

Se mostrarán los productos que requieren configuración (principalmente MySQL Server).

Clic en Next > para iniciar el asistente del servidor.

Aquí se define:

Puerto del servidor

Contraseña del usuario root

Tipo de servidor

![alt text](<img/Captura de pantalla 2026-01-25 204304.png>)

## Verificación y Conexión

Abrir MySQL Workbench.

Clic en + o Setup New Connection.

Completar los campos:

Parámetro	Valor
Connection Name	MysqlEV (o el nombre que prefieras)
Hostname	127.0.0.1
Port	3341
Username	root

El puerto usado aquí es 3341, debe coincidir con el configurado en el servidor.

Clic en Test Connection.

Ingresar la contraseña de root.

Clic en OK.

### Acceso al Entorno

En la pantalla inicial de Workbench:

Verás la nueva conexión MysqlEV.

Haz clic sobre ella para comenzar a administrar bases de datos.
![alt text](<img/Captura de pantalla 2026-01-25 204330.png>)