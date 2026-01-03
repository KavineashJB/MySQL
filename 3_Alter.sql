-- alter
show tables;

desc tb;
select * from tb;

-- columns
-- add column
alter table tb add column city varchar(25);
-- rename column
alter table tb rename to tb;
desc tb;
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


show create table tb;
