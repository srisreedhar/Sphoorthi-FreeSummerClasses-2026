-- create Database NAME_of_the_DATABASE



--raw temporary data

--drop schema staging cascade;
create schema staging;



-- clean business-ready data

--drop schema prod cascade;
create schema prod;



-- Staging Orders tables - raw

create table staging.orders_raw (

    order_id INTEGER,
    customer_name TEXT,
    city TEXT,
    product_name TEXT,
    quantity INTEGER,
    price NUMERIC,
    order_date DATE

);


-- Prod Orders Table

create table prod.orders_data (

    order_id INTEGER,
    customer_name TEXT,
    city TEXT,
    product_name TEXT,
    quantity INTEGER,
    price NUMERIC,
    revenue NUMERIC,
    order_category TEXT,
    order_date DATE

);


-- Copying orders from Local disc to staging

COPY staging.orders_raw
FROM 'D:\SFC2026\Sphoorthi-FreeSummerClasses-2026\Scripts\orders_data.csv'
DELIMITER ','
CSV HEADER;

-- verifing the data in staging

select * from staging.orders_raw;


-- sample transformation query

select order_id,
		customer_name,
		-- convert first letter into CAP
		initcap(city) AS city,
		product_name, quantity,
		price,
		quantity * price AS revenue,
    	case
        when price >= 500 then 'High Value'
		else 'Low Value'	end as order_category,
		order_date
from staging.orders_raw;
--where price is not NULL;



-- Inserting these values into PROD
insert into prod.orders_data
select order_id,
		customer_name,
		-- convert first letter into CAP
		initcap(city) AS city,
		product_name, quantity,
		price,
		quantity * price AS revenue,
    	case
        when price >= 500 then 'High Value'
		else 'Low Value'	end as order_category,
		order_date

from staging.orders_raw;


-- verify the PROD data

select * from prod.orders_data;


-- sample KPI/Insights derivations

select product_name, sum(revenue)
from prod.orders_data
group by product_name;



