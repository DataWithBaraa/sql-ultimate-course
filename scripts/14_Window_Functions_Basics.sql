/* ==============================================================================
   SQL Window Functions
---------------------------------------------------------------------------------
   SQL window functions enable advanced calculations across sets of rows
   related to the current row without resorting to complex subqueries or joins.
   This script demonstrates the fundamentals and key clauses of window functions,
   including the OVER, PARTITION, ORDER, and FRAME clauses, as well as common rules
   and a GROUP BY use case.

   Table of Contents:
     1. BASICS
     2. OVER CLAUSE
     3. PARTITION CLAUSE
     4. ORDER CLAUSE
     5. FRAME CLAUSE
     6. RULES
     7. WINDOW FUNCTIONS WITH GROUP BY
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. BASICS
============================================================================== */

/* TASK 1:
   Calculate the Total Sales Across All Orders
*/
SELECT
    SUM(Sales) AS Total_Sales
FROM Sales.Orders;

/* TASK 2:
   Calculate the Total Sales for Each Product
*/
SELECT
    ProductID,
    SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY ProductID;

/* ==============================================================================
   2. OVER CLAUSE
============================================================================== */

/* TASK 3:
   Find the total sales across all orders,
   additionally providing details such as OrderID and OrderDate
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS Total_Sales
FROM Sales.Orders;

/* ==============================================================================
   3. PARTITION CLAUSE
============================================================================== */

/* TASK 4:
   Find the total sales across all orders and for each product,
   additionally providing details such as OrderID and OrderDate
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER ()                       AS Total_Sales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS Sales_By_Product
FROM Sales.Orders;

/* TASK 5:
   Find the total sales across all orders, for each product,
   and for each combination of product and order status,
   additionally providing details such as OrderID and OrderDate
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER ()                                    AS Total_Sales,
    SUM(Sales) OVER (PARTITION BY ProductID)              AS Sales_By_Product,
    SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus) AS Sales_By_Product_Status
FROM Sales.Orders;

/* ==============================================================================
   4. ORDER CLAUSE
============================================================================== */

/* TASK 6:
   Rank each order by Sales from highest to lowest */
SELECT
    OrderID,
    OrderDate,
    Sales,
    RANK() OVER (ORDER BY Sales DESC) AS Rank_Sales
FROM Sales.Orders;

/* ==============================================================================
   5. FRAME CLAUSE
============================================================================== */

/* TASK 7:
   Calculate Total Sales by Order Status for current and next two orders
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS Total_Sales
FROM Sales.Orders;

/* TASK 8:
   Calculate Total Sales by Order Status for current and previous two orders
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Total_Sales
FROM Sales.Orders;

/* TASK 9:
   Calculate Total Sales by Order Status from previous two orders only
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS 2 PRECEDING
    ) AS Total_Sales
FROM Sales.Orders;

/* TASK 10:
   Calculate cumulative Total Sales by Order Status up to the current order
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Total_Sales
FROM Sales.Orders;

/* TASK 11:
   Calculate cumulative Total Sales by Order Status from the start to the current row
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS UNBOUNDED PRECEDING
    ) AS Total_Sales
FROM Sales.Orders;

/* ==============================================================================
   6. RULES
============================================================================== */

/* RULE 1:
   Window functions can only be used in SELECT or ORDER BY clauses
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (PARTITION BY OrderStatus) AS Total_Sales
FROM Sales.Orders
WHERE SUM(Sales) OVER (PARTITION BY OrderStatus) > 100;  -- Invalid: window function in WHERE

/* RULE 2:
   Window functions cannot be nested
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    -- Invalid nesting
    SUM(SUM(Sales) OVER (PARTITION BY OrderStatus)) OVER (PARTITION BY OrderStatus) AS Total_Sales
FROM Sales.Orders;

/* ==============================================================================
   7. WINDOW FUNCTIONS WITH GROUP BY
============================================================================== */

/* TASK 12:
   Rank customers by their total sales
*/
SELECT
    CustomerID,
    SUM(Sales)                             AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Rank_Customers
FROM Sales.Orders
GROUP BY CustomerID;