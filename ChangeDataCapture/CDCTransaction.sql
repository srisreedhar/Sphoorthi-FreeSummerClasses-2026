-- Trnasactional script for Change Data Capture (CDC)
-- This script demonstrates how to capture and apply changes from
--  a source table to a target table using SQL transactions.

begin;

---------------------------------------------------
-- step 1 : insert new records
---------------------------------------------------

insert into prod.orders (

        order_id,
        customer_name,
        amount,
        order_status

    )

select

        s.order_id,
        s.customer_name,
        s.amount,
        s.order_status

    from staging.orders_source s

    left join prod.orders p
    on s.order_id = p.order_id

    where p.order_id is null;


---------------------------------------------------
-- step 2 : update changed records
---------------------------------------------------

update prod.orders p

    set
        customer_name = s.customer_name,
        amount = s.amount,
        order_status = s.order_status

    from staging.orders_source s

    where p.order_id = s.order_id

    and (

        p.customer_name <> s.customer_name
        or
        p.amount <> s.amount
        or
        p.order_status <> s.order_status

    );


---------------------------------------------------
-- step 3 : delete removed records
---------------------------------------------------

delete from prod.orders p

    where not exists (

        select 1
        from staging.orders_source s
        where s.order_id = p.order_id

    );


---------------------------------------------------
-- step 4 : save changes
---------------------------------------------------

commit;


-- Rollback;
-- to revert the changes if needed
