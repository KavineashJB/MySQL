-- alter
show tables;

desc tb;
select * from tb;

-- columns
-- add column
alter table tb add column city varchar(25);
-- rename table name
alter table tb rename to renamed_tb;
desc renamed_tb;

-- rename renamed_tb to tb
alter table renamed_tb rename to tb;

-- rename col name
alter table tb rename column city to cities;
desc tb;

alter table tb rename column cities to city;


select * from tb;
-- drop column
alter table tb drop column city;

-- constraints
-- add constraint
alter table tb add constraint const_city check (length(city)<=25);
-- modify constraint
alter table tb modify phno varchar(30) not null;
-- drop constraint
alter table tb drop check const_city;


-- show the updated create table sql code
show create table tb;
