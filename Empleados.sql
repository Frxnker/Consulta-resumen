DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

-- 1. Calcula la suma del presupuesto de todos los departamentos.
SELECT SUM(presupuesto) AS suma_presupuesto FROM departamento;

-- 2. Calcula la media del presupuesto de todos los departamentos.
SELECT AVG(presupuesto) AS media_presupuesto FROM departamento;

-- 3. Calcula el valor mínimo del presupuesto de todos los departamentos.
SELECT MIN(presupuesto) AS minimo_presupuesto FROM departamento;

-- 4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (
    SELECT MIN(presupuesto) 
    FROM departamento
);

-- 5. Calcula el valor máximo del presupuesto de todos los departamentos.
SELECT MAX(presupuesto) AS maximo_presupuesto FROM departamento;

-- 6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (
    SELECT MAX(presupuesto) 
    FROM departamento
);

-- 7. Calcula el número total de empleados que hay en la tabla empleado.
SELECT COUNT(*) AS total_empleados FROM empleado;

-- 8. Calcula el número de empleados que no tienen NULL en su segundo apellido.
SELECT COUNT(*) AS empleados_sin_apellido2
FROM empleado
WHERE apellido2 IS NOT NULL;

-- 9. Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
SELECT d.nombre AS nombre_departamento, COUNT(e.id) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
GROUP BY d.id;

-- 10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
SELECT d.nombre AS nombre_departamento, COUNT(e.id) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
GROUP BY d.id
HAVING COUNT(e.id) > 2;

-- 11. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.
SELECT d.nombre AS nombre_departamento, COUNT(e.id) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
GROUP BY d.id, d.nombre;

-- 12. Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.
SELECT d.nombre AS nombre_departamento, COUNT(e.id) AS numero_empleados
FROM departamento d
JOIN empleado e ON d.id = e.id_departamento
WHERE d.presupuesto > 200000
GROUP BY d.id;