/* ==============================================================================
   SQL Window Value Functions
---------------------------------------------------------------------------------
   These functions let you reference and compare values from other rows
   in a result set without complex joins or subqueries, enabling advanced
   analysis on ordered data.

   Table of Contents:
     1. LEAD, LAG
     2. FIRST_VALUE, LAST_VALUE
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. LEAD, LAG
============================================================================== */

/* TASK 1:
   Analyze the Month-over-Month Performance by Finding the Percentage Change in Sales
   Between the Current and Previous Months
*/

SELECT
    *,
    CurrentMonthSales - PreviousMonthSales AS MoM_Change,
    ROUND(
        CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)
        / PreviousMonthSales * 100, 1
    ) AS MoM_Perc
FROM (
    SELECT
        MONTH(OrderDate)                                 AS OrderMonth,
        SUM(Sales)                                       AS CurrentMonthSales,
        LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
    FROM Sales.Orders
    GROUP BY MONTH(OrderDate)
) AS MonthlySales;

/* TASK 2:
   Customer Loyalty Analysis - Rank Customers Based on the Average Days Between Their Orders
*/
SELECT
    CustomerID,
    AVG(DaysUntilNextOrder) AS AvgDays,
    -- 999999 puts customers with only one order (their average is NULL) at the end of the ranking.
    -- The cleaner way (NULL Functions, Task 3):
    -- ORDER BY CASE WHEN AVG(DaysUntilNextOrder) IS NULL THEN 1 ELSE 0 END, AVG(DaysUntilNextOrder)
    RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) AS RankAvg
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate                                                         AS CurrentOrder,
        LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
        DATEDIFF(
            day,
            OrderDate,
            LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)
        ) AS DaysUntilNextOrder
    FROM Sales.Orders
) AS CustomerOrdersWithNext
GROUP BY CustomerID;

/* ==============================================================================
   2. FIRST_VALUE, LAST_VALUE
============================================================================== */

/* TASK 3:
   Find the Lowest and Highest Sales for Each Product,
   and determine the difference between the current Sales and the lowest Sales for each Product.
*/
SELECT
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
    LAST_VALUE(Sales) OVER (
        PARTITION BY ProductID
        ORDER BY Sales
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS HighestSales,
    Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders;