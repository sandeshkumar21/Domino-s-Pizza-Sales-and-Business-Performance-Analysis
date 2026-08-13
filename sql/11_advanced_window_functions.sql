-- 11_advanced_window_functions.sql

USE dominos_sales_db;

-- RANK, DENSE_RANK and ROW_NUMBER
WITH pizza_sales AS (
    SELECT
        pizza_name,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY pizza_name
)
SELECT
    pizza_name,
    ROUND(revenue, 2) AS revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank,

    DENSE_RANK() OVER (
        ORDER BY revenue DESC
    ) AS dense_rank,

    ROW_NUMBER() OVER (
        ORDER BY revenue DESC, pizza_name
    ) AS row_number
FROM pizza_sales
ORDER BY revenue_rank;


-- Revenue share of each pizza
WITH pizza_sales AS (
    SELECT
        pizza_name,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY pizza_name
)
SELECT
    pizza_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_share_pct
FROM pizza_sales
ORDER BY revenue DESC;


-- Cumulative revenue contribution
WITH pizza_sales AS (
    SELECT
        pizza_name,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY pizza_name
)
SELECT
    pizza_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        / SUM(revenue) OVER () * 100,
        2
    ) AS cumulative_revenue_share_pct
FROM pizza_sales
ORDER BY revenue DESC;


-- Highest-revenue pizza in each city
WITH city_pizza AS (
    SELECT
        city,
        pizza_name,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY city, pizza_name
),
ranked AS (
    SELECT
        city,
        pizza_name,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY revenue DESC
        ) AS rn
    FROM city_pizza
)
SELECT
    city,
    pizza_name,
    ROUND(revenue, 2) AS revenue
FROM ranked
WHERE rn = 1
ORDER BY city;


-- Store ranking inside each city
WITH store_sales AS (
    SELECT
        city,
        store_id,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY city, store_id
)
SELECT
    city,
    store_id,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        PARTITION BY city
        ORDER BY revenue DESC
    ) AS city_store_rank
FROM store_sales
ORDER BY city, city_store_rank;


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
