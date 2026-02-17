--Crear base de datos
CREATE DATABASE tienda;
GO

USE tienda;

--Crear tabla cliente

CREATE TABLE cliente(
	id INT not null,
	nombre NVARCHAR(30) not null,
	apaterno NVARCHAR(10) not null,
	amaterno NVARCHAR(10) null,
	sexo NCHAR(1) not null,
	edad INT not null,
	direccion NVARCHAR (80) not null,
	rfc NVARCHAR(20) not null,
	limitedecredito MONEY not null DEFAULT 500.00
);
GO

--Restricciones
CREATE TABLE clientes(
	cliente_id INT not null PRIMARY KEY,
	nombre nvarchar(30) not null,
	apellido_paterno NVARCHAR(20) not null,
	apellido_materno NVARCHAR(20),
	edad INT not null,
	fecha_nacimiento DATE not null,
	limite_credito MONEY not null,
);
GO

INSERT INTO clientes
VALUES (1, 'GOKU', 'LINTERNA', 'SUPERMAN', 450, '1578-01-17', 100);

INSERT INTO clientes
VALUES (2, 'PANCRACIO', 'RIVERO', 'PATROCLO', 20, '1578-01-17', 10000);

INSERT INTO clientes (nombre, cliente_id, limite_credito, fecha_nacimiento, apellido_paterno, edad)
VALUES ('ARCADIA', 3, 45800, '2000-01-22', 'RAMIREZ', 26);

INSERT INTO clientes
VALUES (4, 'VANESA', 'BUENA VISTA', null, 26, '2000-04-25', 3000);

INSERT INTO clientes
VALUES (5, 'Soyla', 'Vaca', 'Del Corral', 42, '1983-04-06', 78955),
(6, 'Bad Bunny', 'Perez', 'Sinsentido', 22, '1999-05-06', 85858),
(7, 'Jose Luis', 'Herrera', 'Gallardo', 42, '1983-04-06', 14000);

SELECT *
FROM clientes

SELECT GETDATE(); --obtiene la fecha del sistema

--Restricciones
CREATE TABLE clientes_2(
	cliente_id INT not null identity(1,1),
	nombre NVARCHAR(50) not null,
	edad INT not null,
	fecha_registro DATE DEFAULT GETDATE(),
	limite_credito MONEY not null,
	CONSTRAINT pk_clientes_2
	PRIMARY KEY (cliente_id)
);

SELECT *
FROM clientes_2;

INSERT INTO clientes_2
VALUES ('Chespirito', 89, DEFAULT, 45500);

INSERT INTO clientes_2 (nombre, edad, limite_credito)
VALUES ('Batman', 45, 890000);

INSERT INTO clientes_2 
VALUES ('Robin', 35, '2026-01-19', 89.32);

INSERT INTO clientes_2 (limite_credito, edad, nombre, fecha_registro)
VALUES (12.33, 24, 'Flash Reverso', '2026-01-21');

CREATE TABLE suppliers (
	supplier_id INT not null IDENTITY(1,1),
	[name] NVARCHAR(30) not null,
	date_register date not null DEFAULT GETDATE(),
	tipo CHAR(1) not null,
	credit_limit MONEY not null,
	CONSTRAINT pk_suppliers
	PRIMARY KEY (supplier_id),
	CONSTRAINT unique_name
	UNIQUE ([name]),
	CONSTRAINT chk_credit_limit
	CHECK (credit_limit > 0.0 and credit_limit <= 50000),
	CONSTRAINT chk_tipo
	CHECK (tipo in ('A', 'B', 'C'))
);

SELECT *
FROM suppliers

INSERT INTO suppliers
VALUES (UPPER('Bimbo'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (UPPER('Tia Rosa'), '2026-01-21', UPPER('a'), 4999.99);

INSERT INTO suppliers (name, tipo, credit_limit)
VALUES (UPPER('Tia mensa'), UPPER('a'), 45000);

--CREAR BASE DE DATOS DBORDERS
CREATE DATABASE dborders;
GO

USE dborders;
GO

CREATE TABLE customers (
	customer_id INT not null IDENTITY(1,1),
	first_name NVARCHAR (20) not null, 
	last_name NVARCHAR (30),
	[address] NVARCHAR (80) not null,
	number INT,
	CONSTRAINT pk_customers
	PRIMARY KEY (customer_id)
);

CREATE TABLE suppliers (
	supplier_id INT,
	[name] NVARCHAR(30) not null,
	date_register date not null DEFAULT GETDATE(),
	tipo CHAR(1) not null,
	credit_limit MONEY not null,
	CONSTRAINT pk_suppliers
	PRIMARY KEY (supplier_id),
	CONSTRAINT unique_name
	UNIQUE ([name]),
	CONSTRAINT chk_credit_limit
	CHECK (credit_limit > 0.0 and credit_limit <= 50000),
	CONSTRAINT chk_tipo
	CHECK (tipo in ('A', 'B', 'C'))
);

CREATE TABLE products(
	product_id INT not null IDENTITY (1,1),
	[name] NVARCHAR (40) not null,
	quantity INT not null,
	unit_price MONEY not null,
	supplier_id INT,
	CONSTRAINT pk_products
	PRIMARY KEY (product_id),
	CONSTRAINT unique_name_products
	UNIQUE ([name]),
	CONSTRAINT chk_quantity
	CHECK (quantity between 1 and 100),
	CONSTRAINT chk_unitprice
	CHECK (unit_price > 0 AND unit_price <= 100000),
	CONSTRAINT fk_products_suppliers
	FOREIGN KEY (supplier_id)
	REFERENCES suppliers (supplier_id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
);
GO
CREATE TABLE products(
	product_id INT not null IDENTITY (1,1),
	[name] NVARCHAR (40) not null,
	quantity INT not null,
	unit_price MONEY not null,
	supplier_id INT,
	CONSTRAINT pk_products
	PRIMARY KEY (product_id),
	CONSTRAINT unique_name_products
	UNIQUE ([name]),
	CONSTRAINT chk_quantity
	CHECK (quantity between 1 and 100),
	CONSTRAINT chk_unitprice
	CHECK (unit_price > 0 AND unit_price <= 100000),
	CONSTRAINT fk_products_suppliers
	FOREIGN KEY (supplier_id)
	REFERENCES suppliers (supplier_id)
	ON DELETE SET NULL
	ON UPDATE SET NULL
);


DROP TABLE products;

INSERT INTO suppliers
VALUES (1,UPPER('Chino S.A'), DEFAULT, UPPER('c'), 45000);

INSERT INTO suppliers
VALUES (2,UPPER('Chanclotas'), '2026-01-21', UPPER('a'), 4999.99);

INSERT INTO suppliers (supplier_id, [name], tipo, credit_limit)
VALUES (3,UPPER('Ramama'), UPPER('b'), 45000);

INSERT INTO products
Values('Papas', 10, 5.3, 1)

INSERT INTO products
Values('Rollos Primavera', 20, 100, 1)

INSERT INTO products
Values('chanclas pata de gallo', 50, 20, 2);

INSERT INTO products
Values('chanclas buenas', 30, 56.7, 2),
	('ramita chiquita', 56, 78.23, 3)

INSERT INTO products
Values('azulito',35, 100, null);

-- Comprobacion on delete no action


--Eliminar al padre
DELETE FROM products 
WHERE supplier_id = 1;

-- Eliminar los hijos
DELETE FROM products 
WHERE supplier_id = 1;

--Comprobar el update NO ACTION
UPDATE suppliers
SET supplier_id =10
WHERE supplier_id =2;

--Permite cambiar el tipo de una columna en la tabla
ALTER TABLE products
ALTER COLUMN supplier_id INT null;
SELECT *
FROM products

-- por si falla
DROP TABLE products
DROP TABLE suppliers

ALTER TABLE products
DROP CONSTRAINT fk_products_suppliers;

UPDATE products
SET supplier_id = null

DELETE FROM products
WHERE supplier_id = 1;

UPDATE products
SET supplier_id = 3
WHERE product_id IN (1006);

SELECT *
FROM suppliers

SELECT *
FROM products

UPDATE products
SET suplier_id = 20
WHere supplier_id is null;

UPDATE products
SET supplier_id = NULL
WHERE supplier_id = 2

--coprobar ON DELETE SET NULL
DELETE suppliers
WHERE supplier_id = 10

--Comprobar ON Update set null
UPDATE suppliers
SET supplier_id = 20
WHERE supplier_id = 1