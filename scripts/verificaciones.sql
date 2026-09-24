-- ==========================================
-- CONSULTAS DE VERIFICACIÓN MIGRACIÓN
-- MariaDB -> PostgreSQL
-- Base: employees
-- ==========================================


-- 1. Conteo de registros por tabla

SELECT 'employees' AS tabla, COUNT(*) AS registros 
FROM employees.employees

UNION ALL

SELECT 'departments', COUNT(*) 
FROM employees.departments

UNION ALL

SELECT 'dept_emp', COUNT(*) 
FROM employees.dept_emp

UNION ALL

SELECT 'dept_manager', COUNT(*) 
FROM employees.dept_manager

UNION ALL

SELECT 'salaries', COUNT(*) 
FROM employees.salaries

UNION ALL

SELECT 'titles', COUNT(*) 
FROM employees.titles;



-- 2. Integridad referencial

-- Empleados sin departamento

SELECT COUNT(*) AS empleados_sin_departamento
FROM employees.employees e
LEFT JOIN employees.dept_emp de
ON e.emp_no = de.emp_no
WHERE de.emp_no IS NULL;


-- Salarios sin empleado

SELECT COUNT(*) AS salarios_sin_empleado
FROM employees.salaries s
LEFT JOIN employees.employees e
ON s.emp_no = e.emp_no
WHERE e.emp_no IS NULL;


-- Títulos sin empleado

SELECT COUNT(*) AS titulos_sin_empleado
FROM employees.titles t
LEFT JOIN employees.employees e
ON t.emp_no = e.emp_no
WHERE e.emp_no IS NULL;



-- 3. Checksum de datos

SELECT 
SUM(emp_no) AS suma_emp_no,
SUM(salary) AS suma_salary
FROM employees.salaries;



-- 4. Verificación de claves duplicadas

SELECT emp_no, COUNT(*)
FROM employees.employees
GROUP BY emp_no
HAVING COUNT(*) > 1;


SELECT dept_no, COUNT(*)
FROM employees.departments
GROUP BY dept_no
HAVING COUNT(*) > 1;



-- 5. Prueba de vistas migradas

SELECT COUNT(*) 
FROM dept_emp_latest_date;


SELECT COUNT(*) 
FROM current_dept_emp;


SELECT *
FROM current_dept_emp
LIMIT 5;
