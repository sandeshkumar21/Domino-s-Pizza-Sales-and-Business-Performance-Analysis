-- 05_sales_trends.sql

USE dominos_sales_db;

-- Monthly sales
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS pizzas_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


-- Day-of-week performance
SELECT
    DAYNAME(order_date) AS day_name,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);


-- Peak ordering hours
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS revenue
FROM dominos_sales
GROUP BY HOUR(order_time)
ORDER BY orders DESC;


-- Month-over-month growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        LAG(revenue) OVER (ORDER BY month),
        2
    ) AS previous_month_revenue,
    ROUND(
        (
            revenue - LAG(revenue) OVER (ORDER BY month)
        )
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0)
        * 100,
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY month;
