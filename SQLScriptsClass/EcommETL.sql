--create staging schema
create schema staging;
drop schema staging cascade;






-- create staging tables for file load

create table staging.ecommerce_raw (
	-- customer kyc
    customer_id TEXT,
    customer_name TEXT,
    city TEXT,
    state TEXT,
    customer_status TEXT,
	-- order colmns
    order_id TEXT,
    order_value NUMERIC,
	-- product colmn
    product_name TEXT,
    product_category TEXT,

    order_date TIMESTAMP,
    order_status TEXT,
	-- paymnt/promo colmns
    promotion_applied TEXT,
    payment_details TEXT,
    name_on_payment TEXT,
	-- seller info
    seller_id TEXT,
    seller_name TEXT,
    seller_city TEXT,
    seller_rating NUMERIC

);



-- copy data into staging table from csv
copy staging.ecommerce_raw
from 'D:\SFC2026\Sphoorthi-FreeSummerClasses-2026\Scripts\ecommerce_data_20260521_0026.csv'
delimiter ','
CSV header;


-- verify
select * from staging.ecommerce_raw
limit 33;





/*

creating prod schema & tables for
f_orders ( fact table)
dim_customer ( dim table )
dim_product  ( dim table )

*/

-- create PROD schema
create schema prod;
drop schema prod cascade;




-- PROD.dim_cust
create table prod.dim_customer (

    customer_id TEXT,
    customer_name TEXT,
    city TEXT,
    state TEXT,
    customer_status TEXT

);

-- PROD.dim_product
create table prod.dim_product (

    product_name TEXT,
    product_category TEXT

);


-- PROD.Orders fact table
create table prod.f_orders (
    order_id TEXT,
	
    customer_id TEXT,

    product_name TEXT,

    order_value NUMERIC,

    revenue_category TEXT,

    order_date TIMESTAMP,

    order_status TEXT,

    promotion_applied TEXT,

    payment_details TEXT,

    seller_id TEXT,
	
    seller_name TEXT,

    seller_city TEXT,

    seller_rating NUMERIC,

    payment_name_match TEXT

);


-- Insert data into "prod.dim_customer" tables using the tables in staging data

insert into prod.dim_customer
select distinct customer_id, -- to remove duplicates
		INITCAP(customer_name) as customer_name,
		INITCAP(city) as city,
		INITCAP(state) as state,
		lower(customer_status) as customer_status -- standardizing
from staging.ecommerce_raw;


-- Insert data into "prod.dim_product" tables using the tables in staging data

insert into prod.dim_product
select distinct INITCAP(product_name) as product_name,
			INITCAP(product_category) as product_category
from staging.ecommerce_raw;


-- FACT TABLE data load
-- target -> f_orders table
-- src -> staging.ecommerce_raw


insert into prod.f_orders
select	order_id,
		customer_id,
		INITCAP(product_name) as product_name,
		order_value,
		-- KPIs/Transformational logic
		case 
        when order_value >= 25000 then 'High Value'
		when order_value >= 10000 then 'Medium Value'
		else 'Low Value' end as revenue_category,
		order_date,
		lower(order_status) as order_status,
		lower(promotion_applied) as promotion_applied,
    	INITCAP(payment_details) as payment_details,
		seller_id,
    	INITCAP(seller_name) as seller_name,
    	INITCAP(seller_city) as seller_city,
    	seller_rating,
		-- KPIs/Transformational logic
   		case
        when lower(customer_name) = lower(name_on_payment) then 'Matched'
		else 'Mismatch' end as payment_name_match

from staging.ecommerce_raw;
-- where order_value is not NULL;



-- VERIFY data in prod tables

select * from prod.dim_customer limit 33;
select * from prod.dim_product limit 33;
select * from prod.f_orders limit 33;



-- Insights

-- profit by categories
select revenue_category, sum(order_value) as total_sale
from prod.f_orders
group by revenue_category;

-- Top Selling
select dp.product_category, count(*) as total_count
from prod.f_orders as fo
join prod.dim_product dp on fo.product_name = dp.product_name
group by dp.product_category
order by count(*) desc;


-- Fraud case scenarios

select  * from prod.f_orders
where payment_name_match = 'Mismatch';


/*

Create a seperate Table for Fraud detection and
populate all the cases/orders into it
this would be in PROD Schema

below are the Fraud Rules

| Rule                  | Fraud Indicator |
| --------------------- | --------------- |
| Payment name mismatch | suspicious      |
| Very high order value | suspicious      |
| Shell customer        | suspicious      |
| Seller rating too low | suspicious      |


*/


-- Fraud Table

create table prod.fraud_detection (
    order_id TEXT,
    customer_id TEXT,
    customer_name TEXT,
    city TEXT,
    customer_status TEXT,
    order_value NUMERIC,
    payment_details TEXT,
    name_on_payment TEXT,
    seller_name TEXT,
    seller_city TEXT,
    fraud_reason TEXT,
    fraud_flag TEXT
);



-- Insert Query

insert into prod.fraud_detection
select order_id, customer_id,
	   customer_name, city, customer_status,
		order_value, payment_details,
		name_on_payment,
		seller_name, seller_city,

    	case
			when lower(customer_name) <> lower(name_on_payment) then 'Payment Name Mismatch'
			when order_value >= 50000 then 'High Value Transaction'
			when lower(customer_status) = 'shell customer' then 'Shell Customer Activity'
			when seller_rating < 2 then 'Low Seller Rating' 
			else 'Normal Activity'
		end as fraud_reason,

    	case
			when lower(customer_name) <> lower(name_on_payment) then 'Fraud'
			when order_value >= 50000 and lower(customer_status) = 'shell customer'  then 'Fraud'
			when seller_rating < 2 then 'Fraud' else 'Safe'
		end as fraud_flag

from staging.ecommerce_raw;

-- Verify fraud data
select * from prod.fraud_detection
limit 33;


-- show fraud rows usingflag
select * from prod.fraud_detection
where fraud_flag = 'Fraud';


-- Fraud Type count
select fraud_reason, count(*) as hit_count
from prod.fraud_detection
group by fraud_reason
order by count(*) desc;







