/* ==============================================================================
   SQL SET Operations
---------------------------------------------------------------------------------
   SQL set operations enable you to combine results from multiple queries
   into a single result set. This script demonstrates the rules and usage of
   set operations, including UNION, UNION ALL, EXCEPT, and INTERSECT.

   Table of Contents:
     1. RULES OF SET OPERATIONS
     2. SET OPERATORS | UNION, UNION ALL, EXCEPT, INTERSECT
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. RULES OF SET OPERATIONS
============================================================================== */

/* RULE: Number of Columns
   The number of columns in each query must be the same.
*/
SELECT
    FirstName,
    LastName,
    Country
FROM Sales.Customers
UNION
SELECT
    FirstName,
    LastName
FROM Sales.Employees;

/* RULE: Data Types (Example)
   The data types of columns in each query should match.
*/
SELECT
    CustomerID,
    LastName
FROM Sales.Customers
UNION
SELECT
    FirstName,
    LastName
FROM Sales.Employees;

/* RULE: Column Order
   The order of the columns in each query must be the same.
*/
SELECT
    LastName,
    CustomerID
FROM Sales.Customers
UNION
SELECT
    EmployeeID,
    LastName
FROM Sales.Employees;

/* RULE: Column Aliases
   The column names in the result set are determined by the column names
   specified in the first SELECT statement.
*/
SELECT
    CustomerID AS ID,
    LastName   AS Last_Name
FROM Sales.Customers
UNION
SELECT
    EmployeeID,
    LastName
FROM Sales.Employees;

/* RULE: Correct Columns
   Ensure that the correct columns are used to maintain data consistency.
*/
SELECT
    FirstName,
    LastName
FROM Sales.Customers
UNION
SELECT
    LastName,
    FirstName
FROM Sales.Employees;

/* ==============================================================================
   2. SET OPERATORS | UNION, UNION ALL, EXCEPT, INTERSECT
============================================================================== */

/* TASK 1:
   Combine the data from Employees and Customers into one table using UNION
*/
SELECT
    FirstName,
    LastName
FROM Sales.Customers
UNION
SELECT
    FirstName,
    LastName
FROM Sales.Employees;

/* TASK 2:
   Combine the data from Employees and Customers into one table,
   including duplicates, using UNION ALL
*/
SELECT
    FirstName,
    LastName
FROM Sales.Customers
UNION ALL
SELECT
    FirstName,
    LastName
FROM Sales.Employees;

/* TASK 3:
   Find employees who are NOT customers using EXCEPT
*/
SELECT
    FirstName,
    LastName
FROM Sales.Employees
EXCEPT
SELECT
    FirstName,
    LastName
FROM Sales.Customers;

/* TASK 4:
   Find employees who are also customers using INTERSECT
*/
SELECT
    FirstName,
    LastName
FROM Sales.Employees
INTERSECT
SELECT
    FirstName,
    LastName
FROM Sales.Customers;

/* TASK 5:
   Combine order data from Orders and OrdersArchive into one report without duplicates
*/
SELECT
    'Orders' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM Sales.Orders
UNION
SELECT
    'OrdersArchive' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM Sales.OrdersArchive
ORDER BY OrderID;