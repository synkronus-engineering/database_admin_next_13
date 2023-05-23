

-- function return order with details
-- drop funtion get_order_with_details
CREATE OR REPLACE FUNCTION get_order_with_details(prm_order_id bigint) RETURNS JSONB AS $$
DECLARE
    order_details JSONB;
BEGIN
    SELECT jsonb_build_object(
        'order_id', o.id,
        'user_id', o.user_id,
        'order_number', o.order_number,
        'state', o.state,
        'amount', o.amount,
        'delivery_date', o.delivery_date,
        'order_created_at', o.created_at,
        'order_detail', jsonb_build_object(
            'detail_id', od.id,
            'shipping_address', od.shipping_address,
            'mobile_number', od.mobile_number,
            'order_detail_created_at', od.created_at,
            'product_items', get_product_details(prm_order_id)
        )
    )
    INTO order_details
    FROM public.orders AS o
        INNER JOIN public.order_detail AS od ON o.id = od.order_id
        where o.id = prm_order_id;

    RETURN order_details;
END;
$$ LANGUAGE plpgsql;

SELECT get_order_with_details(100);


-- function return product list 
-- drop funtion get_product_details
CREATE OR REPLACE FUNCTION get_product_details(prm_order_id bigint) RETURNS JSONB AS $$
DECLARE
    product_details JSONB;
BEGIN
    WITH tbl_od AS (
        SELECT
            od.id AS detail_id,
            (jsonb_array_elements(od.product_items)->>'product_id')::bigint AS product_id,
            (jsonb_array_elements(od.product_items)->>'qty')::bigint AS qty
        FROM
            public.order_detail AS od
        WHERE
            od.order_id = prm_order_id
    )

    SELECT jsonb_agg(jsonb_build_object(
        'product_id', prod_arr.product_id,
        'qty', prod_arr.qty,
        'code', prod_arr.code,
        'name', prod_arr.name,
        'description', prod_arr.description,
        'image', prod_arr.image,
        'path', prod_arr.path,
        'price', prod_arr.price,
        'category', prod_arr.category,
        'quantity', prod_arr.quantity,
        'inventory_status', prod_arr.inventory_status,
        'rating', prod_arr.rating
    ))  FROM (
        SELECT
            tbl_od.product_id,
            tbl_od.qty,
            p.code,
            p.name,
            p.description,
            p.image,
            p.path,
            p.price,
            p.category,
            p.quantity,
            p.inventory_status,
            p.rating
        FROM
            tbl_od JOIN public.products AS p ON p.id = tbl_od.product_id
    )  prod_arr INTO product_details;
    
    RETURN product_details;
END;
$$ LANGUAGE plpgsql;

SELECT get_product_details(100); -- Replace 100 with the desired order_id


