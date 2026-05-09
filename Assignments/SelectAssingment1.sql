/*

- Use Select & Filter statements to solve the problems below 
- Run below Create & Insert statements to create and populate the table with data
- you can Use https://onecompiler.com/postgresql/44nsmvuuf


*/

-- =========================================
-- CREATE TABLE : cars
-- =========================================

CREATE TABLE cars (
    chasis TEXT,
    brand TEXT,
    model TEXT,
    price REAL,
    production_year INTEGER
);


-- =========================================
-- INSERT DATA INTO cars
-- =========================================

INSERT INTO cars VALUES
('LJCPCBLCX14500264', 'Ford', 'Focus', 8000.00, 2005),

('WPOZZZ79ZTS372128', 'Ford', 'Fusion', 12500.00, 2008),

('JF1BR93D7BG498281', 'Toyota', 'Avensis', 11300.00, 1999),

('KLATF08Y1VB363636', 'Volkswagen', 'Golf', 3270.00, 1992),

('1M8GDM9AXKP042788', 'Volkswagen', 'Golf', 13000.00, 2010),

('1HGCM82633A004352', 'Volkswagen', 'Jetta', 6420.00, 2003),

('1G1YZ23J9P5800003', 'Fiat', 'Punto', 5700.00, 1999),

('GS723HDSAK2399002', 'Opel', 'Corsa', NULL, 2007);


/*


+---------------------+------------+----------+----------+-----------------+
| CHASIS                 | BRAND      | MODEL    | PRICE    | PRODUCTION_YEAR |
+---------------------+------------+----------+----------+-----------------+
| LJCPCBLCX14500264  | Ford       | Focus    | 8000.00  | 2005            |
| WPOZZZ79ZTS372128  | Ford       | Fusion   | 12500.00 | 2008            |
| JF1BR93D7BG498281  | Toyota     | Avensis  | 11300.00 | 1999            |
| KLATF08Y1VB363636  | Volkswagen | Golf     | 3270.00  | 1992            |
| 1M8GDM9AXKP042788  | Volkswagen | Golf     | 13000.00 | 2010            |
| 1HGCM82633A004352  | Volkswagen | Jetta    | 6420.00  | 2003            |
| 1G1YZ23J9P5800003  | Fiat       | Punto    | 5700.00  | 1999            |
| GS723HDSAK2399002  | Opel       | Corsa    | NULL     | 2007            |
+---------------------+------------+----------+----------+-----------------+


*/


-- Assignments



-- Select all the FORD cars only



-- Select only cars which are produced after 2003 



-- select cars which are produced in the year 2003 


/*
 Use AND operator to chain multiple conditions in the where condition 

eg : production_year = 2003 and model = 'Ford' and ColumnName=SomeValue and ColumnName = SomeValue ....

*/


-- using the above example select all volkswagen cars 
-- which are prouced after 2003



-- select the volkswagen cars which are produced after 2003 and price more authorization
-- 7000 rupees