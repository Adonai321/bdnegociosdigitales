/*
Funciones de agregado:
1.sum()
2.max()
3.min()
4.avg()
5.count(*)
6.count(campo)
Nota: estas funcines solamente regresan un solo registro
*/

SELECT *
FROM Orders;

--Agregacion count(*) cuenta el número de registros que tiene una tabla

SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders;

--Seleccionar el total de ordenes que fueron enviadas a Alemania

SELECT COUNT(ShipCountry) AS [Ordenes enviadas a Alemania]
FROM Orders
WHERE ShipCountry = 'GERMANY';

SELECT COUNT(ShipCountry) AS [Ordenes enviadas a Alemania]
FROM Orders
GROUP BY ShipCountry;

SELECT *
FROM Customers;

SELECT count (customerID)
FROM Customers;

SELECT count (Region)
FROM Customers;
 --Seleccione de cuantas ciudades son las ciudades de los clientes

 SELECT City
 FROM Customers
 ORDER BY City ASC;

 SELECT DISTINCT City
 FROM Customers
 ORDER BY City ASC;

 SELECT COUNT (DISTINCT City) AS [Ciudades clientes]
 FROM Customers
 ORDER BY City ASC;

 --Selecciona el precio maximo de los productos
 SELECT *
 FROM Products 
 ORDER BY UnitPrice DESC;

 SELECT MAX(UnitPrice) AS [Precio mas alto]
 FROM Products;

 --seleccionar la fecha de compra mas actual, seleccionar el año de la fecha de compra mas reciente

 SELECT MAX (OrderDate) AS [la fecha de compra mas actual]
 FROM Orders
 ORDER BY OrderDate DESC;

 SELECT MAX(YEAR(OrderDate))
 FROM Orders;

 SELECT DATEPART (YEAR, MAX(OrderDate))AS [Año]
 FROM Orders;

 --Cual es la minima cantidad de los pedidos
 
 SELECT MIN(UnitPrice) AS [madafaka]
 FROM [Order Details];

 --Cual es el importe mas bajo de las compras

 SELECT (UnitPrice*Quantity*(1-Discount)) AS [Importe]
 FROM [Order Details]
 ORDER BY [Importe] ASC;

 --Quiero el total de los precios de los productos
 SELECT SUM(UnitPrice) AS [Total de los precios]
 FROM Products;

 --Obtener el total de dinero percibido por las ventas
 SELECT SUM(UnitPrice*Quantity*(1-Discount)) AS [Importe mas Bajo]
 FROM [Order Details];

 --Seleccionar las ventas totales de los productos 4, 10, 20
 SELECT SUM(UnitPrice*Quantity) AS [total de 4, 10 y 20]
 FROM [Order Details]
 WHERE  ProductID IN (4, 10, 20)

 --Seleccionar el numero de ordenes hechas por los siguientes clientes [Arounf the Hornd (AROUT), Bólido comidas preparadas (BOLID), Chop-suey Chinese (CHOPS)]

 SELECT COUNT(CustomerID) AS [NUmero de ordenes]
 FROM Orders
 WHERE CustomerID= 'CHOPS' OR CustomerID= 'AROUT' OR CustomerID= 'BOLID';

 --Seleccionar el total de ordenes del segundo trimestre de 1996



 --Seleccionar los años entre 1999-1997
 SELECT COUNT (*) AS [Numero de ordenes]
 FROM Orders
 WHERE DATEPART (YEAR, OrderDate) between 1996 and 1997;

 --Seleccionar el numero de clientes que comienzan con a o que comienzan con b
 SELECT CustomerID AS [clientes que comienzan con A o B]
 FROM Customers
 WHERE CompanyName LIKE 'a%' OR  CompanyName LIKE 'b%';

  --Seleccionar el numero de clientes que comienzan con b y que terminan con s
 SELECT CustomerID AS [clientes que comienzan con A o B]
 FROM Customers
 WHERE CompanyName LIKE 'b%s';


 --Seleccionar el numero de ordenes realizadas por el cliente Chop-Suey Chinese CHOPS
 SELECT COUNT(CustomerID) AS [NUmero de ordenes]
 FROM Orders
 WHERE CustomerID= 'CHOPS'
 and YEAR(OrderDate) =1996

 /*
 group by Y having 
 */

 SELECT 
 customers.CompanyName,
 COUNT(*) AS [NUmero de Ordenes]
 FROM Orders
 INNER JOIN 
 Customers
 ON orders.CustomerID = Customers.CustomerID
 GROUP BY Customers.CompanyName
 ORDER BY 2 DESC;

 --segunda forma con alias
 SELECT 
 c.CompanyName,
 COUNT(*) AS [NUmero de Ordenes]
 FROM Orders AS o
 INNER JOIN 
 Customers AS c
 ON o.CustomerID = c.CustomerID
 GROUP BY c.CompanyName
 ORDER BY 2 DESC;

 --Seleccionar el numero de productos (conteo) por categoria, mostrar categoriaID, total de los productos ordenarlos de mayor a menor
 --por el total de productos 

 SELECT CategoryID, COUNT(*) AS [productos]
 FROM Products
 GROUP BY CategoryID
 ORDER BY CategoryID ASC;

 --Seleccionar el precio promedio por proveedor de los productos, redondear a dos decimales el resultado
 --ordenar de forma descendente por el precio promedio

 SELECT SupplierID, Count(SupplierID) AS [Productos del provedor], ROUND(AVG(UnitPrice), 2) AS [PrecioPromedio]
 FROM Products
 GROUP BY SupplierID
 ORDER BY PrecioPromedio DESC;

 --Seleccionar el numero de clientes por país y ordenarlos por paíz alfabeticamente

 --obtener la cantidad total vendida agrupada por producto y pedido
 
 SELECT SUM(UnitPrice * Quantity * (1-Discount)) AS [total]
 FROM [Order Details]

 SELECT ProductID, SUM(UnitPrice * Quantity) AS [total]
 FROM [Order Details]
 GROUP BY ProductID
 ORDER BY ProductID

 SELECT ProductID, OrderID, SUM(UnitPrice * Quantity) AS [total]
 FROM [Order Details]
 GROUP BY ProductID, OrderID
 ORDER BY ProductID

 SELECT *, (UnitPrice * Quantity) AS [Total]
 FROM [Order Details]
 WHERE OrderID= 10847
 AND ProductID = 1

 --Seleccionar la cantidad maxima vendida por producto por cada pedido

 SELECT ProductID,OrderID, MAX(Quantity) AS [max]
 FROM [Order Details]
 GROUP BY ProductID, OrderID
 ORDER BY ProductID, OrderID

 SELECT *
 from [Order Details]
