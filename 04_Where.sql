show tables;
show databases;

create database if not exists uber;
use uber;

-- database.table is recommended and professional way
create table if not exists uber.rides ( 
    ride_id int PRIMARY key,
    driver_id int,
    rider_id int,
    pickup_loc varchar(100),
    drop_loc varchar(100),
    ride_date datetime,
    fare decimal(10, 2)
);

show tables;
show databases;


-- insertion
insert into rides (ride_id, driver_id, rider_id, pickup_loc, drop_loc, ride_date, fare) values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', 500.00),(2, 102, 202, 'Bengaluru', 'Hyderabad', '2026-01-01 23:00:00', 800.00),(3, 103, 203, 'Chennai', 'Madurai', '2025-12-30 18:30:00', 400.00),(4, 104, 204, 'Covai', 'Chennai', '2025-12-31 05:30:00', 600.00),(5, 105, 205,  'Covai', 'Bengaluru', '2025-12-31 05:30:00', 700.00);

SELECT * from uber.rides;
desc uber.rides;
-- where clause -> filter condition
SELECT ride_id, rider_id, driver_id, fare from uber.rides where fare <= 500;
select ride_id, fare as fare_with_pickup_covai from uber.rides where pickup_loc='covai' order by fare desc;