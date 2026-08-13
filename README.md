# 🍕 Domino's Pizza Sales Analysis — MySQL

> **SQL Data Analytics Project | MySQL | MySQL Workbench | Advanced SQL**

## 📌 Project Overview

This project analyzes Domino's pizza sales data to understand **sales performance, customer behavior, product demand, store performance, discounts, ordering patterns, and delivery operations**.

The analysis was built entirely in **MySQL** using a single transactional sales table. The goal was not only to calculate basic sales numbers, but to turn raw order-level data into **business insights that could support decisions around products, customers, stores, promotions, and operations**.

The project progresses from basic SQL analysis to advanced SQL techniques such as **CTEs, subqueries, RANK(), DENSE_RANK(), ROW_NUMBER(), LAG(), PARTITION BY, and cumulative calculations**.

---

## 🎯 Business Objective

The main objective of this analysis is to answer questions such as:

- How much revenue is being generated?
- How many orders and pizzas are being sold?
- Which pizzas and categories perform best?
- Which cities and stores generate the most revenue?
- Which customers contribute the most value?
- When are customers ordering the most?
- Which ordering and payment channels are most popular?
- How heavily are discounts being used?
- Which locations have slower delivery performance?
- How is revenue changing month over month?
- Which products contribute the largest share of total revenue?

---

# 📊 Dataset

The dataset contains pizza order-level transactional information.

### Columns

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `order_date` | Date on which the order was placed |
| `order_time` | Time at which the order was placed |
| `customer_id` | Customer identifier |
| `store_id` | Store identifier |
| `city` | City where the order was placed |
| `order_type` | Delivery, Takeaway, Dine-in, etc. |
| `payment_method` | UPI, Card, Cash, Wallet, etc. |
| `pizza_id` | Pizza/product identifier |
| `pizza_name` | Name of the pizza |
| `category` | Product category |
| `size` | Pizza size |
| `quantity` | Number of pizzas purchased |
| `unit_price` | Price per pizza |
| `discount_amount` | Discount applied to the line item |
| `delivery_minutes` | Delivery time in minutes |

### Important Data Structure

One `order_id` can appear multiple times because a single customer order can contain multiple pizza items.

Therefore:

```sql
COUNT(DISTINCT order_id)
```

is used for **order-level metrics**, while:

```sql
SUM(quantity)
```

is used to calculate **total pizzas sold**.

---

# 💰 Revenue Calculation

The project uses the following revenue definitions:

### Gross Revenue

```text
Gross Revenue = quantity × unit_price
```

### Net Revenue

```text
Net Revenue = quantity × unit_price − discount_amount
```

This distinction is important because analyzing gross revenue alone would ignore the effect of discounts.

---

# 🔍 Analysis Performed

## 1. Sales Performance & KPIs

The project calculates the core business KPIs:

- Total orders
- Total pizzas sold
- Gross revenue
- Total discounts
- Net revenue
- Average Order Value (AOV)
- Average pizzas per order
- Average delivery time

### Business value

These KPIs provide a high-level view of the overall health of the business and establish the baseline for all further analysis.

---

# 2. Sales Trends

The project analyzes sales across different time dimensions.

### Monthly Analysis

Identifies:

- Highest-revenue months
- Lowest-revenue months
- Changes in order volume
- Changes in pizza volume
- Month-over-month revenue growth

### Day-of-Week Analysis

Identifies which days generate the highest number of orders and revenue.

### Hourly Analysis

Identifies peak ordering hours.

### Business Insight

Understanding **when customers order** can help a pizza business optimize:

- Staff allocation
- Ingredient preparation
- Delivery capacity
- Promotional timing
- Store operating efficiency

---

# 3. Product & Pizza Analysis

The project evaluates individual pizzas and product categories using:

- Units sold
- Net revenue
- Average price
- Discounts
- Revenue ranking

### Key Questions

- Which pizza sells the most?
- Which pizza generates the most revenue?
- Are the highest-volume products also the highest-revenue products?
- Which category performs best?
- Which pizza size is most popular?
- What are the Top 3 pizzas within each category?

### Advanced Analysis

The project uses:

```sql
DENSE_RANK() OVER (
    PARTITION BY category
    ORDER BY revenue DESC
)
```

to identify the **Top 3 pizzas within each category**.

### Business Insight

This helps distinguish between:

**High-volume products**

and

**High-value products**

A pizza can sell frequently but generate less revenue than a higher-priced product with lower volume.

This distinction is useful for menu optimization and promotional planning.

---

# 4. Customer Analysis

Customer-level analysis was performed to identify:

- Most valuable customers
- Customers with the highest order frequency
- Customers purchasing the most pizzas
- Customer Average Order Value
- Revenue contribution of the Top 10 customers

### Business Insight

Customer analysis helps identify the difference between:

**frequent customers**

and

**high-value customers**.

This can support targeted loyalty programs, personalized offers, and customer retention strategies.

---

# 5. Store & City Performance

The project compares stores and cities using:

- Number of orders
- Pizzas sold
- Net revenue
- Average Order Value
- Average delivery time

### Key Questions

- Which city generates the most revenue?
- Which store is the strongest performer?
- Which stores have the highest AOV?
- Which cities have slower delivery?
- Which store performs best within each city?

### Advanced SQL

Store ranking is performed using:

```sql
RANK() OVER (
    PARTITION BY city
    ORDER BY revenue DESC
)
```

This allows stores to be compared **within their respective cities**, rather than only ranking all stores globally.

### Business Insight

Store-level analysis can highlight locations that:

- Generate strong sales
- Have high-value orders
- Need operational improvement
- Have slower delivery performance

---

# 6. Discount Analysis

Discounts were analyzed by:

- Pizza
- City
- Order type
- Individual order

The project calculates both:

```text
Total Discount
```

and:

```text
Discount Rate %
```

### Why Discount Rate Matters

A city with the highest absolute discount amount is not necessarily the city giving the largest discounts relative to sales.

Therefore:

```text
Discount Rate =
Total Discount / Gross Revenue × 100
```

provides a more meaningful comparison.

### Business Insight

This analysis helps identify areas where promotions may be:

- Supporting sales
- Reducing revenue unnecessarily
- Being used more aggressively than elsewhere

---

# 7. Delivery Performance

Delivery operations were analyzed using:

- Average delivery time
- Median delivery time
- Fastest delivery
- Slowest delivery
- Delivery time by store
- Delivery time by order type
- Delivery-time buckets

### Delivery Buckets

```text
Under 20 minutes
20–29 minutes
30–39 minutes
40+ minutes
```

### Important Data Consideration

The dataset contains `delivery_minutes = 0` for some non-delivery orders such as Takeaway/Dine-in.

Therefore, these records should **not automatically be interpreted as zero-minute deliveries**.

For meaningful delivery analysis, the `order_type` and `delivery_minutes` fields should be considered together.

### Business Insight

Delivery analysis can identify operational bottlenecks and locations where improvements in delivery speed could improve customer experience.

---

# 🧠 Advanced SQL Techniques Used

This project intentionally demonstrates SQL skills that are commonly tested in data analyst interviews.

### Core SQL

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- DISTINCT
- Aggregate functions
- CASE statements

### Intermediate SQL

- Subqueries
- Common Table Expressions (CTEs)
- Conditional aggregation
- Date functions
- String/date/time functions

### Advanced SQL

- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- `LAG()`
- `PARTITION BY`
- `SUM() OVER()`
- Running totals
- Revenue contribution analysis
- Top-N analysis within groups

---

# 📈 Key Insights

The analysis is designed to produce the following business insights from the actual dataset.

> **Important:** The numerical values below should be filled from the result tables generated by the SQL scripts. The project does not invent business figures; all conclusions should be based on the imported dataset.

### Sales

- Total orders: **[Insert result from 04_basic_kpis.sql]**
- Total pizzas sold: **[Insert result]**
- Net revenue: **[Insert result]**
- Average Order Value: **[Insert result]**
- Average delivery time: **[Insert result]**

### Product Performance

- Best-selling pizza: **[Insert pizza]**
- Highest-revenue pizza: **[Insert pizza]**
- Best-performing category: **[Insert category]**
- Most popular size: **[Insert size]**

### Customer Performance

- Highest-revenue customer: **[Insert customer]**
- Most frequent customer: **[Insert customer]**
- Top 10 customer revenue contribution: **[Insert %]**

### Location Performance

- Highest-revenue city: **[Insert city]**
- Highest-revenue store: **[Insert store]**
- Highest-AOV store: **[Insert store]**
- Slowest city by delivery time: **[Insert city]**

### Operations & Discounts

- Most-used order type: **[Insert type]**
- Most-used payment method: **[Insert method]**
- Highest discount-rate city: **[Insert city]**
- Fastest store: **[Insert store]**

### Sales Trends

- Highest-revenue month: **[Insert month]**
- Peak ordering day: **[Insert day]**
- Peak ordering hour: **[Insert hour]**
- Strongest month-over-month growth: **[Insert month + %]**

---

# 💡 Business Recommendations

Based on the final query outputs, the analysis can be translated into recommendations such as:

### 1. Focus on high-performing products

Prioritize high-revenue and high-volume pizzas in promotions and menu visibility.

### 2. Optimize product mix

Compare volume contribution with revenue contribution to identify products that sell frequently but generate relatively lower revenue.

### 3. Target high-value customers

Use customer revenue and frequency analysis to identify customers suitable for loyalty programs and personalized promotions.

### 4. Optimize peak-hour operations

Use hourly and day-of-week trends to align staffing, preparation, inventory, and delivery capacity with demand.

### 5. Review discount effectiveness

Compare discount rates against revenue to determine whether high-discount segments are actually generating enough sales to justify the discounting.

### 6. Improve underperforming locations

Use store-level revenue, AOV, and delivery metrics to identify locations requiring operational or sales improvements.

### 7. Improve delivery operations

Investigate stores and cities with consistently high delivery times and compare them with high-performing locations to identify operational differences.

---

# 🗂️ Project Structure

```text
dominos_mysql_simple_project/
│
├── README.md
│
├── data/
│   └── dominos_sales.csv
│
└── sql/
    ├── 01_create_table.sql
    ├── 02_verify_import.sql
    ├── 03_data_quality.sql
    ├── 04_basic_kpis.sql
    ├── 05_sales_trends.sql
    ├── 06_product_analysis.sql
    ├── 07_customer_analysis.sql
    ├── 08_store_city_analysis.sql
    ├── 09_discount_analysis.sql
    ├── 10_delivery_analysis.sql
    ├── 11_advanced_window_functions.sql
    └── 12_business_insights.sql
```

---

# ▶️ How to Run the Project

## Step 1 — Create the database

Run:

```text
01_create_table.sql
```

This creates:

```text
dominos_sales_db
```

and:

```text
dominos_sales
```

## Step 2 — Import the CSV

Import:

```text
dominos_sales.csv
```

into:

```text
dominos_sales_db → dominos_sales
```

The project can use `LOAD DATA LOCAL INFILE` for SQL-based CSV loading when local file loading is enabled in the MySQL client.

## Step 3 — Verify the data

Run:

```text
02_verify_import.sql
```

## Step 4 — Run the analysis

Run the SQL files in this order:

```text
03_data_quality.sql
04_basic_kpis.sql
05_sales_trends.sql
06_product_analysis.sql
07_customer_analysis.sql
08_store_city_analysis.sql
09_discount_analysis.sql
10_delivery_analysis.sql
11_advanced_window_functions.sql
12_business_insights.sql
```

---

# 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Database management and SQL analysis |
| **MySQL Workbench / SQL Client** | Query execution |
| **SQL** | Data cleaning, transformation and analysis |
| **GitHub** | Project documentation and version control |

---

# 📚 What I Learned

Through this project, I practiced:

- Working with transactional sales data
- Designing analytical SQL queries
- Calculating business KPIs
- Handling repeated order IDs
- Performing time-based analysis
- Ranking products and stores
- Using window functions
- Comparing customer segments
- Measuring revenue contribution
- Analyzing discounts and operational metrics
- Translating SQL results into business recommendations

---




# ⭐ Project Highlights

```text
✔ Real-world transactional sales analysis
✔ MySQL-based SQL project
✔ Business KPI analysis
✔ Product & customer segmentation
✔ Store & city benchmarking
✔ Discount analysis
✔ Delivery performance analysis
✔ Advanced window functions
✔ Month-over-month analysis
✔ GitHub-ready project structure
✔ Resume-ready project
```

---

## 🚀 Future Improvements

This project can be extended by connecting the SQL results to a visualization tool such as **Power BI or Tableau** to create an interactive Domino's sales dashboard.

Potential dashboard KPIs:

- Total Revenue
- Total Orders
- Pizzas Sold
- AOV
- Top Products
- Top Cities
- Monthly Revenue Trend
- Peak Ordering Hours
- Delivery Performance
- Discount Impact
