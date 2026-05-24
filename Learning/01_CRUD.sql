-- DML DDL DCL TCL

-- DDL (Data Definition Language):
-- Purpose: Define or modify the structure of the database (e.g., schemas, tables, indexes).

-- CREATE (to create databases, tables, indexes, etc.)
-- ALTER (to modify an existing database object)
-- DROP (to delete objects)
-- TRUNCATE (to remove all records from a table)
-- RENAME (to rename an object)

-- ============================================

-- DML (Data Manipulation Language):
-- Purpose: Manipulate the data stored in the database.

-- SELECT (to query data)
-- INSERT (to add new records)
-- UPDATE (to modify existing records)
-- DELETE (to remove records)

-- ============================================

-- DCL (Data Control Language):
-- Purpose: Control access to data and database objects.

-- GRANT (to give user access privileges)
-- REVOKE (to take away privileges)

-- ============================================

-- TCL (Transaction Control Language):
-- Purpose: Manage transactions within the database.

-- COMMIT (to save transactions permanently)
-- ROLLBACK (to undo transactions)
-- SAVEPOINT (to set a point within a transaction to which you can roll back)

-- ============================================


-- How MySQL actually processes this keywords in Hierarchical Order:

-- FROM → load employees and departments tables
-- INNER JOIN → combine rows from both tables
-- ON → match rows using e.dept_id = d.dept_id
-- OUTER(LEFT,RIGHT,FULL) → return the unmatched rows
-- WHERE → filter rows (salary > 50000)
-- GROUP BY → group rows by department
-- AGGREGATE FUNCTIONS → COUNT, SUM, AVG, MIN, MAX
-- HAVING → filter groups (COUNT > 5)
-- SELECT → pick columns & aggregates
-- DISTINCT → remove duplicate result rows
-- ORDER BY → sort the output
-- OFFSET → skips the no.of rows
-- LIMIT → restrict number of rows returned


-- General Order
-- CTE (with name as ())
-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- WINDOW     **imp**
-- ORDER BY
-- LIMIT

show databases;

create database test2;

create database test1;

drop database if exists testdb;

use test1;

show tables;

create table if not exists test(sno int, name varchar(100));

desc test;

insert into test1.test values (2,'Raja'),(3,'vimal raj');

select * from test;

-- this sno=4 not exist but if u run this query it doesn't show any error also no insertion
update test set name='Raja Raja Cholan', sno=10 where sno=4;

-- It deletes row based on condition
delete rows from test1.test;
-- If you want to delete all rows in a table. You have table name with 0 rows
truncate table test1.test;
-- or truncate test1.test;

-- If you want to delete the rows and the table itself
drop table if exists test1.test;



