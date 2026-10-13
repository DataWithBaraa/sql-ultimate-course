/*
=============================================================
Database Creation and Table Setup Script
=============================================================
RUN IN: SQL Server Management Studio (SSMS), connected to SQL Server.

Script Purpose:
    This script creates a new SQL Server database named 'SalesDB'. 
    If the database already exists, it is dropped to ensure a clean setup. 
    The script then creates the 'Sales' schema with five tables: 'Customers', 'Employees', 
    'Products', 'Orders' and 'OrdersArchive', and populates them with sample data.
    
WARNING:
    Running this script will drop the entire 'SalesDB' database if it exists, 
    permanently deleting all data within it. Proceed with caution and ensure you 
    have proper backups before executing this script.
*/

USE master;
GO

-- Drop and recreate the 'SalesDB' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SalesDB')
BEGIN
    ALTER DATABASE SalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesDB;
END;
GO

-- Create the 'SalesDB' database
CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

-- Check if the schema 'Sales' exists
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'Sales')
BEGIN
    -- If it does exist, drop the 'Sales' schema
    DROP SCHEMA Sales;
END;
GO

-- Create the 'Sales' Schema using dynamic SQL
EXEC sys.sp_executesql N'CREATE SCHEMA Sales;';
GO

-- ======================================================
-- Table: customers
-- ======================================================

CREATE TABLE Sales.Customers (
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT,
    CONSTRAINT PK_customers PRIMARY KEY (CustomerID)
);
GO

-- Insert data into Customer table
INSERT INTO Sales.Customers 
VALUES
    (1, 'Jossef', 'Goldberg', 'Germany', 350),
    (2, 'Kevin', 'Brown', 'USA', 900),
    (3, 'Mary', NULL, 'USA', 750),
    (4, 'Mark', 'Schwarz', 'Germany', 500),
    (5, 'Anna', 'Adams', 'USA', NULL);
GO

-- ======================================================
-- Table: Employee
-- ======================================================

-- Create Employee table
CREATE TABLE Sales.Employees (
    EmployeeID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1),
    Salary INT,
	ManagerID INT,
	CONSTRAINT PK_employees PRIMARY KEY (EmployeeID)
);
GO

-- Insert data into Employee table
INSERT INTO Sales.Employees
VALUES
    (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, null),
    (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
    (3, 'Mary', null, 'Sales', '1986-01-05', 'F', 75000, 1),
    (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
    (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);
GO

-- ======================================================
-- Table: Products
-- ======================================================

-- Create Products table
CREATE TABLE Sales.Products (
    ProductID INT NOT NULL,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Price INT,
	CONSTRAINT PK_products PRIMARY KEY (ProductID)
);
GO

-- Insert data into Products table
INSERT INTO Sales.Products (ProductID, Product, Category, Price)
VALUES
    (101, 'Bottle', 'Accessories', 10),
    (102, 'Tire', 'Accessories', 15),
    (103, 'Socks', 'Clothing', 20),
    (104, 'Caps', 'Clothing', 25),
    (105, 'Gloves', 'Clothing', 30);
GO

-- ======================================================
-- Table: orders
-- ======================================================

-- Create Orders table
CREATE TABLE Sales.Orders (
    OrderID INT NOT NULL,
	ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
	ShipAddress VARCHAR(255),
	BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
	CreationTime DATETIME2,
	CONSTRAINT PK_orders PRIMARY KEY (OrderID)
);
GO

-- Insert data into Orders table
INSERT INTO Sales.Orders 
VALUES
    (1,  101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered','9833 Mt. Dias Blv.', '1226 Shoe St.',  1, 10, '2025-01-01T12:34:56'),
    (2,  102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped','250 Race Court',NULL, 1, 15, '2025-01-05T23:22:04'),
    (3,  101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered','8157 W. Book','8157 W. Book', 2, 20, '2025-01-10T18:24:08'),
    (4,  105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', '', 2, 60, '2025-01-20T05:50:33'),
    (5,  104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered',NULL, NULL, 1, 25, '2025-02-01T14:02:41'),
    (6,  104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered','1792 Belmont Rd.',NULL, 2, 50, '2025-02-06T15:34:57'),
    (7,  102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered','136 Balboa Court', '', 2, 30, '2025-02-16T06:22:01'),
    (8,  101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped','2947 Vine Lane','4311 Clay Rd', 3, 90, '2025-02-18T10:45:22'),
    (9,  101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped','3768 Door Way', '', 2, 20,'2025-03-10T12:59:04'),
    (10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped',NULL, NULL, 0, 60,'2025-03-16T23:25:15');
GO

-- ======================================================
-- Table: OrdersArchive
-- ======================================================

-- Create OrdersArchive table
CREATE TABLE Sales.OrdersArchive (
    OrderID INT,
	ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
	ShipAddress VARCHAR(255),
	BillAddress VARCHAR(255),
    Quantity INT,
    Sales INT,
	CreationTime DATETIME2
);
GO

INSERT INTO Sales.OrdersArchive 
VALUES
    (1, 101,2 , 3, '2024-04-01', '2024-04-05', 'Shipped','123 Main St', '456 Billing St', 1, 10, '2024-04-01T12:34:56'),
    (2, 102,3 , 3, '2024-04-05', '2024-04-10', 'Shipped','456 Elm St', '789 Billing St', 1, 15, '2024-04-05T23:22:04'),
    (3, 101, 1, 4, '2024-04-10', '2024-04-25', 'Shipped','789 Maple St','789 Maple St', 2, 20, '2024-04-10T18:24:08'),
    (4, 105,1 , 3, '2024-04-20', '2024-04-25', 'Shipped',   '987 Victory Lane', '', 2, 60, '2024-04-20T05:50:33'),
    (4, 105,1 , 3, '2024-04-20', '2024-04-25', 'Delivered', '987 Victory Lane', '', 2, 60, '2024-04-20T14:50:33'),
    (5, 104,2 , 5, '2024-05-01', '2024-05-05', 'Shipped','345 Oak St', '678 Pine St', 1, 25, '2024-05-01T14:02:41'),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered','543 Belmont Rd.',NULL, 2, 50, '2024-05-06T15:34:57'),
    (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered','543 Belmont Rd.','3768 Door Way', 2, 50, '2024-05-07T13:22:05'),
    (6, 101, 3, 5, '2024-05-05', '2024-05-10', 'Delivered','543 Belmont Rd.','3768 Door Way', 2, 50, '2024-05-12T20:36:55'),
	(7, 102,3 , 5, '2024-06-15', '2024-06-20', 'Shipped','111 Main St', '222 Billing St', 0, 60,'2024-06-16T23:25:15');
GO