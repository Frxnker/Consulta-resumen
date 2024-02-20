DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Calcula el número total de productos que hay en la tabla productos.
SELECT count(*)
FROM producto;

-- 2. Calcula el número total de fabricantes que hay en la tabla fabricante.
SELECT count(*)
FROM fabricante;

-- 3. Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.
SELECT count(DISTINCT fabricantes)
FROM producto;

-- 4. Calcula la media del precio de todos los productos.
SELECT avg(precio)
FROM producto;

-- 5. Calcula el precio más barato de todos los productos.
SELECT min(precio)
FROM producto;

-- 6. Calcula el precio más caro de todos los productos.
SELECT max(precio)
FROM producto;

-- 7. Lista el nombre y el precio del producto más barato.
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT min(precio) FROM producto);

-- 8. Lista el nombre y el precio del producto más caro.
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT max(precio) FROM producto);

-- 9. Calcula la suma de los precios de todos los productos.
SELECT sum(precio)
FROM producto;

-- 10. Calcula el número de productos que tiene el fabricante Asus.
SELECT count(id_fabricante)
FROM producto
WHERE id_fabricante = 1;

-- 11. Calcula la media del precio de todos los productos del fabricante Asus.
SELECT avg(precio)
FROM producto
WHERE id_fabricante = 1;

-- 12. Calcula el precio más barato de todos los productos del fabricante Asus.
SELECT min(precio)
FROM producto
WHERE id_fabricante = 1;

-- 13. Calcula el precio más caro de todos los productos del fabricante Asus.
SELECT max(precio)
FROM producto
WHERE id_fabricante = 1;

-- 14. Calcula la suma de todos los productos del fabricante Asus.
SELECT sum(precio)
FROM producto
WHERE id_fabricante = 1;

-- 15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
SELECT 
	max(producto.precio), min(producto.precio),
	avg(precio), count(*)
FROM producto INNER JOIN fabricante
	ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre = 'Crucial';

-- 16. Muestra el número total de productos que tiene cada uno de los fabricantes. 
	-- El listado también debe incluir los fabricantes que no tienen ningún producto. 
	-- El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
	-- Ordene el resultado descendentemente por el número de productos.
SELECT fabricante.nombre, count(producto.id)
FROM 
	fabricante LEFT JOIN producto
	ON fabricante.id = producto.id_fabricante
GROUP BY fabricante.id
ORDER BY 2 DESC;

-- 17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
	-- El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
SELECT 
	fabricante.nombre, 
    max(producto.precio), min(producto.precio), avg(producto.precio)
FROM 
	fabricante INNER JOIN producto
    ON fabricante.id = producto.id_fabricante
GROUP BY fabricante.id;

-- 18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
	-- No es necesario mostrar el nombre del fabricante, con el identificador del fabricante es suficiente.
SELECT 
    id_fabricante AS id_fabricante,
    MAX(precio) AS precio_maximo,
    MIN(precio) AS precio_minimo,
    AVG(precio) AS precio_medio,
    COUNT(*) AS total_productos
FROM 
    producto
GROUP BY 
    id_fabricante;

-- 19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
	-- Es necesario mostrar el nombre del fabricante.
SELECT 
    fabricante.nombre AS nombre_fabricante,
    MAX(p.precio) AS precio_maximo,
    MIN(p.precio) AS precio_minimo,
    AVG(p.precio) AS precio_medio,
    COUNT(p.id) AS total_productos
FROM 
    producto
INNER JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
GROUP BY 
    fabricante.id;

-- 20. Calcula el número de productos que tienen un precio mayor o igual a 180€.
SELECT COUNT(*) AS numero_productos
FROM producto
WHERE precio >= 180;

-- 21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
SELECT 
    fabricante.id AS id_fabricante,
    fabricante.nombre AS nombre_fabricante,
    COUNT(p.id) AS numero_productos
FROM 
    fabricante
LEFT JOIN 
    producto ON fabricante.id = producto.id_fabricante
WHERE 
    producto.precio >= 180
GROUP BY 
    fabricante.id, fabricante.nombre;

-- 22. Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del fabricante.
SELECT 
    id_fabricante,
    AVG(precio) AS precio_medio
FROM 
    producto
GROUP BY 
    id_fabricante;

-- 23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
SELECT 
    fabricante.nombre AS nombre_fabricante,
    AVG(p.precio) AS precio_medio
FROM 
    fabricante
INNER JOIN 
    producto ON fabricante.id = producto.id_fabricante
GROUP BY 
    fabricante.nombre;

-- 24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
SELECT 
    fabricante.nombre AS nombre_fabricante
FROM 
    fabricante
INNER JOIN 
    producto ON fabricante.id = producto.id_fabricante
GROUP BY 
    fabricante.nombre;

-- 25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
SELECT 
    fabricante.nombre AS nombre_fabricante
FROM 
    fabricante
INNER JOIN 
    producto ON fabricante.id = producto.id_fabricante
GROUP BY 
    fabricante.id;

-- 26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
	-- No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
SELECT 
    fabricante.nombre AS nombre_fabricante,
    COUNT(producto.id) AS numero_productos
FROM 
    fabricante
INNER JOIN 
    producto ON fabricante.id = producto.id_fabricante
WHERE 
    producto.precio >= 220
GROUP BY 
    fabricante.id, fabricante.nombre;

-- 27.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
	-- El listado debe mostrar el nombre de todos los fabricantes, es decir, 
	-- si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.
SELECT 
    fabricante.nombre AS nombre_fabricante,
    COALESCE(COUNT(p.id), 0) AS numero_productos
FROM 
    fabricante
LEFT JOIN 
    producto ON fabricante.id = producto.id_fabricante AND producto.precio >= 220
GROUP BY 
    fabricante.id, fabricante.nombre;

-- 28. Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
SELECT 
    fabricante.nombre AS nombre_fabricante
FROM 
    fabricante
INNER JOIN 
    producto ON fabricante.id = producto.id_fabricante
GROUP BY 
    fabricante.id;

-- 29. Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
	-- El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.
SELECT 
    producto.nombre AS nombre_producto,
    producto.precio,
    fabricante.nombre AS nombre_fabricante
FROM 
    (
        SELECT 
            id_fabricante,
            MAX(precio) AS max_precio
        FROM 
            producto
        GROUP BY 
            id_fabricante
    ) AS max_precios
INNER JOIN 
    producto ON max_precios.id_fabricante = producto.id_fabricante AND max_precios.max_precio = producto.precio
INNER JOIN 
    fabricante ON producto.id_fabricante = fabricante.id
ORDER BY 
    fabricante.nombre;
