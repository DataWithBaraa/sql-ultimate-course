/* ==============================================================================
   SQL Views
---------------------------------------------------------------------------------
   This script demonstrates various view use cases in SQL Server.
   It includes examples for creating, dropping, and modifying views, hiding
   query complexity, and implementing data security by controlling data access.

   Table of Contents:
     1. CREATE, DROP, MODIFY VIEW
     2. USE CASE | HIDE COMPLEXITY
     3. USE CASE | DATA SECURITY
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;
GO

/* ==============================================================================
   1. CREATE, DROP, MODIFY VIEW
============================================================================== */

/* TASK 1:
   Create a view that summarizes monthly sales by aggregating:
     - OrderMonth (truncated to month)
     - TotalSales, TotalOrders, and TotalQuantities.
*/

-- Create View
CREATE VIEW Sales.V_Monthly_Summary AS
(
    SELECT
        DATETRUNC(month, OrderDate) AS OrderMonth,
        SUM(Sales)                  AS TotalSales,
        COUNT(OrderID)              AS TotalOrders,
        SUM(Quantity)               AS TotalQuantities
    FROM Sales.Orders
    GROUP BY DATETRUNC(month, OrderDate)
);
GO

-- Query the View
SELECT * FROM Sales.V_Monthly_Summary;

-- Drop View if it exists
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL
    DROP VIEW Sales.V_Monthly_Summary;
GO

-- Re-create the view with modified logic
CREATE VIEW Sales.V_Monthly_Summary AS
SELECT
    DATETRUNC(month, OrderDate) AS OrderMonth,
    SUM(Sales)                  AS TotalSales,
    COUNT(OrderID)              AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(month, OrderDate);
GO

/* ==============================================================================
   2. USE CASE | HIDE COMPLEXITY
============================================================================== */

/* TASK 2:
   Create a view that combines details from Orders, Products, Customers, and Employees.
   This view abstracts the complexity of multiple table joins.
*/
CREATE VIEW Sales.V_Order_Details AS
(
    SELECT
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
        c.Country                                                  AS CustomerCountry,
        COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
        e.Department,
        o.Sales,
        o.Quantity
    FROM Sales.Orders AS o
    LEFT JOIN Sales.Products AS p ON p.ProductID = o.ProductID
    LEFT JOIN Sales.Customers AS c ON c.CustomerID = o.CustomerID
    LEFT JOIN Sales.Employees AS e ON e.EmployeeID = o.SalesPersonID
);
GO

/* ==============================================================================
   3. USE CASE | DATA SECURITY
============================================================================== */

/* TASK 3:
   Create a view for the EU Sales Team that combines details from all tables,
   but excludes data related to the USA.
*/
CREATE VIEW Sales.V_Order_Details_EU AS
(
    SELECT
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
        c.Country                                                  AS CustomerCountry,
        COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
        e.Department,
        o.Sales,
        o.Quantity
    FROM Sales.Orders AS o
    LEFT JOIN Sales.Products AS p ON p.ProductID = o.ProductID
    LEFT JOIN Sales.Customers AS c ON c.CustomerID = o.CustomerID
    LEFT JOIN Sales.Employees AS e ON e.EmployeeID = o.SalesPersonID
    WHERE c.Country != 'USA'
);
GO