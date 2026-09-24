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

-- object: employees.titles | type: TABLE --
-- DROP TABLE IF EXISTS employees.titles CASCADE;
CREATE TABLE employees.titles (
	emp_no bigint NOT NULL,
	title character varying(50) COLLATE pg_catalog."default" NOT NULL,
	from_date date NOT NULL,
	to_date date,
	CONSTRAINT idx_16921_primary PRIMARY KEY (emp_no,title,from_date)
);
-- ddl-end --
ALTER TABLE employees.titles OWNER TO mauricio;
-- ddl-end --

