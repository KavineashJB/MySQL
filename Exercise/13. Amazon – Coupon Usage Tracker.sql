Problem 13: Amazon – Coupon Usage Tracker

Gowtham wants to find Amazon customers (like Anitha, Manoj) who used discount coupons in
all their purchases in the last 3 months

drop table if exists amazon_coupon_usage;

CREATE TABLE amazon_coupon_usage (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
coupon_used BOOLEAN,
order_date DATE
);

INSERT INTO amazon_coupon_usage VALUES
-- Anitha valid
(1, 1401, 'Anitha', TRUE, '2026-04-02'),
(2, 1401, 'Anitha', TRUE, '2026-05-10'),
(3, 1401, 'Anitha', TRUE, '2026-03-12'),
(4, 1401, 'Anitha', TRUE, '2025-12-12'), -- before 3 month
-- Manoj valid
(5, 1402, 'Manoj', TRUE, '2026-04-15'),
(6, 1402, 'Manoj', TRUE, '2026-05-20'),
(7, 1402, 'Manoj', true, '2026-05-26'),
-- Raja invalid 
(8, 1403, 'Raja', false, '2026-04-26'), -- not used coupon
(9, 1403, 'Raja', true, '2026-05-21'),
(10, 1403, 'Raja', true, '2026-01-06'); -- before 3 month


SELECT * FROM amazon_coupon_usage;

with all_purchases_count as (
    SELECT customer_id, customer_name, count(order_date) as no_of_purchases_count
    from amazon_coupon_usage
    where order_date>= date_sub(CURDATE(), interval 3 month)
    group by customer_id, customer_name 
),
all_purchases_using_coupon_count as (
    SELECT distinct customer_id, customer_name, count(order_date) as no_of_purchases_using_coupon_count
    FROM amazon_coupon_usage
    where order_date>= date_sub(curdate(), interval 3 month) and coupon_used=1
    group by customer_id, customer_name
)
SELECT all_pur_cnt.customer_id, all_pur_cnt.customer_name, no_of_purchases_count, no_of_purchases_using_coupon_count
from all_purchases_count all_pur_cnt
join all_purchases_using_coupon_count all_pur_cou_cnt
on all_pur_cnt.customer_id=all_pur_cou_cnt.customer_id
-- and no_of_purchases_count=no_of_purchases_using_coupon_count;
