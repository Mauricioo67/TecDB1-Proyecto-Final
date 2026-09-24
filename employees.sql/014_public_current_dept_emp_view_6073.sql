-- NOTE: the code below contains the SQL for the object itself
-- as well as for its dependencies or children (if applicable).
-- 
-- This feature is only a convenience in order to allow you to test
-- the whole object's SQL definition at once.
-- 
-- When exporting or generating the SQL for the whole database model
-- all objects will be placed at their original positions.


-- object: employees.dept_emp | type: TABLE --
-- DROP TABLE IF EXISTS employees.dept_emp CASCADE;
CREATE TABLE employees.dept_emp (
	emp_no bigint NOT NULL,
	dept_no character(4) COLLATE pg_catalog."default" NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	CONSTRAINT idx_16889_primary PRIMARY KEY (emp_no,dept_no)
);
-- ddl-end --
ALTER TABLE employees.dept_emp OWNER TO mauricio;
-- ddl-end --

-- object: public.dept_emp_latest_date | type: VIEW --
-- DROP VIEW IF EXISTS public.dept_emp_latest_date CASCADE;
CREATE OR REPLACE VIEW public.dept_emp_latest_date
AS 
SELECT emp_no,
    max(from_date) AS from_date,
    max(to_date) AS to_date
   FROM dept_emp
  GROUP BY emp_no;
-- ddl-end --
ALTER VIEW public.dept_emp_latest_date OWNER TO mauricio;
-- ddl-end --

-- object: public.current_dept_emp | type: VIEW --
-- DROP VIEW IF EXISTS public.current_dept_emp CASCADE;
CREATE OR REPLACE VIEW public.current_dept_emp
AS 
SELECT l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
   FROM (dept_emp d
     JOIN dept_emp_latest_date l ON (((d.emp_no = l.emp_no) AND (d.from_date = l.from_date) AND (d.to_date = l.to_date))));
-- ddl-end --
ALTER VIEW public.current_dept_emp OWNER TO mauricio;
-- ddl-end --

