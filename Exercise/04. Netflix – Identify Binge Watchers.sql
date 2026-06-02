Problem 4: Netflix – Identify Binge Watchers

Gowtham wants to find Netflix users (like Saravanan, Divya) who watched at least 5 different
movies per week for 4 consecutive weeks.

drop table if exists netflix_watch_history;

CREATE TABLE netflix_watch_history (
watch_id INT PRIMARY KEY,
user_id INT,
user_name VARCHAR(50),
movie_id INT,
movie_name VARCHAR(100),
watch_date DATE
);

INSERT INTO netflix_watch_history VALUES


(1, 501, 'Saravanan', 2001, 'Movie A', '2026-06-02'),
(2, 501, 'Saravanan', 2002, 'Movie B', '2026-06-03'),
(3, 501, 'Saravanan', 2003, 'Movie C', '2026-06-04'),
(4, 501, 'Saravanan', 2004, 'Movie D', '2026-06-05'),
(5, 501, 'Saravanan', 2005, 'Movie E', '2026-06-06'),

(6, 501, 'Saravanan', 2006, 'Movie F', '2026-06-09'),
(7, 501, 'Saravanan', 2007, 'Movie G', '2026-06-10'),
(8, 501, 'Saravanan', 2008, 'Movie H', '2026-06-11'),
(9, 501, 'Saravanan', 2009, 'Movie I', '2026-06-12'),
(10, 501, 'Saravanan', 2010, 'Movie J', '2026-06-13'),

(11, 501, 'Saravanan', 2011, 'Movie K', '2026-06-16'),
(12, 501, 'Saravanan', 2012, 'Movie L', '2026-06-17'),
(13, 501, 'Saravanan', 2013, 'Movie M', '2026-06-18'),
(14, 501, 'Saravanan', 2014, 'Movie N', '2026-06-19'),
(15, 501, 'Saravanan', 2015, 'Movie O', '2026-06-20'),

(16, 501, 'Saravanan', 2016, 'Movie P', '2026-06-23'),
(17, 501, 'Saravanan', 2017, 'Movie Q', '2026-06-24'),
(18, 501, 'Saravanan', 2018, 'Movie R', '2026-06-25'),
(19, 501, 'Saravanan', 2019, 'Movie S', '2026-06-26'),
(20, 501, 'Saravanan', 2020, 'Movie T', '2026-06-27'),

(21, 501, 'Saravanan', 2021, 'Movie U', '2026-06-30'),
(22, 501, 'Saravanan', 2022, 'Movie V', '2026-07-01'),
(23, 501, 'Saravanan', 2023, 'Movie W', '2026-07-02'),
(24, 501, 'Saravanan', 2024, 'Movie X', '2026-07-03'),
(25, 501, 'Saravanan', 2025, 'Movie Y', '2026-07-04'),

(26, 501, 'Saravanan', 2026, 'Movie Z', '2026-07-07'),
(27, 501, 'Saravanan', 2027, 'Movie AA', '2026-07-08'),
(28, 501, 'Saravanan', 2028, 'Movie AB', '2026-07-09'),
(29, 501, 'Saravanan', 2029, 'Movie AC', '2026-07-10'),
(30, 501, 'Saravanan', 2030, 'Movie AD', '2026-07-11'),


(31, 502, 'Divya', 2101, 'Movie A1', '2026-06-02'),
(32, 502, 'Divya', 2102, 'Movie A2', '2026-06-03'),
(33, 502, 'Divya', 2103, 'Movie A3', '2026-06-04'),
(34, 502, 'Divya', 2104, 'Movie A4', '2026-06-05'),
(35, 502, 'Divya', 2105, 'Movie A5', '2026-06-06'),

(36, 502, 'Divya', 2106, 'Movie B1', '2026-06-16'),
(37, 502, 'Divya', 2107, 'Movie B2', '2026-06-17'),
(38, 502, 'Divya', 2108, 'Movie B3', '2026-06-18'),
(39, 502, 'Divya', 2109, 'Movie B4', '2026-06-19'),
(40, 502, 'Divya', 2110, 'Movie B5', '2026-06-20'),

(41, 502, 'Divya', 2111, 'Movie C1', '2026-06-30'),
(42, 502, 'Divya', 2112, 'Movie C2', '2026-07-01'),
(43, 502, 'Divya', 2113, 'Movie C3', '2026-07-02'),
(44, 502, 'Divya', 2114, 'Movie C4', '2026-07-03'),
(45, 502, 'Divya', 2115, 'Movie C5', '2026-07-04'),

(46, 503, 'Arun', 2201, 'Movie X1', '2026-06-02'),
(47, 503, 'Arun', 2202, 'Movie X2', '2026-06-03'),
(48, 503, 'Arun', 2203, 'Movie X3', '2026-06-04'),


(49, 504, 'Meena', 2301, 'Movie Y1', '2026-06-02'),
(50, 504, 'Meena', 2302, 'Movie Y2', '2026-06-03'),
(51, 504, 'Meena', 2303, 'Movie Y3', '2026-06-04'),
(52, 504, 'Meena', 2304, 'Movie Y4', '2026-06-05'),
(53, 504, 'Meena', 2305, 'Movie Y5', '2026-06-06'),

(54, 504, 'Meena', 2306, 'Movie Z1', '2026-06-23'),
(55, 504, 'Meena', 2307, 'Movie Z2', '2026-06-24'),
(56, 504, 'Meena', 2308, 'Movie Z3', '2026-06-25'),
(57, 504, 'Meena', 2309, 'Movie Z4', '2026-06-26'),
(58, 504, 'Meena', 2310, 'Movie Z5', '2026-06-27');

SELECT * FROM netflix_watch_history;

-- Solution
with year_week_dates as (
    select *, yearweek(watch_date) as year_week from netflix_watch_history
),
atleast_5_movies_per_week as (
    SELECT user_id, year_week , count(year_week) as movies_count_per_week 
    FROM year_week_dates
    group by user_id, year_week 
    having count(year_week)>=5
),
consecutive_weeks as (
    select * from (
        SELECT user_id, year_week,
        -- year_week-lag(year_week,1) over (PARTITION BY user_id order by year_week asc) as prev1,
        -- year_week-lag(year_week,2) over (PARTITION BY user_id order by year_week asc) as prev2,
        year_week-lag(year_week,3) over w as prev3
        from atleast_5_movies_per_week

        window w as (
            partition by user_id ORDER BY year_week asc
        )
    ) consec_weeks
    where prev3=3
)
SELECT * FROM consecutive_weeks;
-- select distinct netflix.user_id, user_name
from netflix_watch_history netflix
join consecutive_weeks consec_weeks
where netflix.user_id=consec_weeks.user_id;


