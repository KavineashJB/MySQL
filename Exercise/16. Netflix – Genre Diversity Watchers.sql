Problem 16: Netflix – Genre Diversity Watchers

Gowtham wants to find Netflix users (like Harini, Ajay) who watched content from at least 5
different genres in the last 2 months.

drop table if exists netflix_genre_watch;

CREATE TABLE netflix_genre_watch (
watch_id INT PRIMARY KEY,
user_id INT,
user_name VARCHAR(50),
genre VARCHAR(30),
watch_date DATE
);

INSERT INTO netflix_genre_watch VALUES
(1, 1701, 'Harini', 'Action', '2026-05-02'),
(2, 1701, 'Harini', 'Drama', '2026-05-10'),
(3, 1701, 'Harini', 'Comedy', '2026-05-15'),
(4, 1701, 'Harini', 'Thriller', '2026-04-05'),
(5, 1701, 'Harini', 'Romance', '2026-04-10'),
(6, 1702, 'Ajay', 'Action', '2026-05-12'),
(7, 1702, 'Ajay', 'Comedy', '2026-05-11'),
(8, 1702, 'Ajay', 'Romance', '2026-05-10'),
(9, 1702, 'Ajay', 'Thriller', '2026-05-09'),
(10, 1702, 'Ajay', 'Drama', '2026-05-08'),
(11, 1702, 'Ajay', 'Family', '2026-05-09');

SELECT * FROM netflix_genre_watch;


with grped_genre as (
    SELECT user_id, user_name, genre, count(*) as cnt_of_genre
    FROM netflix_genre_watch
    where watch_date>=DATE_SUB(curdate(),interval 2 month)
    group by user_id, user_name, genre
),
grped_id as (
    SELECT user_id, user_name, sum(cnt_of_genre) as tot from grped_genre
    GROUP BY user_id, user_name
    HAVING tot>=5
) 
SELECT * FROM grped_id;