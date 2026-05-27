Begin;


-- Load data into staging table from Flat file 

copy staging.ecommerce_raw
from 'FILE-PATH-HERE'
delimiter ','
CSV header;

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


COmmit;

--Rollback;