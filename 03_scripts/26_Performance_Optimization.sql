/* ==============================================================================
   30x SQL Performance Tips
---------------------------------------------------------------------------------
   This section demonstrates best practices for fetching data, filtering,
   joins, UNION, aggregations, subqueries/CTE, DDL, and indexing.
   It covers techniques such as selecting only necessary columns,
   proper filtering methods, explicit joins, avoiding redundant logic,
   and efficient indexing strategies.

   Table of Contents:
     1. FETCHING DATA (Tips 1-3)
     2. FILTERING (Tips 4-7)
     3. JOINS (Tips 8-14)
     4. UNION (Tips 15-16)
     5. AGGREGATIONS (Tips 17-18)
     6. SUBQUERIES, CTE (Tips 19-20)
     7. DDL (Tips 21-25)
     8. INDEXING (Tips 26-30)
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. FETCHING DATA
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 1: Select Only What You Need
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT * FROM Sales.Customers

-- Good Practice
SELECT CustomerID, FirstName, LastName FROM Sales.Customers

/* ------------------------------------------------------------------------------
   Tip 2: Avoid unnecessary DISTINCT & ORDER BY
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT DISTINCT
    FirstName
FROM Sales.Customers
ORDER BY FirstName

-- Good Practice
SELECT
    FirstName
FROM Sales.Customers

/* ------------------------------------------------------------------------------
   Tip 3: For Exploration Purpose, Limit Rows!
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT
    OrderID,
    Sales
FROM Sales.Orders

-- Good Practice
SELECT TOP 10
    OrderID,
    Sales
FROM Sales.Orders

/* ==============================================================================
   2. FILTERING
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 4: Create nonclustered Index on frequently used Columns in WHERE clause
------------------------------------------------------------------------------ */

SELECT *
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)

/* ------------------------------------------------------------------------------
   Tip 5: Avoid applying functions to columns in WHERE clauses
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

-- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'
---------------------------------------------------------
-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

-- Good Practice
SELECT *
FROM Sales.Customers
WHERE FirstName LIKE 'A%'
---------------------------------------------------------
-- Bad Practice
SELECT *
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

/* ------------------------------------------------------------------------------
   Tip 6: Avoid leading wildcards as they prevent index usage
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

-- Good Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

/* ------------------------------------------------------------------------------
   Tip 7: Use IN instead of Multiple OR
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

-- Good Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3)

/* ==============================================================================
   3. JOINS
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 8: Understand The Speed of Joins & Use INNER JOIN when possible
------------------------------------------------------------------------------ */

-- Best Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Slightly Slower Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
SELECT c.FirstName, o.OrderID FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Worst Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c FULL OUTER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

/* ------------------------------------------------------------------------------
   Tip 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

-- Good Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

-- For simple queries: there is no measurable performance difference
-- if both ANSI and non-ANSI queries are correctly written.
-- For complex queries: ANSI joins are usually easier to optimize and debug
-- because their structure makes the intent of the query clearer.

/* ------------------------------------------------------------------------------
   Tip 10: Make sure to Index the columns used in the ON clause
------------------------------------------------------------------------------ */

SELECT c.FirstName, o.OrderID
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON c.CustomerID = o.CustomerID;

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Sales.Orders(CustomerID)

/* ------------------------------------------------------------------------------
   Tip 11: Filter Before Joining (Big Tables)
------------------------------------------------------------------------------ */

-- Best Practice For Small-Medium Tables
-- Filter After Join (WHERE)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

-- Filter During Join (ON)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
   AND o.OrderStatus = 'Delivered';

-- Best Practice For Big Tables
-- Filter Before Join (SUBQUERY)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN (
    SELECT OrderID, CustomerID
    FROM Sales.Orders
    WHERE OrderStatus = 'Delivered'
) AS o
    ON c.CustomerID = o.CustomerID;

/* ------------------------------------------------------------------------------
   Tip 12: Aggregate Before Joining (Big Tables)
------------------------------------------------------------------------------ */

-- Best Practice For Small-Medium Tables
-- Grouping and Joining
SELECT c.CustomerID, c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;

-- Best Practice For Big Tables
-- Pre-aggregated Subquery
SELECT c.CustomerID, c.FirstName, o.OrderCount
FROM Sales.Customers AS c
INNER JOIN (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Sales.Orders
    GROUP BY CustomerID
) AS o
    ON c.CustomerID = o.CustomerID;

-- Bad Practice
-- Correlated Subquery
SELECT
    c.CustomerID,
    c.FirstName,
    (SELECT COUNT(o.OrderID)
     FROM Sales.Orders AS o
     WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers AS c;

/* ------------------------------------------------------------------------------
   Tip 13: Use Union Instead of OR in Joins
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
    OR c.CustomerID = o.SalesPersonID;

-- Best Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
UNION
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.SalesPersonID;

/* ------------------------------------------------------------------------------
   Tip 14: Check for Nested Loops and Use SQL HINTS
------------------------------------------------------------------------------ */

SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID

-- Good Practice for Having Big Table & Small Table
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
OPTION (HASH JOIN);

/* ==============================================================================
   4. UNION
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 15: Use UNION ALL instead of using UNION | duplicates are acceptable
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best Practice
SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive

/* ------------------------------------------------------------------------------
   Tip 16: Use UNION ALL + Distinct instead of using UNION | duplicates are not acceptable
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best Practice
SELECT DISTINCT CustomerID
FROM (
    SELECT CustomerID FROM Sales.Orders
    UNION ALL
    SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData

/* ==============================================================================
   5. AGGREGATIONS
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 17: Use Columnstore Index for Aggregations on Large Table
------------------------------------------------------------------------------ */

SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Sales.Orders
GROUP BY CustomerID

-- Sales.Orders already has a clustered index (its primary key),
-- so create the columnstore index on a copy
SELECT * INTO Sales.DBOrders FROM Sales.Orders
CREATE CLUSTERED COLUMNSTORE INDEX Idx_Orders_Columnstore ON Sales.DBOrders

/* ------------------------------------------------------------------------------
   Tip 18: Pre-Aggregate Data and store it in new Table for Reporting
------------------------------------------------------------------------------ */

SELECT MONTH(OrderDate) OrderMonth, SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT OrderMonth, TotalSales FROM Sales.SalesSummary

/* ==============================================================================
   6. SUBQUERIES, CTE
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 19: JOIN vs EXISTS vs IN (Avoid using IN)
------------------------------------------------------------------------------ */

-- JOIN (Best Practice: If the Performance equals to EXISTS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- EXISTS (Best Practice: Use it for Large Tables)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE EXISTS (
    SELECT 1
    FROM Sales.Customers AS c
    WHERE c.CustomerID = o.CustomerID
      AND c.Country = 'USA'
);

-- IN (Bad Practice)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customers
    WHERE Country = 'USA'
);

/* ------------------------------------------------------------------------------
   Tip 20: Avoid Redundant Logic in Your Query
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT EmployeeID, FirstName, 'Above Average' AS Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT EmployeeID, FirstName, 'Below Average' AS Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees);

-- Good Practice
SELECT
    EmployeeID,
    FirstName,
    CASE
        WHEN Salary > AVG(Salary) OVER () THEN 'Above Average'
        WHEN Salary < AVG(Salary) OVER () THEN 'Below Average'
        ELSE 'Average'
    END AS Status
FROM Sales.Employees;

/* ==============================================================================
   7. DDL
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 21: Avoid VARCHAR Data Type If Possible
   Tip 22: Avoid Using MAX or Overly Large Lengths
   Tip 23: Use NOT NULL If possible
   Tip 24: Make sure all tables have a CLUSTERED PRIMARY KEY
   Tip 25: Create Nonclustered Index on Foreign Key if they are frequently used
------------------------------------------------------------------------------ */
-- Bad Practice
CREATE TABLE CustomersInfo_Bad (
    CustomerID INT,
    FirstName VARCHAR(MAX),
    LastName TEXT,
    Country VARCHAR(255),
    TotalPurchases FLOAT,
    Score VARCHAR(255),
    BirthDate VARCHAR(255),
    EmployeeID INT,
    CONSTRAINT FK_Bad_Customers_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);

-- Good Practice
CREATE TABLE CustomersInfo (
    CustomerID INT PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    TotalPurchases FLOAT,
    Score INT,
    BirthDate DATE,
    EmployeeID INT,
    CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);
CREATE NONCLUSTERED INDEX IX_CustomersInfo_EmployeeID
ON CustomersInfo(EmployeeID);

/* ==============================================================================
   8. INDEXING
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 26: Avoid Over Indexing, as it can slow down insert, update, and delete operations
   Tip 27: Regularly review and drop unused indexes to save space and improve write performance
   Tip 28: Update table statistics weekly to ensure the query optimizer
           has the most up-to-date information
   Tip 29: Reorganize and rebuild fragmented indexes weekly to maintain query performance.
   Tip 30: For large tables (e.g., fact tables), partition the data
           and then apply a columnstore index for best performance results
------------------------------------------------------------------------------ */
