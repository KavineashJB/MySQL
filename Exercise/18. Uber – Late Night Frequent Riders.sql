Problem 18: Uber – Late Night Frequent Riders

Gowtham wants to find Uber customers (like Saravanan, Meera) who took rides after 10 PM at
least 20 times in the last 2 months.

drop table if exists uber_late_rides;

CREATE TABLE uber_late_rides (
ride_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
ride_time TIME,
ride_date DATE
);

INSERT INTO uber_late_rides VALUES
(1,1901,'Saravanan','22:30:00','2026-05-05'),
(2,1901,'Saravanan','23:00:00','2026-05-06'),
(3,1901,'Saravanan','22:45:00','2026-05-07'),
(4,1901,'Saravanan','23:15:00','2026-05-08'),
(5,1901,'Saravanan','22:50:00','2026-05-09'),
(6,1901,'Saravanan','23:10:00','2026-05-10'),
(7,1901,'Saravanan','22:40:00','2026-05-11'),
(8,1901,'Saravanan','23:20:00','2026-05-12'),
(9,1901,'Saravanan','22:35:00','2026-05-13'),
(10,1901,'Saravanan','23:05:00','2026-05-14'),
(11,1901,'Saravanan','22:55:00','2026-05-15'),
(12,1901,'Saravanan','23:25:00','2026-05-16'),
(13,1901,'Saravanan','22:32:00','2026-05-17'),
(14,1901,'Saravanan','23:12:00','2026-05-18'),
(15,1901,'Saravanan','22:48:00','2026-05-19'),
(16,1901,'Saravanan','23:08:00','2026-05-20'),
(17,1901,'Saravanan','22:58:00','2026-05-21'),
(18,1901,'Saravanan','23:18:00','2026-05-22'),
(19,1901,'Saravanan','22:38:00','2026-05-23'),
(20,1901,'Saravanan','23:28:00','2026-05-24'),
-- Valid customer (20 late-night rides)

(21,1902,'Meera','21:00:00','2026-05-05'),
(22,1902,'Meera','21:15:00','2026-05-06'),
(23,1902,'Meera','22:00:00','2026-05-07'),
(24,1902,'Meera','21:30:00','2026-05-08'),
(25,1902,'Meera','20:45:00','2026-05-09'),
-- Invalid customer (not late-night rides)

(26,1903,'Kavin','22:30:00','2026-05-01'),
(27,1903,'Kavin','22:45:00','2026-05-02'),
(28,1903,'Kavin','23:00:00','2026-05-03'),
(29,1903,'Kavin','22:50:00','2026-05-04'),
(30,1903,'Kavin','23:10:00','2026-05-05'),
(31,1903,'Kavin','22:40:00','2026-05-06'),
(32,1903,'Kavin','23:20:00','2026-05-07'),
(33,1903,'Kavin','22:35:00','2026-05-08'),
(34,1903,'Kavin','23:05:00','2026-05-09'),
(35,1903,'Kavin','22:55:00','2026-05-10'),
(36,1903,'Kavin','23:25:00','2026-05-11'),
(37,1903,'Kavin','22:32:00','2026-05-12'),
(38,1903,'Kavin','23:12:00','2026-05-13'),
(39,1903,'Kavin','22:48:00','2026-05-14'),
(40,1903,'Kavin','23:08:00','2026-05-15'),
(41,1903,'Kavin','22:58:00','2026-05-16'),
(42,1903,'Kavin','23:18:00','2026-05-17'),
(43,1903,'Kavin','22:38:00','2026-05-18'),
(44,1903,'Kavin','23:28:00','2026-05-19'),
-- Edge case: 19 late-night rides

(45,1904,'Divya','22:30:00','2026-05-01'),
(46,1904,'Divya','22:45:00','2026-05-01'),
(47,1904,'Divya','23:00:00','2026-05-02'),
(48,1904,'Divya','23:15:00','2026-05-02'),
(49,1904,'Divya','22:50:00','2026-05-03'),
(50,1904,'Divya','23:10:00','2026-05-03');
-- Edge case: multiple rides on same day

SELECT * FROM  uber_late_rides;

select customer_id, customer_name, COUNT(ride_id) as ride_cnt
from uber_late_rides
where 
    ride_date>=date_sub(curdate(), interval 2 month) AND
    ride_time>="22:00:00"
group by customer_id, customer_name
-- having ride_cnt>=20;

-- or hour(ride_time)>22 && minute(ride_time)>0 and SECOND(ride_time)>0