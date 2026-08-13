# 🍕 Domino's Pizza Sales Analysis — MySQL

A beginner-friendly but resume-ready SQL data analysis project built for **MySQL / MySQL Workbench**.

## Dataset

Place the CSV file here:

```text
data/dominos_sales.csv
```

Expected columns:

```text
order_id
order_date
order_time
customer_id
store_id
city
order_type
payment_method
pizza_id
pizza_name
category
size
quantity
unit_price
discount_amount
delivery_minutes
```

Each row represents a pizza line item. One `order_id` can therefore appear more than once.

### Revenue Logic

```text
Gross Revenue = quantity × unit_price
Net Revenue   = quantity × unit_price − discount_amount
```

## How to use this project

### Recommended beginner method

1. Open MySQL Workbench.
2. Create/select your database.
3. Open `01_create_table.sql` and run it.
4. Import `dominos_sales.csv` using **Table Data Import Wizard**.
5. Open and run files `02` through `12` one at a time.

### Importing the CSV in MySQL Workbench

Right-click your database/schema → **Table Data Import Wizard** → select:

```text
data/dominos_sales.csv
```

Choose the `dominos_sales` table and import the data.

Then verify:

```sql
SELECT * FROM dominos_sales LIMIT 10;
SELECT COUNT(*) FROM dominos_sales;
```

## Project Questions

### Sales KPIs
- Total orders
- Total pizzas sold
- Gross revenue
- Total discounts
- Net revenue
- Average Order Value
- Average pizzas per order
- Average delivery time

### Sales Trends
- Monthly sales
- Day-of-week performance
- Peak ordering hours
- Month-over-month revenue growth

### Product Analysis
- Best-selling pizzas
- Highest-revenue pizzas
- Category performance
- Size performance
- Top 3 pizzas in each category
- Pizza revenue contribution

### Customer Analysis
- Top customers by revenue
- Top customers by order frequency
- Customer AOV
- Revenue concentration of top customers

### Store & City Analysis
- Best stores
- Best cities
- Store AOV
- Delivery performance by city/store

### Discount & Delivery
- Discounts by pizza
- Discounts by city
- Discounts by order type
- Delivery-time buckets
- Fastest and slowest stores

### Advanced SQL
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- PARTITION BY
- Running totals
- Revenue share
- Top pizza in each city

## SQL Skills Demonstrated

`SELECT` · `WHERE` · `GROUP BY` · `HAVING` · `ORDER BY` · `CASE` · `CTE` · `Subqueries` · `Window Functions`

## Resume Description

**Domino's Pizza Sales Analysis | MySQL**

- Analyzed pizza sales data using MySQL to evaluate revenue, order volume, product performance, customer behavior, store performance, discounts, and delivery operations.
- Used SQL aggregations, CTEs, subqueries, CASE statements, and window functions including RANK(), DENSE_RANK(), ROW_NUMBER(), and LAG() to perform Top-N, trend, revenue contribution, and customer analysis.
- Derived business insights across products, cities, stores, order types, payment methods, discounts, and delivery performance.

**Tools:** MySQL | MySQL Workbench | SQL | Data Analysis
