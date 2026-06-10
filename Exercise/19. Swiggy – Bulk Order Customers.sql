Problem 19: Swiggy – Bulk Order Customers

Gowtham wants to find Swiggy customers (like Kumar, Anjali) who placed orders above ₹1000
at least 5 times in the last 3 months

drop table if exists swiggy_bulk_orders;

CREATE TABLE swiggy_bulk_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
amount DECIMAL(10,2),
order_date DATE
);

INSERT INTO swiggy_bulk_orders VALUES
(1, 2001, 'Kumar', 1200.00, '2026-04-01'),
(2, 2001, 'Kumar', 1500.00, '2026-04-15'),
(3, 2001, 'Kumar', 150.00, '2026-03-15'),
(4, 2001, 'Kumar', 200.00, '2026-04-11'),
(5, 2001, 'Kumar', 500.00, '2026-05-31'),
(6, 2002, 'Anjali', 800.00, '2026-04-10');

SELECT * FROM swiggy_bulk_orders;

select customer_id, customer_name, count(order_id) as no_of_purchases
from swiggy_bulk_orders
where order_date>=date_sub(curdate(), interval 3 month)
group by customer_id, customer_name
having no_of_purchases>=5;

select date_sub(curdate(), interval 3 month);