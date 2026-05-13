/*

Learn about window functions in SQL and how to use them to perform calculations 
across a set of table rows that are related to the current row.
Window functions are used to perform calculations across a set of rows that are related to the current row.
 They are often used in conjunction with the OVER() clause, which defines the window of rows that the function should operate on.
Some common window functions include: 

Ranking functions such as:

ROW_NUMBER()
RANK()
DENSE_RANK()
and NTILE()

Aggregate functions such as:

SUM()
AVG()
COUNT()
MAX()
MIN()

Analytical functions such as: 

Lead() and Lag()


- These functions can be used to assign a unique sequential integer to rows within a partition of a result set,
- rank rows within a partition of a result set, or divide rows into a specified number of groups.

Important : 
Window functions can be used in SELECT, ORDER BY, and HAVING clauses, but not in WHERE clauses. 
They are often used in data analysis and reporting to perform calculations such as running totals, moving averages, and ranking.


*/


-- =========================================
-- CREATE TABLE : sales_orders
-- =========================================

CREATE TABLE sales_orders (
    order_id INTEGER,
    customer_name TEXT,
    city TEXT,
    product_name TEXT,
    amount REAL,
    order_date DATE
);


-- =========================================
-- INSERT DATA
-- =========================================

INSERT INTO sales_orders VALUES

(1001, 'Ravi', 'Hyderabad', 'Laptop', 75000, '2025-01-01'),

(1002, 'Sneha', 'Bangalore', 'Phone', 45000, '2025-01-02'),

(1003, 'Arjun', 'Chennai', 'Chair', 5000, '2025-01-03'),

(1004, 'Priya', 'Mumbai', 'Laptop', 75000, '2025-01-03'),

(1005, 'Kiran', 'Pune', 'Bottle', 500, '2025-01-04'),

(1006, 'Rahul', 'Hyderabad', 'Mouse', 700, '2025-01-05'),

(1007, 'Meena', 'Delhi', 'Table', 12000, '2025-01-06'),

(1008, 'Suresh', 'Chennai', 'Keyboard', 1500, '2025-01-07'),

(1009, 'Anita', 'Mumbai', 'Phone', 45000, '2025-01-07'),

(1010, 'Vikram', 'Bangalore', 'Laptop', 75000, '2025-01-08'),

(1011, 'Neha', 'Pune', 'Bottle', 500, '2025-01-09'),

(1012, 'Ramesh', 'Hyderabad', 'Chair', 5000, '2025-01-10'),

(1013, 'Divya', 'Delhi', 'Phone', 45000, '2025-01-11'),

(1014, 'Karthik', 'Mumbai', 'Laptop', 80000, '2025-01-12'),

(1015, 'Lavanya', 'Bangalore', 'Mouse', 900, '2025-01-13'),

(1016, 'Harish', 'Chennai', 'Monitor', 18000, '2025-01-14'),

(1017, 'Pooja', 'Hyderabad', 'Keyboard', 2000, '2025-01-15'),

(1018, 'Nikhil', 'Pune', 'Laptop', 72000, '2025-01-16'),

(1019, 'Asha', 'Delhi', 'Phone', 43000, '2025-01-17'),

(1020, 'Manoj', 'Mumbai', 'Chair', 6500, '2025-01-18');




-- Practice Queries Below 



-- minimum order amount for each city
-- This query retrieves the minimum order amount for each city, along with the rank of each order

-- maximum order amount for each city
-- This query retrieves the maximum order amount for each city, along with the rank of each order

-- Total sales amount for each city
-- This query retrieves the total sales amount for each city, along with the rank of each order

-- total sales amount for each city ordered by order date
-- This query retrieves the total sales amount for each city, ordered by the order date, along

-- Top Sales Orders by Amount
-- This query retrieves the top 5 sales orders based on the amount, along with their rank.


-- Top Sales Orders by Amount with Partitioning by City
-- This query retrieves the top 5 sales orders based on the amount for each city, along with their rank within each city.

-- Top Sales Orders by Amount with Partitioning by City and Ordering by Order Date
-- This query retrieves the top 5 sales orders based on the amount for each city,
--  ordered by the order date, along with their rank within each city.


-- Apply Row_number, rank, dense_rank to be below data and find the difference between them.




