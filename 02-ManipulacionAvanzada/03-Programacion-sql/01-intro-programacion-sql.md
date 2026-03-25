# Lenguaje Tarnsact-SQL (MSServer)

## Fundamentos programables

1.¿Qué es la parte programable de T-SQL

Es todo lo que permite: 

- Usar variables
- Controlar el flujo (if/else, while)
- Crear procedimientos almacenados (Stored procedures)
- Disparadores (Triggers)
- Manejar errores
- Crear funciones
- Usar transacciones

Es convertir SQL en un lenguaje casi Cjava pero dentor del motor de base

2. Variables 
Una variable almacena un valor temporal

```
/* ================================== Variables en Transact-SQL*/

DECLARE @edad INT;
SET @edad = 21;

PRINT @edad

SELECT @edad AS [EDAD];

DECLARE @nombre AS VARCHAR(30) = 'San Gallardo';

SELECT @nombre AS [NOMBRE];
SET @nombre = 'San Adonai';
SELECT @nombre AS [Nombre];

/* ============== EJERCICIOS =================*/

/*
Ejercicio 1.

- Declarar una variable precio
- Asignen el valor 150
- Calcular el IVA (16)
- Mostrar el total
*/

DECLARE @precio MONEY = 150;
DECLARE @Iva DECIMAL (10,2);
DECLARE @Total MONEY;

SET @Iva = @precio * 0.16;
SET @Total = @precio + @Iva;

SELECT @precio AS [PRECIO], CONCAT('$', @Iva) AS [IVA (16%)], @Total AS [TOTAL]

```

3. If/Else

Definicion 

Permite ejecutar código según condición

```
DECLARE @edad INT;
SET @edad = 18;

IF NOT @edad >= 18
	PRINT 'Eres mayor de edad';
ELSE
	PRINT 'Eres menor de edad';
    
-- ejercicio mayor a 7 = aprobado de lo contrario reporv (rango con AND)

DECLARE @calificacion INT;
SET @calificacion = -5;

IF @calificacion >=0 AND @calificacion <=10
	IF @calificacion >= 7
		SELECT 'aprovado';
	ELSE
		SELECT 'reprovado';
ELSE 
	SELECT 'que pedo padre'

DECLARE @calif DECIMAL (10,2) = 9.5;

IF @calif >= 0 AND @calif <=10
BEGIN
	IF @calif >=7.0
	BEGIN
	SELECT ('Aprovado')
	END
	ELSE
	BEGIN
	SELECT ('Reprovado')
	END
END
ELSE
BEGIN
SELECT CONCAT(@calif, 'Esta fuera de rango') AS [Respuesta]
END
```
4. WHILE (Ciclos)

