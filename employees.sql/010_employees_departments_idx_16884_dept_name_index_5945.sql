-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


	dept_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
-- object: idx_16884_dept_name | type: INDEX --
-- DROP INDEX IF EXISTS employees.idx_16884_dept_name CASCADE;
CREATE UNIQUE INDEX idx_16884_dept_name ON employees.departments
USING btree
(
	dept_name pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

