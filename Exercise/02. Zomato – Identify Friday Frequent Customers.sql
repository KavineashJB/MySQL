Problem 2: Zomato – Identify Friday Frequent Customers

Gowtham wants to find Zomato customers (like Karthik, Suresh) who placed orders on every Friday for the last 2 months continuously.

drop table if exists zomato_orders;
CREATE TABLE zomato_orders (
order_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE,
amount DECIMAL(10,2)
);

INSERT INTO zomato_orders VALUES
(1, 301, 'Karthik', '2026-04-03', 350.00),
(2, 301, 'Karthik', '2026-04-10', 420.00),
(3, 301, 'Karthik', '2026-04-17', 250.00),
(4, 301, 'Karthik', '2026-04-24', 500.00),
(5, 301, 'Karthik', '2026-05-01', 500.00),
(6, 301, 'Karthik', '2026-05-08', 500.00),
(7, 301, 'Karthik', '2026-05-15', 500.00),
(8, 301, 'Karthik', '2026-05-22', 500.00),
(9, 301, 'Karthik', '2026-05-29', 500.00),
-- (add Fridays for last 2 months for Karthik)
(20, 302, 'Suresh', '2026-04-03', 300.00),
(21, 302, 'Suresh', '2026-04-17', 450.00),
-- (incomplete Fridays for Suresh)
(40, 303, 'Divya', '2026-04-05', 600.00);

SELECT * FROM zomato_orders;

-- select customer_name from zomato_orders
-- where order_date>=DATE_SUB(curdate(),interval 2 months) 
-- group by customer_id
-- having sum(DATE_FORMAT(order_date,"%w")=5)=sum(DATE_FORMAT(DATE_SUB(curdate(),interval 2 months) ,"%w")=5);

-- select date from (DATE_SUB(curdate(),interval 2 months) and curdate()) as d;

-- select date from (date_sub())
-- sum(DATE_FORMAT(order_date,"%w")=5)=sum(DATE_FORMAT(curdate(),"%w")=5)


-- first generate the count of no.of fridays in the last 2 months
with recursive last_2_month_dates as (
    -- start date
    select date_sub(curdate(), interval 2 month) as dt
    union all
    select date_add(dt, interval 1 day) from last_2_month_dates
    where dt<curdate()
),
last_2_month_total_fridays as (
    select count(dt) as fridays_count 
    from last_2_month_dates
    where DAYOFWEEK(dt)=6
), 
customer_friday_purchase_dates as (
    select *
    from zomato_orders
    where order_date>=date_sub(order_date,interval 2 month) and DAYOFWEEK(order_date)=6
)

SELECT customer_id, customer_name, (select fridays_count from last_2_month_total_fridays) as "last_2_month_total_fridays", count(*) as customer_order_date_on_friday_count
from customer_friday_purchase_dates
group by customer_id, customer_name
-- having customer_order_date_on_friday_count = (select fridays_count from last_2_month_total_fridays); -- this line for id ordered all fridays