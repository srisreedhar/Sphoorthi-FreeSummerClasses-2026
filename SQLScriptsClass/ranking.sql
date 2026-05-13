/*

Apply Row_number, rank, dense_rank to be below data and find the difference between them.

also try with and without partition by clause.

try with and without order by clause.


*/





-- =========================================
-- CREATE TABLE : city_sales
-- =========================================

CREATE TABLE city_sales (
    sale_id INTEGER,
    city TEXT,
    sales_amount INTEGER
);


-- =========================================
-- INSERT DATA
-- =========================================

INSERT INTO city_sales VALUES

(1,  'Hyderabad', 5000),
(2,  'Hyderabad', 7000),
(3,  'Hyderabad', 7000),
(4,  'Hyderabad', 9000),
(5,  'Hyderabad', 12000),

(6,  'Bangalore', 4000),
(7,  'Bangalore', 6000),
(8,  'Bangalore', 6000),
(9,  'Bangalore', 10000),
(10, 'Bangalore', 15000),

(11, 'Chennai', 3000),
(12, 'Chennai', 3000),
(13, 'Chennai', 5000),
(14, 'Chennai', 8000),
(15, 'Chennai', 11000),

(16, 'Mumbai', 4500),
(17, 'Mumbai', 4500),
(18, 'Mumbai', 7500),
(19, 'Mumbai', 9500),
(20, 'Mumbai', 14000),

(21, 'Pune', 3500),
(22, 'Pune', 5500),
(23, 'Pune', 5500),
(24, 'Pune', 8500),
(25, 'Pune', 13000),

(26, 'Delhi', 6000),
(27, 'Delhi', 6000),
(28, 'Delhi', 9000),
(29, 'Delhi', 9000),
(30, 'Delhi', 16000);