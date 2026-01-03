drop table if EXISTS customers;
create table customers (
    id int PRIMARY KEY,
    name varchar(100) not null,
    email VARCHAR(100),
    phno char(10) check (length(phno)=10),
    amount DECIMAL(10,2)
);

INSERT INTO customers (id, name, email, phno, amount)
VALUES
(1, 'Arun Kumar',   'arun.kumar@gmail.com',   '9876543210', 12500.50),
(2, 'Divya Sharma', null, null,  8400.00),
(3, 'Ravi Teja',    'ravi.teja@outlook.com',  '9988776655', 15200.75),
(4, 'Sneha Patel',  NULL, '9090909090',  4600.00),
(5, 'Karthik R',    'karthik.r@gmail.com',   null, 18999.99);

SELECT * from customers limit 2 offset 1;
-- use limit, becaz most of the apps running on cloud(firestore) it charges by how many times the data reads and writes. so limit reads a limited no.of records. it's a cost saving factor

-- syntax
-- SELECT
-- CASE 
--     WHEN 1>1 THEN 'first 1 is large'   
--     when 1<1 then 'second 1 is large'
--     else 'both are equal'
-- END as comparision;


select name,
CASE 
    when phno is null and email is null then 'no unique attr except cutomer_id'
    WHEN phno is null THEN concat(email, ' - unique email')
    ELSE concat(phno, ' - unique phno')
END as 'unique attributes'
from customers;