Problem 5: Swiggy – Identify Frequent Order

Gowtham wants to find Swiggy customers (like Meena, Ravi) who cancelled orders more than 3
times in any single month.

drop table if exists swiggy_orders;

CREATE TABLE swiggy_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE,
cancelled BOOLEAN
);

INSERT INTO swiggy_orders VALUES
(1, 601, 'Meena', '2025-03-02', TRUE),
(2, 601, 'Meena', '2025-03-05', TRUE),
(3, 601, 'Meena', '2025-03-10', TRUE),
(4, 601, 'Meena', '2025-03-15', TRUE),
(5, 602, 'Ravi', '2025-04-03', TRUE),
(6, 602, 'Ravi', '2025-04-10', FALSE),
(7, 602, 'Ravi', '2025-04-18', TRUE);

SELECT * FROM swiggy_orders;

SELECT customer_id, customer_name, date_format(order_date, "%M-%Y") as month_name, count(*) as cancelled_count
from swiggy_orders
where cancelled=1
GROUP BY customer_id, customer_name, month(order_date), month_name
HAVING  count(*)>3;