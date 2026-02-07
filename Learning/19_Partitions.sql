-- Partitions:
    -- splitting large table into smaller logical tables based on a column, while still treating it as a single table.
    -- basically partition is based on year, dates,...

-- Types (3):
        -- 1) Range
        -- 2) list
        -- 3) hash

DROP TABLE IF EXISTS orders;

-- syntax
-- partition by partition_type (column) (
--     partition partition_name values less than (value),
--     ...
-- );

-- ** Note: While creating table itself we've to create a partition for it. **


-- Rank Partitions
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT,
    order_date DATE NOT NULL,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2),
    PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p_before_2020 VALUES LESS THAN (2020),
    PARTITION p_2020        VALUES LESS THAN (2021),
    PARTITION p_2021        VALUES LESS THAN (2022),
    PARTITION p_2022        VALUES LESS THAN (2023),
    PARTITION p_future      VALUES LESS THAN MAXVALUE
)

INSERT INTO orders (order_date, customer_name, amount)
VALUES
('2019-05-10', 'Alice', 100.00),
('2020-01-15', 'Bob', 200.50),
('2020-12-01', 'Charlie', 300.00),
('2021-07-20', 'Diana', 150.75),
('2022-03-02', 'Edward', 500.00),
('2025-06-18', 'FutureMan', 9999.99);

-- To check which column is used for partition in the table
-- method 1 ==> using MySQL's information_schema table
SELECT * FROM information_schema.PARTITIONS WHERE `TABLE_SCHEMA`='test1' and table_name='orders';
-- table_schema='db_name'

-- method 2 ==> shows schema of table which also includes the partitions
show create table orders;


-- Partition pruning.
        -- it's a query-optimization technique where MySQL skips scanning unnecessary partition and reads only the partition that can contain the required data.
        -- In simple words, We are proving that here the partition is worked right? by using "EXPLAIN FORMAT=JSON" is called partition pruning means SQL takes that partition alone and skip others becaz where the actual record is there.

-- The below query searches in all partitions
explain format=json select * from orders where year(order_date)='2021';
-- output:
-- "partitions": ["p_before_2020","p_2020","p_2021","p_2022","p_future"],  "rows_examined_per_scan": 6,


-- the below query searches only the partition which has sepecified partition year
explain format=json select * from orders where order_date='2021-07-20';
-- output:
-- "partitions": ["p_2021"],  "rows_examined_per_scan": 1,




-- List Partitions
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    PRIMARY KEY (employee_id, department)
)
-- since "PARTITION BY LIST" allows only int type column to be partitioned but If we need to partition based on column type varchar() then we've to use "PARTITION BY LIST COLUMNS"

PARTITION BY LIST COLUMNS (department) (
    PARTITION p_sales        VALUES IN ('Sales'),
    PARTITION p_hr           VALUES IN ('HR'),
    PARTITION p_engineering  VALUES IN ('Engineering', 'DevOps'),
    PARTITION p_other        VALUES IN ('Finance', 'Marketing', 'Operations')
);

INSERT INTO employees (first_name, last_name, department)
VALUES
('Alice', 'Smith', 'Sales'),
('Bob', 'Johnson', 'HR'),
('Charlie', 'Lee', 'Engineering'),
('Diana', 'Lopez', 'DevOps'),
('Eve', 'Turner', 'Marketing');


explain format=json SELECT * from employees WHERE department='hr';
-- output: "partitions": ["p_hr"] skips other partitions

explain format=json SELECT * from employees WHERE department in ('hr','sales','devops');
-- output: "partitions": ["p_sales","p_hr","p_engineering"],


-- Hash partition
        -- if you unable to any partition with the columns in a table like all the columns are unique. You can use Hash Partition.
        -- It works depends % operation

drop table if exists customers;
create table customers (
    cust_id int PRIMARY key,
    name varchar(50),
    phno char(10),
    email varchar(50)
)
partition by hash(cust_id) 
partitions 2;

INSERT INTO customers (cust_id, name, phno, email) VALUES
(1, 'Arun Kumar',   '9876543210', 'arun.kumar@gmail.com'),
(2, 'Priya Sharma','9123456780', 'priya.sharma@gmail.com'),
(3, 'Rahul Verma', '9988776655', 'rahul.verma@gmail.com'),
(4, 'Sneha Iyer',  '9012345678', 'sneha.iyer@gmail.com'),
(5, 'Vikram Singh','9090909090', 'vikram.singh@gmail.com'),
(6, 'Ananya Rao',  '9345678901', 'ananya.rao@gmail.com'),
(7, 'Karthik Raj', '9567890123', 'karthik.raj@gmail.com'),
(8, 'Meena Patel', '9789012345', 'meena.patel@gmail.com'),
(9, 'Suresh Nair', '9654321098', 'suresh.nair@gmail.com'),
(10,'Pooja Mehta', '9871203456', 'pooja.mehta@gmail.com');


explain format=json select * from customers where cust_id=4;
-- output: "partitions": ["p1"],

explain format=json select * from customers where cust_id=4;
-- output: "partitions": ["p0"],

-- How it Works
-- Example ==> Formula (hash column % no.of partitions to be created) here hash column=cust_id & no.of partitions=2
-- since no.of partitions=2, MySQL creates p0 and p1 partitions

-- if cust_id=1,
-- 1%2 = 1 ==> this record stored in p1
-- 2%2 = 0 ==> this record stored in p0

-- when reading, the cust_id=1 means MySQL checks 1%2=1 then it scans in the p1 