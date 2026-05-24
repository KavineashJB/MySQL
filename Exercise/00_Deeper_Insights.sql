-- 1. multi CTE style query
with tempTab1 as (
    SELECT * from tb1
),
tempTab2 as (
    SELECT * from tb2
)
SELECT * FROM tempTab1;
-- Note:
-- the alias in temp table 1 cannot be access in the nested CTE style temp tables but you can use in the select query 

-- 2. 
select empId, empSalary, empDesignation
from employees
group by 1 order by 1;
-- 1 means the selected 1st col(empId) - group by empId order by empId
-- if 2 means group by empSalary order by empSalary


-- 3. For month, year matching
-- best to match the month&year, it also helps in indexing. Find the rows with Feb 2020.
date>='2020-02-01' and order_date<'2020-03-01'
-- or between '2020-02-01' and '2020-02-29' => in between clause both dates are inclusive, u may missed out feb leap year. so above one is best 

-- 4. In regexp
-- [] and ():
-- [] -> create ranges and match single character 
-- () -> matches grp of chars
-- Eg: [a-zA-Z_-.] - between 2 chars means range between 2 chars but for safer side declare the -(hypen) always at the end of the string
-- (a-z) match exactly the word with "a-z" not a|b|c|..|z

-- regexp '^[a-zA-Z][a-zA-Z0-9_.-]*@(?-i)leetcode\\.com$';
-- \\. represent the exact .
-- | Pattern | Meaning                  |
-- | ------- | ------------------------ |
-- | `(?i)`  | enable case-insensitive  |
-- | `(?-i)` | disable case-insensitive |
-- turn OFF case-insensitive matching from that point onward.


-- 5. for returning null value instead of empty result table use the following technique
1. aggregation FUNCTION - SELECT MAX(salary) FROM employees WHERE department_id = 100;
2. force one row using subquery - SELECT ( SELECT name FROM students WHERE id = 100) AS name;   *** best ***
3. left join - SELECT s.id, c.course_name FROM students s LEFT JOIN courses c ON s.course_id = c.id;


-- 6. important diff
RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW   --> takes logically 6 days before current day
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW                 --> takes exactly 6 rows before current row


-- 7. named window specification
1321. Restaurant Growth

Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 
You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.
The result format is in the following example.

Example 1:
Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86

-- problem link: https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50
# Write your MySQL query statement below

-- In this u can use avg() becaz here we grouped the visited_on date (no dup date row)
with grouped_date as (
    select visited_on, sum(amount) as tot_amt
    from customer
    group by visited_on
)
select visited_on, 
sum(tot_amt) over w as amount,
round(avg(tot_amt) over w,2) as average_amount  
from grouped_date 
window w as (
    order by visited_on
    rows between 6 preceding and current row
)
limit 100 offset 6;

-- or

select distinct visited_on,
sum(amount) over w as amount,
round(sum(amount) over w /7,2)as average_amount
from customer
window w as (
    order by visited_on
    range between interval 6 day preceding and current row
)
limit 100 offset 6;


-- Use Window function to get the dup ranked rows too using dense_rank()