drop table if exists restaurants;
create table restaurants (
    id int PRIMARY KEY,
    name varchar(100) not null,
    location varchar(100)
);

drop table if exists orders;
create table orders (
    order_id int primary key,
    restaurant_id int,
    cust_id int,
    order_date date
)


INSERT INTO restaurants (id, name, location) VALUES
(1, 'Spice Garden',      'Chennai'),
(2, 'Food Factory',     'Bangalore'),
(3, 'Ocean Delight',    'Kochi'),
(4, 'Urban Tandoor',    'Hyderabad'),
(5, 'Green Leaf',       'Coimbatore');

INSERT INTO orders (order_id, restaurant_id, cust_id, order_date) VALUES
(101, 1, 1, '2025-01-05'),
(102, 2, 3, '2025-01-06'),
(103, 1, 2, '2025-01-07'),
(104, 3, 1, '2025-01-08'),
(105, 6, 4, '2025-01-09');

select * from restaurants;
select * from orders;
select * from customers;

-- inner join
-- select restaurant name in which customers ordered food
select r.id, r.name, o.order_date
from restaurants r
join orders o on o.restaurant_id = r.id order by o.order_date desc;

-- left join
-- select restaurant in which customer may or may not order food
select r.id, name, order_date
from restaurants r
left join orders o on o.restaurant_id=r.id;

-- right join
select r.id, r.name, o.order_date 
from restaurants r 
right join orders o on o.restaurant_id=r.id;

-- since MySQL does not support full but other techs such as hive, bigdata, oracle supports it.
-- In MySQL, Full join is supported by union of left and right join. We'll discuss in the upcoming union section.  


-- join morethan 2 cols
select c.id, c.name, r.id, r.name, o.order_id, o.order_date
from restaurants r
join orders o on o.restaurant_id = r.id
join customers c on c.id = o.cust_id;