select * from customers;
insert into customers VALUES (8, 'kumar', 'null', null ,null);

-- select all records with atleast 1 null attribute
-- where (email = null) -> here the comparision returns unknown but where always return the record whose condition return true. So If we want to check whether the attribute is null or not we need to use 'column is null'.

select * from customers where email=null; -- returns unknown to where
select * from customers where email='null';
select id, name from customers where email is null or phno is null or amount is null;


-- filling null values - use coalesce() or ifnull()
-- ifnull() accepts 2 args and return first non null value.
-- coalesce() accepts multiple args and return first non null value.

SELECT amount, coalesce(amount, 0.00, 1.00) as amount FROM customers;
SELECT amount, IFNULL(amount, 15.00) as amount FROM customers;

