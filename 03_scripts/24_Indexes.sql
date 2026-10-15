/* ==============================================================================
   SQL Indexing
---------------------------------------------------------------------------------
   This script demonstrates various index types in SQL Server including clustered,
   non-clustered, columnstore, unique, and filtered indexes. It provides examples
   of creating a heap table, applying different index types, and testing their
   usage with sample queries.

   Table of Contents:
     INDEX TYPES
         1. CLUSTERED AND NON-CLUSTERED INDEXES
         2. LEFTMOST PREFIX RULE EXPLANATION
         3. COLUMNSTORE INDEXES
         4. UNIQUE INDEXES
         5. FILTERED INDEXES
     INDEX MONITORING
         6. MONITOR INDEX USAGE
         7. MONITOR MISSING INDEXES
         8. MONITOR DUPLICATE INDEXES
         9. UPDATE STATISTICS
        10. FRAGMENTATIONS
=================================================================================
*/

-- Run this line first: the queries in this script use SalesDB
-- (section 3 also uses AdventureWorksDW2022)
USE SalesDB;
GO

/* ==============================================================================
   1. CLUSTERED AND NON-CLUSTERED INDEXES
============================================================================== */

-- Create a Heap Table as a copy of Sales.Customers
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers;

-- Test Query: Select Data and Check the Execution Plan
SELECT *
FROM Sales.DBCustomers
WHERE CustomerID = 1;

-- Create a Clustered Index on Sales.DBCustomers using CustomerID
CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID);

-- Attempt to create a second Clustered Index on the same table (will fail)
CREATE CLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName);

-- Drop the Clustered Index
DROP INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers;

-- Test Query: Select Data with a Filter on LastName
SELECT *
FROM Sales.DBCustomers
WHERE LastName = 'Brown';

-- Create a Non-Clustered Index on LastName
CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName);

-- Create an additional Non-Clustered Index on FirstName
CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName);

-- Create a Composite (Composed) Index on Country and Score
CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score);

-- Query that uses the Composite Index
SELECT *
FROM Sales.DBCustomers
WHERE Country = 'USA'
  AND Score > 500;

-- Query that likely won't use the Composite Index due to column order
SELECT *
FROM Sales.DBCustomers
WHERE Score > 500
  AND Country = 'USA';

/* ==============================================================================
   2. LEFTMOST PREFIX RULE EXPLANATION
---------------------------------------------------------------------------------
   For a composite index defined on columns (A, B, C, D), the index can be
   utilized by queries that filter on:
     - Column A only,
     - Columns A and B,
     - Columns A, B, and C.
   However, queries that filter on:
     - Column B only,
     - Columns A and C,
     - Columns A, B, and D,
   will not be able to fully utilize the index due to the leftmost prefix rule.
=================================================================================
*/

/* ==============================================================================
   3. COLUMNSTORE INDEXES
============================================================================== */

-- Create a Clustered Columnstore Index on Sales.DBCustomers
CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers;
GO

-- Create a Non-Clustered Columnstore Index on the FirstName column
-- (fails if the Clustered Columnstore Index above exists: only one columnstore index per table)
CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS_FirstName
ON Sales.DBCustomers (FirstName);
GO

-- Switch context to AdventureWorksDW2022 for FactInternetSales examples
-- AdventureWorksDW2022 is a free sample database from Microsoft. Download AdventureWorksDW2022.bak
-- from https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure
-- and restore it like SalesDB.
USE AdventureWorksDW2022;

-- Create a Heap Table from FactInternetSales
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales;

-- Create a RowStore Table from FactInternetSales
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales;

-- Create a Clustered Index (RowStore) on FactInternetSales_RS
CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber);

-- Create a Columnstore Table from FactInternetSales
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales;

-- Create a Clustered Columnstore Index on FactInternetSales_CS
CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS;

/* ==============================================================================
   4. UNIQUE INDEXES
============================================================================== */

-- Switch back to SalesDB for the rest of the script
USE SalesDB;

-- Attempt to create a Unique Index on the Category column in Sales.Products.
-- Note: This may fail if duplicate values exist.

CREATE UNIQUE INDEX idx_Products_Category
ON Sales.Products (Category);

-- Create a Unique Index on the Product column in Sales.Products
CREATE UNIQUE INDEX idx_Products_Product
ON Sales.Products (Product);

-- Test Insert: Attempt to insert a duplicate value (should fail if the constraint is enforced)
INSERT INTO Sales.Products (ProductID, Product)
VALUES (106, 'Caps');

/* ==============================================================================
   5. FILTERED INDEXES
============================================================================== */

-- Test Query: Select Customers where Country is 'USA'
SELECT *
FROM Sales.Customers
WHERE Country = 'USA';

-- Create a Non-Clustered Filtered Index on the Country column for rows where Country = 'USA'
CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers (Country)
WHERE Country = 'USA';

/* ==============================================================================
   INDEX MONITORING
---------------------------------------------------------------------------------
     - List indexes and monitor their usage.
     - Report missing and duplicate indexes.
     - Retrieve and update statistics.
     - Check index fragmentation and perform index maintenance (reorganize/rebuild).
=================================================================================
*/

/* ==============================================================================
   6. MONITOR INDEX USAGE
============================================================================== */

-- List all indexes on a specific table
EXEC sp_helpindex 'Sales.DBCustomers'

-- Monitor Index Usage
SELECT
    tbl.name           AS TableName,
    idx.name           AS IndexName,
    idx.type_desc      AS IndexType,
    idx.is_primary_key AS IsPrimaryKey,
    idx.is_unique      AS IsUnique,
    idx.is_disabled    AS IsDisabled,
    s.user_seeks       AS UserSeeks,
    s.user_scans       AS UserScans,
    s.user_lookups     AS UserLookups,
    s.user_updates     AS UserUpdates,
    COALESCE(s.last_user_seek, s.last_user_scan) AS LastUpdate
FROM sys.indexes idx
JOIN sys.tables tbl
    ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats s
    ON s.object_id = idx.object_id
    AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name;

/* ==============================================================================
   7. MONITOR MISSING INDEXES
============================================================================== */

SELECT *
FROM sys.dm_db_missing_index_details;

/* ==============================================================================
   8. MONITOR DUPLICATE INDEXES
============================================================================== */

SELECT
    tbl.name      AS TableName,
    col.name      AS IndexColumn,
    idx.name      AS IndexName,
    idx.type_desc AS IndexType,
    COUNT(*) OVER (PARTITION BY  tbl.name , col.name ) ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic ON idx.object_id = ic.object_id AND idx.index_id = ic.index_id
JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY ColumnCount DESC

/* ==============================================================================
   9. UPDATE STATISTICS
============================================================================== */

SELECT
    SCHEMA_NAME(t.schema_id)                  AS SchemaName,
    t.name                                    AS TableName,
    s.name                                    AS StatisticName,
    sp.last_updated                           AS LastUpdate,
    DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
    sp.rows                                   AS 'Rows',
    sp.modification_counter                   AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables AS t
    ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY sp.modification_counter DESC;

-- Update statistics for a specific automatically created system statistic
-- Note: the name is different on your machine;
-- copy it from the StatisticName column of the query above
UPDATE STATISTICS Sales.DBCustomers _WA_Sys_00000001_6EF57B66;
GO

-- Update all statistics for the Sales.DBCustomers table
UPDATE STATISTICS Sales.DBCustomers;
GO

-- Update statistics for all tables in the database
EXEC sp_updatestats;
GO

/* ==============================================================================
   10. FRAGMENTATIONS
============================================================================== */

-- Retrieve index fragmentation statistics for the current database
SELECT
    tbl.name AS TableName,
    idx.name AS IndexName,
    s.avg_fragmentation_in_percent,
    s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl
    ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx
    ON idx.object_id = s.object_id
    AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC;

-- Reorganize the index (lightweight defragmentation)
ALTER INDEX idx_Customers_Country
ON Sales.Customers REORGANIZE;
GO

-- Rebuild the index (full rebuild, more resource-intensive)
ALTER INDEX idx_Customers_Country
ON Sales.Customers REBUILD;
GO
