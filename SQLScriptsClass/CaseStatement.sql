/*

:: CASE STATEMENT :: 

It is a control flow statement that allows you to perform conditional logic in SQL queries. 
It is used to evaluate a list of conditions and return a specific result based on the first condition that is met. 

You can understand it as an IF-THEN-ELSE statement in programming languages.


IF condition1 THEN result1
ELSE IF condition2 THEN result2
ELSE default_result



The syntax for a CASE statement is as follows:

CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END


In this syntax:
- condition1, condition2, ...:  These are the conditions that you want to evaluate. 
                                They can be any valid SQL expressions that return a boolean value (true or false).
- result1, result2, ...: These are the results that will be returned if the corresponding condition is true. 
                         They can be any valid SQL expressions, including literals, column names, or even other CASE statements.
- default_result: This is the result that will be returned if none of the conditions are true.
                  It is optional, and if it is not provided, the CASE statement will return NULL when no conditions are met.



Example of using a CASE statement:

SELECT
    name,
    age,
    city,
    course,
    grade,
    -- classify students based on their grade using CASE statement
    CASE 
        WHEN grade = 'Pass' THEN 'Congratulations!'
        WHEN grade = 'Promoted' THEN 'Keep it up!'
        WHEN grade = 'Failed' THEN 'Better luck next time.'
        ELSE 'No grade available.'
    END AS feedback         
FROM students;


In the above example, 
the CASE statement evaluates the value of the grade column for each student and 
returns a corresponding feedback message based on whether the student passed, was promoted, or failed. 
If the grade does not match any of the specified conditions, it returns a default message indicating that no grade is available.


*/


-- =========================================
-- Table Creation : Student grade classification
-- =========================================

CREATE TABLE students (
    id INTEGER,
    name TEXT,
    age INTEGER,
    city TEXT,
    course TEXT,
    marks INTEGER
);

INSERT INTO students VALUES
(1, 'Ravi', 20, 'Hyderabad', 'SQL', 80),
(2, 'Sneha', 22, 'Bangalore', 'Python',70 ),
(3, 'Arjun', 21, 'Chennai', 'SQL', 60),
(4, 'Priya', 23, 'Mumbai', 'Power BI',50 ),
(5, 'Kiran', 20, 'Pune', 'Python', 50),
(6, 'Anjali', 24, 'Delhi', 'SQL', 40),
(7, 'Rahul', 22, 'Hyderabad', 'Python',30 ),
(8, 'Sanya', 21, 'Bangalore', 'Power BI',25 ),
(9, 'Vikram', 23, 'Chennai', 'SQL', 60),
(10, 'Meera', 20, 'Mumbai', 'Python', 80),
(11, 'Arnav', 24, 'Pune', 'Power BI', 90),
(12, 'Isha', 22, 'Delhi', 'SQL', 66),
(13, 'Karan', 21, 'Hyderabad', 'Python', 42),
(14, 'Nisha', 23, 'Bangalore', 'Power BI', 33),
(15, 'Aditya', 20, 'Chennai', 'SQL', 24),
(16, 'Sofia', 24, 'Mumbai', 'Python', 33),
(17, 'Rohan', 22, 'Pune', 'Power BI', 15),
(18, 'Ananya', 21, 'Delhi', 'SQL', 96),
(19, 'Kabir', 23, 'Hyderabad', 'Python', 33),
(20, 'Maya', 20, 'Bangalore', 'Power BI', 24),
(21, 'Dev', 24, 'Chennai', 'SQL', 51),
(22, 'Aarav', 22, 'Mumbai', 'Python', 33),
(23, 'Sanya', 21, 'Pune', 'Power BI', 27),
(24, 'Vikram', 23, 'Delhi', 'SQL', 37),
(25, 'Meera', 20, 'Hyderabad', 'Python', 22),
(26, 'Arnav', 24, 'Bangalore', 'Power BI', 24),
(27, 'Isha', 22, 'Chennai', 'SQL', 21),
(28, 'Karan', 21, 'Mumbai', 'Python', 30),
(29, 'Nisha', 23, 'Pune', 'Power BI', 15),
(30, 'Aditya', 20, 'Delhi', 'SQL', 69),
(31, 'Sofia', 24, 'Hyderabad', 'Python', 54),
(32, 'Rohan', 22, 'Bangalore', 'Power BI', 51),
(33, 'Ananya', 21, 'Chennai', 'SQL', 42),
(34, 'Kabir', 23, 'Mumbai', 'Python', 42),
(35, 'Maya', 20, 'Pune', 'Power BI', 51),
(36, 'Dev', 24, 'Delhi', 'SQL', 26),
(37, 'Aarav', 22, 'Hyderabad', 'Python',31 ),
(38, 'Sanya', 21, 'Bangalore', 'Power BI',33 ),
(39, 'Vikram', 23, 'Chennai', 'SQL', 36),
(40, 'Meera', 20, 'Mumbai', 'Python', 35);


-- Practice Queries :

-- Grade Criteria
-- below 36 marks - FAILED
-- 36 to 50 marks - PROMOTED
-- above 50 marks - PASS

-- Create a column called grade and classify students based on the above criteria using CASE statement
