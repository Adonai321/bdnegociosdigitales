SELECT *
FROM Clientes

SELECT *
FROM Representantes --Empleados;

SELECT *
FROM Productos;

SELECT *
FROM Oficinas;

SELECT * 
FROM Pedidos;

--Crear una vista que visualice el total de los importes por productos

CREATE or ALTER VIEW vw_importes_productos
AS
SELECT pr.Descripcion AS [Nombre producto], SUM(p.Importe) AS [total], SUM(p.Importe*1.15) AS [importeDescuento]
FROM Pedidos AS p
inner join Productos AS pr
ON p.Fab = pr.Id_fab
AND p.Producto = pr.Id_producto
GROUP BY pr.Descripcion;

SELECT * 
FROM vw_importes_productos
WHERE [Nombre producto] like '%brazo'
AND importeDescuento > 34000

--Seleccionar los nombre de los representantes y las oficinas donde trabajan

CREATE or ALTER VIEW vw_oficinas_representantes
AS
SELECT 
r.Nombre,
o.Region,
r.Ventas AS [ventas_representantes],
o.Ciudad,  
o.Oficina, o.Ventas AS [ventas_oficinas]
FROM Representantes AS r
INNER JOIN Oficinas AS o
ON r.Oficina_Rep = o.Oficina

SELECT *
FROM Representantes
WHERE Nombre = 'Daniel Ruidrobo'

SELECT Nombre, Ciudad
FROM vw_oficinas_representantes
ORDER BY Nombre DESC

--seleccionar los pedidos con fecha e importe, el nombre del representante y al cliente que lo utilizo

SELECT p.Num_Pedido, p.Fecha_Pedido, p.Importe, c.Empresa, r.Nombre
FROM Pedidos AS p
inner join Clientes AS c
ON c.Num_Cli = p.Cliente
inner join Representantes AS r
ON r.Num_Empl = p.Rep

--seleccionar los pedidos con fecha e importe, el nombre del representante que atendio al cliente que lo utilizo

SELECT p.Num_Pedido, p.Fecha_Pedido, p.Importe, c.Empresa, r.Nombre
FROM Pedidos AS p
inner join Clientes AS c
ON c.Num_Cli = p.Cliente
inner join Representantes AS r
ON r.Num_Empl = c.Rep_Cli