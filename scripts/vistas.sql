CREATE VIEW dept_emp_latest_date AS
SELECT
    emp_no,
    MAX(from_date) AS from_date,
    MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;


CREATE VIEW current_dept_emp AS
SELECT
    l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
FROM dept_emp d
JOIN dept_emp_latest_date l
    ON d.emp_no = l.emp_no
    AND d.from_date = l.from_date
    AND d.to_date = l.to_date;
