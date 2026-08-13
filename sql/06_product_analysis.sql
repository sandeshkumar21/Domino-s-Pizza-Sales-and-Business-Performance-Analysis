-- 06_product_analysis.sql

USE dominos_sales_db;

-- Pizza performance
SELECT
    pizza_name,
    category,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue,
    ROUND(AVG(unit_price), 2) AS average_price,
    ROUND(SUM(discount_amount), 2) AS total_discount
FROM dominos_sales
GROUP BY pizza_name, category
ORDER BY net_revenue DESC;


-- Top 10 pizzas by quantity
SELECT
    pizza_name,
    SUM(quantity) AS units_sold
FROM dominos_sales
GROUP BY pizza_name
ORDER BY units_sold DESC
LIMIT 10;


-- Top 10 pizzas by revenue
SELECT
    pizza_name,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY pizza_name
ORDER BY net_revenue DESC
LIMIT 10;


-- Category performance
SELECT
    category,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY category
ORDER BY net_revenue DESC;


-- Size performance
SELECT
    size,
    SUM(quantity) AS units_sold,
    ROUND(
        SUM(quantity * unit_price - discount_amount),
        2
    ) AS net_revenue
FROM dominos_sales
GROUP BY size
ORDER BY net_revenue DESC;


-- Top 3 pizzas in each category
WITH pizza_sales AS (
    SELECT
        category,
        pizza_name,
        SUM(quantity * unit_price - discount_amount) AS revenue
    FROM dominos_sales
    GROUP BY category, pizza_name
),
ranked AS (
    SELECT
        category,
        pizza_name,
        revenue,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM pizza_sales
)
SELECT
    category,
    pizza_name,
    ROUND(revenue, 2) AS revenue,
    category_rank
FROM ranked
WHERE category_rank <= 3
ORDER BY category, category_rank;
