-- index is a data structure (B Tree) which improves the speed of data retrival in a table.
-- pros:
        -- faster select queries (big advantage)
        -- faster joins
        -- used in where, order by, group by, distinct

-- cons:
        -- slower insert, update, delete => because for each table modification it automatically need to update the index also.
        -- extra storage space for storing indexes

-- ** Index may improve read performance but may degrade write-heavy workload**


SELECT * FROM customers;

create index idx_cust_email on customers(email);

explain select * from customers where email='karthik.r@gmail.com'

explain format=json select * from customers where email="karthik.r@gmail.com"

-- to get the query execution speed - for customer email index is specified
explain analyze select * from customers where email="karthik.r@gmail.com"
-- Output: EXPLAIN	-> Index lookup on customers using idx_cust_email (email = 'karthik.r@gmail.com') (cost=0.35 rows=1) (actual time=0.103..0.107 rows=1 loops=1) 

drop table if EXISTS customers1;
create table customers1 (
    id int PRIMARY KEY,
    name varchar(100) not null,
    email VARCHAR(100),
    phno char(10) check (length(phno)=10),
    amount DECIMAL(10,2),
    city varchar(100)
);

INSERT INTO customers1 (id, name, email, phno, amount, city)
VALUES
(1, 'Arun Kumar',   'arun.kumar@gmail.com',   '9876543210', 12500.50,'covai'),
(2, 'Divya Sharma', null, null,  8400.00,null),
(3, 'Ravi Teja',    'ravi.teja@outlook.com',  '9988776655', 15200.75,'chennai'),
(4, 'Sneha Patel',  NULL, '9090909090',  4600.00,'covai'),
(5, 'Karthik R',    'karthik.r@gmail.com',   null, 18999.99,'salem');
-- for customer_id index not specified
explain analyze select * from customers1 where email='karthik.r@gmail.com'
-- Output:  
-- 1) Filter: (customers1.email = 'karthik.r@gmail.com') (cost=0.75 rows=1) (actual time=0.274..0.291 rows=1 loops=1). 
-- 2) Table scan on customers1 (cost=0.75 rows=5) (actual time=0.233..0.27 rows=5 loops=1)