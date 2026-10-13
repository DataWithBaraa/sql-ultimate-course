/* ==============================================================================
   SQL Window Ranking Functions
---------------------------------------------------------------------------------
   These functions allow you to rank and order rows within a result set
   without the need for complex joins or subqueries. They enable you to assign
   unique or non-unique rankings, group rows into buckets, and analyze data
   distributions on ordered data.

   Table of Contents:
     1. ROW_NUMBER, RANK, DENSE_RANK
     2. NTILE
     3. CUME_DIST
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. ROW_NUMBER, RANK, DENSE_RANK
============================================================================== */

/* TASK 1:
   Rank Orders Based on Sales from Highest to Lowest
*/
SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER (ORDER BY Sales DESC) AS SalesRank_Row,
    RANK() OVER (ORDER BY Sales DESC)       AS SalesRank_Rank,
    DENSE_RANK() OVER (ORDER BY Sales DESC) AS SalesRank_Dense
FROM Sales.Orders;

/* TASK 2:
   Use Case | Top-N Analysis: Find the Highest Sale for Each Product
*/
SELECT *
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
    FROM Sales.Orders
) AS TopProductSales
WHERE RankByProduct = 1;

/* TASK 3:
   Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales
*/
SELECT *
FROM (
    SELECT
        CustomerID,
        SUM(Sales)                              AS TotalSales,
        ROW_NUMBER() OVER (ORDER BY SUM(Sales)) AS RankCustomers
    FROM Sales.Orders
    GROUP BY CustomerID
) AS BottomCustomerSales
WHERE RankCustomers <= 2;

/* TASK 4:
   Use Case | Assign Unique IDs to the Rows of the 'Order Archive'
*/
SELECT
    ROW_NUMBER() OVER (ORDER BY OrderID, OrderDate) AS UniqueID,
    *
FROM Sales.OrdersArchive;

/* TASK 5:
   Use Case | Identify Duplicates:
   Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates
*/
SELECT *
FROM (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn,
        *
    FROM Sales.OrdersArchive
) AS UniqueOrdersArchive
WHERE rn = 1;

/* ==============================================================================
   2. NTILE
============================================================================== */

/* TASK 6:
   Divide Orders into Groups Based on Sales
*/
SELECT
    OrderID,
    Sales,
    NTILE(1) OVER (ORDER BY Sales)                        AS OneBucket,
    NTILE(2) OVER (ORDER BY Sales)                        AS TwoBuckets,
    NTILE(3) OVER (ORDER BY Sales)                        AS ThreeBuckets,
    NTILE(4) OVER (ORDER BY Sales)                        AS FourBuckets,
    NTILE(2) OVER (PARTITION BY ProductID ORDER BY Sales) AS TwoBucketByProducts
FROM Sales.Orders;

/* TASK 7:
   Segment all Orders into 3 Categories: High, Medium, and Low Sales.
*/
SELECT
    OrderID,
    Sales,
    Buckets,
    CASE
        WHEN Buckets = 1 THEN 'High'
        WHEN Buckets = 2 THEN 'Medium'
        WHEN Buckets = 3 THEN 'Low'
    END AS SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER (ORDER BY Sales DESC) AS Buckets
    FROM Sales.Orders
) AS SalesBuckets;

/* TASK 8:
   Divide Orders into Groups for Processing
*/
SELECT
    NTILE(5) OVER (ORDER BY OrderID) AS Buckets,
    *
FROM Sales.Orders;

/* ==============================================================================
   3. CUME_DIST
============================================================================== */

/* TASK 9:
   Find Products that Fall Within the Highest 40% of the Prices
*/
SELECT
    Product,
    Price,
    DistRank,
    CONCAT(DistRank * 100, '%') AS DistRankPerc
FROM (
    SELECT
        Product,
        Price,
        CUME_DIST() OVER (ORDER BY Price DESC) AS DistRank
    FROM Sales.Products
) AS PriceDistribution
WHERE DistRank <= 0.4;