-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


-- object: employees | type: SCHEMA --
-- DROP SCHEMA IF EXISTS employees CASCADE;
CREATE SCHEMA employees;
-- ddl-end --
ALTER SCHEMA employees OWNER TO mauricio;
-- ddl-end --

-- object: employees.departments | type: TABLE --
-- DROP TABLE IF EXISTS employees.departments CASCADE;
CREATE TABLE employees.departments (
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	dept_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT idx_16884_primary PRIMARY KEY (dept_no)
);
-- ddl-end --
ALTER TABLE employees.departments OWNER TO mauricio;
-- ddl-end --

