Problem 15: Uber – Cash Payment Consistency

Gowtham wants to find Uber customers (like Muthu, Priya) who paid cash for all rides in the last 3 months.

drop table if exists uber_cash_payments;

CREATE TABLE uber_cash_payments (
ride_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
payment_mode VARCHAR(20),
ride_date DATE
);

INSERT INTO uber_cash_payments VALUES
(1, 1601, 'Muthu', 'Cash', '2026-04-05'),
(2, 1601, 'Muthu', 'Cash', '2026-05-10'),
(3, 1601, 'Muthu', 'Cash', '2026-06-01'),
(4, 1602, 'Muhesh', 'Card', '2026-02-02'),
(5, 1603, 'Priya', 'Card', '2026-04-08'),
(6, 1603, 'Priya', 'Cash', '2026-04-09'),
(7, 1604, 'Prasanth', 'Cash', '2026-02-08');

SELECT * FROM uber_cash_payments;

with last_3_month_trans as (
    SELECT * 
    FROM uber_cash_payments
    where ride_date>=date_sub(curdate(), interval 3 month)
),
grp_customer_cte as (
    select customer_id, customer_name, count(*) as payment_cnt
    from last_3_month_trans
    GROUP BY customer_id, customer_name
),
grp_customer_with_payment_mode_cte as (
    select customer_id, customer_name, payment_mode, count(*) as cash_payment_cnt
    from last_3_month_trans
    GROUP BY customer_id, customer_name, payment_mode
)
SELECT cust_pay_cte.customer_id, cust_pay_cte.customer_name, cash_payment_cnt 
FROM grp_customer_cte as cust_cte
join grp_customer_with_payment_mode_cte as cust_pay_cte
on cust_cte.customer_id=cust_pay_cte.customer_id
WHERE payment_cnt=cash_payment_cnt;