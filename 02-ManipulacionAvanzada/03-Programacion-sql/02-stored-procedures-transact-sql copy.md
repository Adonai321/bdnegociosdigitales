#Stored Procedures (Procedimientos Almacenados) en Transact-SQL (SQL SERVER)

Fundamentos

- ¿Qué es un Stored Procedure?

Un **Stored Procedure (SP)** es un bloque de código SQL guardado dentro de la base de datos que puede ejecutarse cuando se necesite. Es decir, es un **OBJETO DE LA BASE DE DATOS**.

Es algo similar a una función o método en programación.

Ventajas

1. Reutilizar el código.
2. Mejor rendimiento.
3. Mayor seguridad.
4. Centralización de lógica de negocio.
5. Menos tráfico entre aplicación y servidor.

- Sintáxis

![SintaxisSQL](../../Img/sp_sintaxis.png)

- Nomenclatura Recomendada

```
spu_<Entidad>_<Acción>
```

| Parte   | Significado                     | Ejemplo |
|--------|---------------------------------|--------|
| spu    | Stored Procedure User           | spu_   |
| Entidad| Tabla o concepto del negocio    | Cliente|
| Acción | Lo que hace                     | Insert |

- Acciones Estándar

Estas son las **Acciones más usadas** en sistemas empresariales

| Acción     | Significado          | Ejemplo                |
| ---------- | -------------------- | ---------------------- |
| Insert     | Insertar registro    | spu_Cliente_Insert     |
| Update     | Actualizar           | spu_Cliente_Update     |
| Delete     | Eliminar             | spu_Cliente_Delete     |
| Get        | Obtener uno          | spu_Cliente_Get        |
| List       | Obtener varios       | spu_Cliente_List       |
| Search     | Búsqueda con filtros | spu_Cliente_Search     |
| Exists     | Validar si existe    | spu_Cliente_Exists     |
| Activate   | Activar registro     | spu_Cliente_Activate   |
| Deactivate | Desactivar           | spu_Cliente_Deactivate |

-- Ejemplo completo

Suponer que tenemos una tabla cliente

Insertar Cliente

```
spu_Cliente_Insert
```

Actualizar Cliente

```
spu_Cliente_Update
```

Obtener Cliente por Id

```
spu_Cliente_Get
```

Listar todos los clientes

```
spu_Cliente_List
```

Buscar Cliente

```
spu_Cliente_Search
```

```

/* ========================================== Stored Procedures ==========================================*/

CREATE DATABASE bdstored;
GO

USE bdstored;
GO

-- Ejemplo Simple

CREATE PROCEDURE usp_Mensaje_saludar
-- No tendrá parámetros
AS
BEGIN
    PRINT 'Hola Mundo Transact SQL desde SQL SERVER';
END;
GO

-- Ejecutar

EXECUTE usp_Mensaje_saludar;
GO

-- No tendrá parámetros 
CREATE PROC usp_Mensaje_saludar2
AS
BEGIN
    SELECT 'Hola Mundo ING en TI';
END;
GO

EXEC usp_Mensaje_saludar2;

--tercero

/*CREATE OR*/ ALTER PROC usp_Mensaje_saludar3
AS
BEGIN
    SELECT 'Hola Mundo EVND';
END;
GO

EXEC usp_Mensaje_saludar3;

--Eliminar un SP
DROP PROCEDURE  usp_Mensaje_saludar3;

--Crear un SP que muestre la fecha actual del sistema

CREATE OR ALTER PROC usp_Servidor_FechaActual;

AS
BEGIN
    SELECT CAST(GETDATE () AS DATE)AS [Fecha del Sistema]
END;
GO

--CRear un sp que muestre  el nombre de la base de datos (DB_Name())

CREATE OR ALTER PROC spu_Dbname_get
AS
BEGIN
SELECT
HOST_NAME() AS [Machine],
SUSER_NAME() AS [SQLUSER],
SYSTEM_USER AS [SystemUser],
APP_NAME () AS [Application],
DB_NAME() AS [DATABASE NAME];
END;

--ejecutar
EXEC spu_Dbname_get;
GO
```
2. Parametros

```
--todo  ejemplo  con consultas, vamos a crear una tabla de clientes basada en la tabla customers
--de northwind

SELECT CustomerID, Companyname
INTO Customers
FROM NORTHWND.dbo.Customers;

SELECT *
FROM Customers

-- Crear un SP que busque un cliente en especifico

CREATE OR ALTER PROC spu_Customer_buscar
@id NCHAR(5)
AS
BEGIN
    IF NOT (LEN(@id)>0 AND LEN(@id)>=5)
    BEGIN
    SELECT ('El id debe estar en el rango de 1 a 5');
    RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        PRINT 'El cliente no existe en la base de datos'
        RETURN;
    END

    SELECT CustomerID AS [Número], CompanyName AS [Cliente]
    FROM Customers
    WHERE CustomerID = @id
END;
GO

SELECT *
FROM Customers
WHERE CustomerID = 'Anton'

--Ejecutar
EXEC spu_Customer_buscar 'Anton';

SELECT 1
FROM NORTHWND.dbo.Categories
WHERE NOT EXISTS(
SELECT 1
FROM Customers
WHERE CustomerID = 'ANTONI'
);

--Ejercicios: Crear un SP que reciba un numero que verifique que no sea negativo
--Si es negativo imprimir valor no valido, y si no miltiplicarlo por 5 y
--Para mostrar un select

CREATE OR ALTER PROCEDURE usp_numero_multiplicar
@number INT
AS
BEGIN
    IF @number<= 0
    BEGIN
    SELECT 'El numero no puede ser negativo ni cero'
    RETURN;
END;

SELECT (@number * 5) AS [Operacion]
END;

--Ejercicio2 CRear un SP que reciba un nombre y lo imprima en mayusculas

CREATE OR ALTER PROC usp_nombre_mayusculas
@name VARCHAR(15)
AS
BEGIN
    SELECT UPPER(@name) AS [name]
END;

EXEC usp_nombre_mayusculas carlos;
```
# 3 Parametros de salida

Los parametros OUTPUT devueleven valores al usuario

```
/* =================== Parametros de salida ====================== */

CREATE OR ALTER PROC spu_numeros_sumar
@a INT,
@b INT,
@resultado INT output
AS
BEGIN
    SET @resultado = @a + @b
END;

DECLARE @res INT;
EXEC spu_numeros_sumar 5,7, @res OUTPUT;
SELECT @res AS [Resultado]

--Crear un SP que devuelva el area de un circulo 

CREATE OR ALTER PROC usp_area_circulo
@radio DECIMAL (10,2),
@area DECIMAL(10,2) OUTPUT
AS
BEGIN
    --SET @area = PI() * @radio * @radio
    SET @area = PI() * POWER(@radio,2);
END;

DECLARE @r DECIMAL (10,2);
EXEC usp_area_circulo 2.4, @r OUTPUT;
SELECT @r AS [area del circulo];

--Crear un SP que reciba un idCliente y devuelva el nombre

Create OR ALTER PROC spu_cliente_obtener
@id nchar(10),
@name NVARCHAR(40) OUTPUT
AS
BEGIN
    IF LEN(@id) = 5
    BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
    SELECT @name = CompanyName 
    FROM Customers
    WHERE CustomerID = @id;

    RETURN;
END
PRINT 'el customer no existe'
RETURN
END
PRINT 'el ID debe ser de tamaño 5'
END;

SELECT *
FROM Customers

DECLARE @name NVARCHAR(40)
EXEC spu_cliente_obtener 'AROUT', @name OUTPUT
SELECT @name AS [nombre del cliente];
```

# 4 CASE

Sirve para evaluaar condiciones como un switch o if multiple

```
/* =============CASE========*/

CREATE OR ALTER PROC spu_Evaluar_Calificacion
@calif INT
AS
BEGIN
    SELECT 
    CASE
        WHEN @calif >= 90 THEN 'exelcior'
        WHEN @calif >= 70 THEN 'Aprobado'
        WHEN @calif >= 60 THEN 'Regular'
        ELSE 'No acredito'
    END AS [Resultado];
END;

EXEC spu_Evaluar_Calificacion 100;
EXEC spu_Evaluar_Calificacion 75;
EXEC spu_Evaluar_Calificacion 65;
EXEC spu_Evaluar_Calificacion 55;

--Case dentro de un select caso real

CREATE  TABLE bdstored.dbo.Productos
(
    nombre VARCHAR(50),
    precio MONEY
);

--Inserta los datos basados en la consulta (select)
INSERT INTO bdstored.dbo.Productos
SELECT 
    ProductName, UnitPrice
    FROM NORTHWND.dbo.Products;

SELECT COUNT (*) FROM bdstored.dbo.Productos;

--Ejercicio con case

--CREATE OR ALTER PROC usp_

SELECT 
    nombre, precio,
    CASE
        WHEN precio>=200 THEN 'Caro'
        WHEN precio>=200 THEN 'Medio'
        ELSE 'Balatro'
        END AS [Categoria]
FROM bdstored.dbo.Productos;

--Selecciona los clientes con su nombre, pais, ciudad y region (los vlaores nulos, visualizadoscon la leyenda
--sin region), ademas quiero que todo el resultado este mayuscula

CREATE OR ALTER VIEW vw_buena
AS
SELECT 
    UPPER(CompanyName) AS [CompanyName],
    UPPER(c.Country) AS [Country],
    UPPER(c.City) AS [City],
    UPPER (ISNULL(c.Region, 'Sin Region')) AS [RegionLimpia],
    LTRIM(UPPER(CONCAT(e.FirstName,'',e.LastName))) AS [FULLNAME],
    ROUND(SUM(od.Quantity * od.UnitPrice),2) AS [Total],
  CASE
    WHEN SUM(od.Quantity * od.UnitPrice) >= 30000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 60000 THEN 'GOLD'
    when 
    SUM(od.Quantity * od.UnitPrice) >= 10000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 30000 THEN 'SILVER'
    ELSE 'BRONCE'
    END AS [MEDALLON]
FROM NORTHWND.dbo.Customers AS c
INNER JOIN
NORTHWND.dbo.Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN NORTHWND.dbo.[Order Details] AS od
ON o.OrderID = od.OrderID
INNER JOIN NORTHWND.dbo.Employees AS e
ON e.EmployeeID = o.EmployeeID
GROUP BY c.CompanyName,c.Country,c.City, c.Region, CONCAT(e.FirstName,'',e.LastName);

CREATE OR ALTER PROC spu_informe_clientes_empleados
@nombre VARCHAR(50),
@region VARCHAR(50)
AS
BEGIN
    SELECT * 
    FROM vw_buena
    WHERE Fullname = @nombre
    AND RegionLimpia = @region;
END;
```

# 5 Try Catch
Manejo de errores o excepciones en tiempo de ejecucion y manejar lo que sucede cuando ocurren

SINTAXIS

```SQL
BEGIN TRY
--codigo que puede generar un error
END TRY
BEGIN CATCH
--Codigo que se ejecuta si ocurre un error
END CATCH
```

- ¿Como funciona?
1. SQL ejecuta todo lo que esta dentro del TRY
2. Si ocurre un error:
- Se detiene la ejecucion del TRY
- Salta automaticamente al CATCH
3. En el catch se puede:
- Mostrar mensajes
- Registrar Errores
- Revertir transacciones

## Obetener informacion del error

Dentro del catch, SQL SERVER tiene funciones especiales:

| FUNCION| DESCRIPCION |
| :--- | :--- |
| ERROR_MESAGE()| Mensaje de error |
| ERROR_NUMBER() | Numero de error |
| ERROR_LINE | Linea donde ocurrio |
| ERROR_PROCEDURE() | Procedimiento |
| ERROR_SEVERITY() | Nivel de gravedad |
| ERROR_STATE() | Estado del error |

```
/* =========================Manejo de errores con try catch=====================*/

--Sin try catch
Select 10/0;

--Con try cathc

BEGIN TRY
    SELECT 10/0;
END TRY
BEGIN CATCH
    PRINT 'Ocurrio un Error';
END CATCH;

-- Ejemplo de uso de funciones para obtener informacion del error
BEGIN TRY
SELECT 10/0;
END TRY
BEGIN CATCH
    PRINT 'Mensaje' + ERROR_MESAGE();
    PRINT 'Numero de Error' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Linea de Error' + CAST(ERROR_LINE() AS VARCHAR);
    PRINT 'Procedimiento' + ERROR_PROCEDURE();
    PRINT 'Etado del error' + CAST(ERROR_STATE() AS VARCHAR);
END CATCH;

CREATE TABLE clientes2(
id INT PRIMARY KEY,
nombre VARCHAR(35)
)

INSERT INTO clientes2
VALUES (1, 'Panfilo');

BEGIN TRY
    INSERT INTO clientes2
    VALUES (1, 'SILVANO');
END TRY
BEGIN CATCH
    SELECT 'Error al insertar' + ERROR_MESSAGE();
    SELECT 'Error en la linea' + CAST(ERROR_LINE() AS VARCHAR);
END CATCH

BEGIN TRANSACTION

INSERT INTO clientes2
VALUES (3, 'VESPUCIO');

SELECT *
FROM clientes2

COMMIT;
ROLLBACK;

-- Ejemplo de uso de transacciones junto con el try catch

BEGIN TRY
    BEGIN TRANSACTION
    INSERT INTO clientes2 VALUES(4, 'Barragan');
    INSERT INTO clientes2 VALUES (5, 'Roles');
    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 1
    BEGIN
    ROLLBACK;
    END
    PRINT 'Se hizo rollback por el error'
    PRINT 'ERROR: '+ ERROR_MESSAGE();
END CATCH
GO

--Crear un store procedure que inserte un cliente, con las validaciones necesarias
 CREATE OR ALTER PROC usp_insertar_cliente
    @id INT,
    @nombre VARCHAR(35)
 AS
 BEGIN 
    BEGIN TRY
      BEGIN TRANSACTION
      INSERT INTO clientes2
      VALUES (@id, @nombre);

      COMMIT;
      SELECT 'Cliente insertado';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 1
        BEGIN
            ROLLBACK;
        END
        SELECT 'Error:' + ERROR_MESSAGE();
    END CATCH

 END;

/*
 SELECT * FROM clientes2
 UPDATE clientes
 SET nombre = 'Americo Azul'
 WHERE id = 3;

 IF @@ROWCOUNT < 1
 BEGIN
    SELECT @@ROWCOUNT
    SELECT 'No existe el cliente';
END
ELSE
    PRINT 'ya quedo';
*/

CREATE TABLE teams
(
id INT NOT NULL IDENTITY PRIMARY KEY,
nombre NVARCHAR(15)
);
INSERT INTO teams (nombre)
VALUES ('CHAFA AZUL');
--Forma de obtener un identity insertado forma 1
DECLARE @id_insertado INT 
SET @id_insertado = @@IDENTITY
PRINT 'id insertado:' + CAST(@id_insertado AS VARCHAR);
SELECT @id_insertado = @@IDENTITY
PRINT 'id insertado forma 2' + CAST(@id_insertado AS VARCHAR);

INSERT INTO teams (nombre)
VALUES ('JUAN');

--Forma de obtener un identity insertado forma 2
DECLARE @id_insertado2 INT 
SET @id_insertado2 = SCOPE_IDENTITY();
PRINT 'id insertado:' + CAST(@id_insertado2 AS VARCHAR);
SELECT @id_insertado2 = SCOPE_IDENTITY();
PRINT 'id insertado forma 2' + CAST(@id_insertado2 AS VARCHAR);
```