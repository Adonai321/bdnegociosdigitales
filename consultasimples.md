# DOCUMENTACIÓN GENERAL: CONSULTAS SQL

## 1 Consultas
Este documento explica las consultas realizadas en SQL utilizando las tablas:

* Categories
* Products
* Orders
* Order Details
* Customers
* Se documentan:
* Consultas simples
* Proyecciones
* Alias
* Campos calculados
* Filtros
* Operadores
* Funciones de fecha
* Funciones de agregado
* GROUP BY
* JOIN

## 2 CONSULTAS BÁSICAS
```
SELECT
```
Permite consultar datos.

```
SELECT * 
FROM Products;
```
Muestra todas las columnas y registros.

```
SELECT ProductID, ProductName, UnitPrice
FROM Products;
```
Seleccionar columnas específicas
Muestra solo esas columnas.

**Alias**
```
SELECT ProductID AS [NUMERO DE PRODUCTO]
FROM Products;
```
Cambia el nombre visual de la columna.

## 3 CAMPOS CALCULADOS

Un campo calculado se obtiene mediante una operación.

**Valor del inventario**
```
(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
```
Calcula cuánto vale el inventario por producto.

**Importe de venta**
```
(UnitPrice * Quantity) AS IMPORTE
```
Calcula el total vendido.

**Importe con descuento**
```
(UnitPrice * Quantity) * (1 - Discount)
```
Aplica el descuento al total.

## 4 FILTROS – WHERE

Permite aplicar condiciones.

**Operadores relacionales**

* mayor que
* < menor que
* = mayor o igual
* <= menor o igual
* = igual
* <> diferente

Ejemplo:
```
WHERE UnitPrice > 30;
```
Productos con precio mayor a 30.

## 5 ORDENAMIENTO
**ORDER BY**
```
ORDER BY UnitPrice DESC;
```
Ordena de mayor a menor.

**TOP**
```
SELECT TOP 10 *
FROM Products;
```
Muestra los primeros 10 registros.

### 6 OPERADORES LÓGICOS

**AND**
```
WHERE UnitPrice > 20 AND UnitsInStock < 100;
```
Ambas condiciones deben cumplirse.

**OR**
```
WHERE Country = 'USA' OR Country = 'Canada';
```
Solo una condición debe cumplirse.

**NOT**

Niega una condición.


###  Precio mayor a 20 y stock menor a 100
```
WHERE UnitPrice > 20 AND UnitsInStock < 100;
```

Muestra productos que cumplen ambas condiciones al mismo tiempo.

###  Clientes de USA o Canadá
```
WHERE Country = 'USA' OR Country = 'Canada';
```

Muestra clientes que pertenezcan a cualquiera de esos dos países.

###  Valores NULL
```
WHERE ShipRegion IS NULL;
```
Muestra pedidos sin región.

```
WHERE ShipRegion IS NOT NULL;
```
Muestra pedidos que sí tienen región.

## OPERADOR IN
```
WHERE Country IN ('Germany','France','UK');
```

Selecciona clientes que pertenezcan a cualquiera de esos países.
## OPERADOR LIKE (comodines)
Empieza con “a”
```
WHERE CompanyName LIKE 'a%';
```
Selecciona nombres que comiencen con la letra "a".

## OPERADOR BETWEEN
```
WHERE UnitPrice BETWEEN 20 AND 40;
```

Muestra productos cuyo precio esté entre 20 y 40 (incluye ambos valores).

## OPERADOR LIKE

Sirve para buscar patrones.

**Comodines**

* % → varios caracteres

* _ → un carácter

* [abc] → cualquiera del grupo

* [^abc] → cualquiera excepto esos

Ejemplo:
```
WHERE CompanyName LIKE 'A%';
```
Empieza con A.

## 11 FUNCIONES DE FECHA

* YEAR()
* MONTH()
* DAY()
* DATEPART()
* DATENAME()

Ejemplo:
```
SELECT YEAR(OrderDate)
FROM Orders;
```
Extrae el año del pedido.

## 12FUNCIONES DE AGREGADO

Estas funciones devuelven un solo registro.

**COUNT()**

Cuenta registros.

```
SELECT COUNT(*)
FROM Orders;
```
Total de órdenes.


**COUNT(DISTINCT)**

```
SELECT COUNT(DISTINCT City)
FROM Customers;
```
Número de ciudades diferentes.

**SUM()**
```
SELECT SUM(UnitPrice)
FROM Products;
```
Suma valores.

**MAX()**
```
SELECT MAX(UnitPrice)
FROM Products;
```
Precio más alto.

**MIN()**
```
SELECT MIN(UnitPrice)
FROM [Order Details];
```
Precio más bajo.

**AVG()**
```
SELECT AVG(UnitPrice)
FROM Products;
```
Promedio de precios.

**ROUND()**
```
ROUND(AVG(UnitPrice),2)
```
Redondea a 2 decimales.

## 13 GROUP BY

Agrupa registros.
```
SELECT CategoryID, COUNT(*)
FROM Products
GROUP BY CategoryID;
```
Número de productos por categoría.

## 14 JOIN

Une tablas relacionadas.
```
SELECT c.CompanyName, COUNT(*)
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;
```
Muestra cuántas órdenes hizo cada cliente.

## 15 CONSULTAS IMPORTANTES DEL EJERCICIO
**Total vendido general**
```
SELECT SUM(UnitPrice*Quantity*(1-Discount))
FROM [Order Details];
```
Total de ingresos.

**Ventas por producto**
```
SELECT ProductID, SUM(UnitPrice*Quantity)
FROM [Order Details]
GROUP BY ProductID;
```
Total vendido por producto.

**Ventas por producto y pedido**
```
GROUP BY ProductID, OrderID;
```

Total vendido por producto en cada orden.

**Cantidad máxima vendida**
```
SELECT ProductID, OrderID, MAX(Quantity)
FROM [Order Details]
GROUP BY ProductID, OrderID;
```
Mayor cantidad vendida por producto por orden.

## 16 Having (Filtro de grupos)

```
SELECT CustomerID, COUNT (*) AS [Numero de ordenes]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
```
* Agrupa órdenes por cliente
* Cuenta cuántas órdenes tiene cada uno
* Filtra solo los que tienen más de 10
* Ordena de mayor a menor

# Consultas
### 1 Calcular costo de inventario
```
SELECT *, (UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;
```
Esta consulta muestra todos los campos de la tabla Products y además calcula el costo total del inventario multiplicando el precio unitario por las unidades en stock.

```
SELECT *,
ProductID,
ProductName,
UnitPrice,
UnitsInStock,
(UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;
```

Esta consulta también calcula el costo de inventario, pero repite explícitamente algunos campos (aunque ya están incluidos por el *).
Multiplica UnitPrice por UnitsInStock para obtener el valor total por producto.

### 2 Calcular importe de venta
```
SELECT *
FROM [Order Details];
```
Muestra todos los campos de la tabla Order Details.

```
SELECT
    OrderID,
    ProductID,
    UnitPrice,
    Quantity,
    (UnitPrice * Quantity) AS IMPORTE
FROM [Order Details];
```

Calcula el importe de cada producto vendido multiplicando el precio unitario por la cantidad vendida.

### 3Calcular importe con descuento
SELECT
    OrderID,
    UnitPrice,
    Discount
FROM [Order Details];

Muestra el ID de la orden, el precio unitario y el descuento aplicado.

```
SELECT
    OrderID,
    UnitPrice,
    Quantity,
    Discount,
    (UnitPrice * Quantity) AS IMPORTE,
    (UnitPrice * Quantity) - ((UnitPrice * Quantity) * Discount)
    AS [Importe con Descuento 1],
    (UnitPrice * Quantity) * (1- Discount)
    AS [Importe con Descuento 2]
FROM [Order Details];
```
Calcula el importe total.
Calcula el importe aplicando descuento de dos formas diferentes.
Ambas fórmulas dan el mismo resultado.

### 4 TOP 10 productos
```
SELECT TOP 10 *
FROM PRODUCTS;
```

Muestra los primeros 10 registros de la tabla Products.

### 5 Productos con precio mayor a 30
```
SELECT ProductID AS [NUMERO DE PRODUCTO],
ProductName AS  [NOMBRE PRODUCTO],
UnitPrice AS  [PRECIO UNITARIO],
UnitsINStock AS  [STOCK]
FROM PRODUCTS
WHERE UnitPrice>30
ORDER BY UnitPrice DESC;
```

Selecciona productos con precio mayor a 30.
Los ordena de mayor a menor según el precio.

### 6 Productos con stock menor a 20
```
WHERE UnitsInStock < 20;
```
Muestra productos con menos de 20 unidades en inventario.

### 7 Pedidos posteriores a 1998
```
SELECT OrderDate, OrderID
FROM Orders
WHERE OrderDate > 1998;
```

Muestra pedidos realizados después del año 1998.

### 8 Extraer partes de la fecha
```
YEAR(OrderDate)
MONTH(OrderDate)
DAY(OrderDate)
DATEPART(...)
DATENAME(...)
```


Extrae año, mes y día.

Obtiene trimestre.

Obtiene número y nombre del día de la semana.

Filtra pedidos posteriores a 1997.

### 9 Total de órdenes
```
SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders;
```
Cuenta el total de órdenes registradas en la tabla Orders.

### 10 Órdenes enviadas a Alemania
```
SELECT COUNT(ShipCountry) AS [Ordenes enviadas a Alemania]
FROM Orders
WHERE ShipCountry = 'GERMANY';
```
Cuenta cuántas órdenes fueron enviadas a Alemania.
```
SELECT COUNT(ShipCountry)
FROM Orders
GROUP BY ShipCountry;
```
Cuenta el número de órdenes por cada país de envío.

### 11 Total de clientes
```
SELECT COUNT(CustomerID)
FROM Customers;
```
Cuenta el total de clientes.
```
SELECT COUNT(Region)
FROM Customers;
```
Cuenta cuántos clientes tienen región registrada (no cuenta valores NULL).

### 12 DISTINCT (Valores únicos)
```
SELECT DISTINCT City
FROM Customers
ORDER BY City ASC;
```

Muestra las ciudades sin repetir.
```
SELECT COUNT(DISTINCT City) AS [Ciudades clientes]
FROM Customers;
```
Cuenta cuántas ciudades diferentes existen en la tabla de clientes.

### 13 MAX (Valor máximo)
Precio más alto
```
SELECT MAX(UnitPrice) AS [Precio mas alto]
FROM Products;
```

Obtiene el precio más alto de los productos.

Fecha más reciente
```
SELECT MAX(OrderDate)
FROM Orders;
```
Obtiene la fecha de compra más reciente.
```
SELECT DATEPART(YEAR, MAX(OrderDate)) AS [Año]
FROM Orders;
```
Obtiene el año de la compra más reciente.

### 14 MIN (Valor mínimo)
```
SELECT MIN(UnitPrice)
FROM [Order Details];
```

Obtiene el precio más bajo registrado en los detalles de órdenes.

### 15 SUM (Sumatorias)
Total de precios de productos
```
SELECT SUM(UnitPrice) AS [Total de los precios]
FROM Products;
```
Suma todos los precios unitarios de los productos.

Total dinero percibido por ventas
```
SELECT SUM(UnitPrice*Quantity*(1-Discount))
FROM [Order Details];
```
Calcula el total real vendido considerando cantidad y descuento.

Total vendido de productos 4, 10 y 20
```
SELECT SUM(UnitPrice*Quantity)
FROM [Order Details]
WHERE ProductID IN (4,10,20);
```
Suma el total vendido solo de esos productos específicos.

### 16 Conteo con condiciones
Órdenes de clientes específicos
```
SELECT COUNT(CustomerID)
FROM Orders
WHERE CustomerID IN ('CHOPS','AROUT','BOLID');
```

Cuenta las órdenes realizadas por esos clientes.

Órdenes entre 1996 y 1997
```
SELECT COUNT(*)
FROM Orders
WHERE DATEPART(YEAR, OrderDate) BETWEEN 1996 AND 1997;
```

Cuenta órdenes realizadas entre esos años.

Órdenes de CHOPS en 1996
```
SELECT COUNT(CustomerID)
FROM Orders
WHERE CustomerID='CHOPS'
AND YEAR(OrderDate)=1996;
```

Cuenta cuántas órdenes hizo ese cliente en 1996.

### 17 GROUP BY (Agrupar datos)
Número de órdenes por cliente
```
SELECT c.CompanyName,
COUNT(*) AS [Numero de Ordenes]
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY 2 DESC;
```

Cuenta cuántas órdenes tiene cada cliente y las ordena de mayor a menor.

Productos por categoría
```
SELECT CategoryID, COUNT(*) AS [productos]
FROM Products
GROUP BY CategoryID
ORDER BY CategoryID;
```

Cuenta cuántos productos hay por cada categoría.

Precio promedio por proveedor
```
SELECT SupplierID,
COUNT(*) AS [Productos del proveedor],
ROUND(AVG(UnitPrice),2) AS [PrecioPromedio]
FROM Products
GROUP BY SupplierID
ORDER BY PrecioPromedio DESC;
```

Cuántos productos tiene cada proveedor.

El precio promedio de sus productos.

Redondeado a 2 decimales.

Ordenado de mayor a menor.

### 18 Ventas agrupadas
Total vendido por producto
```
SELECT ProductID,
SUM(UnitPrice * Quantity) AS [total]
FROM [Order Details]
GROUP BY ProductID;
```

Muestra el total vendido por cada producto.

Total vendido por producto y pedido
```
SELECT ProductID, OrderID,
SUM(UnitPrice * Quantity) AS [total]
FROM [Order Details]
GROUP BY ProductID, OrderID;
```

Muestra cuánto se vendió de cada producto dentro de cada pedido.

Venta específica
```
SELECT *, (UnitPrice * Quantity) AS [Total]
FROM [Order Details]
WHERE OrderID=10847
AND ProductID=1;
```

Muestra el detalle de un producto específico dentro de un pedido específico y calcula su total.

### 19 Máxima cantidad vendida
```
SELECT ProductID, OrderID,
MAX(Quantity) AS [max]
FROM [Order Details]
GROUP BY ProductID, OrderID;
```

Obtiene la mayor cantidad vendida de cada producto en cada pedido.

### 20 Clientes con más de 10 órdenes
```
SELECT CustomerID, COUNT (*) AS [Numero de ordenes]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
```


Agrupa las órdenes por cliente (CustomerID).

Cuenta cuántas órdenes tiene cada cliente.

Muestra solo los clientes que tienen más de 10 órdenes (HAVING COUNT(*) > 10).

Ordena el resultado de mayor a menor según el número de órdenes.

HAVING se usa para filtrar resultados después del GROUP BY.

### 21 Clientes de ciertos países con más de 10 órdenes
```
SELECT CustomerID, ShipCountry, COUNT (*) AS [Numero de ordenes]
FROM Orders
WHERE ShipCountry IN ('Germany', 'FRANCE', 'BRAZIL')
GROUP BY CustomerID, ShipCountry
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
```


Filtra primero las órdenes enviadas a Alemania, Francia o Brasil.

Agrupa por cliente y país de envío.

Cuenta cuántas órdenes tiene cada cliente en esos países.

Muestra solo los que tienen más de 10 órdenes.

Ordena el resultado por la segunda columna (ShipCountry).

WHERE para filtrar antes de agrupar.

HAVING para filtrar después del conteo.

### 22 Nombre del cliente con más de 10 órdenes (usando JOIN)
```
SELECT c.CompanyName, COUNT (*) AS [Numero de ordenes]
FROM Orders AS o
INNER JOIN Customers AS c 
ON o.CustomerID = c.CustomerID
GROUP BY CompanyName
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
```


Une la tabla Orders con Customers mediante CustomerID.

Agrupa por nombre de la empresa (CompanyName).

Cuenta cuántas órdenes tiene cada cliente.

Muestra solo los clientes con más de 10 órdenes.

Ordena de mayor a menor según el número de órdenes.
