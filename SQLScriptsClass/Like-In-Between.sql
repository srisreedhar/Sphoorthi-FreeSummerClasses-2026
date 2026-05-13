/*

LIKE, IN, BETWEEN Operators in SQL


:: LIKE Operator ::

The LIKE, IN, and BETWEEN operators are commonly used in SQL to filter data based on specific conditions.
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

The syntax for the LIKE operator is as follows:

SELECT column1, 
        column2,    
        ... 
        columnN
FROM table_name
WHERE column_name LIKE pattern;


In this syntax:
- column_name: This is the name of the column you want to search.
- pattern: This is the pattern you want to search for. It can include wildcard characters:
  - %: Represents zero or more characters.
  - _: Represents a single character.  

:: Sample Patterns for the LIKE operator ::

- 'A%': Matches any string that starts with 'A'.
- '%A': Matches any string that ends with 'A'.
- '%A%': Matches any string that contains 'A'.
- 'A_B': Matches any string that starts with 'A', followed by any single character
    and ends with 'B' (e.g., 'ACB', 'A1B', etc.).



Example of using the LIKE operator:

SELECT *
FROM products
WHERE product_name LIKE 'A%';

This query retrieves all products whose names start with the letter 'A'.

=================================================================================================
::  IN Operator ::

The IN operator is used to filter the result set based on a list of specified values.
The syntax for the IN operator is as follows:

SELECT column1, 
        column2,
         ... 
        columnN
FROM table_name
WHERE column_name IN (value1, value2, ...);


In this syntax:
- column_name: This is the name of the column you want to filter.
- value1, value2, ...: These are the values you want to match against the column. 
                       You can specify one or more values, separated by commas.


Example of using the IN operator:
SELECT *    
FROM students
WHERE city IN ('New York', 'Los Angeles', 'Chicago');

This query retrieves all students who are from either New York, Los Angeles, or Chicago.


=================================================================================================



:: BETWEEN Operator ::


The BETWEEN operator is used to filter the result set based on a range of values.
The syntax for the BETWEEN operator is as follows:

SELECT column1, 
        column2, 
        ... 
        columnN
FROM table_name
WHERE column_name BETWEEN value1 AND value2;


In this syntax:
- column_name: This is the name of the column you want to filter.
- value1: This is the lower bound of the range.
- value2: This is the upper bound of the range.

:: Between Operator Notes ::
- The BETWEEN operator is inclusive, meaning it includes the boundary values or RANGE (value1 and value2) in the results.
- The values used with the BETWEEN operator can be numbers, dates, or even text (depending
on the data type of the column).
- Between can also be used with the NOT keyword to filter out values that fall within a specified range. 
  For example, WHERE column_name NOT BETWEEN value1 AND value2 would return rows where the column value is outside the 
  specified range. 


Example of using the BETWEEN operator:
SELECT *
FROM products
WHERE price BETWEEN 100 AND 500;    
This query retrieves all products whose price is between 100 and 500, inclusive.


*/


-- =========================================
-- Table Creation : ecommerce products
-- =========================================


CREATE TABLE products (
    product_id INTEGER,
    product_name TEXT,
    category TEXT,
    price REAL
);      

-- =========================================
-- Insert Sample Data into products table
-- =========================================

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 499.99),
(3, 'Headphones', 'Electronics', 199.99),
(4, 'Coffee Maker', 'Home Appliances', 79.99),
(5, 'Blender', 'Home Appliances', 59.99),
(6, 'Air Fryer', 'Home Appliances', 129.99),
(7, 'Running Shoes', 'Footwear', 89.99),
(8, 'Sandals', 'Footwear', 39.99),
(9, 'Boots', 'Footwear', 149.99)
(10, 'T-shirt', 'Clothing', 19.99),
(11, 'Jeans', 'Clothing', 49.99),
(12, 'Jacket', 'Clothing', 89.99)
(13, 'Sofa', 'Furniture', 899.99),
(14, 'Dining Table', 'Furniture', 499.99),
(15, 'Bed Frame', 'Furniture', 699.99)
(16, 'Bookshelf', 'Furniture', 199.99),
(17, 'Office Chair', 'Furniture', 149.99),
(18, 'TV Stand', 'Furniture', 299.99),
(19, 'Wardrobe', 'Furniture', 799.99),
(20, 'Coffee Table', 'Furniture', 249.99);


-- Sample Queries to practice LIKE, IN, BETWEEN operators
-- 1. Using LIKE operator to find products that start with 'S'
-- 2. Using IN operator to find products in the 'Electronics' and 'Furniture' categories
-- 3. Using BETWEEN operator to find products with price between 100 and 500

