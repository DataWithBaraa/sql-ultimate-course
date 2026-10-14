/* ==============================================================================
   SQL Aggregate Functions
---------------------------------------------------------------------------------
   This document provides an overview of SQL aggregate functions, which allow
   performing calculations on multiple rows of data to generate summary results.

   Table of Contents:
     1. BASIC AGGREGATE FUNCTIONS
        - COUNT
        - SUM
        - AVG
        - MAX
        - MIN
     2. GROUPED AGGREGATIONS | GROUP BY
=================================================================================
*/

-- Run this line first: every query in this script uses MyDatabase
USE MyDatabase;

/* ==============================================================================
   1. BASIC AGGREGATE FUNCTIONS
============================================================================== */

-- Find the total number of customers
SELECT COUNT(*) AS total_customers
FROM customers

-- Find the total sales of all orders
SELECT SUM(sales) AS total_sales
FROM orders

-- Find the average sales of all orders
SELECT AVG(sales) AS avg_sales
FROM orders

-- Find the highest score among customers
SELECT MAX(score) AS max_score
FROM customers

-- Find the lowest score among customers
SELECT MIN(score) AS min_score
FROM customers

/* ==============================================================================
   2. GROUPED AGGREGATIONS | GROUP BY
============================================================================== */

-- Find the number of orders, total sales, average sales,
-- highest sales, and lowest sales per customer
SELECT
    customer_id,
    COUNT(*)   AS total_orders,
    SUM(sales) AS total_sales,
    AVG(sales) AS avg_sales,
    MAX(sales) AS highest_sales,
    MIN(sales) AS lowest_sales
FROM orders
GROUP BY customer_id
