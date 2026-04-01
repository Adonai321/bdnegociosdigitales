CREATE DATABASE bdpracticas;
GO

USE bdpracticas
GO

CREATE TABLE CatProducto
(
Id_producto INT IDENTITY PRIMARY KEY,
Nombre_Producto NVARCHAR(40),
Existencia INT,
Precio MONEY
);

SELECT *
FROM CatProducto

CREATE TABLE CatCliente
(
Id_Cliente NCHAR(5) PRIMARY KEY,
Nombre_Cliente NVARCHAR(40),
Pais NVARCHAR(15),
Ciudad NVARCHAR(15)
);

CREATE TABLE TBLVenta
(
Id_Venta INT IDENTITY PRIMARY KEY,
Fecha DATE,
Id_Cliente NCHAR(5),
FOREIGN KEY (Id_Cliente) REFERENCES CatCliente(Id_Cliente)
);

CREATE TABLE TBLDetalleVenta
(
Id_Venta INT,
Id_Producto INT,
Precio_Venta MONEY,
Cantidad_Vendida INT,
PRIMARY KEY (Id_Venta, Id_Producto),
FOREIGN KEY (Id_Venta) REFERENCES tblVenta(Id_Venta),
FOREIGN KEY (Id_Producto) REFERENCES CatProducto(Id_Producto)
);

INSERT INTO CatProducto (Nombre_Producto, Existencia, Precio)
SELECT ProductName, UnitsInStock, UnitPrice FROM NORTHWND.dbo.Products

INSERT INTO CatCliente(Id_Cliente, Nombre_Cliente,Pais, Ciudad)
SELECT CustomerID, ContactName, Country, City FROM NORTHWND.dbo.Customers

SELECT *
FROM CatProducto

CREATE OR ALTER PROC usp_agregar_ventas
    @Id_Cliente NCHAR(5),
    @Id_Producto INT,
    @Cantidad_Vendida INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        DECLARE @Id_Venta INT;
        DECLARE @Precio_Unitario MONEY;
        DECLARE @Precio_Venta MONEY;
        DECLARE @Existencia INT;

        -- El cliente existe o estoy loco?
        IF NOT EXISTS (
            SELECT 1 FROM CatCliente 
            WHERE Id_Cliente = @Id_Cliente
        )
        BEGIN
            PRINT 'No reconozco a este tipo';
            THROW 50001, 'Cliente no existe', 1;
        END

        PRINT 'A este tipo lo conozco';

        -- Tendre eso que pidio?
        IF NOT EXISTS (
            SELECT 1 FROM CatProducto 
            WHERE Id_Producto = @Id_Producto
        )
        BEGIN
            PRINT 'Creo que ya no tengo, lo siento';
            THROW 50002, 'Producto no existe', 1;
        END

        PRINT 'De pura suerte aun tengo';

        -- Cuanto costara?... Aun tendre?
        SELECT 
            @Precio_Unitario = Precio,
            @Existencia = Existencia
        FROM CatProducto 
        WHERE Id_Producto = @Id_Producto;

        -- Si tendre lo que me pide?
        IF @Existencia < @Cantidad_Vendida
        BEGIN
            PRINT 'No hay suficiente stock';
            THROW 50003, 'Stock insuficiente', 1;
        END

        PRINT 'Stock suficiente';

         -- Precio unitario en el ticket
        SET @Precio_Venta = @Precio_Unitario;

        -- Cuando hicimos la venta en el ticket
        INSERT INTO TBLVenta (Fecha, Id_Cliente)
        VALUES (GETDATE(), @Id_Cliente);

        SET @Id_Venta = @@IDENTITY;

        -- Insertar detalles en el ticket
        INSERT INTO TBLDetalleVenta (Id_Venta, Id_Producto, Cantidad_Vendida, Precio_Venta)
        VALUES (@Id_Venta, @Id_Producto, @Cantidad_Vendida, @Precio_Venta);

        -- Actualizar inventario
        UPDATE CatProducto
        SET Existencia = Existencia - @Cantidad_Vendida
        WHERE Id_Producto = @Id_Producto;

        COMMIT;

        PRINT 'Venta realizada correctamente';

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK;
        END

        PRINT 'Error en la venta';
        PRINT ERROR_MESSAGE();
        PRINT 'Linea: ' + CAST(ERROR_LINE() AS VARCHAR);

    END CATCH
END;

EXEC usp_agregar_ventas
@Id_Cliente = 'ANATR', 
@Id_Producto = 4, 
@Cantidad_Vendida = 5;

SELECT *
FROM TBLDetalleVenta

SELECT *
FROM TBLVenta


--parte 2
CREATE TYPE TipoDetalleVenta AS TABLE
(
    Id_Producto INT,
    Cantidad INT
);
GO

CREATE OR ALTER PROC usp_agregar_productos
@Id_Cliente NCHAR(5),
@Cantidad INT,
@Tabla_Type TYPE 
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            
        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
                PRINT 'Error en la venta';
                PRINT ERROR_MESSAGE();
                PRINT 'Linea: ' + CAST(ERROR_LINE() AS VARCHAR);
    END CATCH
END;