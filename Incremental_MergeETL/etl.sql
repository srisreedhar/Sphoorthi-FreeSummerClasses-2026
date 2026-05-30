
-- database,schema,tables creation

create database incredb;


create schema staging;
create schema prod;

-- verify
select schema_name from information_schema.schemata 
where schema_name in ('staging', 'prod');


-- 1. staging table (raw layer)
create table if not exists staging.ecommerce_raw (
    customer_id text,
    customer_name text,
    city text,
    state text,
    customer_status text,
    order_id text primary key,           -- key
    order_value numeric(12,2),
    product_name text,
    product_category text,
    order_date timestamp,
    order_status text,
    promotion_applied text,
    payment_details text,
    name_on_payment text,
    seller_id text,
    seller_name text,
    seller_city text,
    seller_rating numeric(2,1),
    load_timestamp timestamp default current_timestamp
);

-- 2. production table (clean + final)
create table if not exists prod.ecommerce (
    customer_id text,
    customer_name text,
    city text,
    state text,
    customer_status text,
    
    order_id text primary key,
    order_value numeric(12,2),
    product_name text,
    product_category text,
    order_date timestamp,
    order_status text,
    promotion_applied text,
    payment_details text,
    name_on_payment text,
    
    seller_id text,
    seller_name text,
    seller_city text,
    seller_rating numeric(2,1),
    
    load_timestamp timestamp,
    last_updated timestamp default current_timestamp
);

-- load data using copy

-- truncate staging first (for fresh load)
-- truncate table staging.ecommerce_raw;

-- load data using \copy (recommended in psql)
copy staging.ecommerce_raw (customer_id, customer_name, city, state, customer_status, 
                             order_id, order_value, product_name, product_category, 
                             order_date, order_status, promotion_applied, payment_details, 
                             name_on_payment, seller_id, seller_name, seller_city, seller_rating)
from 'c:/path_to_created_file_here.csv'
delimiter ',' csv header;


-- check data load
select count(*) from staging.ecommerce_raw;




-- Incremental logic
-- Routine logic

-- 1. update existing records
update prod.ecommerce p
set 
    customer_name     = s.customer_name,
    city              = s.city,
    customer_status   = s.customer_status,
    order_value       = s.order_value,
    order_status      = s.order_status,
    name_on_payment   = s.name_on_payment,
    seller_city       = s.seller_city,
    last_updated      = current_timestamp
from staging.ecommerce_raw s
where p.order_id = s.order_id
  and (
      p.customer_name is distinct from s.customer_name or
      p.city is distinct from s.city or
      p.customer_status is distinct from s.customer_status
  );

-- 2. insert only new records
insert into prod.ecommerce
select 
    s.customer_id, s.customer_name, s.city, s.state, s.customer_status,
    s.order_id, s.order_value, s.product_name, s.product_category, s.order_date,
    s.order_status, s.promotion_applied, s.payment_details, s.name_on_payment,
    s.seller_id, s.seller_name, s.seller_city, s.seller_rating,
    s.load_timestamp, current_timestamp
from staging.ecommerce_raw s
left join prod.ecommerce p on p.order_id = s.order_id
where p.order_id is null;