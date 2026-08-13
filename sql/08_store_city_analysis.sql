-- 08_store_city_analysis.sql

USE dominos_sales_db;

-- Store performance
SELECT
    store_id,
    city,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS pizzas_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes,
    ROUND(
        SUM(quantity * unit_price - discount_amount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM dominos_sales
GROUP BY store_id, city
ORDER BY net_revenue DESC;


-- City performance
SELECT
    city,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS pizzas_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes
FROM dominos_sales
GROUP BY city
ORDER BY net_revenue DESC;


-- Slowest cities
SELECT
    city,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes,
    COUNT(DISTINCT order_id) AS orders
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL
GROUP BY city
ORDER BY avg_delivery_minutes DESC;


-- Highest AOV stores
SELECT
    store_id,
    city,
    ROUND(
        SUM(quantity * unit_price - discount_amount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM dominos_sales
GROUP BY store_id, city
ORDER BY average_order_value DESC;
