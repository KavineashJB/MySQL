Problem 12: Uber – Multi-City Riders

Gowtham wants to find Uber customers (like Vignesh, Sneha) who took rides in more than 3
different cities in the last 6 months.

drop table if exists uber_multi_city;

CREATE TABLE uber_multi_city (
ride_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(50),
city VARCHAR(50),
ride_date DATE
);

INSERT INTO uber_multi_city VALUES
(1, 1301, 'Vignesh', 'Chennai', '2026-02-10'),
(2, 1301, 'Vignesh', 'Bangalore', '2026-03-15'),
(3, 1301, 'Vignesh', 'Coimbatore', '2026-04-20'),
(4, 1301, 'Vignesh', 'Hyderabad', '2026-05-25'),
(5, 1302, 'Sneha', 'Chennai', '2026-03-10');

SELECT * from uber_multi_city;

SELECT customer_id, customer_name, count(city) as no_of_cities_travelled
FROM uber_multi_city
where ride_date>=date_sub(curdate(),interval 6 month)
group by customer_id, customer_name
having no_of_cities_travelled>3;
