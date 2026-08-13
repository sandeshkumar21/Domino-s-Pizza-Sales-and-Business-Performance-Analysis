-- 07_customer_analysis.sql

USE dominos_sales_db;

-- Customer performance
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS pizzas_bought,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue,
    ROUND(
        SUM(quantity * unit_price - discount_amount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM dominos_sales
GROUP BY customer_id
ORDER BY net_revenue DESC;


-- Top 10 customers by revenue
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;


-- Top 10 customers by order frequency
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS orders
FROM dominos_sales
GROUP BY customer_id
ORDER BY orders DESC
LIMIT 10;


-- Revenue share of top 10 customers
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY customer_id
),
ranked AS (
    SELECT
        customer_id,
        revenue,
        ROW_NUMBER() OVER (ORDER BY revenue DESC) AS rn
    FROM customer_revenue
)
SELECT
    ROUND(
        SUM(CASE WHEN rn <= 10 THEN revenue ELSE 0 END)
        / SUM(revenue) * 100,
        2
    ) AS top_10_revenue_share_pct
FROM ranked;
