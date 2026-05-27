/*
orders_current.csv ->  staging.orders_current ->  

Compare with prod.orders ->  Find rows not already present -> 

insert ONLY new rows into prod.orders



*/


-- create schemas

create schema staging;
create schema prod;



-- Staging

create table staging.orders_current (

    order_id integer,
    customer_name text,
    product_name text,
    quantity integer,
    price numeric,
    order_date date,
    order_status text

);

create table prod.orders (

    order_id integer primary key,
    customer_name text,
    product_name text,
    quantity integer,
    price numeric(10,2),
    order_date date,
    order_status text

);


-- load previous file to staging

copy staging.orders_current
from 'D:\SFC2026\Sphoorthi-FreeSummerClasses-2026\Orders_prev.csv'
delimiter ','
CSV header;

-- load current file to staging

copy staging.orders_current
from 'D:\SFC2026\Sphoorthi-FreeSummerClasses-2026\Orders_current.csv'
delimiter ','
CSV header;



-- Identify new rows by comparing staging.orders_current with prod.orders

select *
from staging.orders_current as sc  
left join prod.orders as po on sc.order_id = po.order_id
where po.order_id is null; -- This will give you the new rows that are not in prod.orders



-- insert new rows into prod.orders

insert into prod.orders (
    order_id, customer_name, product_name,quantity,price,
    order_date,order_status
    )
select
    s.order_id,
    initcap(s.customer_name),
    initcap(s.product_name),
    s.quantity,
    s.price,
    to_date(s.order_date,'DD-MM-YYYY'),
    initcap(s.order_status)
from staging.orders_current as s
left join prod.orders as p on s.order_id = p.order_id
where p.order_id is null;