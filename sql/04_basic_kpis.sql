-- 04_basic_kpis.sql

USE dominos_sales_db;

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_pizzas_sold,

    ROUND(SUM(quantity * unit_price), 2) AS gross_revenue,

    ROUND(SUM(discount_amount), 2) AS total_discount,

    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue,

    ROUND(
        SUM(quantity * unit_price - discount_amount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,

    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS average_pizzas_per_order,

    ROUND(AVG(delivery_minutes), 2) AS average_delivery_minutes

FROM dominos_sales;


-- Revenue by order type
SELECT
    order_type,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS pizzas_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY order_type
ORDER BY net_revenue DESC;


-- Revenue by payment method
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY payment_method
ORDER BY net_revenue DESC;
