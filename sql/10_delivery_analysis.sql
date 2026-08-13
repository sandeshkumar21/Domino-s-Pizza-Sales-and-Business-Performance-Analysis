-- 10_delivery_analysis.sql

USE dominos_sales_db;

-- Overall delivery performance
SELECT
    ROUND(AVG(delivery_minutes), 2) AS average_delivery_minutes,
    MIN(delivery_minutes) AS fastest_delivery_minutes,
    MAX(delivery_minutes) AS slowest_delivery_minutes
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL;


-- Median delivery time
SELECT DISTINCT
    PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY delivery_minutes)
    OVER () AS median_delivery_minutes
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL;


-- Delivery performance by store
SELECT
    store_id,
    city,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes,
    COUNT(DISTINCT order_id) AS orders
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL
GROUP BY store_id, city
ORDER BY avg_delivery_minutes;


-- Delivery performance by order type
SELECT
    order_type,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes,
    COUNT(DISTINCT order_id) AS orders
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL
GROUP BY order_type
ORDER BY avg_delivery_minutes;


-- Delivery-time buckets
SELECT
    CASE
        WHEN delivery_minutes < 20 THEN 'Under 20 min'
        WHEN delivery_minutes < 30 THEN '20-29 min'
        WHEN delivery_minutes < 40 THEN '30-39 min'
        ELSE '40+ min'
    END AS delivery_bucket,
    COUNT(DISTINCT order_id) AS orders
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL
GROUP BY
    CASE
        WHEN delivery_minutes < 20 THEN 'Under 20 min'
        WHEN delivery_minutes < 30 THEN '20-29 min'
        WHEN delivery_minutes < 40 THEN '30-39 min'
        ELSE '40+ min'
    END
ORDER BY delivery_bucket;
