Problem 9: Amazon – High Spend Customers

Gowtham wants to find Amazon customers (like Lakshmi, Kiran) who spent more than ₹1 Lakh
in the last year.

drop table if exists amazon_orders_high_spend;

CREATE TABLE amazon_orders_high_spend (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
order_amount DECIMAL(10,2),
order_date DATE
);

INSERT INTO amazon_orders_high_spend VALUES
(1,1001,'Lakshmi',60000.00,'2025-03-15'),
(2,1001,'Lakshmi',50000.00,'2025-11-20'),
-- Valid for both: total = 110000 in 2025 and within last 12 months

(3,1002,'Kiran',70000.00,'2025-06-10'),
(4,1002,'Kiran',40000.00,'2026-02-05'),
-- Valid for last 12 months only, not for calendar year 2025

(5,1003,'Priya',60000.00,'2025-04-01'),
(6,1003,'Priya',40000.00,'2025-08-15'),
-- Invalid edge case: exactly 100000 in 2025

(7,1005,'Meena',50000.00,'2025-12-20'),
(8,1005,'Meena',60000.00,'2026-02-15'),
-- Valid for calendar year 2025 (assuming both counted by business rule),
-- but may fail last-12-month checks depending on current date

(9,1006,'Gowtham',30000.00,'2025-07-01'),
(10,1006,'Gowtham',35000.00,'2025-09-01'),
(11,1006,'Gowtham',34999.00,'2026-01-01');
-- Invalid: total = 99999 within rolling year

SELECT * FROM amazon_orders_high_spend;


-- Ask the Interviewer:
-- If the last year means the exact last year like 2025, 2026
SELECT customer_id, customer_name, sum(order_amount) as amt_spent_2025 FROM amazon_orders_high_spend
where year(order_date)=2025
group by customer_id, customer_name
having amt_spent_2025>100000;

-- If the last year means from date to last year same date
SELECT customer_id, customer_name, sum(order_amount) as amt_spent_last_year FROM amazon_orders_high_spend
where order_date>=date_sub(curdate(), interval 1 year)
group by customer_id, customer_name
having amt_spent_last_year>100000;
