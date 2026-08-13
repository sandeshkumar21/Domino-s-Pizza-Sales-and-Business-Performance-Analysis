-- 03_data_quality.sql

USE dominos_sales_db;

-- Null checks
SELECT
    SUM(order_id IS NULL) AS null_order_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(store_id IS NULL) AS null_store_id,
    SUM(pizza_id IS NULL) AS null_pizza_id,
    SUM(quantity IS NULL) AS null_quantity,
    SUM(unit_price IS NULL) AS null_unit_price,
    SUM(discount_amount IS NULL) AS null_discount,
    SUM(delivery_minutes IS NULL) AS null_delivery
FROM dominos_sales;

-- Check invalid values
SELECT *
FROM dominos_sales
WHERE quantity <= 0
   OR unit_price < 0
   OR discount_amount < 0
   OR delivery_minutes < 0;

-- Orders containing multiple pizza rows
SELECT
    order_id,
    COUNT(*) AS line_items
FROM dominos_sales
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY line_items DESC;
