-- Subconsulta escalar (un valor)

-- Escalar en select

SELECT o.OrderID, (od.Quantity * od.UnitPrice) AS [total], 
(SELECT AVG (od.Quantity * od.UnitPrice)FROM [Order Details] AS od) AS [AVGTOTAL]
FROM Orders AS o
inner join [Order Details] AS od
ON o.OrderID = od.OrderID

--Mostrar el nombre del producto y el precio promedio de todos los productos
SELECT ProductName, (SELECT AVG (UnitsInStock *  UnitPrice) FROM Products) AS [precio promedio]
FROM Products 

--Mostrar cada empleado y la cantidad de pedidos que tiene
SELECT e.EmployeeID, (SELECT COUNT (*)FROM orders AS o WHERE e.EmployeeID = o.EmployeeID ) AS [Intermedio]
FROM Employees AS e

SELECT e.EmployeeID, FirstName, LastName, COUNT (o.OrderID) AS [Numero de ordenes]
FROM Employees AS e
inner join Orders AS o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, FirstName, LastName

SELECT *
FROM Employees;


-- Mostrar cada cliente y la fecha de su ultimo producto
SELECT *
FROM Customers AS C
inner join Orders AS O 
ON c.CustomerID = o.CustomerID
GROUP BY C.CustomerID

-- mostrar pedidos con nombre del cliente y total de l pedido (sum)

-- Datos de ejemplo
CREATE DATABASE bdsubconsultas;
GO

USE NORTHWND;
GO

CREATE TABLE clientes (
id_cliente INT not null IDENTITY (1,1) PRIMARY KEY,
nombre NVARCHAR(50) not null,
ciudad NCHAR(20) not null
);

CREATE TABLE pedidos (
id_pedido INT not null IDENTITY (1,1) PRIMARY KEY,
id_cliente INT not null,
total MONEY not null,
fecha DATE not null,
CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes(id_cliente)
);

--Consulta escalar (obtener el total maximo de las ordenes)

SELECT *
FROM [Order Details]


INSERT INTO clientes (nombre, ciudad) VALUES
('Ana', 'CDMX'),
('Luis', 'Guadalajara'),
('Marta', 'CDMX'),
('Pedro', 'Monterrey'),
('Sofia', 'Puebla'),
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz');

INSERT INTO pedidos (id_cliente, total, fecha) VALUES
(1, 1000.00, '2024-01-10'),
(1, 500.00,  '2024-02-10'),
(2, 300.00,  '2024-01-05'),
(3, 1500.00, '2024-03-01'),
(3, 700.00,  '2024-03-15'),
(1, 1200.00, '2024-04-01'),
(2, 800.00,  '2024-02-20'),
(3, 400.00,  '2024-04-10');

--Seleccionar los pedidos en donde el total sea igual al total maximo de ellos

SELECT MAX(total)
FROM pedidos;

Select *
FROM pedidos
WHERE total = ( SELECT MAX (total) FROM pedidos);

SELECT TOP 1 p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos AS p
inner join clientes AS c
ON p.id_cliente = c.id_cliente
ORDER BY  p.total DESC;
--Manera alternativa
SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos AS p
inner join clientes AS c
ON p.id_cliente = c.id_cliente
WHERE p.total = ( SELECT MAX (total) FROM pedidos)

--Seleccionar los pedidos mayores al pomedio

SELECT MIN (id_cliente)
FROM pedidos;

SELECT *
FROM pedidos
WHERE id_cliente = (SELECT MIN (id_cliente) FROM pedidos);


SELECT id_cliente, COUNT(*) AS [Numero de pedidos]
FROM pedidos
WHERE id_cliente = (SELECT MIN (id_cliente) FROM pedidos)
GROUP BY id_cliente;


SELECT AVG(total)
FROM pedidos

--Mostrar los pedidos 
SELECT MAX (fecha)
FROM pedidos;

SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE fecha = (
SELECT MAX(fecha)
FROM pedidos);

--Mostrar todos los pedidos con un total que sea el mas bajo

SELECT *
FROM pedidos 
WHERE total = (SELECT MIN (total) FROM pedidos);

SELECT *
FROM pedidos

--Seleccionar los pedidos con el nombre del cleinte cuyo total (Freight) sea mayor al 
--promedio general de freight

SELECT o.OrderID, c.CompanyName, o.Freight
FROM Orders AS o
INNER JOIN Customers AS C
ON o.CustomerID = C.CustomerID
WHERE o.Freight > (SELECT AVG(Freight) FROM Orders)

SELECT
o.OrderID, c.CompanyName, CONCAT(e.FirstName, ' ', e.LastName) AS [FULLNAME],
o.Freight
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c. CustomerID
INNER JOIN Employees AS e
ON e. EmployeeID = o. EmployeeID
WHERE o. Freight > (
SELECT AVG(Freight)
FROM Orders
);

--Subqueries con IN, ANY, ALL 
--La clausula IN
--Clientes que han hecho pedidos

SELECT *
FROM pedidos

SELECT *
FROM clientes
WHERE id_cliente IN (
SELECT id_cliente
FROM pedidos
);

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
inner join pedidos AS p
ON c.id_cliente = p.id_cliente

--clientes que han hecho pedidos mayores a 800
SELECT *
FROM pedidos 
WHERE total IN (SELECT total FROM pedidos WHERE total > 800)
ORDER BY total DESC;

--consulta del profe


--Seleccionar todos los clientes de la cdmx que han hecho pedidos

 SELECT DISTINCT p.id_cliente, c.nombre, c.ciudad
 FROM pedidos AS p
 inner join clientes AS C
 on p.id_cliente = c.id_cliente
 WHERE c.ciudad = 'CDMX'
--aporte del profe
 and p.id_cliente IN (SELECT p.id_cliente FROM pedidos)

 --seleccionar clientes que no han hecho pedidos

 SELECT c.id_cliente, c.nombre, c.ciudad
 FROM pedidos AS p
 right join clientes AS c
 ON p.id_cliente = c.id_cliente
 WHERE p.id_cliente is null

 SELECT *
 FROM clientes
 WHERE id_cliente not in (SELECT id_cliente FROM pedidos)

 --seleccionar los pedidos de clientes de monterrey
 SELECT *
 FROM clientes c
 WHERE c.ciudad = 'Monterrey'

 --profe
 SELECT *
 FROM clientes AS c
 LEFT JOIN pedidos AS p
 ON c.id_cliente = p.id_cliente
 WHERE c.ciudad = 'Monterrey'

 --Seleccionar pedidos mayores que algún pedido de luis (id_cliente=2)
 --primero la subconsulta
 SELECT total
 FROM pedidos
 WHERE id_cliente = 2

 --consulta principal
SELECT *
FROM pedidos
WHERE total > ANY(
	SELECT total
	FROM pedidos
	WHERE id_cliente = 2
	)


	---SELECCIONAR PEDIDOS QUE SEAN MAYORES(TOTAL) DE ALGUN PEDIDO DE ANA 

	SELECT *
	FROM pedidos
	WHERE id_cliente = 1

SELECT *
FROM pedidos
WHERE total > ANY (
SELECT total
	FROM pedidos
	WHERE id_cliente = 1)

---SELECCIOANR LOS PEDIDOS MAYIRES QUE ALHUN PEDIDO SUPERIOR A 500 (total)

SELECT *
FROM pedidos 
WHERE total > 500

SELECT *
FROM pedidos 
WHERE total > ANY (SELECT total
FROM pedidos 
WHERE total > 500)

---ALL

--Seleccionar los pedidos donde el total sea mayor a los totales de los pedidos de Luis
SELECT TOTAL
FROM pedidos
WHERE id_cliente = 2

SELECT total
FROM pedidos

SELECT total
FROM pedidos
WHERE total > ALL (
SELECT TOTAL
FROM pedidos
WHERE id_cliente = 2
)

--seleccionar todos los clientes donde su ID sea menor que todos los clientes de la CDMX
SELECT id_cliente
FROM clientes
WHERE ciudad= 'CDMX'

SELECT *
FROM clientes
WHERE id_cliente < ALL(
SELECT id_cliente
FROM clientes
WHERE ciudad= 'CDMX'
)

--Subconsultas correlacionadas
SELECT SUM(total)
FROM pedidos AS p

SELECT *
FROM clientes AS c
WHERE (
SELECT SUM(total)
FROM pedidos AS p
WHERE p.id_cliente = c.id_cliente
) > 1000

SELECT SUM(total)
FROM pedidos AS p
WHERE p.id_cliente = 3

--Seleccionar todos los clientes que han hecho mas de un pedido

SELECT COUNT(*)
FROM pedidos AS p
WHERE p.id_cliente = 2

SELECT *
FROM clientes AS c
WHERE (
SELECT COUNT(*)
FROM pedidos AS p
WHERE p.id_cliente = c.id_cliente
) > 1

--Seleccionar todos los pedidos en donde su total debe ser mayor al promedio de los totales hechos por los clientes

SELECT AVG (total) AS promedio
FROM pedidos
WHERE id_cliente = 1

SELECT *
FROM pedidos AS p
WHERE total > (
SELECT AVG (total) AS promedio
FROM pedidos AS pe
WHERE p.id_cliente = pe.id_cliente
)

--Seleccionar todos los clientes cuyo pedido maximo sea mayor a 1200

SELECT MAX(total)
FROM pedidos AS p
WHERE p.id_cliente = 1

SELECT *
FROM clientes AS c
WHERE (
SELECT MAX(total)
FROM pedidos AS p
WHERE p.id_cliente = c.id_cliente
) > 1200


SELECT *
FROM pedidos

SELECT *
FROM clientes