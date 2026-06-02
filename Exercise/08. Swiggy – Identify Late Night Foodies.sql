Problem 8: Swiggy – Identify Late Night Foodies

Gowtham wants to find Swiggy customers (like Aravind, Selvi) who ordered food after 11 PM for
10 consecutive days.

drop table if exists swiggy_late_orders;

CREATE TABLE swiggy_late_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE,
order_time TIME
);


INSERT INTO swiggy_late_orders VALUES
-- VALID CUSTOMER (10 consecutive days, all after 11 PM)
(1, 901, 'Aravind', '2025-06-01', '23:15:00'),
(2, 901, 'Aravind', '2025-06-02', '23:20:00'),
(3, 901, 'Aravind', '2025-06-03', '23:05:00'),
(4, 901, 'Aravind', '2025-06-04', '23:40:00'),
(5, 901, 'Aravind', '2025-06-05', '23:12:00'),
(6, 901, 'Aravind', '2025-06-06', '23:30:00'),
(7, 901, 'Aravind', '2025-06-07', '23:50:00'),
(8, 901, 'Aravind', '2025-06-08', '23:18:00'),
(9, 901, 'Aravind', '2025-06-09', '23:25:00'),
(10, 901, 'Aravind', '2025-06-10', '23:45:00'),
-- INVALID 1: Only 9 consecutive days
(11, 902, 'Selvi', '2025-06-01', '23:10:00'),
(12, 902, 'Selvi', '2025-06-02', '23:15:00'),
(13, 902, 'Selvi', '2025-06-03', '23:20:00'),
(14, 902, 'Selvi', '2025-06-04', '23:25:00'),
(15, 902, 'Selvi', '2025-06-05', '23:30:00'),
(16, 902, 'Selvi', '2025-06-06', '23:35:00'),
(17, 902, 'Selvi', '2025-06-07', '23:40:00'),
(18, 902, 'Selvi', '2025-06-08', '23:45:00'),
(19, 902, 'Selvi', '2025-06-09', '23:50:00'),
-- INVALID 2: Break in consecutive dates
(20, 903, 'Kumar', '2025-06-01', '23:10:00'),
(21, 903, 'Kumar', '2025-06-02', '23:15:00'),
(22, 903, 'Kumar', '2025-06-03', '23:20:00'),
(23, 903, 'Kumar', '2025-06-04', '23:25:00'),
(24, 903, 'Kumar', '2025-06-06', '23:30:00'), -- Missing June 5
(25, 903, 'Kumar', '2025-06-07', '23:35:00'),
(26, 903, 'Kumar', '2025-06-08', '23:40:00'),
(27, 903, 'Kumar', '2025-06-09', '23:45:00'),
(28, 903, 'Kumar', '2025-06-10', '23:50:00'),
(29, 903, 'Kumar', '2025-06-11', '23:55:00'),
-- INVALID 3: 10 consecutive days but one order before 11 PM
(30, 904, 'Meena', '2025-06-01', '23:10:00'),
(31, 904, 'Meena', '2025-06-02', '23:15:00'),
(32, 904, 'Meena', '2025-06-03', '23:20:00'),
(33, 904, 'Meena', '2025-06-04', '22:45:00'), -- Before 11 PM, for checking change '22:45:00' to '23:45:00'
(34, 904, 'Meena', '2025-06-05', '23:30:00'),
(35, 904, 'Meena', '2025-06-06', '23:35:00'),
(36, 904, 'Meena', '2025-06-07', '23:40:00'),
(37, 904, 'Meena', '2025-06-08', '23:45:00'),
(38, 904, 'Meena', '2025-06-09', '23:50:00'),
(39, 904, 'Meena', '2025-06-10', '23:55:00');

SELECT * FROM swiggy_late_orders;

--also use time(order_time) >= '23:00:00'
with food_order_after_11_PM as (
    SELECT customer_id, customer_name, order_date FROM swiggy_late_orders
    where Hour(order_time)>=23 
    group by customer_id, customer_name, order_date
),
row_number_for_order_dates as (
    select *,
    row_number() over (PARTITION BY customer_id order by order_date asc) as rn
    from food_order_after_11_PM
),
grouped_cte as (
        select *,
        date_sub(order_date, interval rn day) as grp
        from row_number_for_order_dates
)
-- SELECT * FROM grouped_cte;
select customer_id, customer_name, grp from grouped_cte
group by customer_id, customer_name,grp
having count(*)>=10;