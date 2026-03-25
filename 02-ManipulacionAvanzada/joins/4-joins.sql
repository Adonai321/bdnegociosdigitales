/**
JOINS

1. INNER JOIN
2. LEFT JOIN
3. RIGTH JOIN
4.FULL JOIN
**/

--Seleccionar las categorias y sus productos

SELECT categories.CategoryID,
categories.CategoryName,
Products.ProductID,
Products.ProductName,
Products.UnitPrice,
Products.UnitsInStock,
(products.UnitPrice * Products.UnitsInStock)
AS [Precio inventario]
FROM Categories
INNER JOIN Products
ON categories.CategoryID = products.CategoryID
categories.Categories

/**
grupo logico de ejecucion de sql
from
inner join
where
group by
having
select
distinct
order by
**/

--Having (filtro de grupos)

--Mostrar los clientes que hayan realizado mas de 10 pedidos
SELECT CustomerID, COUNT (*) AS [NUmero de ordenes]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

SELECT CustomerID,ShipCountry, COUNT (*) AS [NUmero de ordenes]
FROM Orders
WHERE ShipCountry IN ('Germany', 'FRANCE', 'BRAZIL')
GROUP BY CustomerID, ShipCountry
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

SELECT c.CompanyName, COUNT (*) AS [NUmero de ordenes]
FROM Orders AS o
INNER JOIN
Customers AS c ON o.CustomerID=c.CustomerID
GROUP BY CompanyName
HAVING COUNT(*) > 10
ORDER BY 2 DESC;

--Seleccionar los empleados que hayan gestinado pedidos por un total superior a 100000 en ventas (Mostrar el ID del empleado y el nombre y total de compras)
SELECT CONCAT( e.FirstName,'', e.LastName) AS [nombre completo], (od.Quantity*od.UnitPrice*(1-od.Discount)) AS [Importe]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] AS od
ON o.OrderID=od.OrderID
ORDER BY e.FirstName ASC

SELECT CONCAT( e.FirstName,'', e.LastName) AS [nombre completo], 
ROUND(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 2) AS [Importe]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] AS od
ON o.OrderID=od.OrderID
GROUP BY e.FirstName, e.LastName
HAVING SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) > 100000
ORDER BY [Importe] DESC


--Nuevos joins con bdejemplos
SELECT TOP 0 CategoryID, CategoryName
INTO categoria
FROM Categories

ALTER TABLE categoria
ADD CONSTRAINT pk_categoria
PRIMARY KEY (CategoryID);

INSERT INTO categoria
VALUES ('C1'), ('C2'), ('C3'), ('C4'), ('C5');

SELECT TOP 0 ProductID AS [numero_producto], ProductName AS [Nombre_producto], CategoryID AS [catego_id]
INTO producto
FROM Products;

ALTER TABLE producto
ADD CONSTRAINT pk_producto
PRIMARY KEY (numero_producto);

ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria
FOREIGN KEY (catego_id)
REFERENCES categoria (CategoryID)
ON DELETE CASCADE;

INSERT INTO producto
VALUES('p1', 1), ('p2', 2), ('p3', 3), ('p4', 4), ('p5', null), ('p6', null);

SELECT *
FROM categoria AS c
inner join producto AS p
ON c.CategoryID = p.catego_id;

SELECT * 
FROM categoria;

SELECT *
From [Order Details]

SELECT *
FROM producto;

--left join
SELECT *
FROM categoria AS c
left join producto AS p
ON c.CategoryID = p.catego_id;

--right join
SELECT *
FROM categoria AS c
right join producto AS p
ON c.CategoryID = p.catego_id;

--full join
SELECT *
FROM categoria AS c
FULL join producto AS p
ON c.CategoryID = p.catego_id;

--simular el right join del query anterior con un left join

SELECT c.CategoryID, c.CategoryName, p.numero_producto, p.Nombre_producto, p.catego_id
FROM categoria AS c
right join producto AS p
ON c.CategoryID = p.catego_id;

SELECT c.CategoryID, c.CategoryName, p.numero_producto, p.Nombre_producto, p.catego_id
FROM producto AS p
left join categoria AS c
ON c.CategoryID = p.catego_id;

--visualizar todas las ctegorias que no tienen productos
SELECT *
FROM categoria AS c
left join producto AS p
ON c.CategoryID = p.catego_id
WHERE numero_producto is null;

--seleccionar todos los productos que no tienen categoria
SELECT *
FROM categoria AS c
right join producto AS p
ON c.CategoryID = p.catego_id
WHERE c.CategoryID is null

SELECT *
FROM producto AS p
left join categoria AS c
ON c.CategoryID = p.catego_id
WHERE c.CategoryID is null

--guardar en una tabla de productos nuevos todos aquellos productos que fueron agregados recientemente y no estan 
--en esta tabla de apoyo

--Crear la tabla de products_new a partir de products mediante una consulta
SELECT TOP 0
ProductID AS [Product_number], ProductName AS [product_name], UnitPrice AS [Unit_price], UnitsInStock AS [Stock], (UnitPrice * UnitsInStock) AS [total]
INTO products_new
FROM Products

ALTER TABLE products_new
ADD CONSTRAINT pk_products_new
PRIMARY KEY ([product_number])

SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock, (p.UnitPrice * p.UnitsInStock) AS [total], pw.*
FROM Products AS p
LEFT JOIN products_new AS pw
ON p.ProductID = pw.product_number;

INSERT INTO products_new
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock, (p.UnitPrice * p.UnitsInStock) AS [total]
FROM Products AS p
LEFT JOIN products_new AS pw
ON p.ProductID = pw.product_number
WHERE pw.product_number is null


--que termine con cualquiera de las sleytas a,c,e y que empiece con cualquiera de las letras a,c
WHERE CompanyName like '[a,c]%[a,c,e]'