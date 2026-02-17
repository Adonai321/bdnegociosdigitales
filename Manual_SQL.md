    # Guía Completa: Instalación de SQL Server 2022 y SSMS

    Este manual documenta el proceso paso a paso para desplegar un entorno de base de datos local, incluyendo el motor de base de datos (SQL Server 2022) y la herramienta de administración (SSMS).

    ---

    ## Parte 1: Motor de Base de Datos (Database Engine)

    ### 1. Descarga del Medio de Instalación
    Se inició el proceso ejecutando el instalador web (`SQL2022-SSEI-Dev`) con privilegios de administrador.

    ![Ejecución instalador web](img/Imagen1.jpg)

    Se seleccionó la opción **"Descargar medios" (Download Media)** para bajar el archivo ISO completo, permitiendo una instalación *offline* posterior.

    ![Selección Download Media](img/Imagen2.jpg)
    ![Progreso de descarga](img/Imagen3.png)
    ![Descarga finalizada](img/Imagen4.png)

    ### 2. Montaje y Preparación
    Una vez descargada la imagen de disco (`SQLServer2022-x64-ENU-Dev`), se montó en el sistema como una unidad virtual.

    ![Archivo ISO](img/Imagen5.png)
    ![Montar imagen](img/Imagen6.png)

    Dentro de la unidad, se ejecutó `setup.exe` como administrador para lanzar el Centro de Instalación.

    ![Ejecutar Setup](img/Imagen7.png)
    ![Installation Center](img/Imagen8.png)

    ### 3. Configuración Inicial
    * **Edición:** Se eligió "Developer Edition" (gratuita para desarrollo).
    * **Licencia:** Se aceptaron los términos del software.
    * **Azure:** Se deshabilitó la extensión de Azure para mantener la instalación puramente local.

    ![Edición Developer](img/Imagen9.png)
    ![Términos de Licencia](img/Imagen10.png)
    ![Reglas de instalación](img/Imagen12.png)
    ![Deshabilitar Azure Extension](img/Imagen13.png)

    ### 4. Selección de Características e Instancia
    Se seleccionaron los componentes **Database Engine Services** y **SQL Server Replication**. Se configuró la instancia con el nombre predeterminado `MSSQLSERVER`.

    ![Features](img/Imagen14.png)
    ![Configuración de Instancia](img/Imagen15.png)

    ### 5. Configuración del Motor (Seguridad)
    Se configuró el modo de autenticación **Mixto** (Mixed Mode):
    1.  Se asignó una contraseña para el usuario `sa`.
    2.  Se agregó al usuario actual de Windows como administrador (`Add Current User`).

    ![Cuentas de Servicio](img/Imagen16.png)
    ![Configuración de Autenticación](img/Imagen17.png)
    ![Administradores agregados](img/Imagen18.png)

    ### 6. Instalación Exitosa
    Tras revisar el resumen, se procedió con la instalación, la cual finalizó correctamente para todos los servicios.

    ![Ready to Install](img/Imagen19.png)
    ![Progreso](img/Imagen20.png)
    ![Instalación Completada](img/Imagen21.png)

    ---

    ## Parte 2: SQL Server Management Studio (SSMS)

    Para administrar la base de datos, se procedió a instalar la interfaz gráfica.

    ### 1. Obtención del Instalador
    Desde la documentación oficial de Microsoft, se descargó el instalador para **SSMS 22**.

    ![Documentación SSMS](img/Imagen22.png)

    ### 2. Ejecución mediante Visual Studio Installer
    Se ejecutó el instalador `vs_SSMS` con permisos de administrador. En esta versión, la instalación se gestiona a través del *Visual Studio Installer*.

    ![Ejecutar instalador SSMS](img/Imagen23.png)
    ![Visual Studio Installer preparando](img/Imagen24.png)

    Se confirmó la instalación de **SQL Server Management Studio 22** desde la interfaz del instalador.

    ![Instalando SSMS](img/Imagen25.png)

    ---

    ## Parte 3: Verificación de Conexión

    Finalmente, se abrió la herramienta de conexión para validar el acceso a la instancia `MSSQLSERVER` recién creada.

    ![Prueba de conexión](img/Captura%20de%20pantalla%202026-01-21%20193538.png "juan")