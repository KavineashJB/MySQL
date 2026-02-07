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


-- How MySQL actually processes this:

-- FROM → load employees and departments tables
-- JOIN → combine rows from both tables
-- ON → match rows using e.dept_id = d.dept_id
-- WHERE → filter rows (salary > 50000)
-- GROUP BY → group rows by department
-- HAVING → filter groups (COUNT > 5)
-- SELECT → pick columns & aggregates
-- DISTINCT → remove duplicate result rows
-- ORDER BY → sort the output
-- LIMIT → restrict number of rows returned


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

update test set name='Raja Raja Cholan', sno=4 where sno=2;

-- It deletes row based on condition
delete from test1.test where sno=2;
-- If you want to delete all rows in a table. You have table name with 0 rows
truncate table test1.test;
-- or truncate test1.test;

-- If you want to delete the rows and the table itself
drop table if exists test1.test;



