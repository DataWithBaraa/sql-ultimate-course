/* ==============================================================================
   SQL Joins
---------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. BASIC JOINS
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. ADVANCED JOINS
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. MULTIPLE TABLE JOINS (4 TABLES)
=================================================================================
*/

-- Run this line first: the queries in this script use MyDatabase (section 3 uses SalesDB)
USE MyDatabase;

/* ==============================================================================
   1. BASIC JOINS
============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN
/* Get all customers along with their orders,
   but only for customers who have placed an order */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- LEFT JOIN
/* Get all customers along with their orders,
   including those without orders */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- RIGHT JOIN
/* Get all customers along with their orders,
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders,
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id

/* ==============================================================================
   2. ADVANCED JOINS
============================================================================== */

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN
/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders,
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL OR c.id IS NULL

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */
SELECT *
FROM customers
CROSS JOIN orders

/* ==============================================================================
   3. MULTIPLE TABLE JOINS (4 TABLES)
============================================================================== */

/* TASK: Using SalesDB, Retrieve a list of all orders, along with the related customer, product,
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB

SELECT
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName  AS CustomerLastName,
    p.Product   AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName  AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID