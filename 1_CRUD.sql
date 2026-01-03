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
-- If you want to delete the rows and the table itself
drop table if exists test1.test;



