# Migración de Base de Datos Employees: MariaDB → PostgreSQL 18

## Tecnología de Base de Datos I

### Proyecto Final - Bloque 3
**Migración de un sistema informático a otro SGBD**

---

## Información del proyecto

**Estudiante:** Johny Mauricio Mita Gutierrez  
**Asignatura:** Tecnología de Base de Datos I  
**Tema:** Migración de tablas, vistas y consultas de verificación  
**Motor origen:** MariaDB 11.8.9  
**Motor destino:** PostgreSQL 18  

---

# Descripción

Este proyecto documenta el proceso de migración de la base de datos
`employees` desde MariaDB hacia PostgreSQL 18.

El objetivo principal fue trasladar la estructura, datos y objetos de la
base de datos, verificando posteriormente que la información mantuviera
su consistencia e integridad.

La migración incluye:

- Tablas y registros.
- Vistas SQL.
- Validaciones de integridad referencial.
- Comparación de datos entre ambos gestores.
- Generación de respaldo PostgreSQL.

---

# Arquitectura utilizada

El entorno fue implementado mediante Docker Compose:

```
                    Docker Compose

        +----------------------+
        |       MariaDB        |
        |  Base: employees     |
        +----------+-----------+
                   |
                   |
              Migración
             (pgloader)
                   |
                   v

        +----------------------+
        |    PostgreSQL 18     |
        |  Base: employees     |
        +----------------------+
```

---

# Herramientas utilizadas

- Docker
- Docker Compose
- MariaDB 11.8.9
- PostgreSQL 18
- pgloader
- psql
- pg_dump
- GitHub

---

# Proceso realizado

## 1. Migración de tablas

Se realizó la transferencia de las tablas:

- employees
- departments
- dept_emp
- dept_manager
- salaries
- titles

La validación se realizó comparando la cantidad de registros
en MariaDB y PostgreSQL.

Resultado:

| Tabla | Estado |
|---|---|
| employees | ✓ Validada |
| departments | ✓ Validada |
| dept_emp | ✓ Validada |
| dept_manager | ✓ Validada |
| salaries | ✓ Validada |
| titles | ✓ Validada |

---

## 2. Migración de vistas

Se migraron y adaptaron las vistas:

- `dept_emp_latest_date`
- `current_dept_emp`

Se verificó su funcionamiento mediante consultas en PostgreSQL.

---

## 3. Verificaciones realizadas

Se ejecutaron pruebas para comprobar la consistencia de los datos:

### Conteo de registros

Comparación entre MariaDB y PostgreSQL:

- Misma cantidad de filas en todas las tablas.

### Integridad referencial

Se verificó:

- Empleados sin departamento.
- Salarios sin empleados asociados.
- Títulos sin empleados asociados.

Resultado:

```
Registros inconsistentes encontrados: 0
```

### Comparación de valores

Se realizaron sumatorias de datos para comprobar coincidencia:

```
SUM(emp_no)
SUM(salary)
```

Los resultados fueron iguales en ambos gestores.

---

# Estructura del repositorio

```
.
├── README.md
├── INFORME_FINAL.md
├── employees_backup.dump
├── docker-compose.yml
│
└── scripts
    ├── migracion.load
    ├── vistas.sql
    └── verificaciones.sql
```

---

# Archivos principales

| Archivo | Descripción |
|-|-|
| `INFORME_FINAL.md` | Informe completo de la migración |
| `employees_backup.dump` | Backup de PostgreSQL generado con pg_dump |
| `scripts/migracion.load` | Configuración utilizada para pgloader |
| `scripts/vistas.sql` | Creación de vistas PostgreSQL |
| `scripts/verificaciones.sql` | Consultas de validación |
| `docker-compose.yml` | Configuración del entorno Docker |

---

# Restauración del backup

El respaldo fue generado utilizando:

```bash
pg_dump -h localhost -U mauricio -d employees \
-F c -f employees_backup.dump
```

Para restaurarlo:

```bash
pg_restore -h localhost -U mauricio \
-d nueva_base employees_backup.dump
```

---

# Resultado final

La migración fue completada satisfactoriamente.

Las verificaciones realizadas confirmaron:

- Datos transferidos correctamente.
- Coincidencia de registros.
- Integridad referencial conservada.
- Vistas funcionando en PostgreSQL.
- Backup generado correctamente.

---

# Autor

**Johny Mauricio Mita Gutierrez**

Proyecto académico realizado para la asignatura:

**Tecnología de Base de Datos I**
