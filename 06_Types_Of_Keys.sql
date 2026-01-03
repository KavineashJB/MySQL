drop table if exists enrollment;
create table enrollment (
    stu_id int not null,
    course_id int not null,
    enrollment_date date,
    course_name varchar(100),

    -- minimal
    CONSTRAINT pk_enrollment_1 PRIMARY key (stu_id, course_id), -- if anyone col removed from primary key then it affects the pk constraint

    -- not minimal
    CONSTRAINT pk_enrollment_2 PRIMARY key (stu_id, course_id, course_name) -- here when we remove course_name it doesn't affect pk constraint
)


-- Concepts:
-- 1. Surrogate and Natural Key
-- Natural ==> naturally uniquely identifies a record also can be primary key
-- Surrogate ==> Unique for each record for customer also can be a primary key

-- eg:
drop table if exists customer;
create table customer (
    customer_key int AUTO_INCREMENT, -- surrogate KEY
    aadhar_number int primary key, -- natural KEY
    city varchar(100),
    age int not null
)


-- 2. Primary, Composite, Candidate, super keys
-- Primary key 
--     * Can be single-column or multi-column
--     * Must uniquely identify each row
--     * Cannot contain NULL

-- Composite key
--     * Composite key = 2 or more columns together identify a row
--     * A composite key may or may not be minimal

-- Candidate key
--     * A candidate key is a minimal set of columns that uniquely identifies a row.

-- Super key
--     * A super key is any set of columns that uniquely identifies a row, with or without extra (unnecessary) columns.
--     * Candidate keys are minimal super keys