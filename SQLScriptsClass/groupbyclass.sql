/*

:: sales_data table creation and data insertion script ::

This SQL script creates a table named `sales_data` and populates it with sample sales records.
The table includes columns for order ID, customer name, city, category, product name, quantity, and sales amount.
The inserted data represents various sales transactions across different cities and product categories.

:: Group by Queries ::

Group by creates a set of rows that have the same values in specified columns and allows you to perform aggregate functions on those groups.
For example, you can use GROUP BY to calculate the total sales amount for each city or category.
Example of a GROUP BY query:
SELECT city, SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY city;


:: Aggregate Functions ::
Aggregate functions perform calculations on a set of values and return a single value.
Some common aggregate functions include:
- SUM(): Calculates the total sum of a numeric column.
- COUNT(): Counts the number of rows in a group.
- AVG(): Calculates the average value of a numeric column.
- MAX(): Returns the maximum value in a group.
- MIN(): Returns the minimum value in a group.


:: Syntax of GROUP BY::


SELECT column1,
        column2, 
        aggregate_function(column3)
FROM table_name
GROUP BY column1, column2;


In this syntax:
- column1, column2: These are the columns by which you want to group the data.  
                    You can specify one or more columns.
- aggregate_function(column3): This is the aggregate function you want to apply to the grouped data.                         
- table_name:   This is the name of the table from which you want to retrieve data.
- GROUP BY :    clause groups the result set by the specified columns,
                and the aggregate function is applied to each group to produce a summary result.


*/


CREATE TABLE sales_data (
    order_id INTEGER,
    customer_name TEXT,
    city TEXT,
    category TEXT,
    product_name TEXT,
    quantity INTEGER,
    sales_amount REAL
);



INSERT INTO sales_data VALUES
(1, 'Alice', 'Hyderabad', 'Electronics', 'Laptop', 1, 5000),
(2, 'Bob', 'Hyderabad', 'Electronics', 'Smartphone', 2, 7000),
(3, 'Charlie', 'Hyderabad', 'Electronics', 'Tablet', 3, 7000),
(4, 'David', 'Hyderabad', 'Electronics', 'Headphones', 4, 9000),
(5, 'Eve', 'Hyderabad', 'Electronics', 'Camera', 5, 12000),
(6, 'Frank', 'Bangalore', 'Home Appliances', 'Refrigerator', 1, 4000),
(7, 'Grace', 'Bangalore', 'Home Appliances', 'Washing Machine', 2, 6000),
(8, 'Heidi', 'Bangalore', 'Home Appliances', 'Microwave Oven', 3, 6000),
(9, 'Ivan', 'Bangalore', 'Home Appliances', 'Air Conditioner', 4, 10000),
(10, 'Judy', 'Bangalore', 'Home Appliances', 'Vacuum Cleaner', 5, 15000),
(11, 'Karl', 'Chennai', 'Furniture', 'Sofa Set', 1, 3000),
(12, 'Leo', 'Chennai', 'Furniture', 'Dining Table', 2, 3000),
(13, 'Mallory', 'Chennai', 'Furniture', 'Bed Frame', 3, 5000),
(14, 'Nina', 'Chennai', 'Furniture', 'Wardrobe', 4, 8000),
(15, 'Oscar', 'Chennai', 'Furniture', 'Bookshelf', 5, 11000),
(16, 'Peggy', 'Mumbai', 'Clothing & Accessories','T-shirt Set' ,1 ,4500),
(17,  	'Quentin'	,'Mumbai'	,'Clothing & Accessories'	,'Jeans'		2	 ,4500),
(18	,'Rupert'	,'Mumbai'	,'Clothing & Accessories'	,'Jacket'	3	 ,7500),
(19	,'Sybil'	,'Mumbai'	,'Clothing & Accessories'	,'Sneakers'	4	 ,9500),
(20	,'Trent'	,'Mumbai'	,'Clothing & Accessories'	,'Watch'	5	 ,14000),
(21	,'Uma'	,'Pune'	,'Books & Stationery'	,'Novel Set'	1	 ,3500),
(22	,'Victor'	,'Pune'	,'Books & Stationery'	,'Textbook Set'	2	 ,5500),
(23	,'Wendy'	,'Pune'	,'Books & Stationery'	,'Notebook Set'	3	 ,5500),
(24	,'Xavier'	,'Pune'	,'Books & Stationery'	,'Pen Set'	    4	  ,8500),
(25	,'Yvonne'	,'Pune'	,'Books & Stationery'	,'Art Supplies Set', 5, 13000),
(26, 'Zara', 'Delhi', 'Sports & Outdoors', 'Fitness Tracker', 1, 6000),
(27, 'Adam', 'Delhi', 'Sports & Outdoors', 'Yoga Mat', 2, 4000),
(28, 'Eve', 'Delhi', 'Sports & Outdoors', 'Dumbbell Set', 3, 8000),
(29, 'Charlie', 'Delhi', 'Sports & Outdoors', 'Treadmill', 4, 15000),
(30, 'Bob', 'Delhi', 'Sports & Outdoors', 'Bicycle', 5, 20000),
(31, 'Alice', 'Hyderabad', 'Electronics', 'Laptop', 1, 5000),
(32, 'Bob', 'Hyderabad', 'Electronics', 'Smartphone', 2, 7000),
(33, 'Charlie', 'Hyderabad', 'Electronics', 'Tablet', 3, 7000),
(34, 'David', 'Hyderabad', 'Electronics', 'Headphones', 4, 9000),
(35, 'Eve', 'Hyderabad', 'Electronics', 'Camera', 5, 12000),
(36, 'Frank', 'Bangalore', 'Home Appliances', 'Refrigerator', 1, 4000),
(37, 'Grace', 'Bangalore', 'Home Appliances', 'Washing Machine', 2, 6000),
(38, 'Heidi', 'Bangalore', 'Home Appliances', 'Microwave Oven', 3, 6000),
(39, 'Ivan', 'Bangalore', 'Home Appliances', 'Air Conditioner', 4, 10000),
(40, 'Judy', 'Bangalore', 'Home Appliances', 'Vacuum Cleaner', 5, 15000);





-- Sample GROUP BY queries to practice

-- 1. Total sales amount for each city
-- 2. Total quantity sold for each category
-- 3. Average sales amount for each product
-- 4. Maximum sales amount for each city
-- 5. Minimum sales amount for each category
-- 6. Total sales amount for each city and category
-- 7. Total quantity sold for each city and product
-- 8. Average sales amount for each city and product
-- 9. Maximum sales amount for each city and category
-- 10. Minimum sales amount for each city and category
-- 11. Total sales amount for each customer
-- 12. Total quantity sold for each customer
-- 13. Average sales amount for each customer
-- 14. Maximum sales amount for each customer
-- 15. Minimum sales amount for each customer
