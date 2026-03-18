-- All commit and rollback works after we started "START TRANSACTION" or "BEGIN"
-- COMMIT
-- Permanently saves all changes made in the current transaction.
-- Once committed, cannot rollback to previous consistant state.

-- ROLLBACK
-- Undoes all changes made since the last COMMIT.

drop table if exists accounts;

create table accounts (
    account_no int PRIMARY key,
    account_holder varchar(100),
    balance decimal(10, 2)
)

INSERT INTO Accounts VALUES (1, 'Alice', 5000.00);

SELECT * FROM accounts;

start TRANSACTION;

update accounts set balance = balance - 1000 where account_no = 1;

SELECT * FROM accounts;
-- balance=4000

ROLLBACK;

SELECT * FROM accounts;
-- balance=5000

update accounts set balance = balance - 2000 where account_no = 1;

SELECT * FROM accounts;
-- balance=3000

commit;

ROLLBACK;

SELECT * FROM accounts;
-- balance=3000
-- here no change in balance becaz we got commited the changes so we can't move to previous transaction of recent commit; so use commit only for the correct and trusted transactions.