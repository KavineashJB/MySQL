show databases;

create database if not exists aggregation;
use aggregation;

drop table if exists customerTransactions;
create table customerTransactions (
    id int PRIMARY KEY,
    login_device varchar(50),
    customer_name varchar(20),
    ip_address varchar(20),
    product varchar(100),
    amount decimal(10,2),
    is_placed boolean,
    is_viewed boolean,
    transaction_status varchar(20)
);

INSERT INTO customerTransactions 
(id, login_device, customer_name, ip_address, product, amount, is_placed, is_viewed, transaction_status)
VALUES
(1, 'Mobile',  'Arun',   '192.168.1.10', 'Wireless Earbuds',      1999.00, true,  true,  'SUCCESS'),
(2, 'Desktop',     'Divya',  '192.168.1.11', 'Laptop Bag',            1499.50, true,  true,  'SUCCESS'),
(3, 'Tablet',  'Karthik','192.168.1.12', 'Smart Watch',           4999.99, true, true,  'SUCCESS'),
(4, 'Mobile',  'Meena',  '192.168.1.13', 'Bluetooth Speaker',     2999.00, true,  true,  'SUCCESS'),
(5, 'Desktop',     'Rahul',  '192.168.1.14', 'Gaming Mouse',          1299.75, false, false,  'CANCELLED'),
(6, 'Mobile',  'Sneha',  '192.168.1.15', 'USB-C Charger',          899.00, true,  true,  'SUCCESS'),
(7, 'Desktop',     'Vikram', '192.168.1.16', 'Mechanical Keyboard',   5499.00, true,  true,  'SUCCESS'),
(8, 'Tablet',  'Anjali', '192.168.1.17', 'Noise Cancelling Headphones', 8999.00, false, true, 'FAILED'),
(9, 'Mobile',  'Suresh', '192.168.1.18', 'Power Bank',            1599.00, true,  false,  'SUCCESS'),
(10,'Desktop',     'Priya',  '192.168.1.19', 'External Hard Drive',   6499.00, false, false, 'VIEWED');

TRUNCATE customerTransactions;

desc customerTransactions;
select * from aggregation.customerTransactions;

select count(*) from customerTransactions;

select count(*) from customerTransactions where transaction_status not in ('success','failed')

SELECT sum(amount) as tot_spending, min(amount) as min_amt_spent, max(amount) as max_amt_spent, avg(amount) as avg_amt_spent from customerTransactions where transaction_status='success';


-- group by
select login_device, sum(amount) from aggregation.customertransactions group by login_device;

-- group by with having
select login_device, sum(amount) as tot_amt_spent from aggregation.customertransactions group by login_device having tot_amt_spent > 10000;
