
-- =========================================
-- SIMPLE DATABASE DEMO
-- PostgreSQL // SQLite Compatible
-- =========================================


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


