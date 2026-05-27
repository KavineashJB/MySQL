Question:
Gowtham wants to find Uber customers (like Mani, Ravi) who completed at least 50 rides in Chennai over the last 3 months without any cancellations.

drop table if EXISTS uber_rides;
CREATE TABLE uber_rides (
ride_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
city VARCHAR(50),
ride_date DATE,
cancelled BOOLEAN
);

INSERT INTO uber_rides VALUES
(1, 201, 'Mani', 'Chennai', '2026-04-01', FALSE),
(2, 201, 'Mani', 'Chennai', '2026-04-02', FALSE),
-- (add 48 more rows for Mani)
(51, 202, 'Ravi', 'Chennai', '2026-04-01', FALSE),
(52, 202, 'Ravi', 'Chennai', '2026-04-02', FALSE),
-- (add additional data for variety)
(100, 203, 'Arun', 'Coimbatore', '2026-04-01', FALSE);
SELECT * FROM uber_rides;


-- Solution:
select customer_id, customer_name, count(*) as total_ride_count
from uber_rides
where city='chennai' and ride_date>=DATE_SUB(CURDATE(),interval 3 month) and cancelled=0
group by customer_id, customer_name
having count(*)>=2;
-- use having count(*)>=50, since the data is inadequate i used 2;

-- curdate() / current_date --> provides the today's date of your system. To check: select curdate();