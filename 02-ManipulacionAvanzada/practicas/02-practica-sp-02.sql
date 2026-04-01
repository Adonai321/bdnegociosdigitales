CREATE TYPE TipoDetalleVenta AS TABLE
(
    Id_Producto INT,
    Cantidad INT
);
GO

CREATE OR ALTER PROC usp_agregar_productos
    @Id_Cliente NCHAR(5),
    @Detalles TipoDetalleVenta READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Id_Venta INT;

        -- Validar cliente
        IF NOT EXISTS (
            SELECT 1 FROM CatCliente WHERE Id_Cliente = @Id_Cliente
        )
        BEGIN
            ;THROW 50001, 'Cliente no existe', 1;
        END

        -- Validar productos
        IF EXISTS (
            SELECT d.Id_Producto
            FROM @Detalles d
            LEFT JOIN CatProducto p ON d.Id_Producto = p.Id_Producto
            WHERE p.Id_Producto IS NULL
        )
        BEGIN
            ;THROW 50002, 'Uno o más productos no existen', 1;
        END

        -- Validar stock
        IF EXISTS (
            SELECT 1
            FROM @Detalles d
            INNER JOIN CatProducto p ON d.Id_Producto = p.Id_Producto
            WHERE p.Existencia < d.Cantidad
        )
        BEGIN
            ;THROW 50003, 'Stock insuficiente en uno o mas productos', 1;
        END

        -- Hacer la venta
        INSERT INTO TBLVenta (Fecha, Id_Cliente)
        VALUES (GETDATE(), @Id_Cliente);

        SET @Id_Venta = SCOPE_IDENTITY();

        INSERT INTO TBLDetalleVenta (Id_Venta, Id_Producto, Cantidad_Vendida, Precio_Venta)
        SELECT 
            @Id_Venta, p.Id_Producto, d.Cantidad, p.Precio
        FROM @Detalles d
        INNER JOIN CatProducto p ON d.Id_Producto = p.Id_Producto;

        -- Actualizar inventario
        UPDATE p
        SET p.Existencia = p.Existencia - d.Cantidad
        FROM CatProducto p
        INNER JOIN @Detalles d ON p.Id_Producto = d.Id_Producto;

        COMMIT;

        PRINT 'Venta realizada';

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK;

        PRINT ERROR_MESSAGE();
    END CATCH
END;

DECLARE @ListaProductos TipoDetalleVenta;
INSERT INTO @ListaProductos (Id_Producto, Cantidad)
VALUES 
(1, 2), (3, 1), (5, 4);
EXEC usp_agregar_productos
    @Id_Cliente = 'ANATR',
    @Detalles = @ListaProductos;