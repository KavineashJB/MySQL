drop table if exists products;
create table products (
    id int,
    name varchar(50),
    price decimal(10,2),
    year YEAR
)

INSERT INTO products (id, name, price, year) VALUES
(1, 'Laptop', 30000.00, 2021),
(1, 'Laptop', 27000.00, 2022),
(1, 'Laptop', 25000.00, 2023),
(2, 'Mobile', 20000.00, 2021),
(2, 'Mobile', 18000.00, 2022),
(2, 'Mobile', 16500.00, 2023),
(3, 'Tablet', 15000.00, 2021),
(3, 'Tablet', 13500.00, 2022),
(3, 'Tablet', 12000.00, 2023),
(4, 'Smart Watch', 8000.00, 2022),
(4, 'Smart Watch', 7200.00, 2023),
(4, 'Smart Watch', 6800.00, 2024),
(5, 'Headphones', 5000.00, 2022),
(5, 'Headphones', 4500.00, 2023),
(5, 'Headphones', 4200.00, 2024);

SELECT * FROM products;

-- lag() => returns the previous price of the current id
SELECT * , 
lag(price) over (PARTITION BY id order by year asc) as prod_prev_prc, price - lag(price) over (PARTITION BY id order by year asc) as diff from products;

-- lag() => returns the previous price of the current id
SELECT * , 
lead(price) over (PARTITION BY id order by year asc) as salary_change, lead(price) over (PARTITION BY id order by year asc) - price as diff from products;


select *, 
first_value(price) over (PARTITION BY id order by year asc) as initial_prc from products;

select *, 
last_value(price) over (PARTITION BY id order by year asc rows between current row and UNBOUNDED FOLLOWING) as initial_prc from products;

-- nth_value(column, nth_largest) => return nth largest of specified column
select *, 
nth_value(price, 2) over (PARTITION BY id order by year asc rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) as nth_prc from products;