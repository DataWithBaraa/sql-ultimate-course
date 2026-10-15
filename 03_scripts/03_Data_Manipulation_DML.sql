/* ==============================================================================
   SQL Data Manipulation Language (DML)
---------------------------------------------------------------------------------
   This guide covers the essential DML commands used for inserting, updating,
   and deleting data in database tables.

   Table of Contents:
     1. INSERT
     2. UPDATE
     3. DELETE
=================================================================================
*/

-- Run this line first: every query in this script uses MyDatabase
USE MyDatabase;

/* ==============================================================================
   1. INSERT
============================================================================== */
/* #1 Method: Manual INSERT using VALUES */
-- Insert new records into the customers table
INSERT INTO customers (id, first_name, country, score)
VALUES
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

-- Incorrect column order
INSERT INTO customers (id, first_name, country, score)
VALUES
    (8, 'USA', 'Max', NULL)

-- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES
    ('Max', 9, 'Max', NULL)

-- Insert a new record with full column values
-- (if you ran the incorrect column order example above, delete that row first:
--  DELETE FROM customers WHERE id = 8)
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Max', 'USA', 368)

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers
VALUES
    (9, 'Andreas', 'Germany', NULL)

-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name)
VALUES
    (10, 'Sahra')

/* #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */
-- The DDL lesson changed the table persons and dropped it: create it again as it was
DROP TABLE IF EXISTS persons;
CREATE TABLE persons (
    id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Copy data from the 'customers' table into 'persons'
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers

/* ==============================================================================
   2. UPDATE
============================================================================== */

-- Change the score of customer with ID 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE customers
SET score = 0,
    country = 'UK'
WHERE id = 10

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL

-- Verify the update
SELECT *
FROM customers
WHERE score IS NULL

/* ==============================================================================
   3. DELETE
============================================================================== */

-- Select customers with an ID greater than 5 before deleting
SELECT *
FROM customers
WHERE id > 5

-- Delete all customers with an ID greater than 5
DELETE FROM customers
WHERE id > 5

-- Delete all data from the persons table
DELETE FROM persons

-- Faster method to delete all rows, especially useful for large tables
TRUNCATE TABLE persons
