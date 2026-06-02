Problem 10: Netflix – Tamil Content Watchers

Gowtham wants to find Netflix users (like Harish, Kavya) who watched only Tamil content for 6
months continuously.

drop table if exists netflix_tamil_watch;

CREATE TABLE netflix_tamil_watch (
watch_id INT PRIMARY KEY,
user_id INT,
user_name VARCHAR(50),
content_language VARCHAR(20),
watch_date DATE
);

INSERT INTO netflix_tamil_watch VALUES
(1, 1101, 'Harish', 'Tamil', '2025-01-10'),
(2, 1101, 'Harish', 'Tamil', '2025-02-12'),
(3, 1101, 'Harish', 'Tamil', '2025-03-05'),
(4, 1101, 'Harish', 'Tamil', '2025-04-15'),
(5, 1101, 'Harish', 'Tamil', '2025-05-20'),
(6, 1101, 'Harish', 'Tamil', '2025-06-02'),
(7, 1101, 'Harish', 'Tamil', '2025-06-12'),
(1077, 1101, 'Harish', 'English', '2026-06-01'),
(8, 1102, 'Kavya', 'English', '2025-12-01'),
(10, 1102, 'Kavya', 'Tamil', '2026-01-02'),
(11, 1102, 'Kavya', 'Tamil', '2026-02-02'),
(12, 1102, 'Kavya', 'English', '2026-03-01');

SELECT * FROM netflix_tamil_watch;


with consectuive_month as (
    SELECT user_id, user_name, content_language, month(watch_date) as watch_month, count(month(watch_date)) as tamil_movie_watch_count_per_month,
    ROW_NUMBER() over (PARTITION BY user_id order by month(watch_date) asc) as rn
    FROM
    netflix_tamil_watch
    group by user_id, user_name, watch_month, content_language
),
grouped_month as (
    SELECT *,
    watch_month-rn as grp
    from consectuive_month
)
SELECT * FROM grouped_month;
SELECT user_id, user_name, grp, content_language, count(grp) FROM grouped_month
GROUP BY user_id, user_name, content_language, grp;