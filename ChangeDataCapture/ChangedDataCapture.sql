/*

load only what has been changed and not every row:
load only - 
- new rows
- updated rows
- deleted rows

capture only changed Data



YesterDay's Data -> 

order_id | customer | amount | status
--------------------------------------
101      | Ravi     | 500    | Processing
102      | Sneha    | 900    | Shipped
103      | Priya    | 1200   | Delivered


Today's Data ->

order_id | customer | amount | status
--------------------------------------
101      | Ravi     | 500    | Shipped      <- updated
102      | Sneha    | 900    | Shipped      <- no change
104      | Arjun    | 1500   | Processing   <- new row
103      | Priya    | 1200   | Delivered    <- deleted


SQL Operations

UPDATE -> 101
IGNORE -> 102
DELETE -> 103
INSERT -> 104


*/

create database if not exists cdc;
create schema if not exists staging;
create schema prod;

-- staging table
create table if not exists staging.orders_raw (
    order_id integer,
    customer_name text,
    amount numeric,
    order_status text
);


-- prod table
create table prod.orders (
    order_id integer primary key,
    customer_name text,
    amount numeric,
    order_status text
);


-- there's already dayta in the prod.orders table(Yesterday's data), 
-- we need to load New-Upcoming-fresh-Latest-Today's data 
-- load existing data to prod.orders

insert into prod.orders 
values
(101,'Ravi',500,'Processing'),
(102,'Sneha',900,'Shipped'),
(103,'Priya',1200,'Delivered')
--(104,'Arjun',1500,'Processing');



-- TOday's Data

insert into staging.orders_raw 
values
(101,'Ravi',500,'Shipped'),
(102,'Sneha',900,'Shipped'),
(104,'Arjun',1500,'Processing');



/*

fresh_data left join old_data
finding new rows

select s.*
from staging.orders_raw s
left join prod.orders p
on s.order_id = p.order_id
where p.order_id is null;

*/

-- insert 

insert into prod.orders
select s.*
from staging.orders_raw as  s
left join prod.orders as p
on s.order_id = p.order_id
where p.order_id is null;



/*
updated rows with new statuses

select
    s.order_id,
    p.order_status as old_status,
    s.order_status as new_status

from staging.orders_raw as s
join prod.orders as p
on s.order_id = p.order_id

where
    s.amount <> p.amount
    or
    s.order_status <> p.order_status;

*/

-- update statement

update prod.orders as p
set
    amount = s.amount,
    order_status = s.order_status

from staging.orders_raw as s
where p.order_id = s.order_id
and (
    p.amount <> s.amount or 
    p.order_status <> s.order_status
);


-- deleted rows
/*

select p.*
from prod.orders as p
left join staging.orders_raw as s
on p.order_id = s.order_id
where s.order_id is null;

*/

--delete query

delete from prod.orders
where order_id in (
    select p.order_id
    from prod.orders as p
    left join staging.orders_raw as s 
        on p.order_id = s.order_id
    where s.order_id is null
);

/*
other way

delete from prod.orders p

where not exists (
    select 1
    from staging.orders_raw as s
    where s.order_id = p.order_id
);

select 1 or select * or select order_id would work
 in the subquery as we are just checking for existence of rows ( with exists or not exists) 
*/



