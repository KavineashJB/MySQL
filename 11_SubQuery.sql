show tables;
desc customers;

drop table if exists orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO orders (order_id, customer_id, order_date, product, amount, order_status) VALUES
(101, 1, '2025-01-10', 'Laptop',        55000.00, 'SUCCESS'),
(102, 2, '2025-01-12', 'Mobile Phone',  22000.00, 'SUCCESS'),
(103, 1, '2025-01-15', 'Wireless Mouse', 1200.00, 'CANCELLED'),
(104, 3, '2025-01-18', 'Headphones',     3000.00, 'SUCCESS'),
(105, 4, '2025-01-20', 'Smart Watch',    8000.00, 'PENDING');

SELECT * from orders;
select * from customers;

-- max amount spent by each customer
select c.id, (select max(o.amount) from orders o where o.customer_id=c.id) from customers c;

-- select customer_name where amount>5000
select c.id, c.name from customers c where c.id in
(select distinct o.customer_id from orders o where o.amount>10000);


-- exists
-- it can return empty or full record
-- return full record without where condition when atleast one subquery returns true
-- return empty if all subquery returns false

SELECT name from customers where EXISTS (
select * from customers where city='covai'
);   -- return all records becaz 2 records having city=covai

SELECT name from customers where EXISTS (
select * from customers where city='eride'
)   -- return empty becaz no records having city=erode


-- subquery can come after from as a table
select 
    id, name, city, amount, l_pad, r_pad, replaced_str, index_of_exist_char, index_of_inexist_char, reversed_str, formated_amount
from (
    select id, name, city, amount, lpad(city,2,'*') as l_pad, rpad(city,10,'*') as r_pad, replace(name,' ','_') as replaced_str, instr(name, 'a') as index_of_exist_char, instr(name, 'z') as index_of_inexist_char, reverse(name) as reversed_str, format(amount, 2) as formated_amount from customers 
) as string_handling_subquery;


-- subquery using case conditions
select name, 
case
    when (select sum(amount) from orders where orders.customer_id=customers.id) >= (select avg(amount) from orders) then 'above average'
    else 'below average' -- it also executes record with null amount
end as customer_avg_amount from customers;


-- It shows above average
select customer_id, sum(amount) as tot_sum from orders group by customer_id having tot_sum >= (SELECT avg(amount) from orders);
-- It shows below average
select customer_id, sum(amount) as tot_sum from orders group by customer_id having tot_sum < (SELECT avg(amount) from orders);
