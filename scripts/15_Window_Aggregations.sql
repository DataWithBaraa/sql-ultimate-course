/* ==============================================================================
   SQL Window Aggregate Functions
---------------------------------------------------------------------------------
   These functions allow you to perform aggregate calculations over a set
   of rows without the need for complex subqueries. They enable you to compute
   counts, sums, averages, minimums, and maximums while still retaining access
   to individual row details.

   Table of Contents:
     1. COUNT
     2. SUM
     3. AVG
     4. MAX / MIN
     5. USE CASE | ROLLING SUM & AVERAGE
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. COUNT
============================================================================== */

/* TASK 1:
   Find the Total Number of Orders and the Total Number of Orders for Each Customer
*/
SELECT
    OrderID,
    OrderDate,
    CustomerID,
    COUNT(*) OVER()                        AS TotalOrders,
    COUNT(*) OVER(PARTITION BY CustomerID) AS OrdersByCustomers
FROM Sales.Orders

/* TASK 2:
   - Find the Total Number of Customers
   - Find the Total Number of Scores for Customers
   - Find the Total Number of Countries
*/
SELECT
    *,
    COUNT(*) OVER ()      AS TotalCustomersStar,
    COUNT(1) OVER ()      AS TotalCustomersOne,
    COUNT(Score) OVER()   AS TotalScores,
    COUNT(Country) OVER() AS TotalCountries
FROM Sales.Customers

/* TASK 3:
   Check whether the table 'OrdersArchive' contains any duplicate rows
*/
SELECT
    *
FROM (
    SELECT
        *,
        COUNT(*) OVER(PARTITION BY OrderID) AS CheckDuplicates
    FROM Sales.OrdersArchive
) t
WHERE CheckDuplicates > 1

/* ==============================================================================
   2. SUM
============================================================================== */

/* TASK 4:
   - Find the Total Sales Across All Orders
   - Find the Total Sales for Each Product
*/
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER ()                       AS TotalSales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProduct
FROM Sales.Orders

/* TASK 5:
   Find the Percentage Contribution of Each Product's Sales to the Total Sales
*/
SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER ()                                        AS TotalSales,
    ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Sales.Orders

/* The query above shows each ORDER's share of the total sales.
   For each PRODUCT's share, sum the sales per product first: */
SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS ProductSales,
    SUM(Sales) OVER ()                       AS TotalSales,
    ROUND(CAST(SUM(Sales) OVER (PARTITION BY ProductID) AS FLOAT)
          / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Sales.Orders

/* ==============================================================================
   3. AVG
============================================================================== */

/* TASK 6:
   - Find the Average Sales Across All Orders
   - Find the Average Sales for Each Product
*/
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) OVER ()                       AS AvgSales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgSalesByProduct
FROM Sales.Orders

/* TASK 7:
   Find the Average Scores of Customers
*/
SELECT
    CustomerID,
    LastName,
    Score,
    COALESCE(Score, 0)              AS CustomerScore,
    AVG(Score) OVER ()              AS AvgScore,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
FROM Sales.Customers

/* TASK 8:
   Find all orders where Sales exceed the average Sales across all orders
*/
SELECT
    *
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER () AS Avg_Sales
    FROM Sales.Orders
) t
WHERE Sales > Avg_Sales

/* ==============================================================================
   4. MAX / MIN
============================================================================== */

/* TASK 9:
   Find the Highest and Lowest Sales across all orders
*/
SELECT
    MIN(Sales) AS MinSales,
    MAX(Sales) AS MaxSales
FROM Sales.Orders

/* TASK 10:
   Find the Lowest Sales across all orders and by Product
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    MIN(Sales) OVER ()                       AS LowestSales,
    MIN(Sales) OVER (PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders

/* TASK 11:
   Show the employees who have the highest salaries
*/
SELECT *
FROM (
    SELECT *,
           MAX(Salary) OVER() AS HighestSalary
    FROM Sales.Employees
) t
WHERE Salary = HighestSalary

/* TASK 12:
   Find the deviation of each Sale from the minimum and maximum Sales
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    MAX(Sales) OVER ()         AS HighestSales,
    MIN(Sales) OVER ()         AS LowestSales,
    Sales - MIN(Sales) OVER () AS DeviationFromMin,
    MAX(Sales) OVER () - Sales AS DeviationFromMax
FROM Sales.Orders

/* ==============================================================================
   5. USE CASE | ROLLING SUM & AVERAGE
============================================================================== */

/* TASK 13:
   Calculate the moving average of Sales for each Product over time
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID)                    AS AvgByProduct,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS MovingAvg
FROM Sales.Orders

/* TASK 14:
   Calculate the moving average of Sales for each Product over time,
   including only the next order
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate
                     ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders