-- diff b/w datetime and timestamp
-- datatime
    -- Stores exact date & time
    -- No time zone conversion
-- timestamp
    -- Always stored in UTC
    -- Converted to/from server time zone

drop table if exists events;

CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO events (event_name, event_date)
VALUES
('Team Meeting', '2025-01-15 10:30:00'),
('Conference', '2025-02-10 09:00:00'),
('Online Webinar', '2025-03-05 15:45:00'),
('Workshop', '2025-03-20 13:30:00');

SELECT * FROM events;

-- Functions
SELECT
    DAY(event_date),
    DAYNAME(event_date),
    DAYOFMONTH(event_date),
    DAYOFWEEK(event_date),
    DAYOFYEAR(event_date),
    DATE(event_date),
    DATEDIFF(event_date, '2025-01-01'),
    DATE_ADD(event_date, INTERVAL 10 DAY),
    DATE_SUB(event_date, INTERVAL 10 DAY),
    DATE_FORMAT(event_date, '%W, %e %D %M %Y'), -- %e=%d
    DATE_FORMAT(event_date, '%D %b %Y'),
    DATE_FORMAT(event_date, '%h:%i %p'),    
    -- %p-am/pm, %a-dayname,  %H-24hr, %h-12hr
    MONTH(event_date),
    MONTHNAME(event_date),
    YEAR(event_date),
    YEARWEEK(event_date)
FROM events;


SELECT event_name, event_date, event_date + interval 30 year as "+30 years" from events

SELECT event_name, event_date, event_date - interval 30 year as "+30 years" from events

SELECT event_name, event_date, DATE_FORMAT(event_date, "%W-%w (%D-%d %M-%m %Y-%y)") from events;

-- changing timezones
-- to convert timezones we need to install convert timezone utility
-- you can run the below code in "OneCompiler" website.
select '2025-01-01 10:00:00' as newYork_time, convert_tz('2025-01-01 10:00:00', 'America/New_York', 'Asia/Kolkata') as asia_time;
-- Output:
-- +---------------------+---------------------+
-- | newYork_time        | asia_time           |
-- +---------------------+---------------------+
-- | 2025-01-01 10:00:00 | 2025-01-01 20:30:00 |
-- +---------------------+---------------------+
