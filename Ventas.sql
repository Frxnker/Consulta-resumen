DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE cliente (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoría INT UNSIGNED
);

CREATE TABLE comercial (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  comisión FLOAT
);

CREATE TABLE pedido (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,
  id_cliente INT UNSIGNED NOT NULL,
  id_comercial INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- 1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT SUM(total) AS cantidad_total_pedidos
FROM pedido;

-- 2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(total) AS cantidad_media_pedidos
FROM pedido;

-- 3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT COUNT(DISTINCT id_comercial) AS total_comerciales_distintos
FROM pedido;

-- 4. Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT count(*) AS total_clientes
FROM cliente;

-- 5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(total) AS mayor_cantidad_pedido
FROM pedido;

-- 6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(total) AS menor_cantidad_pedido
FROM pedido;

-- 7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT ciudad, MAX(categoría) AS max_categoria
FROM cliente
GROUP BY ciudad;

-- 8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
	-- Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. 
    -- Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
    -- Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
SELECT cliente.id AS id_cliente, cliente.nombre, cliente.apellido1, cliente.apellido2, MAX(pedido.fecha) AS fecha, MAX(pedido.total) AS valor_cantidad
FROM cliente
JOIN pedido ON cliente.id = pedido.id_cliente
GROUP BY cliente.id, pedido.fecha;

-- 9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
SELECT cliente.id AS id_cliente, cliente.nombre, cliente.apellido1, cliente.apellido2, MAX(pedido.fecha) AS fecha, MAX(pedido.total) AS valor_cantidad
FROM cliente
JOIN pedido ON cliente.id = pedido.id_cliente
GROUP BY cliente.id, pedido.fecha
HAVING MAX(pedido.total) > 2000;

-- 10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
SELECT comercial.id AS id_comercial, comercial.nombre, comercial.apellido1, comercial.apellido2, MAX(pedido.total) AS total
FROM comercial
JOIN pedido ON comercial.id = pedido.id_comercial
WHERE pedido.fecha = '2016-08-17'
GROUP BY comercial.id, comercial.nombre, comercial.apellido1, comercial.apellido2;

-- 11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes. 
	-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
SELECT cliente.id AS id_cliente, cliente.nombre, cliente.apellido1, cliente.apellido2, 
       COUNT(pedido.id) AS total_pedidos
FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
GROUP BY cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2;

-- 12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017.
SELECT cliente.id AS id_cliente, cliente.nombre, cliente.apellido1, cliente.apellido2, 
       COUNT(pedido.id) AS total_pedidos
FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
WHERE YEAR(pedido.fecha) = 2017
GROUP BY cliente.id, cliente.nombre, cliente.apellido1, cliente.apellido2;

-- 13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
	-- El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.
SELECT cliente.id AS id_cliente, cliente.nombre, cliente.apellido1, 
       MAX(IFNULL(pedido.total, 0)) AS maxima_cantidad_pedido
FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
GROUP BY cliente.id, cliente.nombre, cliente.apellido1;

-- 14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT pedido.*
FROM pedido
JOIN (
    SELECT YEAR(fecha) AS año, MAX(total) AS max_total
    FROM pedido
    GROUP BY YEAR(fecha)
) maximos_por_anio ON YEAR(pedido.fecha) = maximos_por_anio.año AND pedido.total = maximos_por_anio.max_total;

-- 15. Devuelve el número total de pedidos que se han realizado cada año.
SELECT YEAR(fecha) AS año, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY YEAR(fecha);