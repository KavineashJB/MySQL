Problem 3: Amazon – Top Repeat Purchasers

Gowtham wants to find Amazon customers (like Priya, Arjun) who purchased the same product at least 5 times in the last 3 months.

drop table if exists amazon_orders;
CREATE TABLE amazon_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
product_id INT,
product_name VARCHAR(50),
order_date DATE
);
INSERT INTO amazon_orders VALUES
(1, 401, 'Priya', 1001, 'Bluetooth Speaker', '2026-04-02'),
(2, 401, 'Priya', 1001, 'Bluetooth Speaker', '2026-04-10'),
(3, 401, 'Priya', 1001, 'Bluetooth Speaker', '2026-04-20'),
(4, 401, 'Priya', 1001, 'Bluetooth Speaker', '2026-05-01'),
(5, 401, 'Priya', 1001, 'Bluetooth Speaker', '2026-05-15'),
(6, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-04-05'),
(7, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-03-01'),
(8, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-05-10'),
(9, 402, 'Arjun', 1003, 'Wireless Keyboard', '2026-01-12'),
(10, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-04-23'),
(11, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-02-11'),
(12, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-05-24'),
(13, 403, 'Uma', 1004, 'Wired Mouse', '2026-05-09'),
(14, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-03-24'),
(15, 402, 'Arjun', 1002, 'Wireless Mouse', '2026-02-21');

SELECT * FROM amazon_orders;

-- Solution
SELECT customer_id, customer_name, product_id, product_name, count(*) as purchase_count
from amazon_orders
where order_date>=date_sub(curdate(),interval 3 month)
group by customer_id, customer_name, product_id, product_name
having purchase_count>=5;
