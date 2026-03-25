# ¿Qué es una subconsulta?

Una subconsulta es un select dentro de otro select. Puede devolver 
* Un solo valor (escalar)
* Una lista de valores (una columna, varias filas)
* Una tabla (varias columnas y/o varias filas)
* Según lo que devuelva se elige el operador correcto (=, IN, EXIST, etc).

Una subconsulta es una consulta dentro de otra consulta que permite
resolver problemas en varios niveles de información

```
Dependiendo de donde se coloque y que retorne cambia su comportamiento
```

5 grandes formas de usarlas 
* Subconsultas escalares
* Subconsultas con **IN, ANY, ALL**
* Subconsultas correlacionadas
* Subconsultas en **select**
* Subconsultas en **From** (tablas derivadas)

## Escalares
Devuelven un unico valor, por eso se pueden utilizar con operadores **=, >,<**

```
Select *
FROM pedidos
WHERE total = ( SELECT MAX (total) FROM pedidos);
```

## Subconsultas con **IN, ANY, ALL**

Devuelve varios valores pero con una sola columna (IN)

```
SELECT *
FROM clientes
WHERE id_cliente IN (
SELECT id_cliente
FROM pedidos
);

SELECT *
FROM pedidos 
WHERE total IN (SELECT total FROM pedidos WHERE total > 800)
ORDER BY total DESC;

 SELECT DISTINCT p.id_cliente, c.nombre, c.ciudad
 FROM pedidos AS p
 inner join clientes AS C
 on p.id_cliente = c.id_cliente
 WHERE c.ciudad = 'CDMX'
--aporte del profe
 and p.id_cliente IN (SELECT p.id_cliente FROM pedidos)

  SELECT *
 FROM clientes
 WHERE id_cliente not in (SELECT id_cliente FROM pedidos)
```

## clausula ANY
- Compara un valor contra una lista y luego la condición se cumple
- con **al menos uno**

```
valor > ANY (subconsulta)
```

> Es como decir: Mayor que al menos uno de los valores

-Seleccionar pedidos mayores que algún pedido de luis (id_cliente=2)


```
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
```

## clausula ALL
Se cumple contra todos los valores

```
sql
valor > ALL (subconsulta)
```
Significa:
- Mayor que todos los valores

```
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
```

## Subconsultas correlacionadas
> Una Subconsulta correlacionada depende de la fila actual de la consulta principal y se ejecuta una vez por cada fila

1. Seleccionar los cientes cuyo total de compras sea mayor a 1000