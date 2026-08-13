-- 12_business_insights.sql
-- Final queries for the GitHub project

USE dominos_sales_db;

-- Best category
SELECT
    category,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;


-- Best-selling pizza
SELECT
    pizza_name,
    SUM(quantity) AS units_sold
FROM dominos_sales
GROUP BY pizza_name
ORDER BY units_sold DESC
LIMIT 1;


-- Highest-revenue pizza
SELECT
    pizza_name,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 1;


-- Best city
SELECT
    city,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;


-- Best store
SELECT
    store_id,
    city,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY store_id, city
ORDER BY revenue DESC
LIMIT 1;


-- Fastest store
SELECT
    store_id,
    city,
    ROUND(AVG(delivery_minutes), 2) AS avg_delivery_minutes
FROM dominos_sales
WHERE delivery_minutes IS NOT NULL
GROUP BY store_id, city
ORDER BY avg_delivery_minutes
LIMIT 1;


-- Most discount-heavy city
SELECT
    city,
    ROUND(
        SUM(discount_amount)
        / NULLIF(SUM(quantity * unit_price), 0)
        * 100,
        2
    ) AS discount_rate_pct
FROM dominos_sales
GROUP BY city
ORDER BY discount_rate_pct DESC
LIMIT 1;
