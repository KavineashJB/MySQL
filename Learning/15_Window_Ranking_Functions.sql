-- rownum return the rank/ row_number of rows
-- ultimate usecaase is to de-dup rows

drop table if exists employees;
create table employees (
    emp_id int,
    name varchar(50),
    dept varchar(50),
    hireDate date
);


INSERT INTO Employees (emp_id, name, dept, hireDate)
VALUES
(1, 'Alice',   'HR',      '2020-05-01'),
(1, 'Alice',   'HR',      '2022-06-15'),
(2, 'Bob',     'IT',      '2021-07-10'),
(3, 'Charlie', 'Finance', '2020-09-30'),
(3, 'Charlie', 'Finance', '2022-05-22');


SELECT * FROM employees;

-- dup rows => since there are 2 alice with same id it may be the id unknowing assigned by respective team. So we need to filter only one alice who is joined firstly.

-- filtering only emp_id who joined first
with high as (
select *, 
ROW_NUMBER() over (PARTITION BY emp_id) as rownum from employees
) SELECT * FROM high where rownum=1;


-- rank
drop table if exists students;
create table students (
    sno int,
    name varchar(100),
    score decimal(2)
);

insert into students values (1,'mohan',90),(2,'sowmi',95),(3,'kavi',90),(4,'rithi',95),(5,'loga',87),(6,'sivani',87);

SELECT * FROM students;

-- We'll see the difference between row_number, rank, dense_rank
-- 🔹 ROW_NUMBER()
            -- Always unique
            -- No ties
            -- Increments by 1 for every row
-- 🔹 RANK()
            -- Same rank for ties
            -- Skips numbers after ties
-- 🔹 DENSE_RANK()
            -- Same rank for ties
            -- No gaps

select *,
row_number() over (ORDER BY score desc) as rownum,
rank() over (ORDER BY score desc) as stu_rank, 
dense_rank() over (ORDER BY score desc) as stu_dense_rank
from students;

-- percent_rank => range (0-1), 0-first, 1-last
-- formula: percent_rank=(rank of row - 1)/(tot no.of rows - 1)

SELECT
    sno,
    name,
    score,
    RANK() OVER (ORDER BY score desc) AS rank_val,
    PERCENT_RANK() OVER (ORDER BY score desc) AS percent_rank_val
FROM students;


-- ntile => used to separate the data
-- separate the employees into 4 groups based on their salary so that soon after I can provide hike to them to 10% 
-- formula: ntile(n) = (tot no.of rows) / n
-- if result is whole number to groups normally like 10/2= 5grps
-- else if (10/4)=2.5
-- base = 2 for each groups, remainder = 2 -> first and second rows have extra 1 (2+1=3)
-- 1st-3, 2nd-3, 3rd-2, 4th-2

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

INSERT INTO employees 
(employee_id, first_name, last_name, email, hire_date, job_title, salary)
VALUES
(1,  'John',    'Doe',       'john.doe@company.com',     '2021-03-15', 'Software Engineer', 85000.00),
(2,  'Jane',    'Smith',     'jane.smith@company.com',   '2020-07-10', 'Data Scientist',    92000.00),
(3,  'Arun',    'Kumar',     'arun.kumar@company.com',   '2019-11-05', 'Backend Developer', 78000.00),
(4,  'Priya',   'Sharma',    'priya.sharma@company.com', '2022-01-20', 'Frontend Developer',72000.00),
(5,  'Rahul',   'Verma',     'rahul.verma@company.com',  '2018-06-18', 'DevOps Engineer',   98000.00),
(6,  'Sneha',   'Patel',     'sneha.patel@company.com',  '2023-04-12', 'QA Engineer',       65000.00),
(7,  'Michael', 'Brown',     'michael.brown@company.com','2017-09-25', 'Project Manager',  105000.00),
(8,  'Anjali',  'Mehta',     'anjali.mehta@company.com', '2021-12-01', 'Business Analyst',  83000.00),
(9,  'David',   'Wilson',    'david.wilson@company.com', '2020-02-14', 'System Architect', 115000.00),
(10, 'Karthik', 'R',         'karthik.r@company.com',    '2022-08-08', 'Cloud Engineer',    90000.00);


SELECT employee_id, first_name, salary FROM employees;

select employee_id, first_name, salary, 
ntile(3) over (order by salary desc) as group_number
from employees;