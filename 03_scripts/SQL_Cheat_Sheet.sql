/* ==============================================================================
   SQL Cheat Sheet
---------------------------------------------------------------------------------
   The whole course in one file: the syntax you need most, as small queries
   you can run. Each section names the script with the full lesson.

   Every example runs on SalesDB. The examples that create or change data work
   on copies and on new objects the file deletes again, so your course tables
   stay as they are.

   Table of Contents:
      1. SELECT QUERY
      2. DATA DEFINITION (DDL)
      3. DATA MANIPULATION (DML)
      4. FILTERING DATA
      5. JOINS
      6. SET OPERATORS
      7. STRING FUNCTIONS
      8. NUMBER FUNCTIONS
      9. DATE & TIME FUNCTIONS
     10. NULL FUNCTIONS
     11. CASE STATEMENT
     12. AGGREGATE FUNCTIONS
     13. WINDOW FUNCTIONS BASICS
     14. WINDOW AGGREGATE FUNCTIONS
     15. WINDOW RANKING FUNCTIONS
     16. WINDOW VALUE FUNCTIONS
     17. SUBQUERIES
     18. COMMON TABLE EXPRESSIONS (CTE)
     19. VIEWS
     20. TEMPORARY TABLES
     21. STORED PROCEDURES
     22. TRIGGERS
     23. INDEXES
     24. PARTITIONS
     25. PERFORMANCE TIPS

   Not in this file: the AI prompts for SQL (27_AI_and_SQL.sql)
=================================================================================
*/

-- Run this line first: every query in this file uses SalesDB
USE SalesDB;
GO

/* ==============================================================================
   1. SELECT QUERY
   Full lesson: 01_Query_Data_SELECT.sql
============================================================================== */

-- All columns, or only the columns you need
SELECT * FROM Sales.Customers;
SELECT FirstName, Country, Score FROM Sales.Customers;

-- Filter the rows, then sort them (DESC = highest first, ASC = lowest first)
SELECT FirstName, Country, Score
FROM Sales.Customers
WHERE Score > 400
ORDER BY Score DESC;

-- Group the rows, then filter the groups with HAVING
SELECT
    Country,
    COUNT(*)   AS TotalCustomers,
    AVG(Score) AS AvgScore
FROM Sales.Customers
GROUP BY Country
HAVING AVG(Score) > 500;

-- Unique values only, and the first rows only
SELECT DISTINCT Country FROM Sales.Customers;
SELECT TOP 3 FirstName, Score FROM Sales.Customers ORDER BY Score DESC;

/* The order SQL executes a query:
   1. FROM  2. WHERE  3. GROUP BY  4. HAVING  5. SELECT (then DISTINCT)  6. ORDER BY (then TOP) */

/* ==============================================================================
   2. DATA DEFINITION (DDL)
   Full lesson: 02_Data_Definition_DDL.sql
============================================================================== */

-- Create a table: column name, data type, constraint
-- (# makes it a temporary table, see section 20)
CREATE TABLE #Persons (
    ID         INT         NOT NULL PRIMARY KEY,
    PersonName VARCHAR(50) NOT NULL,
    BirthDate  DATE,
    Phone      VARCHAR(15) NOT NULL
);

-- Add a column, then remove one
ALTER TABLE #Persons ADD Email VARCHAR(50) NOT NULL;
ALTER TABLE #Persons DROP COLUMN Phone;

-- Delete the table, structure and data
DROP TABLE #Persons;

/* ==============================================================================
   3. DATA MANIPULATION (DML)
   Full lesson: 03_Data_Manipulation_DML.sql
============================================================================== */

-- Work on a copy: SELECT INTO creates a new table from a query
SELECT * INTO #Customers FROM Sales.Customers;

-- Insert rows: the values follow the order of the column list
INSERT INTO #Customers (CustomerID, FirstName, LastName, Country, Score)
VALUES
    (6, 'Sara', 'Lee', 'UK', 300),
    (7, 'Tom', NULL, NULL, NULL);

-- Insert the result of a query (the employees, as IDs 101 to 105)
INSERT INTO #Customers (CustomerID, FirstName, LastName)
SELECT EmployeeID + 100, FirstName, LastName
FROM Sales.Employees;

-- Change rows (without WHERE, every row changes)
UPDATE #Customers
SET Score = 0
WHERE Score IS NULL;

-- Delete rows (without WHERE, every row goes)
DELETE FROM #Customers
WHERE CustomerID > 100;

-- Empty the whole table at once, then delete it
TRUNCATE TABLE #Customers;
DROP TABLE #Customers;

/* ==============================================================================
   4. FILTERING DATA
   Full lesson: 04_Filtering_Data.sql
============================================================================== */

-- Compare: =  <> (or !=)  >  >=  <  <=
SELECT * FROM Sales.Customers WHERE Country <> 'Germany';

-- Combine conditions: AND (both true), OR (one true), NOT (reverse)
SELECT * FROM Sales.Customers WHERE Country = 'USA' AND Score > 500;
SELECT * FROM Sales.Customers WHERE Country = 'USA' OR Score > 500;
SELECT * FROM Sales.Customers WHERE NOT Score < 500;

-- Range: BETWEEN includes both ends
SELECT * FROM Sales.Customers WHERE Score BETWEEN 100 AND 500;

-- List of values
SELECT * FROM Sales.Customers WHERE Country IN ('Germany', 'USA');

-- Patterns: % = any number of characters, _ = exactly one character
SELECT * FROM Sales.Customers WHERE FirstName LIKE 'M%';    -- starts with M
SELECT * FROM Sales.Customers WHERE FirstName LIKE '%n';    -- ends with n
SELECT * FROM Sales.Customers WHERE FirstName LIKE '%r%';   -- contains r
SELECT * FROM Sales.Customers WHERE FirstName LIKE '__r%';  -- r in third position

/* ==============================================================================
   5. JOINS
   Full lesson: 05_JOINs.sql
============================================================================== */

-- INNER JOIN: only the rows that match on both sides
SELECT c.FirstName, o.OrderID, o.Sales
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

-- LEFT JOIN: all customers, and their orders where they exist
-- (RIGHT JOIN is the same from the other side)
SELECT c.FirstName, o.OrderID, o.Sales
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

-- FULL JOIN: all rows from both sides
SELECT c.FirstName, o.OrderID, o.Sales
FROM Sales.Customers AS c
FULL JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

-- LEFT ANTI JOIN: customers without any order
SELECT c.FirstName
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

-- CROSS JOIN: every customer with every product
SELECT c.FirstName, p.Product
FROM Sales.Customers AS c
CROSS JOIN Sales.Products AS p;

-- Several tables: each order with its customer, product, and sales person
SELECT
    o.OrderID,
    c.FirstName AS CustomerName,
    p.Product,
    e.FirstName AS SalesPerson
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products  AS p ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e ON o.SalesPersonID = e.EmployeeID;

/* ==============================================================================
   6. SET OPERATORS
   Full lesson: 06_SETs.sql
============================================================================== */

-- Rules: same number of columns, matching data types, column names come from the first query

-- UNION: rows from both queries, duplicates removed
SELECT FirstName, LastName FROM Sales.Customers
UNION
SELECT FirstName, LastName FROM Sales.Employees;

-- UNION ALL: rows from both queries, duplicates kept (and faster)
SELECT 'Orders' AS SourceTable, OrderID, Sales FROM Sales.Orders
UNION ALL
SELECT 'OrdersArchive', OrderID, Sales FROM Sales.OrdersArchive;

-- EXCEPT: rows of the first query that are not in the second
SELECT FirstName, LastName FROM Sales.Customers
EXCEPT
SELECT FirstName, LastName FROM Sales.Employees;

-- INTERSECT: rows that are in both queries
SELECT FirstName, LastName FROM Sales.Customers
INTERSECT
SELECT FirstName, LastName FROM Sales.Employees;

/* ==============================================================================
   7. STRING FUNCTIONS
   Full lesson: 07_String_Functions.sql
============================================================================== */

SELECT
    FirstName,
    CONCAT(FirstName, ' ', LastName) AS FullName,   -- joins texts, NULL counts as empty
    UPPER(FirstName)                 AS UpperName,
    LOWER(FirstName)                 AS LowerName,
    LEN(FirstName)                   AS NameLength,
    LEFT(FirstName, 2)               AS First2Chars,
    RIGHT(FirstName, 2)              AS Last2Chars,
    SUBSTRING(FirstName, 2, 3)       AS Chars2To4      -- start at 2, take 3
FROM Sales.Customers;

-- Clean text
SELECT
    TRIM('   Maria   ')              AS Trimmed,    -- spaces removed at both ends
    REPLACE('123-456-7890', '-', '') AS CleanPhone; -- 1234567890

/* ==============================================================================
   8. NUMBER FUNCTIONS
   Full lesson: 08_Number_Functions.sql
============================================================================== */

SELECT
    3.516           AS Original,
    ROUND(3.516, 2) AS Round2,        -- 3.520
    ROUND(3.516, 1) AS Round1,        -- 3.500
    ROUND(3.516, 0) AS Round0,        -- 4.000
    ABS(-10)        AS AbsoluteValue; -- 10

/* ==============================================================================
   9. DATE & TIME FUNCTIONS
   Full lesson: 09_Date_Time_Functions.sql (format lists: 10a to 10d)
============================================================================== */

-- Today, and the parts of a date
SELECT
    OrderID,
    OrderDate,
    GETDATE()                    AS Today,
    YEAR(OrderDate)              AS OrderYear,
    MONTH(OrderDate)             AS OrderMonth,
    DAY(OrderDate)               AS OrderDay,
    DATEPART(quarter, OrderDate) AS OrderQuarter,
    DATENAME(month, OrderDate)   AS MonthName,
    DATETRUNC(month, OrderDate)  AS MonthStart,
    EOMONTH(OrderDate)           AS MonthEnd
FROM Sales.Orders;

-- Date math
SELECT
    OrderID,
    OrderDate,
    ShipDate,
    DATEADD(day, 30, OrderDate)        AS Plus30Days,
    DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip
FROM Sales.Orders;

-- Date to text, and text to date
SELECT
    OrderDate,
    FORMAT(OrderDate, 'dd.MM.yyyy')  AS EuropeanDate, -- 01.01.2025
    FORMAT(OrderDate, 'MMM yyyy')    AS MonthYear,    -- Jan 2025
    CONVERT(VARCHAR, OrderDate, 101) AS USDate,       -- 01/01/2025
    CAST(OrderDate AS VARCHAR(10))   AS DateAsText,
    CAST('2025-08-20' AS DATE)       AS TextAsDate
FROM Sales.Orders;

-- Check if a text is a valid date: 1 = yes, 0 = no
SELECT ISDATE('2025-08-20') AS ValidDate, ISDATE('Hello') AS NotADate;

/* ==============================================================================
   10. NULL FUNCTIONS
   Full lesson: 11_NULL_Functions.sql
============================================================================== */

-- Replace NULL: ISNULL takes 2 values, COALESCE takes the first non-NULL of a list
SELECT
    CustomerID,
    Score,
    ISNULL(Score, 0)                     AS ScoreIsNull,
    COALESCE(Score, 0)                   AS ScoreCoalesce,
    COALESCE(LastName, FirstName, 'n/a') AS NameOrFallback
FROM Sales.Customers;

-- NULL in math gives NULL; aggregate functions skip NULLs
SELECT
    10 + NULL               AS NullInMath,    -- NULL
    AVG(Score)              AS AvgSkipsNulls,
    AVG(COALESCE(Score, 0)) AS AvgNullAsZero
FROM Sales.Customers;

-- NULLIF returns NULL when both values are equal: no division by zero
SELECT OrderID, Sales, Quantity, Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders;

-- Find NULLs with IS NULL / IS NOT NULL (never with = NULL)
SELECT * FROM Sales.Customers WHERE Score IS NULL;
SELECT * FROM Sales.Customers WHERE Score IS NOT NULL;

-- Sort NULLs last
SELECT CustomerID, Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score;

/* ==============================================================================
   11. CASE STATEMENT
   Full lesson: 12_Case_Statements.sql
============================================================================== */

-- The first true condition wins, ELSE catches the rest
SELECT
    OrderID,
    Sales,
    CASE
        WHEN Sales > 50 THEN 'High'
        WHEN Sales > 20 THEN 'Medium'
        ELSE 'Low'
    END AS SalesCategory
FROM Sales.Orders;

-- Quick form: compare one column with values
SELECT
    CustomerID,
    Country,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryCode
FROM Sales.Customers;

-- Conditional aggregation: count only some rows
SELECT
    CustomerID,
    COUNT(*)                                    AS TotalOrders,
    SUM(CASE WHEN Sales > 30 THEN 1 ELSE 0 END) AS HighSalesOrders
FROM Sales.Orders
GROUP BY CustomerID;

/* ==============================================================================
   12. AGGREGATE FUNCTIONS
   Full lesson: 13_Aggregate_Functions.sql
============================================================================== */

-- One result for the whole table
SELECT
    COUNT(*)   AS TotalOrders,
    SUM(Sales) AS TotalSales,
    AVG(Sales) AS AvgSales,
    MAX(Sales) AS HighestSales,
    MIN(Sales) AS LowestSales
FROM Sales.Orders;

-- One result per group
SELECT
    CustomerID,
    COUNT(*)   AS TotalOrders,
    SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID;

-- AVG of whole numbers gives a whole number (product 104: 37, not 37.5):
-- cast first to keep the decimals
SELECT
    ProductID,
    AVG(Sales)                AS AvgWhole,
    AVG(CAST(Sales AS FLOAT)) AS AvgExact
FROM Sales.Orders
GROUP BY ProductID;

/* ==============================================================================
   13. WINDOW FUNCTIONS BASICS
   Full lesson: 14_Window_Functions_Basics.sql
============================================================================== */

-- GROUP BY returns one row per group; a window function keeps every row
SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER ()                       AS TotalSales,    -- the whole table
    SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProduct -- per product
FROM Sales.Orders;

-- ORDER BY inside OVER: a running total
SELECT
    OrderID,
    OrderDate,
    Sales,
    SUM(Sales) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Sales.Orders;

-- The frame: which rows the window sees
SELECT
    OrderID,
    OrderDate,
    Sales,
    SUM(Sales) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingSum3
FROM Sales.Orders;

/* With ORDER BY and no frame, SQL Server uses:
   RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW (rows with the same date share one total) */

/* ==============================================================================
   14. WINDOW AGGREGATE FUNCTIONS
   Full lesson: 15_Window_Aggregations.sql
============================================================================== */

SELECT
    OrderID,
    ProductID,
    Sales,
    COUNT(*)   OVER (PARTITION BY ProductID)                  AS OrdersPerProduct,
    AVG(Sales) OVER (PARTITION BY ProductID)                  AS AvgPerProduct,
    MAX(Sales) OVER ()                                        AS HighestSales,
    ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentOfTotal
FROM Sales.Orders;

-- Moving average: the current and the next order of each product
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate
                     ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders;

/* ==============================================================================
   15. WINDOW RANKING FUNCTIONS
   Full lesson: 16_Window_Ranking.sql
============================================================================== */

SELECT
    OrderID,
    Sales,
    ROW_NUMBER() OVER (ORDER BY Sales DESC) AS SalesRank_Row,   -- 1, 2, 3, 4 (no ties)
    RANK()       OVER (ORDER BY Sales DESC) AS SalesRank_Rank,  -- 1, 2, 2, 4 (gaps)
    DENSE_RANK() OVER (ORDER BY Sales DESC) AS SalesRank_Dense, -- 1, 2, 2, 3 (no gaps)
    NTILE(3)     OVER (ORDER BY Sales DESC) AS Bucket,          -- 3 groups
    CUME_DIST()  OVER (ORDER BY Sales DESC) AS CumeDist         -- share of rows up to here
FROM Sales.Orders;

-- Top N per group: the highest sale of each product
SELECT *
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProduct
    FROM Sales.Orders
) AS t
WHERE RankByProduct = 1;

/* ==============================================================================
   16. WINDOW VALUE FUNCTIONS
   Full lesson: 17_Window_Value_Functions.sql
============================================================================== */

SELECT
    OrderID,
    CustomerID,
    OrderDate,
    Sales,
    LAG(Sales)  OVER (ORDER BY OrderDate)                                AS PreviousSales,
    LEAD(Sales) OVER (ORDER BY OrderDate)                                AS NextSales,
    FIRST_VALUE(Sales) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS FirstSales,
    LAST_VALUE(Sales)  OVER (PARTITION BY CustomerID ORDER BY OrderDate
                             ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LastSales
FROM Sales.Orders;

-- LAST_VALUE needs the frame above; without it, it only looks up to the current row

/* ==============================================================================
   17. SUBQUERIES
   Full lesson: 18_Subqueries.sql
============================================================================== */

-- One value: compare every order with the average
SELECT OrderID, Sales, (SELECT AVG(Sales) FROM Sales.Orders) AS AvgSales
FROM Sales.Orders;

SELECT OrderID, Sales
FROM Sales.Orders
WHERE Sales > (SELECT AVG(Sales) FROM Sales.Orders);

-- A list of values: orders of German customers
SELECT OrderID, CustomerID, Sales
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany');

-- Correlated with EXISTS: the inner query uses the row of the outer query
SELECT c.CustomerID, c.FirstName
FROM Sales.Customers AS c
WHERE EXISTS (SELECT 1 FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID);

-- A table: aggregate first, then query the result (it needs an alias)
SELECT AVG(TotalSales) AS AvgSalesPerCustomer
FROM (
    SELECT CustomerID, SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
) AS t;

/* ==============================================================================
   18. COMMON TABLE EXPRESSIONS (CTE)
   Full lesson: 19_Common_Table_Expressions_CTE.sql
============================================================================== */

-- A named query you use like a table
WITH CTE_Total_Sales AS (
    SELECT CustomerID, SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
)
SELECT c.CustomerID, c.FirstName, cts.TotalSales
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
    ON cts.CustomerID = c.CustomerID;

-- Recursive: the numbers 1 to 10
WITH Series AS (
    SELECT 1 AS MyNumber          -- anchor: the start
    UNION ALL
    SELECT MyNumber + 1           -- repeats on its own result
    FROM Series
    WHERE MyNumber < 10           -- the stop condition
)
SELECT * FROM Series;

-- Recursive: the employee hierarchy
WITH CTE_Emp_Hierarchy AS (
    SELECT EmployeeID, FirstName, ManagerID, 1 AS Level
    FROM Sales.Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, ceh.Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy AS ceh
        ON e.ManagerID = ceh.EmployeeID
)
SELECT * FROM CTE_Emp_Hierarchy;

/* ==============================================================================
   19. VIEWS
   Full lesson: 20_Views.sql
============================================================================== */

-- A view is a saved query. CREATE VIEW needs its own batch: GO before and after
-- (ALTER VIEW changes it, DROP VIEW deletes it)
GO
CREATE VIEW Sales.V_Customer_Sales AS
SELECT c.CustomerID, c.FirstName, SUM(o.Sales) AS TotalSales
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName;
GO

SELECT * FROM Sales.V_Customer_Sales;

DROP VIEW Sales.V_Customer_Sales;

/* ==============================================================================
   20. TEMPORARY TABLES
   Full lesson: 21_Temporary_Tables.sql
============================================================================== */

-- # = temporary table: it lives in tempdb until you close the session
SELECT * INTO #Orders FROM Sales.Orders WHERE OrderStatus = 'Delivered';
SELECT * FROM #Orders;
DROP TABLE #Orders;

/* ==============================================================================
   21. STORED PROCEDURES
   Full lesson: 22_Stored_Procedures.sql
============================================================================== */

-- A saved program with a parameter (the default is used when you pass nothing)
-- (ALTER PROCEDURE changes it, DROP PROCEDURE deletes it)
GO
CREATE PROCEDURE Sales.GetCountrySummary @Country VARCHAR(50) = 'USA'
AS
BEGIN
    SELECT COUNT(*) AS TotalCustomers, AVG(Score) AS AvgScore
    FROM Sales.Customers
    WHERE Country = @Country;
END;
GO

EXEC Sales.GetCountrySummary;
EXEC Sales.GetCountrySummary @Country = 'Germany';

DROP PROCEDURE Sales.GetCountrySummary;

-- Variables, IF/ELSE and error handling also work outside procedures
DECLARE @AvgScore INT = (SELECT AVG(Score) FROM Sales.Customers);

IF @AvgScore > 500
    PRINT 'The average score is high';
ELSE
    PRINT 'The average score is normal';

BEGIN TRY
    SELECT 1 / 0 AS Result;                     -- fails: division by zero
END TRY
BEGIN CATCH
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;

/* ==============================================================================
   22. TRIGGERS
   Full lesson: 23_Triggers.sql
============================================================================== */

-- A trigger runs by itself after an INSERT, UPDATE or DELETE on its table
CREATE TABLE Sales.Members (MemberID INT, FirstName VARCHAR(50));
CREATE TABLE Sales.MembersLog (MemberID INT, LogMessage VARCHAR(100), LogDate DATE);
GO
CREATE TRIGGER trg_AfterInsertMember
ON Sales.Members
AFTER INSERT
AS
BEGIN
    INSERT INTO Sales.MembersLog (MemberID, LogMessage, LogDate)
    SELECT MemberID, 'New member: ' + FirstName, GETDATE()
    FROM INSERTED;                              -- INSERTED = the new rows
END;
GO

INSERT INTO Sales.Members VALUES (1, 'Maria');
SELECT * FROM Sales.MembersLog;

DROP TABLE Sales.Members;                       -- deletes its trigger too
DROP TABLE Sales.MembersLog;

/* ==============================================================================
   23. INDEXES
   Full lesson: 24_Indexes.sql
============================================================================== */

-- Work on a copy (SELECT INTO creates a heap: a table without a clustered index)
SELECT * INTO Sales.CustomersCopy FROM Sales.Customers;

-- Clustered: sorts the table itself, one per table
CREATE CLUSTERED INDEX idx_CustomersCopy_CustomerID ON Sales.CustomersCopy (CustomerID);

-- Nonclustered: a separate sorted lookup, many per table
CREATE NONCLUSTERED INDEX idx_CustomersCopy_LastName ON Sales.CustomersCopy (LastName);

-- Composite: the column you filter on most comes first
CREATE NONCLUSTERED INDEX idx_CustomersCopy_CountryScore ON Sales.CustomersCopy (Country, Score);

-- Unique: no duplicate values allowed
CREATE UNIQUE NONCLUSTERED INDEX idx_CustomersCopy_FirstName ON Sales.CustomersCopy (FirstName);

-- Filtered: only the rows that match the WHERE
CREATE NONCLUSTERED INDEX idx_CustomersCopy_USA ON Sales.CustomersCopy (Country)
WHERE Country = 'USA';

-- Columnstore, for big analytical tables (not run here):
-- CREATE CLUSTERED COLUMNSTORE INDEX idx_FactSales_CS ON FactSales;

-- See the indexes, delete one, delete the copy
EXEC sp_helpindex 'Sales.CustomersCopy';
DROP INDEX idx_CustomersCopy_LastName ON Sales.CustomersCopy;
DROP TABLE Sales.CustomersCopy;

/* ==============================================================================
   24. PARTITIONS
   Full lesson: 25_Partitions.sql
============================================================================== */

-- 1. Function: where to split the data (here by year)
CREATE PARTITION FUNCTION pf_OrdersByYear (DATE)
AS RANGE LEFT FOR VALUES ('2024-12-31', '2025-12-31');

-- 2. Scheme: where each partition is stored (all in PRIMARY, so no extra files needed)
CREATE PARTITION SCHEME ps_OrdersByYear
AS PARTITION pf_OrdersByYear ALL TO ([PRIMARY]);

-- 3. Table on the scheme, partitioned by OrderDate
CREATE TABLE Sales.OrdersByYear (OrderID INT, OrderDate DATE, Sales INT)
ON ps_OrdersByYear (OrderDate);

INSERT INTO Sales.OrdersByYear
SELECT OrderID, OrderDate, Sales FROM Sales.Orders;

-- Rows in each partition
SELECT partition_number, rows
FROM sys.partitions
WHERE object_id = OBJECT_ID('Sales.OrdersByYear');

-- Clean up: table, scheme, function
DROP TABLE Sales.OrdersByYear;
DROP PARTITION SCHEME ps_OrdersByYear;
DROP PARTITION FUNCTION pf_OrdersByYear;

/* ==============================================================================
   25. PERFORMANCE TIPS
   Full lesson: 26_Performance_Optimization.sql (30 tips)
============================================================================== */

/* The tips that matter most:
   - Select only the columns you need, not SELECT *
   - Filter early, and keep functions away from filtered columns (example below)
   - Avoid a leading wildcard: LIKE '%son' cannot use an index, LIKE 'son%' can
   - Use UNION ALL when duplicates are fine (UNION spends time removing them)
   - Use EXISTS or a JOIN instead of IN with a big subquery
   - Index the columns you filter and join on, but do not over-index
*/

-- Slow: a function on the column hides it from the index
SELECT OrderID, Sales FROM Sales.Orders WHERE YEAR(OrderDate) = 2025;

-- Fast: compare the column itself with a range
SELECT OrderID, Sales FROM Sales.Orders WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31';
