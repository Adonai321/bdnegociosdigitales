# Manual de Instalación, Configuración y Uso de Docker en Windows

## Descripción
Este documento describe de manera detallada el proceso de instalación, configuración y uso básico de Docker Desktop en Windows. Se abordan todas las fases necesarias, desde la preparación del entorno, la obtención de imágenes, la práctica del ciclo de vida de los contenedores, hasta un caso de uso real con el despliegue y conexión de una base de datos SQL Server en contenedores.

---

## Requisitos Previos
- Sistema operativo Windows 10 u 11 (64 bits)
- Virtualización habilitada en BIOS
- Docker Desktop para Windows
- Acceso a Internet
- Terminal Git Bash o PowerShell
- SQL Server Management Studio (SSMS) u otro cliente SQL compatible

---

### Requisitos del Sistema
- Windows 10/11 de 64 bits
- CPU con virtualización (Intel VT-x / AMD-V)
- Virtualización habilitada en BIOS
- Mínimo 4 GB de RAM (8 GB recomendado)
- WSL 2 habilitado

## Fase 1: Instalación y Configuración del Entorno

### Paso 1: Descarga e Instalación
El proceso comienza con la instalación del software principal en el sistema operativo Windows.

Se ejecuta el instalador de **Docker Desktop versión 4.55.0**, el cual inicia el proceso de preparación del entorno de contenedores.

Durante la instalación, el sistema descomprime y configura los archivos necesarios, incluyendo:
- Imágenes ISO
- Herramientas de línea de comandos (CLI)
- Configuraciones del demonio Docker para Linux y Windows

Este proceso prepara el entorno de virtualización requerido para la ejecución de contenedores.

![Instalación de Docker Desktop](img/Captura%20de%20pantalla%202026-01-21%20193413.png)

---

### Paso 2: Exploración de Imágenes (Docker Hub)
Antes de utilizar Docker, es necesario localizar las imágenes de software requeridas.

Se utiliza **Docker Hub**, el repositorio oficial de imágenes de contenedores, para buscar versiones confiables y mantenidas de los servicios necesarios.

Durante esta exploración:
- Se identifican imágenes certificadas como **Docker Official Image** o **Verified Publisher**
- Se seleccionan imágenes oficiales para servicios como **MySQL** y **SQL Server**
- Se garantiza que las imágenes sean seguras, actualizadas y respaldadas por sus proveedores

![Exploración Docker Hub SQL Server](img/Captura%20de%20pantalla%202026-01-21%20193418.png)
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193423.png)

## Interfaz Principal de Docker Desktop
La interfaz gráfica de Docker Desktop permite administrar contenedores, imágenes y volúmenes.

Las secciones principales son:
- Containers: muestra contenedores activos y detenidos
- Images: lista las imágenes descargadas
- Volumes: administra datos persistentes
- Settings: configuración del entorno Docker

![alt text](<img/Captura de pantalla 2026-01-27 080629.png>)
---

## Fase 2: Obtención de Recursos (Pull)

### Paso 3: Descarga de Imágenes vía Terminal
Una vez seleccionadas las imágenes, se procede a descargarlas en la máquina local utilizando la terminal (Git Bash / MINGW64).

Se ejecuta el comando `docker pull` para obtener las siguientes imágenes:

```
docker pull mcr.microsoft.com/mssql/server:2019-latest
docker pull mysql:latest
docker pull docker/getting-started
```
Durante la descarga, la terminal muestra el progreso de las distintas capas (layers) que componen cada imagen, confirmando la correcta obtención de los recursos.

![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193445.png)

## Paso 4: Verificación de Recursos Locales
Se confirma que las imágenes descargadas estén disponibles y listas para su uso.

Verificación vía Interfaz Gráfica (GUI)
En la pestaña Images de Docker Desktop se enlistan las imágenes descargadas, mostrando información como:

* Nombre del repositorio

* Etiqueta (tag)

* Tamaño (por ejemplo, SQL Server con un peso aproximado de 2.04 GB)

* Fecha de creación

Verificación vía Terminal
También es posible validar las imágenes mediante el comando:

```
docker images
Este comando muestra los repositorios, identificadores (ID) y tamaños en formato texto.
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193515.png)

## Fase 3: Práctica de Comandos (Ciclo de Vida del Contenedor)
### Paso 5: Creación y Ejecución de Contenedores
Se realizan las primeras pruebas utilizando la imagen del tutorial oficial de Docker.

Ejecución simple
Se ejecuta un contenedor usando el ID corto de la imagen:

```
docker run d793
```
Los logs generados en la terminal indican que el servicio se inicia correctamente.

![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193457.png)

Ejecución con nombre personalizado
Para facilitar la identificación de los contenedores, se utiliza la bandera --name.

Ejemplos:


```
docker run --name miprimercontenedor d793
docker run --name tlacoyo -d d793
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193520.png)

En el segundo caso, la opción -d permite ejecutar el contenedor en segundo plano (detached mode).

### Paso 6: Gestión del Estado (Start / Stop / Remove)
Se practican comandos básicos para controlar el ciclo de vida de los contenedores.

Visualizar contenedores activos:

```
docker ps
```
### Verificación de la instalación
Para validar que Docker está correctamente instalado, se ejecuta:

```
docker version
```

Este comando muestra la versión del cliente y del servidor Docker, confirmando que el motor está en ejecución.

Listar todos los contenedores (activos y detenidos):

```
docker container ls -a
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193510.png)

Iniciar un contenedor detenido:

```
docker start <ID>
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193505.png)

Detener un contenedor:

```
docker stop thirsty_wright
docker stop tlacoyo
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193525.png)

Eliminar contenedores para liberar espacio:

```
docker rm <NOMBRE o ID>
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-22%20084951.png)

Estos comandos permiten limpiar el entorno y administrar los recursos de manera eficiente.

### Paso 7: Mapeo de Puertos (Port Mapping)
Para acceder a los servicios del contenedor desde el navegador, se realiza el mapeo de puertos entre el contenedor y la máquina local.

```
docker run -d -p 8089:80 --name tutorial-docker d793
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-22%20085324.png)

Este comando redirige el tráfico del puerto 8089 de la computadora local al puerto 80 del contenedor.

Resultado:
Al acceder desde el navegador a la dirección:

```
http://localhost:8089
```
![Exploración Docker Hub MySQL](img/Captura%20de%20pantalla%202026-01-21%20193529.png)

se visualiza correctamente la documentación de Getting Started.


## Fase 4: Caso de Uso Real – Base de Datos SQL Server
### Paso 8: Despliegue de SQL Server con Variables de Entorno
Se ejecuta un comando avanzado para desplegar una instancia funcional de SQL Server dentro de un contenedor.

```
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-p 1433:1435 --name servidordesqlserver \
-d mcr.microsoft.com/mssql/server:2019-latest
```
![olo](img/Captura%20de%20pantalla%202026-01-21%20193534.png)

Descripción de parámetros:

* -e: Define variables de entorno obligatorias (aceptación de licencia y contraseña del administrador).

* -p 1433:1435: Mapea el puerto del servicio SQL Server hacia un puerto específico del entorno local.

* -d: Ejecuta el contenedor en segundo plano.


### Paso 9: Conexión Cliente-Servidor
Finalmente, se valida el funcionamiento del contenedor conectándose desde un cliente externo como SQL Server Management Studio (SSMS).

* Configuración de conexión:

* Nombre del servidor: .,1435

* Autenticación: SQL Server Authentication

* Usuario: sa

* Contraseña: P@ssw0rd

![olo](img/Captura%20de%20pantalla%202026-01-21%20193545.png)

La conexión exitosa confirma que el contenedor está operativo y accesible desde herramientas externas.