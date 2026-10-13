/* ==============================================================================
   SQL Temporary Tables
---------------------------------------------------------------------------------
   This script provides a generic example of data migration using a temporary
   table.

   Table of Contents:
     1. CREATE TEMPORARY TABLE (#Orders)
     2. CLEAN DATA IN TEMPORARY TABLE
     3. LOAD CLEANED DATA INTO PERMANENT TABLE (Sales.OrdersTest)
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   STEP 1: CREATE TEMPORARY TABLE (#Orders)
============================================================================== */
SELECT
    *
INTO #Orders
FROM Sales.Orders;

/* ==============================================================================
   STEP 2: CLEAN DATA IN TEMPORARY TABLE
============================================================================== */
DELETE FROM #Orders
WHERE OrderStatus = 'Delivered';

/* ==============================================================================
   STEP 3: LOAD CLEANED DATA INTO PERMANENT TABLE (Sales.OrdersTest)
============================================================================== */
SELECT
    *
INTO Sales.OrdersTest
FROM #Orders;
