use uber;

create table if not exists uber.rides ( 
    ride_id int PRIMARY key,
    driver_id int,
    rider_id int,
    pickup_loc varchar(100),
    drop_loc varchar(100),
    ride_date datetime,
    fare decimal(10, 2)
);

desc uber.rides

-- Primary key
-- It doesn't allow dups and null values

-- Composite Primary Key
-- Use case: In buses, there are many unique riders but in the same ride_id
drop table if exists uber.rides;
create table if not exists uber.rides ( 
    ride_id int,
    driver_id int not null,
    rider_id int,
    pickup_loc varchar(100) not null,
    drop_loc varchar(100) not null,
    ride_date datetime not null,
    fare decimal(10, 2) not null check (fare > 0),
    rider_email varchar(50) unique,
    PRIMARY KEY (ride_id, rider_id)
);
desc uber.rides;

insert into uber.rides values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', 500.00, null);
-- composite key -> both primary key should be same as record already present in the record. even anyone is different it doesn't throw an error  
insert into uber.rides values (1, 101, 202, 'Chennai', 'Covai', '2025-12-29 08:00:00', 500.00, 'user1@gmail.com');

SELECT * from uber.rides;

-- unique constraint -> accepts multiple null but not allow dups
insert into uber.rides values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', 500.00, null)

-- not null
insert into uber.rides values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', null, null) 
-- Error: column fare cannot be null.

-- check
insert into uber.rides values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', 0, null)
-- Error: Check constraint 'rides_chk_1' is violated.


-- foreign key
-- relates 2 or more tables
create table if not exists uber.drivers (
    driver_id int primary key,
    driver_name varchar(25) not null,
    license_number varchar(8) not null unique
);

drop TABLE if EXISTS uber.rides, uber.drivers;
create table if not exists uber.rides ( 
    ride_id int,
    driver_id int not null,
    rider_id int,
    pickup_loc varchar(100) not null,
    drop_loc varchar(100) not null,
    ride_date datetime not null,
    fare decimal(10, 2) not null check (fare > 0),
    rider_email varchar(50) unique,
    PRIMARY KEY (ride_id, rider_id),
    Foreign Key (driver_id) REFERENCES uber.drivers(driver_id)
); -- on cascade delete -> if deleting driver_id in drivers also delete driver_id in the rides

-- hard delete -> delete using sql command
-- soft delete -> just add extra column (is_delete boolean default false); if you want to delete driver_id you have to update is_delete col to true

insert into uber.drivers values (101, 'raja', 'ABC1234'),(102, 'vimal','XYZ4321');

insert into uber.rides values (1, 101, 201, 'Chennai', 'Covai', '2025-12-29 08:00:00', 500.00,null),(2, 101, 202, 'Bengaluru', 'Hyderabad', '2026-01-01 23:00:00', 800.00,'rose123@gmail.com'),(3, 102, 203, 'Chennai', 'Madurai', '2025-12-30 18:30:00', 400.00,'ramsaran@gmail.com'),(4, 101, 204, 'Covai', 'Chennai', '2025-12-31 05:30:00', 600.00, 'user1@gmail.com'),(5, 102, 205,  'Covai', 'Bengaluru', '2025-12-31 05:30:00', 700.00, 'real@gmail.com');

desc rides; 
desc drivers;

SELECT * from drivers;
SELECT * from rides;

-- default
drop table if exists citizen;
create table if not exists citizen (
    sno int primary key,
    name varchar(25) not null,
    country varchar(3) DEFAULT 'ind'
);
desc citizen;

insert into citizen (sno, name) values (1,'kamal'),(2,'rani');

insert into citizen VALUES (3,'ram','usa'),(4,'rocky','kor')

SELECT * from citizen;