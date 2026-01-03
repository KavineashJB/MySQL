-- Types of creating tables
-- 1. Normal table creation
create table tb1 (
    sno int primary key AUTO_INCREMENT,
    name VARCHAR(25) not null,
    salary int check(salary>0),
    email VARCHAR(30) UNIQUE,
    phno char(10) check(length(phno)=10)
)

-- ignore keyword adds only the unique rows
insert into tb1 (name,salary,email,phno) values ('remo',20000,'remo@gmail.com',9087654567),('vijay',34000,null,8790876545),('anbu',null,null,6574893480),('kannan',45000,null,9087134579); 

select * from tb1;


-- 2. CTAS - Create Table As Select
create table tb2 as select sno,name,salary from tb1 t where t.salary>=30000;
-- or follow below but above one is perfect and clean
-- create table tb2 (sno int primary key AUTO_INCREMENT,
-- name VARCHAR(25) not null,
-- salary int check(salary>0)
-- );
-- insert into tb2 SELECT (sno,name,salary) from tb1 where t.salary>=30000;

select * from tb2;


-- 3. temporary table - exists until session overs
-- since it is temporary it's not exist when executing "show tables;" command
create TEMPORARY table tb3 SELECT * from tb1 where salary<30000;

SELECT * from tb3;


-- 4. CTE - Common Table Expression **** freq used
WITH high_paid AS (
    SELECT * FROM tb1 WHERE salary > 30000
)
select sno, name from high_paid; 




