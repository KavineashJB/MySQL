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


-- 2. Primary, Composite, Candidate, Super Keys

-- Primary Key
--     * Can be single-column or multi-column
--     * Must uniquely identify each row
--     * Cannot contain NULL
--     * Only one primary key per table

-- Composite Key
--     * A single key formed using two or more columns
--     * All columns together uniquely identify a row
--     * It is minimal by definition (no extra columns)
--     * Can be a primary key or candidate key

-- Candidate Key
--     * A minimal set of columns that uniquely identifies a row
--     * A table can have multiple candidate keys
--     * One candidate key is selected as the primary key

-- Super Key
--     * Any set of columns that uniquely identifies a row
--     * May contain extra (non-minimal) columns
--     * Candidate keys are minimal super keys