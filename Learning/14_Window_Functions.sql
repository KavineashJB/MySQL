-- Window function in SQL performs a calculation across a set of row related to the current row
-- without changing the no.of rows in result set.
-- the term windows refers to the set of rows that are somehow related to the current row.

-- Types:
-- 1) Aggregate - count,sum,avg,min,max
-- 2) Ranking - row_number, rank, dense_rank, percent_rank, ntile
-- 3) value - lag, lead, first_value, last_value, nth_value

drop table if exists sales;
create table sales (
    trans_id int,
    store varchar(50),
    amount decimal(10,2)
)

insert into sales VALUES (1, 'A', 100.00), (2, 'A', 200.00), (3, 'A', 150.00), (4, 'B', 250.00), (5, 'B', 300.00);

SELECT * from sales;

-- running total ==> calculate sum of curr=curr+prev day
SELECT trans_id, store, amount, sum(amount) over (PARTITION BY store order by trans_id) from sales;

-- calculate avg of each days
SELECT trans_id, store, amount,
avg(amount) over (PARTITION BY store ORDER BY trans_id) as avg_amt_by_store
from sales;

-- calculate avg of each store
SELECT trans_id, store, amount,
avg(amount) over (PARTITION BY store) as avg_amt_by_store
from sales;
