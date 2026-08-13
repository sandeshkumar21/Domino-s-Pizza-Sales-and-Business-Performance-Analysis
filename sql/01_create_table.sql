-- 01_create_table.sql
-- Run this first in MySQL Workbench.

CREATE DATABASE IF NOT EXISTS dominos_sales_db;

USE dominos_sales_db;

DROP TABLE IF EXISTS dominos_sales;

CREATE TABLE dominos_sales (
    order_id BIGINT,
    order_date DATE,
    order_time TIME,
    customer_id VARCHAR(50),
    store_id VARCHAR(50),
    city VARCHAR(100),
    order_type VARCHAR(50),
    payment_method VARCHAR(50),
    pizza_id VARCHAR(50),
    pizza_name VARCHAR(150),
    category VARCHAR(50),
    size VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    delivery_minutes INT
);
