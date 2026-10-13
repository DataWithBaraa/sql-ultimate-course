/* ==============================================================================
   SQL Filtering Data
---------------------------------------------------------------------------------
   This document provides an overview of SQL filtering techniques using WHERE
   and various operators for precise data retrieval.

   Table of Contents:
     1. COMPARISON OPERATORS
        - =, <>, >, >=, <, <=
     2. LOGICAL OPERATORS
        - AND, OR, NOT
     3. RANGE FILTERING | BETWEEN
     4. SET FILTERING | IN
     5. PATTERN MATCHING | LIKE
=================================================================================
*/

-- Run this line first: every query in this script uses MyDatabase
USE MyDatabase;

/* ==============================================================================
   1. COMPARISON OPERATORS
============================================================================== */

-- Retrieve all customers from Germany.
SELECT *
FROM customers
WHERE country = 'Germany'

-- Retrieve all customers who are not from Germany.
SELECT *
FROM customers
WHERE country <> 'Germany'

-- Retrieve all customers with a score greater than 500.
SELECT *
FROM customers
WHERE score > 500

-- Retrieve all customers with a score of 500 or more.
SELECT *
FROM customers
WHERE score >= 500

-- Retrieve all customers with a score less than 500.
SELECT *
FROM customers
WHERE score < 500

-- Retrieve all customers with a score of 500 or less.
SELECT *
FROM customers
WHERE score <= 500

/* ==============================================================================
   2. LOGICAL OPERATORS
============================================================================== */

/* Combining conditions using AND, OR, and NOT */

-- Retrieve all customers who are from the USA and have a score greater than 500.
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500

-- Retrieve all customers who are either from the USA or have a score greater than 500.
SELECT *
FROM customers
WHERE country = 'USA' OR score > 500

-- Retrieve all customers with a score not less than 500.
SELECT *
FROM customers
WHERE NOT score < 500

/* ==============================================================================
   3. RANGE FILTERING | BETWEEN
============================================================================== */

-- Retrieve all customers whose score falls in the range between 100 and 500.
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

-- Alternative method (Equivalent to BETWEEN)
SELECT *
FROM customers
WHERE score >= 100 AND score <= 500

/* ==============================================================================
   4. SET FILTERING | IN
============================================================================== */

-- Retrieve all customers from either Germany or the USA.
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')

/* ==============================================================================
   5. PATTERN MATCHING | LIKE
============================================================================== */

-- Find all customers whose first name starts with 'M'.
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name ends with 'n'.
SELECT *
FROM customers
WHERE first_name LIKE '%n'

-- Find all customers whose first name contains 'r'.
SELECT *
FROM customers
WHERE first_name LIKE '%r%'

-- Find all customers whose first name has 'r' in the third position.
SELECT *
FROM customers
WHERE first_name LIKE '__r%'