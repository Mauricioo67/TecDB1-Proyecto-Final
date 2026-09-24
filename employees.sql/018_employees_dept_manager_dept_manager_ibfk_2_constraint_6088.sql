-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


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

	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
-- object: dept_manager_ibfk_2 | type: CONSTRAINT --
-- ALTER TABLE employees.dept_manager DROP CONSTRAINT IF EXISTS dept_manager_ibfk_2 CASCADE;
ALTER TABLE employees.dept_manager ADD CONSTRAINT dept_manager_ibfk_2 FOREIGN KEY (dept_no)
REFERENCES employees.departments (dept_no) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE RESTRICT;
-- ddl-end --

