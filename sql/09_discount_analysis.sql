-- 09_discount_analysis.sql

USE dominos_sales_db;

-- Discount by pizza
SELECT
    pizza_name,
    ROUND(SUM(discount_amount), 2) AS total_discount,
    ROUND(SUM(quantity * unit_price), 2) AS gross_revenue,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY pizza_name
ORDER BY total_discount DESC;


-- Discount by city
SELECT
    city,
    ROUND(SUM(discount_amount), 2) AS total_discount,
    ROUND(
        SUM(discount_amount)
        / NULLIF(SUM(quantity * unit_price), 0)
        * 100,
        2
    ) AS discount_rate_pct
FROM dominos_sales
GROUP BY city
ORDER BY discount_rate_pct DESC;


-- Discount by order type
SELECT
    order_type,
    ROUND(SUM(discount_amount), 2) AS total_discount,
    ROUND(
        SUM(discount_amount)
        / NULLIF(SUM(quantity * unit_price), 0)
        * 100,
        2
    ) AS discount_rate_pct
FROM dominos_sales
GROUP BY order_type
ORDER BY discount_rate_pct DESC;


-- Highest-discount orders
SELECT
    order_id,
    customer_id,
    city,
    ROUND(SUM(discount_amount), 2) AS order_discount
FROM dominos_sales
GROUP BY order_id, customer_id, city
ORDER BY order_discount DESC
LIMIT 20;
