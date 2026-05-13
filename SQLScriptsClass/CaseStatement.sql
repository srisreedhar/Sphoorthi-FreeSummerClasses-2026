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
    grade TEXT
);

INSERT INTO students VALUES
(1, 'Ravi', 20, 'Hyderabad', 'SQL', 'Pass'),

(2, 'Sneha', 22, 'Bangalore', 'Python', 'Promoted'),

(3, 'Arjun', 21, 'Chennai', 'SQL', 'Failed'),

(4, 'Priya', 23, 'Mumbai', 'Power BI', 'Pass'),

(5, 'Kiran', 20, 'Pune', 'Python', 'Promoted')
(6, 'Anjali', 24, 'Delhi', 'SQL', 'Failed')
(7, 'Rahul', 22, 'Hyderabad', 'Python', 'Pass')
(8, 'Sanya', 21, 'Bangalore', 'Power BI', 'Promoted')
(9, 'Vikram', 23, 'Chennai', 'SQL', 'Failed')
(10, 'Meera', 20, 'Mumbai', 'Python', 'Pass')
(11, 'Arnav', 24, 'Pune', 'Power BI', 'Promoted')
(12, 'Isha', 22, 'Delhi', 'SQL', 'Failed')
(13, 'Karan', 21, 'Hyderabad', 'Python', 'Pass')
(14, 'Nisha', 23, 'Bangalore', 'Power BI', 'Promoted')
(15, 'Aditya', 20, 'Chennai', 'SQL', 'Failed')
(16, 'Sofia', 24, 'Mumbai', 'Python', 'Pass')
(17, 'Rohan', 22, 'Pune', 'Power BI', 'Promoted')
(18, 'Ananya', 21, 'Delhi', 'SQL', 'Failed')
(19, 'Kabir', 23, 'Hyderabad', 'Python', 'Pass')
(20, 'Maya', 20, 'Bangalore', 'Power BI', 'Promoted')
(21, 'Dev', 24, 'Chennai', 'SQL', 'Failed')
(22, 'Aarav', 22, 'Mumbai', 'Python', 'Pass')
(23, 'Sanya', 21, 'Pune', 'Power BI', 'Promoted')
(24, 'Vikram', 23, 'Delhi', 'SQL', 'Failed')
(25, 'Meera', 20, 'Hyderabad', 'Python', 'Pass')
(26, 'Arnav', 24, 'Bangalore', 'Power BI', 'Promoted')
(27, 'Isha', 22, 'Chennai', 'SQL', 'Failed')
(28, 'Karan', 21, 'Mumbai', 'Python', 'Pass')
(29, 'Nisha', 23, 'Pune', 'Power BI', 'Promoted')
(30, 'Aditya', 20, 'Delhi', 'SQL', 'Failed')
(31, 'Sofia', 24, 'Hyderabad', 'Python', 'Pass')
(32, 'Rohan', 22, 'Bangalore', 'Power BI', 'Promoted')
(33, 'Ananya', 21, 'Chennai', 'SQL', 'Failed')
(34, 'Kabir', 23, 'Mumbai', 'Python', 'Pass')
(35, 'Maya', 20, 'Pune', 'Power BI', 'Promoted')
(36, 'Dev', 24, 'Delhi', 'SQL', 'Failed')
(37, 'Aarav', 22, 'Hyderabad', 'Python', 'Pass')
(38, 'Sanya', 21, 'Bangalore', 'Power BI', 'Promoted')
(39, 'Vikram', 23, 'Chennai', 'SQL', 'Failed')
(40, 'Meera', 20, 'Mumbai', 'Python', 'Pass');




-- Practice Queries :

-- 1. Classify students based on their grade using CASE statement
-- 2. Classify students based on their age group using CASE statement
-- 3. Classify students based on their city using CASE statement
-- 4. Classify students based on their course using CASE statement
-- 5. Combine multiple conditions in a single CASE statement to classify students based on both grade and age group.

