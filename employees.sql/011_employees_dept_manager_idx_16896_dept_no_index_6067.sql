-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
-- object: idx_16896_dept_no | type: INDEX --
-- DROP INDEX IF EXISTS employees.idx_16896_dept_no CASCADE;
CREATE INDEX idx_16896_dept_no ON employees.dept_manager
USING btree
(
	dept_no pg_catalog.bpchar_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

