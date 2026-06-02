Problem 14: Zomato – Weekly Consistent Order Customers

Gowtham wants to find Zomato customers (like Santhosh, Keerthi) who ordered at least once
every week for the last 8 weeks

drop table if exists zomato_weekly_orders;

CREATE TABLE zomato_weekly_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE
);

INSERT INTO zomato_weekly_orders VALUES
(1,1501,'Santhosh','2026-05-29'),
(2,1501,'Santhosh','2026-05-22'),
(3,1501,'Santhosh','2026-05-15'),
(4,1501,'Santhosh','2026-05-08'),
(5,1501,'Santhosh','2026-05-01'),
(6,1501,'Santhosh','2026-04-24'),
(7,1501,'Santhosh','2026-04-17'),
(8,1501,'Santhosh','2026-04-10'),
-- Valid customer (ordered in all 8 weeks)

(9,1502,'Keerthi','2026-05-29'),
(10,1502,'Keerthi','2026-05-22'),
(11,1502,'Keerthi','2026-05-15'),
(12,1502,'Keerthi','2026-05-08'),
(13,1502,'Keerthi','2026-05-01'),
(14,1502,'Keerthi','2026-04-24'),
(15,1502,'Keerthi','2026-04-17'),
-- Invalid customer (only 7 weeks)

(16,1503,'Arjun','2026-05-29'),
(17,1503,'Arjun','2026-05-22'),
(18,1503,'Arjun','2026-05-15'),
(19,1503,'Arjun','2026-05-08'),
(20,1503,'Arjun','2026-04-24'),
(21,1503,'Arjun','2026-04-17'),
(22,1503,'Arjun','2026-04-10'),
(23,1503,'Arjun','2026-04-03'),
-- Invalid customer (missed one week in between)

(24,1504,'Priya','2026-05-29'),
(25,1504,'Priya','2026-05-28'),
(26,1504,'Priya','2026-05-22'),
(27,1504,'Priya','2026-05-15'),
(28,1504,'Priya','2026-05-08'),
(29,1504,'Priya','2026-05-01'),
(30,1504,'Priya','2026-04-24'),
(31,1504,'Priya','2026-04-17'),
(32,1504,'Priya','2026-04-10'),
-- Valid customer (multiple orders in same week, still covers all 8 weeks)

(33,1505,'Vijay','2026-05-29'),
(34,1505,'Vijay','2026-05-22'),
(35,1505,'Vijay','2026-05-15'),
(36,1505,'Vijay','2026-05-08'),
(37,1505,'Vijay','2026-05-01'),
(38,1505,'Vijay','2026-04-24'),
(39,1505,'Vijay','2026-04-17'),
(40,1505,'Vijay','2026-04-12');
-- Edge case: 8 orders but date falls into only 7 distinct calendar weeks depending on week calculation

SELECT * FROM zomato_weekly_orders;


with last_8_weeks_orders as (
    SELECT *
    from zomato_weekly_orders
    where order_date >= date_sub(curdate(), interval 8 week)
),
year_week_number_cte as (
    select customer_id, customer_name, yearweek(order_date) as week_num, count(*) as orders_count_per_week
    from last_8_weeks_orders
    group by customer_id, customer_name, week_num 
),
row_number_cte as (
    SELECT *, 
    row_number() over (PARTITION BY  customer_id ORDER BY week_num) as rn
    from year_week_number_cte
),
consecutive_last_8_weeks as (
    SELECT *,
    week_num-rn as grp
    from row_number_cte
)
-- SELECT * FROM consecutive_last_8_weeks;
SELECT customer_id, customer_name, count(*) as no_of_consective_weeks
FROM consecutive_last_8_weeks
group by customer_id, customer_name, grp
-- having count(*)>=8;