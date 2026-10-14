-- =============================================================
-- PostgreSQL Database Creation and Table Setup Script
-- =============================================================
-- RUN IN: a PostgreSQL tool (psql, pgAdmin, DBeaver, Postico).
-- Not for SQL Server Management Studio: for SQL Server use 01_datasets/00_sql-server/.
--
-- WARNING:
-- This script assumes you are connected to the 'postgres' database
-- and have the privileges to drop/create databases.
-- It drops the 'MyDatabase' database if it exists.

-- DROP AND CREATE DATABASE
DROP DATABASE IF EXISTS "MyDatabase";
CREATE DATABASE "MyDatabase";

-- Connect to the new database "MyDatabase" (manual step in most PostgreSQL tools)

-- Now switch to the "MyDatabase" database to execute the following

-- ======================================================
-- Table: customers
-- ======================================================
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    score INT,
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

-- Insert customers data
INSERT INTO customers (id, first_name, country, score) VALUES
    (1, 'Maria', 'Germany', 350),
    (2, ' John', 'USA', 900),
    (3, 'Georg', 'UK', 750),
    (4, 'Martin', 'Germany', 500),
    (5, 'Peter', 'USA', 0);

-- ======================================================
-- Table: orders
-- ======================================================
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    sales INT,
    CONSTRAINT pk_orders PRIMARY KEY (order_id)
);

-- Insert orders data
INSERT INTO orders (order_id, customer_id, order_date, sales) VALUES
    (1001, 1, '2021-01-11', 35),
    (1002, 2, '2021-04-05', 15),
    (1003, 3, '2021-06-18', 20),
    (1004, 6, '2021-08-31', 10);
