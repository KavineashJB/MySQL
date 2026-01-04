drop table if exists employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_title, salary)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2022-05-01', 'Software Engineer', 85000.00),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '2023-03-15', 'Data Scientist', 92000.00),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2024-05-01', 'Engineer', 95000.00),
(4, 'Mark', 'Taylor', 'mark.taylor@example.com', '2022-11-15', 'Manager', 100000.00),
(5, 'Gowtham', 'sb', 'mark.taylor@example.com', '2022-11-15', 'Data Engineer', 110000.00),
(6, 'Peter', 'sb', 'mark.taylor@example.com', '2022-11-15', 'Data Engineer', 120000.00);

-- syntax
-- create view view_name as query

-- select emps with salaray > 90000;

create view high_sal as
select * from employees where salary > 90000;

select first_name from high_sal;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_title, salary)
VALUES
(7, 'meera', 'snow', 'meera.snow@example.com', '2022-07-14', 'Software Engineer', 95000.00)

-- after inserting record 7 immediately executes below command
select * from high_sal; -- you no need to re-execute the create view query it automatically updates when the table record changes.
-- Views doesn't store in the memory