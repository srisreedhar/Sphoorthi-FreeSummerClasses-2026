-- =========================================
-- TABLE 1 : students
-- =========================================

CREATE TABLE students (
    id INTEGER,
    name TEXT,
    age INTEGER,
    city TEXT,
    course TEXT,
    grade TEXT
);

-- =========================================
-- INSERT DATA INTO students
-- =========================================

INSERT INTO students VALUES
(1, 'Ravi', 20, 'Hyderabad', 'SQL', 'Pass'),

(2, 'Sneha', 22, 'Bangalore', 'Python', 'Promoted'),

(3, 'Arjun', 21, 'Chennai', 'SQL', 'Failed'),

(4, 'Priya', 23, 'Mumbai', 'Power BI', 'Pass'),

(5, 'Kiran', 20, 'Pune', 'Python', 'Promoted');



-- =========================================
-- The Above code creates below table,
-- column names and respective values 
-- we use SELECT statement to extract respective Columns
-- =========================================

/*

+----+--------+-----+------------+----------+-----------+
| id | name   | age | city       | course   | grade     |
+----+--------+-----+------------+----------+-----------+
| 1  | Ravi   | 20  | Hyderabad  | SQL      | Pass      |
| 2  | Sneha  | 22  | Bangalore  | Python   | Promoted  |
| 3  | Arjun  | 21  | Chennai    | SQL      | Failed    |
| 4  | Priya  | 23  | Mumbai     | Power BI | Pass      |
| 5  | Kiran  | 20  | Pune       | Python   | Promoted  |
+----+--------+-----+------------+----------+-----------+

*/


/*

-- Ex Run below code and see which column is being returned ?

select course  from students;

-- Extract/show city column


select city from students;


-- Extract/ show grade column 

select grade from students;

-- Extract age column 

select age from students;

-- now try to Extract multiple columns,
-- each column in select statement should be comma seperated
-- select column1,column2 from tableName

-- extract name,age columns 

select name,age from students;
select age,name from students;


-- extract name,age,course, grade from the table 
select name
        ,age
        ,course
        ,grade
from students;


-- extract all the columns except id column 

select name
        ,age
        ,course
        ,grade
        ,city
from students;

*/

select * from students;

select name
        ,age
        ,course
        ,grade
        ,city
        ,'dummy column' 
from students;



select name
        ,age
        ,course
        ,grade
        ,city
        ,'dummy column' as dummy
from students;



select name
        ,age
        ,course
        ,grade
        ,city
        ,'dummy column' as dummy
        ,2026-age as birthyear
        ,current_date as today
        ,current_time as time
from students;


-- Filtering

select name
        ,age
        ,course
        ,grade
        ,city
        ,'dummy column' as dummy
        ,2026-age as birthyear
        ,current_date as today
        ,current_time as time
from students
where course = 'SQL';



-- show me all the students who are failed 

select * from students
where grade = 'Failed';

/* 

> greater than 
< lesser than 
!= not equals to 

*/

select * from students
where age > 21;

-- chaining of multiple conditions together as a single condition 




