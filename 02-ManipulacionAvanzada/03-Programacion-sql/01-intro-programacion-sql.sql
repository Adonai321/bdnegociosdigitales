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


/* ======================== IF/ELSE ======================== */

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

/* ======================== WHILE ======================== */

DECLARE @limite INT = 5;
DECLARE @i INT = 1;

WHILE (@i<=@limite)
BEGIN
	SELECT CONCAT('Numero:', @i)
	SET @i = @i + 1
END