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