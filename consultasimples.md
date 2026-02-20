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
