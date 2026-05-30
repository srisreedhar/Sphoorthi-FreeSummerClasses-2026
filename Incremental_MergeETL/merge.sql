-- the same INSERT,DELETE,UPDATE operations are performed on the prod.ecommerce table using MERGE statement

-- Incremental Load: Insert New + Update Changed Records
MERGE INTO prod.ecommerce AS target
USING staging.ecommerce_raw AS source
ON target.order_id = source.order_id

WHEN MATCHED 
    -- Update only if something actually changed
    AND (
        target.customer_name      IS DISTINCT FROM source.customer_name OR
        target.city               IS DISTINCT FROM source.city OR
        target.customer_status    IS DISTINCT FROM source.customer_status OR
        target.order_value        IS DISTINCT FROM source.order_value OR
        target.order_status       IS DISTINCT FROM source.order_status OR
        target.name_on_payment    IS DISTINCT FROM source.name_on_payment OR
        target.seller_city        IS DISTINCT FROM source.seller_city
    )
THEN 
    UPDATE SET
        customer_name     = source.customer_name,
        city              = source.city,
        state             = source.state,
        customer_status   = source.customer_status,
        order_value       = source.order_value,
        product_name      = source.product_name,
        product_category  = source.product_category,
        order_date        = source.order_date,
        order_status      = source.order_status,
        promotion_applied = source.promotion_applied,
        payment_details   = source.payment_details,
        name_on_payment   = source.name_on_payment,
        seller_id         = source.seller_id,
        seller_name       = source.seller_name,
        seller_city       = source.seller_city,
        seller_rating     = source.seller_rating,
        last_updated      = CURRENT_TIMESTAMP,
        load_timestamp    = source.load_timestamp

WHEN NOT MATCHED THEN
    INSERT (
        customer_id, customer_name, city, state, customer_status,
        order_id, order_value, product_name, product_category, order_date,
        order_status, promotion_applied, payment_details, name_on_payment,
        seller_id, seller_name, seller_city, seller_rating,
        load_timestamp, last_updated
    )
    VALUES (
        source.customer_id, source.customer_name, source.city, source.state, source.customer_status,
        source.order_id, source.order_value, source.product_name, source.product_category, source.order_date,
        source.order_status, source.promotion_applied, source.payment_details, source.name_on_payment,
        source.seller_id, source.seller_name, source.seller_city, source.seller_rating,
        source.load_timestamp, CURRENT_TIMESTAMP
    );