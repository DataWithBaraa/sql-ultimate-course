/* ==============================================================================
   SQL CASE Statement
---------------------------------------------------------------------------------
   This script demonstrates various use cases of the SQL CASE statement, including
   data categorization, mapping, quick form syntax, handling nulls, and conditional
   aggregation.

   Table of Contents:
     1. USE CASE | CATEGORIZE DATA
     2. USE CASE | MAPPING
     3. QUICK FORM SYNTAX
     4. HANDLING NULLS
     5. CONDITIONAL AGGREGATION
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. USE CASE | CATEGORIZE DATA
============================================================================== */

/* TASK 1:
   Create a report showing total sales for each category:
       - High: Sales over 50
       - Medium: Sales between 20 and 50
       - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/
SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM (
    SELECT
        OrderID,
        Sales,
        CASE
            WHEN Sales > 50 THEN 'High'
            WHEN Sales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS Category
    FROM Sales.Orders
) AS t
GROUP BY Category
ORDER BY TotalSales DESC;

/* ==============================================================================
   2. USE CASE | MAPPING
============================================================================== */

/* TASK 2:
   Retrieve customer details with abbreviated country codes
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;

/* ==============================================================================
   3. QUICK FORM SYNTAX
============================================================================== */

/* TASK 3:
   Retrieve customer details with abbreviated country codes using quick form
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr2
FROM Sales.Customers;

/* ==============================================================================
   4. HANDLING NULLS
============================================================================== */

/* TASK 4:
   Calculate the average score of customers, treating NULL as 0,
   and provide CustomerID and LastName details.
*/
SELECT
    CustomerID,
    LastName,
    Score,
    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS ScoreClean,
    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS AvgCustomerClean,
    AVG(Score) OVER () AS AvgCustomer
FROM Sales.Customers;

/* ==============================================================================
   5. CONDITIONAL AGGREGATION
============================================================================== */

/* TASK 5:
   Count how many orders each customer made with sales greater than 30
*/
SELECT
    CustomerID,
    SUM(
        CASE
            WHEN Sales > 30 THEN 1
            ELSE 0
        END
    ) AS TotalOrdersHighSales,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY CustomerID;