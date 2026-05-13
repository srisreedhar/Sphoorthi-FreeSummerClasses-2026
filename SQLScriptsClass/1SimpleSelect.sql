
-- =========================================
-- SIMPLE DATABASE
-- PostgreSQL // SQLite Compatible
-- =========================================
/*

Select Command Syntax:
SELECT column1, column2, ...
FROM table_name
WHERE condition;

The SELECT statement is used to query data from a database.
    
    To Select is - To show , To Print, to Display on the screen, to Extract, to Retrieve data from a database.


- column1, column2, ...columnN: These are the columns you want to retrieve from the table. 
                                You can specify one or more columns, or use * to select all columns.
- table_name: This is the name of the table from which you want to retrieve data.
- WHERE condition: This is an optional clause that allows you to filter the results based on specific conditions.
                   You can use various operators (e.g., =, >, <, LIKE) to specify the conditions.


Examples of SELECT statements:
1. Select all columns from a table:
   SELECT * 
   FROM students;

   * is a wildcard character that means "all columns".

2. Select specific columns from a table:
   SELECT name, 
          city 
    FROM students;

3. Select rows based on a condition:
   SELECT * 
   FROM products 
   WHERE price > 5000;

*/
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
-- TABLE 2 : products
-- =========================================

CREATE TABLE products (
    product_id INTEGER,
    product_name TEXT,
    category TEXT,
    price REAL,
    stock INTEGER,
    review TEXT
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
-- INSERT DATA INTO products
-- =========================================

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 75000, 10, 'Good'),

(102, 'Mouse', 'Electronics', 500, 50, 'Good'),

(103, 'Chair', 'Furniture', 3500, 15, 'Bad'),

(104, 'Bottle', 'Accessories', 250, 100, 'Good'),

(105, 'Phone', 'Electronics', 45000, 20, 'Bad');

-- =========================================
-- =========================================
-- =========================================


-- Practice:

-- Select all columns from students table
-- Select only name and city from students table
-- Select all products with price greater than 5000
-- Select all products in the Electronics category
-- Select all students who passed the SQL course
-- Select all students who are from Hyderabad
-- Select all products with stock less than 20
-- Select all students who are promoted in Python course
-- Select all products with review 'Good'
-- Select all students who are 20 years old
-- Select all products with price between 1000 and 50000
-- Select all students whose name starts with 'P'
-- Select all products whose name contains 'top'

 -- Using Where Clause
-- Select all students whose city is either 'Hyderabad' or 'Mumbai'
-- Select all products whose category is either 'Electronics' or 'Furniture'
-- Select all students whose age is greater than 21 and course is 'Python'
-- Select all products whose price is greater than 1000 and stock is less than 30
-- Select all students whose name starts with 'R' and city is 'Hyderabad'
-- Select all products whose name contains 'o' and review is 'Good'
