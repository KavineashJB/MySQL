-- union for remove dups
-- union all doesn't remove dups just select as it is
-- Main Condition: no.of cols and datatype of cols should be same.

drop table if exists employees, contractors;
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE contractors (
    contractor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    hourly_rate DECIMAL(10,2)
);

INSERT INTO employees (first_name, last_name, position, salary)
VALUES
('Alice', 'Smith', 'Developer', 70000.00),
('Bob', 'Johnson', 'Developer', 75000.00),
('Charlie', 'Lee', 'Manager', 90000.00);

INSERT INTO contractors (first_name, last_name, position, hourly_rate)
VALUES
('Dave', 'Williams', 'Developer', 40.00),
('Eve', 'Brown', 'Tester', 35.00),
('Bob', 'Johnson', 'Developer', 45.00);

-- here both employees and contractors having same no.of cols and same datatype of each cols even the col name is different 
SELECT * from employees
union ALL
SELECT * FROM contractors;

SELECT * from employees
union
SELECT * FROM contractors;
-- we can't see the output difference for both union and union all due to there is no dup rows
-- but let try the below query
-- union all ==> doesn't remove dup rows
select first_name, last_name, position from employees
union ALL
SELECT first_name, last_name, position from contractors;

-- union ==> remove dup rows
-- one bob record will be removed
select first_name, last_name, position from employees
union
SELECT first_name, last_name, position from contractors;

-- you can also union mutliple tables
show tables;
SELECT * FROM customers;

-- below query is not a practical usecase it's just for showing union can also used with multiple tables other than the below one doesn't mean anything
select first_name, last_name, position from employees
union
SELECT first_name, last_name, position from contractors
UNION
select name, email, city from customers;