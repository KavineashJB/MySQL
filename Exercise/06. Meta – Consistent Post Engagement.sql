Problem 6: Meta – Consistent Post Engagement

Gowtham wants to find Meta users (like Kavin, Divya) who liked at least 5 posts each month
consistently for the last 4 months.


drop table if EXISTS meta_likes;

CREATE TABLE meta_likes (
like_id INT PRIMARY KEY,
user_id INT,
user_name VARCHAR(50),
post_id INT,
like_date DATE
);

INSERT INTO meta_likes VALUES
-- Kavin (Valid User)
(151,701,'Kavin',9151,'2026-02-02'),
(152,701,'Kavin',9152,'2026-02-03'),
(153,701,'Kavin',9153,'2026-02-04'),
(154,701,'Kavin',9154,'2026-02-05'),
(155,701,'Kavin',9155,'2026-02-06'),

(1,701,'Kavin',9001,'2026-03-05'),
(2,701,'Kavin',9002,'2026-03-06'),
(3,701,'Kavin',9003,'2026-03-07'),
(4,701,'Kavin',9004,'2026-03-08'),
(5,701,'Kavin',9005,'2026-03-09'),

(51,701,'Kavin',9051,'2026-04-02'),
(52,701,'Kavin',9052,'2026-04-03'),
(53,701,'Kavin',9053,'2026-04-04'),
(54,701,'Kavin',9054,'2026-04-05'),
(55,701,'Kavin',9055,'2026-04-06'),

(101,701,'Kavin',9101,'2026-05-02'),
(102,701,'Kavin',9102,'2026-05-03'),
(103,701,'Kavin',9103,'2026-05-04'),
(104,701,'Kavin',9104,'2026-05-05'),
(105,701,'Kavin',9105,'2026-05-06'),
-- Raja (InValid, Only 2 consecutive months)
(501,702,'Raja',9051,'2026-04-02'),
(502,702,'Raja',9052,'2026-04-03'),
(503,702,'Raja',9053,'2026-04-04'),
(504,702,'Raja',9054,'2026-04-05'),
(505,702,'Raja',9055,'2026-04-06'),

(181,702,'Raja',9101,'2026-05-02'),
(182,702,'Raja',9102,'2026-05-03'),
(183,702,'Raja',9103,'2026-05-04'),
(184,702,'Raja',9104,'2026-05-05'),
(185,702,'Raja',9105,'2026-05-06'),
-- Divya (Invalid)
(200,703,'Divya',9201,'2026-03-10'),
(201,703,'Divya',9202,'2026-03-12'),
(202,703,'Divya',9203,'2026-04-15'),
(203,703,'Divya',9204,'2026-06-18'),
(204,703,'Divya',9205,'2026-06-17');


SELECT * FROM meta_likes;

with liked_atleast_5_posts as (
    select user_id, user_name, month(like_date) as month_num
    from meta_likes
    where like_date>=date_sub(CURDATE(),interval 4 month)
    GROUP BY user_id, user_name, month(like_date)
    having count(*)>=5
),
consecutive_4_months as (
    SELECT *
    from (
        select *,
        -- month_num-lag(month_num, 1) over (PARTITION BY user_id ORDER BY month_num asc) as prev1, month_num-lag(month_num, 2) over (PARTITION BY user_id ORDER BY month_num asc) as prev2,
        month_num-lag(month_num, 3) over (PARTITION BY user_id ORDER BY month_num asc) as prev3
        from liked_atleast_5_posts
    ) users
    where prev3=3
)
SELECT user_id, user_name FROM consecutive_4_months;
