/*

Snapshot loading is a data integration technique where a complete copy of the source data 
is taken at a specific point in time and loaded into the target system. 
This method is often used when the source data is not frequently updated 
or when a full refresh of the data is required.
In a snapshot load, 
the entire dataset is extracted from the source system and loaded into the target system,
 replacing any existing data. 
 This approach is straightforward and can be efficient for "small to medium-sized" datasets. 
 
In contrast to incremental loading, 
which only captures and loads the changes since the last load, 
snapshot loading does not require tracking changes or maintaining a history of data modifications. 
It is a simple and effective method for scenarios where data changes are infrequent or when a complete refresh is necessary.


27-05-2026
*/

use database test_etl;

create table if not exists staging.inventory_current (

    product_id integer,
    product_name text,
    stock_qty integer

);


create table if not exists prod.inventory (

    snapshot_date date, -- new column to track when the snapshot was taken important
    product_id integer,
    product_name text,
    stock_qty integer

);


-- Insert into staging
-- Data Load step - loading data into staging table from flat file
insert into staging.inventory_current
 values
(101, 'Laptop', 15),
(102, 'Mobile', 28),
(103, 'Mouse', 40);



insert into prod.inventory
 values
(101, 'Laptop', 12),
(102, 'Mobile', 25),
(103, 'Mouse', 40);



insert into prod.inventory (
    snapshot_date,product_id,product_name,stock_qty)
select
    current_date, -- this is snapshot date 
    product_id,
    initcap(product_name),
    stock_qty
from staging.inventory_current;


/*
after yesterday's data load the table looks like this 

2026-05-26 | 101 | Laptop | 15
2026-05-26 | 102 | Mobile | 28
2026-05-26 | 103 | Mouse  | 40


Load fresh data again tomorrow and the table will look like this

2026-05-27 | 101 | Laptop | 12
2026-05-27 | 102 | Mobile | 25
2026-05-27 | 103 | Mouse  | 40

observe the changed values and date to understand the changes in inventory levels.



After tomorow's data load the table looks like this --

+-------------+------------+--------------+----------+
| snapshot_dt | product_id | product_name | stock_qty|
+-------------+------------+--------------+----------+
| 26-05-2026  | 101        | Laptop       | 15       |
| 26-05-2026  | 102        | Mobile       | 28       |
| 27-05-2026  | 101        | Laptop       | 12       |
| 27-05-2026  | 102        | Mobile       | 25       |
+-------------+------------+--------------+----------+




*/

-- Option -1 
select *
from prod.inventory
where product_id = 101
order by snapshot_date;


-- Option -2

select *
from prod.inventory
where product_id = 101
and snapshot_date = (select max(snapshot_date) from prod.inventory);
--order by snapshot_date;
--max(snapshot_date) will give you the latest snapshot date,
--min(snapshot_date) will give you the earliest snapshot date


-- option -3
select *
from prod.inventory
where product_id = 101
    and snapshot_date = '2026-05-27';
--order by snapshot_date;

-- always keeps an audit trail of changes with the help of snapshot_date column,