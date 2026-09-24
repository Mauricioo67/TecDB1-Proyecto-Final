-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


-- object: employees.employees | type: TABLE --
-- DROP TABLE IF EXISTS employees.employees CASCADE;
CREATE TABLE employees.employees (
	emp_no bigint NOT NULL,
	birth_date date NOT NULL,
	first_name character varying(14) COLLATE pg_catalog."default" NOT NULL,
	last_name character varying(16) COLLATE pg_catalog."default" NOT NULL,
	gender text COLLATE pg_catalog."default" NOT NULL,
	hire_date date NOT NULL,
	CONSTRAINT idx_16903_primary PRIMARY KEY (emp_no)
);
-- ddl-end --
ALTER TABLE employees.employees OWNER TO mauricio;
-- ddl-end --

	emp_no bigint NOT NULL,
	emp_no bigint NOT NULL,
-- object: titles_ibfk_1 | type: CONSTRAINT --
-- ALTER TABLE employees.titles DROP CONSTRAINT IF EXISTS titles_ibfk_1 CASCADE;
ALTER TABLE employees.titles ADD CONSTRAINT titles_ibfk_1 FOREIGN KEY (emp_no)
REFERENCES employees.employees (emp_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

