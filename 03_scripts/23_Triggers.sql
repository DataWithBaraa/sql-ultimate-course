/* ==============================================================================
   SQL Triggers
---------------------------------------------------------------------------------
   This script demonstrates the creation of a logging table, a trigger, and
   an insert operation into the Sales.Employees table that fires the trigger.
   The trigger logs details of newly added employees into the Sales.EmployeeLogs table.
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;
GO

-- Step 1: Create Log Table
CREATE TABLE Sales.EmployeeLogs
(
    LogID      INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    LogMessage VARCHAR(255),
    LogDate    DATE
);
GO

-- Step 2: Create Trigger on Employees Table
CREATE TRIGGER trg_AfterInsertEmployee
ON Sales.Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
    SELECT
        EmployeeID,
        'New Employee Added = ' + CAST(EmployeeID AS VARCHAR),
        GETDATE()
    FROM INSERTED;
END;
GO

-- Step 3: Insert New Data Into Employees
INSERT INTO Sales.Employees
VALUES (6, 'Maria', 'Doe', 'HR', '1988-01-12', 'F', 80000, 3);
GO

-- Check the Logs
SELECT *
FROM Sales.EmployeeLogs;
GO