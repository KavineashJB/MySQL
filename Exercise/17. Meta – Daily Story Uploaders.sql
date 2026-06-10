Problem 17: Meta – Daily Story Uploaders

Gowtham wants to find Meta users (like Arun, Divya) who uploaded stories daily for 30
consecutive days.

drop table if exists meta_story_uploads;

CREATE TABLE meta_story_uploads (
story_id INT PRIMARY KEY,
user_id INT,
user_name VARCHAR(50),
upload_date DATE
);

INSERT INTO meta_story_uploads VALUES
(1,1801,'Arun','2026-05-01'),
(2,1801,'Arun','2026-05-02'),
(3,1801,'Arun','2026-05-03'),
(4,1801,'Arun','2026-05-04'),
(5,1801,'Arun','2026-05-05'),
(6,1801,'Arun','2026-05-06'),
(7,1801,'Arun','2026-05-07'),
(8,1801,'Arun','2026-05-08'),
(9,1801,'Arun','2026-05-09'),
(10,1801,'Arun','2026-05-10'),
(11,1801,'Arun','2026-05-11'),
(12,1801,'Arun','2026-05-12'),
(13,1801,'Arun','2026-05-13'),
(14,1801,'Arun','2026-05-14'),
(15,1801,'Arun','2026-05-15'),
(16,1801,'Arun','2026-05-16'),
(17,1801,'Arun','2026-05-17'),
(18,1801,'Arun','2026-05-18'),
(19,1801,'Arun','2026-05-19'),
(20,1801,'Arun','2026-05-20'),
(21,1801,'Arun','2026-05-21'),
(22,1801,'Arun','2026-05-22'),
(23,1801,'Arun','2026-05-23'),
(24,1801,'Arun','2026-05-24'),
(25,1801,'Arun','2026-05-25'),
(26,1801,'Arun','2026-05-26'),
(27,1801,'Arun','2026-05-27'),
(28,1801,'Arun','2026-05-28'),
(29,1801,'Arun','2026-05-29'),
(30,1801,'Arun','2026-05-30'),
(90,1801,'Arun','2026-05-31'),
(91,1801,'Arun','2026-06-01'),
(92,1801,'Arun','2026-06-02'),
(93,1801,'Arun','2026-06-03'),
(94,1801,'Arun','2026-06-04'),
(95,1801,'Arun','2026-06-05'),
-- Valid user (30 consecutive days)

(31,1802,'Divya','2026-05-01'),
(32,1802,'Divya','2026-05-02'),
(33,1802,'Divya','2026-05-03'),
(34,1802,'Divya','2026-05-04'),
(35,1802,'Divya','2026-05-05'),
(36,1802,'Divya','2026-05-06'),
(37,1802,'Divya','2026-05-07'),
(38,1802,'Divya','2026-05-08'),
(39,1802,'Divya','2026-05-09'),
(40,1802,'Divya','2026-05-10'),
(41,1802,'Divya','2026-05-11'),
(42,1802,'Divya','2026-05-12'),
(43,1802,'Divya','2026-05-13'),
(44,1802,'Divya','2026-05-14'),
(45,1802,'Divya','2026-05-15'),
(46,1802,'Divya','2026-05-16'),
(47,1802,'Divya','2026-05-17'),
(48,1802,'Divya','2026-05-18'),
(49,1802,'Divya','2026-05-19'),
(50,1802,'Divya','2026-05-20'),
(51,1802,'Divya','2026-05-21'),
(52,1802,'Divya','2026-05-22'),
(53,1802,'Divya','2026-05-23'),
(54,1802,'Divya','2026-05-24'),
(55,1802,'Divya','2026-05-25'),
(56,1802,'Divya','2026-05-26'),
(57,1802,'Divya','2026-05-27'),
(58,1802,'Divya','2026-05-28'),
(59,1802,'Divya','2026-05-29'),
-- Invalid user (29 consecutive days)

(60,1803,'Kiran','2026-05-01'),
(61,1803,'Kiran','2026-05-02'),
(62,1803,'Kiran','2026-05-03'),
(63,1803,'Kiran','2026-05-04'),
(64,1803,'Kiran','2026-05-05'),
(65,1803,'Kiran','2026-05-06'),
(66,1803,'Kiran','2026-05-07'),
(67,1803,'Kiran','2026-05-08'),
(68,1803,'Kiran','2026-05-09'),
(69,1803,'Kiran','2026-05-10'),
(70,1803,'Kiran','2026-05-11'),
(71,1803,'Kiran','2026-05-12'),
(72,1803,'Kiran','2026-05-13'),
(73,1803,'Kiran','2026-05-14'),
(74,1803,'Kiran','2026-05-15'),
(75,1803,'Kiran','2026-05-17'), -- missing streak here
(76,1803,'Kiran','2026-05-18'),
(77,1803,'Kiran','2026-05-19'),
(78,1803,'Kiran','2026-05-20'),
(79,1803,'Kiran','2026-05-21'),
(80,1803,'Kiran','2026-05-22'),
(81,1803,'Kiran','2026-05-23'),
(82,1803,'Kiran','2026-05-24'),
(83,1803,'Kiran','2026-05-25'),
(84,1803,'Kiran','2026-05-26'),
(85,1803,'Kiran','2026-05-27'),
(86,1803,'Kiran','2026-05-28'),
(87,1803,'Kiran','2026-05-29'),
(88,1803,'Kiran','2026-05-30'),
(89,1803,'Kiran','2026-05-31');
-- Invalid user (30 uploads but one missing day breaks the streak)

SELECT * FROM  meta_story_uploads;

with row_num_cte as (
    select *,
    row_number() over (PARTITION BY user_id order by upload_date asc) as rn
    from meta_story_uploads
),
consec_30_days as (
    SELECT user_id, user_name,
    date_sub(upload_date,interval rn day) as grp_date,
    COUNT(date_sub(upload_date,interval rn day)) as cnt_grp_date
    from row_num_cte
    group by user_id, user_name, grp_date
    -- having cnt_grp_date>=30
)
SELECT * FROM consec_30_days;



-- If last 30 consecutive days
select user_id, user_name, count(DISTINCT upload_date) as cnt_date
from meta_story_uploads
where upload_date>=date_sub(curdate(), interval 30 DAY)
group by user_id, user_name
-- having cnt_date>=30;
