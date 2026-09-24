# Informe Final - Migración MariaDB a PostgreSQL

## Portada

**Asignatura:** Tecnología de Base de Datos I  
**Unidad:** Bloque 3 - Migración de un sistema informático a otro SGBD  
**Tema:** Migración de tablas, vistas y consultas de verificación (MariaDB → PostgreSQL)  

**Estudiante:**  Johny Mauricio Mita Gutierrez  
**Fecha:** 29 de septiembre de 2026  

---

# 1. Introducción

El presente informe documenta la migración de la base de datos `employees`
desde MariaDB hacia PostgreSQL 18.

La migración incluye:

- Transferencia de tablas y datos.
- Migración y adaptación de vistas.
- Consultas de verificación de integridad.
- Comparación de resultados entre ambos gestores.
- Generación de respaldo de PostgreSQL.

El entorno utilizado fue Docker Compose con los servicios:

- MariaDB 11.8.9
- PostgreSQL 18
- pgloader
- psql
- Docker

---

# 2. Entorno utilizado

## Contenedores activos

Comando utilizado:

```bash
docker ps
```

Resultado:

```text
postgresql     PostgreSQL 18
mariadb        MariaDB 11.8.9
pgadmin4       PgAdmin
adminer        Administrador web
```

---

# 3. Migración de tablas

## 3.1 Conteo de registros en MariaDB

Consulta ejecutada:

```sql
SELECT 'employees' AS tabla, COUNT(*) AS registros FROM employees
UNION ALL
SELECT 'departments', COUNT(*) FROM departments
UNION ALL
SELECT 'dept_emp', COUNT(*) FROM dept_emp
UNION ALL
SELECT 'dept_manager', COUNT(*) FROM dept_manager
UNION ALL
SELECT 'salaries', COUNT(*) FROM salaries
UNION ALL
SELECT 'titles', COUNT(*) FROM titles;
```

Resultado MariaDB:

```text
employees       300024
departments          9
dept_emp        331603
dept_manager        24
salaries       2844047
titles          443308
```

---

## 3.2 Conteo de registros en PostgreSQL

Consulta ejecutada:

```sql
SELECT 'employees' AS tabla, COUNT(*) AS registros 
FROM employees.employees
UNION ALL
SELECT 'departments', COUNT(*) FROM employees.departments
UNION ALL
SELECT 'dept_emp', COUNT(*) FROM employees.dept_emp
UNION ALL
SELECT 'dept_manager', COUNT(*) FROM employees.dept_manager
UNION ALL
SELECT 'salaries', COUNT(*) FROM employees.salaries
UNION ALL
SELECT 'titles', COUNT(*) FROM employees.titles;
```

Resultado PostgreSQL:

```text
employees       300024
departments          9
dept_emp        331603
dept_manager        24
salaries       2844047
titles          443308
```

---

## 3.3 Comparación

Los resultados obtenidos muestran que:

| Tabla | MariaDB | PostgreSQL |
|---|---:|---:|
| employees | 300024 | 300024 |
| departments | 9 | 9 |
| dept_emp | 331603 | 331603 |
| dept_manager | 24 | 24 |
| salaries | 2844047 | 2844047 |
| titles | 443308 | 443308 |

Conclusión:

La migración de datos fue correcta debido a que todos los conteos coinciden.

---

# 4. Verificación de integridad referencial

## Empleados sin departamento

Consulta:

```sql
SELECT COUNT(*) AS empleados_sin_departamento
FROM employees.employees e
LEFT JOIN employees.dept_emp de
ON e.emp_no = de.emp_no
WHERE de.emp_no IS NULL;
```

Resultado:

```text
0
```

---

## Salarios sin empleado

Consulta:

```sql
SELECT COUNT(*) AS salarios_sin_empleado
FROM employees.salaries s
LEFT JOIN employees.employees e
ON s.emp_no=e.emp_no
WHERE e.emp_no IS NULL;
```

Resultado:

```text
0
```

---

## Títulos sin empleado

Consulta:

```sql
SELECT COUNT(*) AS titulos_sin_empleado
FROM employees.titles t
LEFT JOIN employees.employees e
ON t.emp_no=e.emp_no
WHERE e.emp_no IS NULL;
```

Resultado:

```text
0
```

---

# 5. Verificación mediante checksum

Consulta:

```sql
SELECT 
SUM(emp_no),
SUM(salary)
FROM employees.salaries;
```

Resultado PostgreSQL:

```text
SUM(emp_no)     719707262094
SUM(salary)     181480757419
```

Resultado MariaDB:

```text
SUM(emp_no)     719707262094
SUM(salary)     181480757419
```

Conclusión:

Los valores calculados coinciden entre ambos gestores.

---

# 6. Migración de vistas

## 6.1 Vista dept_emp_latest_date

Definición original MariaDB:

```sql
CREATE VIEW dept_emp_latest_date AS
SELECT
emp_no,
MAX(from_date) AS from_date,
MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;
```

Versión PostgreSQL:

```sql
CREATE VIEW dept_emp_latest_date AS
SELECT
emp_no,
MAX(from_date) AS from_date,
MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;
```

---

## 6.2 Vista current_dept_emp

Versión PostgreSQL:

```sql
CREATE VIEW current_dept_emp AS
SELECT
l.emp_no,
d.dept_no,
l.from_date,
l.to_date
FROM dept_emp d
JOIN dept_emp_latest_date l
ON d.emp_no=l.emp_no
AND d.from_date=l.from_date
AND d.to_date=l.to_date;
```

---

# 7. Pruebas de vistas

Consulta:

```sql
SELECT COUNT(*) FROM dept_emp_latest_date;

SELECT COUNT(*) FROM current_dept_emp;
```

Resultado:

```text
dept_emp_latest_date
300024

current_dept_emp
300024
```

Consulta de ejemplo:

```sql
SELECT * FROM current_dept_emp LIMIT 5;
```

Resultado:

```text
10075 d005 1988-05-17 2001-01-15
10076 d005 1996-07-15 9999-01-01
10078 d005 1994-09-29 9999-01-01
10081 d004 1986-10-30 9999-01-01
10082 d008 1990-01-03 1990-01-15
```

---

# 8. Validación de claves duplicadas

## Tabla employees

```sql
SELECT emp_no, COUNT(*)
FROM employees.employees
GROUP BY emp_no
HAVING COUNT(*) > 1;
```

Resultado:

```text
0 filas
```

---

## Tabla departments

```sql
SELECT dept_no, COUNT(*)
FROM employees.departments
GROUP BY dept_no
HAVING COUNT(*) > 1;
```

Resultado:

```text
0 filas
```

---

# 9. Backup PostgreSQL

Se generó el respaldo mediante:

```bash
pg_dump -h localhost -U mauricio -d employees -F c \
-f employees_backup.dump
```

Archivo generado:

```text
employees_backup.dump
Tamaño: 35 MB
```

---

# 10. Estructura del proyecto

```
tecBD1/
│
├── INFORME_FINAL.md
├── employees_backup.dump
│
├── scripts/
│   ├── migracion.load
│   ├── vistas.sql
│   └── verificaciones.sql
│
├── docker-compose.yml
└── README.md
```

---

# 11. Conclusiones

La migración desde MariaDB hacia PostgreSQL fue realizada correctamente.

Las verificaciones realizadas demostraron:

- Igual cantidad de registros en todas las tablas.
- Ausencia de registros huérfanos.
- Coincidencia de valores calculados mediante sumas.
- Correcto funcionamiento de las vistas migradas.
- Generación exitosa del respaldo PostgreSQL.

La base de datos quedó preparada para ser utilizada en PostgreSQL 18.

