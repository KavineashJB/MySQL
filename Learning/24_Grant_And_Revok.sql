-- Let's take a scenario:
-- If the fresher joins to our company. I told we need to allow the fresher only access to select, insert all the table not to update or delete.

drop table if exists accounts;

create table accounts (
    account_no int PRIMARY key,
    account_holder varchar(100),
    balance decimal(10, 2)
);

INSERT INTO Accounts VALUES (1, 'Alice', 5000.00);

SELECT * FROM accounts;
-- To create a new user and password
-- username: 'kavineashJB', password:'Kavin@54321'
create user 'kavineashJB' @'localhost' IDENTIFIED by 'Kavin@54321';

select USER, HOST from mysql.user;

-- To grant select access. Username & Password are case sensitive
grant select, insert on test1.* to 'kavineashJB' @'localhost';

-- to immediately give access
flush PRIVILEGES;

-- To check whether the user created
select USER, HOST from mysql.user;

-- To check whether the previledges working fine
-- 1) Open Windows Powershell
-- 2) Go to mysql path "C:\Program Files\MySQL\MySQL Server 9.4\bin"
-- 3) To login as particular user ".\mysql.exe -u(username) username -p(password)" then press enter
-- 4) Asks password, Enter it.

-- To know who you are
select user ();
-- +-----------------------+
-- | user()                |
-- +-----------------------+
-- | kavineashJB@localhost |
-- +-----------------------+

show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | performance_schema |
-- | test1              |
-- +--------------------+

insert into accounts values (2, 'Bob', 5000);

select * from accounts;
-- +------------+----------------+---------+
-- | account_no | account_holder | balance |
-- +------------+----------------+---------+
-- |          1 | Alice          | 3000.00 |
-- |          2 | Bob            | 5000.00 |
-- +------------+----------------+---------+

update accounts set balance = balance -1000 where account_no = 1;
-- ERROR 1142 (42000): UPDATE command denied to user 'kavineashJB'@'localhost' for table 'accounts'

-- To revoke the priviledges ==> you should grant and revoke only as the root user (Admin)
revoke select, insert on test1.* from 'kavineashJB' @'localhost';

flush PRIVILEGES;

exit;
-- to exit from the current session. So that the current modifications in the priviledges will affect
-- Bye
-- PS C:\Program Files\MySQL\MySQL Server 9.4\bin> .\mysql.exe -u kavineashJB -p
-- Enter password: ***********
-- Welcome to the MySQL monitor.

show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |
-- | performance_schema |
-- +--------------------+

mysql > use test1;
-- ERROR 1044 (42000): Access denied for user 'kavineashJB'@'localhost' to database 'test1'