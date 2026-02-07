drop table if exists regex_tab;
CREATE TABLE regexp_tab (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sample_text VARCHAR(100)
);


INSERT INTO regexp_tab (sample_text) VALUES
('apple'),
('Banana'),
('cherry'),
('date'),
('elderberry'),
('fig'),
('grape'),
('honeydew'),
('running'),
('123abc');


SELECT * FROM regexp_tab;

SELECT * FROM regexp_tab where sample_text regexp '^a';
SELECT * FROM regexp_tab where sample_text regexp 'e$';
SELECT * FROM regexp_tab where sample_text regexp '^[0-9]';
-- (.)\\1 is for selecting double char sequentially 
SELECT * FROM regexp_tab where sample_text regexp '(.)\\1';
SELECT * FROM regexp_tab where sample_text regexp '^[A-Za-z]+$';
SELECT * FROM regexp_tab where sample_text regexp '^.{5}$';
SELECT * FROM regexp_tab where sample_text regexp '[A-Z]';
SELECT * FROM regexp_tab where sample_text regexp '^(apple|banana)$';
SELECT * FROM regexp_tab where sample_text regexp '^[0-9]{3}[A-Za-z]+$';


drop table if exists demo_data;
CREATE TABLE demo_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    phone VARCHAR(25),
    email VARCHAR(100),
    date_col VARCHAR(10),   -- Storing as VARCHAR for the demo
    status VARCHAR(20),
    sku VARCHAR(20),
    username VARCHAR(30),
    notes VARCHAR(100)
);

INSERT INTO demo_data (full_name, phone, email, date_col, status, sku, username, notes)
VALUES
('John Smith',  '123-456-7890',  'john@example.com',  '2025-02-07',  'pending',  'ABCD',  'johnsmith',  'Ships to CA'),
('Alice Johnson',  '(987) 654-3210',  'alice@@example.net',  '2025-02-07',  'inactive',  'SKU-123',  'alice',  'NY location'),
('Bob Williams',  '+1-555-123-4567',  'bob@sample.org',  '20250207',  'complete',  '1SKU',  'bob123',  'Shipping to CA'),
('Mary 1 White',  '(123) 123-4567',  'mary123@example.com',  '2025-13-31',  'PENDING',  'abc-999',  'mary_white',  'Something about CA or'),
('Mark-Spencer',  '1234567890',  'mark@example.com',  '2024-11-02', 
 'active',  'SKU-9999',  'mark',  'Random note'),
('Jane O''Connor',    '987-654-3210',  'jane.o.connor@example.org',  '2024-12-31',  'inactive',  'ABCDE',  'janeO',  'Contains CA or NY'),
('Invalid Mail',  '000-000-0000',  'invalid@@example..com',  '2023-01-15',  'inactive',  'XYZ000',  'invalid',  'Double @ and dots'),
('NoSpacesHere',  '+12-345-678-9012', 'nospaces@example.co', '2025-02-07', 'pending', 'SKU999', 'NoSpaces', 'Ends with .co domain');

-- 1. Not matching wiht Strict Date Format (YYYY-MM-DD)
SELECT *
FROM demo_data
WHERE date_col not REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

-- Matching full_name constaining special chars in full_name
select * from demo_data where full_name not regexp '^[a-zA-Z ]+$'