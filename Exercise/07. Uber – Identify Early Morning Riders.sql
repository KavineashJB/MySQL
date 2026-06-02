Problem 7: Uber – Identify Early Morning Riders

Gowtham wants to find Uber customers (like Prabhu, Siva) who took rides between 6-9 AM
continuously for 30 days

drop table if exists uber_rides_morning;

CREATE TABLE uber_rides_morning (
ride_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
ride_date DATE,
ride_time TIME
);

INSERT INTO uber_rides_morning VALUES
-- VALID USER
-- Prabhu → 30 consecutive days before 8 AM
(1, 801, 'Prabhu', '2026-05-01', '06:30:00'),
(2, 801, 'Prabhu', '2026-05-02', '07:15:00'),
(3, 801, 'Prabhu', '2026-05-03', '06:45:00'),
(4, 801, 'Prabhu', '2026-05-04', '07:05:00'),
(5, 801, 'Prabhu', '2026-05-05', '06:50:00'),
(6, 801, 'Prabhu', '2026-05-06', '07:20:00'),
(7, 801, 'Prabhu', '2026-05-07', '06:40:00'),
(8, 801, 'Prabhu', '2026-05-08', '07:10:00'),
(9, 801, 'Prabhu', '2026-05-09', '06:35:00'),
(10, 801, 'Prabhu', '2026-05-10', '07:00:00'),

(11, 801, 'Prabhu', '2026-05-11', '06:55:00'),
(12, 801, 'Prabhu', '2026-05-12', '07:25:00'),
(13, 801, 'Prabhu', '2026-05-13', '06:20:00'),
(14, 801, 'Prabhu', '2026-05-14', '07:05:00'),
(15, 801, 'Prabhu', '2026-05-15', '06:50:00'),
(16, 801, 'Prabhu', '2026-05-16', '07:15:00'),
(17, 801, 'Prabhu', '2026-05-17', '06:40:00'),
(18, 801, 'Prabhu', '2026-05-18', '07:30:00'),
(19, 801, 'Prabhu', '2026-05-19', '06:45:00'),
(20, 801, 'Prabhu', '2026-05-20', '07:10:00'),

(21, 801, 'Prabhu', '2026-05-21', '06:55:00'),
(22, 801, 'Prabhu', '2026-05-22', '07:05:00'),
(23, 801, 'Prabhu', '2026-05-23', '06:35:00'),
(24, 801, 'Prabhu', '2026-05-24', '07:20:00'),
(25, 801, 'Prabhu', '2026-05-25', '06:25:00'),
(26, 801, 'Prabhu', '2026-05-26', '07:00:00'),
(27, 801, 'Prabhu', '2026-05-27', '06:50:00'),
(28, 801, 'Prabhu', '2026-05-28', '07:15:00'),
(29, 801, 'Prabhu', '2026-05-29', '06:45:00'),
(30, 801, 'Prabhu', '2026-05-30', '07:10:00'),
(31, 801, 'Prabhu', '2026-05-31', '08:10:00'),
-- INVALID USER
-- Siva → not consecutive and one ride after 8 AM
(32, 802, 'Siva', '2026-05-01', '08:45:00'),
(33, 802, 'Siva', '2026-05-03', '07:10:00'),
(34, 802, 'Siva', '2026-05-04', '07:20:00'),
(35, 802, 'Siva', '2026-05-07', '07:05:00'),
(36, 802, 'Siva', '2026-05-08', '09:15:00');

SELECT * FROM uber_rides_morning;

-- Not Good: This query works only for the exact consecutive days
with rides_between_6_to_9_Am as (
    select customer_id, ride_date
    from uber_rides_morning
    where ride_time>='06:00:00' and ride_time<='09:00:00'
    group by customer_id, ride_date
),
consecutive_30_days as (
    select *
    from (
        SELECT *,
        ride_date-lag(ride_date,29) over (PARTITION BY customer_id order by ride_date asc) as prev30
        from uber_rides_morning
    ) customer
    where prev30=29
)
SELECT distinct customer_id, customer_name FROM consecutive_30_days;


-- Best: This query also work for the greater/lesser consecutive days
with rides_between_6_to_9_Am as (
    select customer_id, customer_name, ride_date
    from uber_rides_morning
    where hour(ride_time) between 6 and 9
    group by customer_id, customer_name, ride_date
),
rides AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY ride_date ASC
        ) AS rn
    FROM rides_between_6_to_9_Am
),
groups_cte AS (
    SELECT
        customer_id,
        ride_date,
        DATE_SUB(ride_date, INTERVAL rn DAY) AS grp
    FROM rides
)
-- SELECT * FROM groups_cte;
SELECT customer_id
FROM groups_cte
GROUP BY customer_id, grp
HAVING COUNT(*) >= 30;


Example:
Suppose a customer has rides on:

ride_date	rn
2025-06-01	1
2025-06-02	2
2025-06-03	3
2025-06-04	4

Now compute:
DATE_SUB(ride_date, INTERVAL rn DAY)

ride_date	rn	grp
2025-06-01	1	2025-05-31
2025-06-02	2	2025-05-31
2025-06-03	3	2025-05-31
2025-06-04	4	2025-05-31

Notice:

All rows have the same grp value.
That's the key.
So: GROUP BY customer_id, grp

produces:
customer_id	grp	count
801	2025-05-31	4

Meaning: a streak of 4 consecutive days.