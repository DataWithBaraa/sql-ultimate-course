/* ==============================================================================
   SQL String Functions
---------------------------------------------------------------------------------
   This document provides an overview of SQL string functions, which allow
   manipulation, transformation, and extraction of text data efficiently.

   Table of Contents:
     1. CONCAT() | STRING CONCATENATION
     2. LOWER() & UPPER() | CASE TRANSFORMATION
     3. TRIM() | REMOVE WHITE SPACES
     4. REPLACE() | REPLACE OR REMOVE OLD VALUE WITH NEW ONE
     5. LEN() | STRING LENGTH & TRIMMING
     6. LEFT() & RIGHT() | SUBSTRING EXTRACTION
     7. SUBSTRING() | EXTRACTING SUBSTRINGS
     8. NESTING FUNCTIONS
=================================================================================
*/

-- Run this line first: every query in this script uses MyDatabase
USE MyDatabase;

/* ==============================================================================
   1. CONCAT() | STRING CONCATENATION
============================================================================== */

-- Concatenate first name and country into one column
SELECT
    CONCAT(first_name, '-', country) AS full_info
FROM customers

/* ==============================================================================
   2. LOWER() & UPPER() | CASE TRANSFORMATION
============================================================================== */

-- Convert the first name to lowercase
SELECT
    LOWER(first_name) AS lower_case_name
FROM customers

-- Convert the first name to uppercase
SELECT
    UPPER(first_name) AS upper_case_name
FROM customers

/* ==============================================================================
   3. TRIM() | REMOVE WHITE SPACES
============================================================================== */

-- Find customers whose first name contains leading or trailing spaces
SELECT
    first_name,
    LEN(first_name) len_name,
    LEN(TRIM(first_name)) len_trim_name,
    LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name)  != LEN(TRIM(first_name))
-- WHERE first_name != TRIM(first_name)

/* ==============================================================================
   4. REPLACE() | REPLACE OR REMOVE OLD VALUE WITH NEW ONE
============================================================================== */
-- Replace dashes (-) with slashes (/) in a phone number
SELECT
'123-456-7890'                    AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone

-- Replace File Extension from txt to csv
SELECT
'report.txt'                          AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename

/* ==============================================================================
   5. LEN() | STRING LENGTH & TRIMMING
============================================================================== */

-- Calculate the length of each customer's first name
SELECT
    first_name,
    LEN(first_name) AS name_length
FROM customers

/* ==============================================================================
   6. LEFT() & RIGHT() | SUBSTRING EXTRACTION
============================================================================== */

-- Retrieve the first two characters of each first name
SELECT
    first_name,
    LEFT(TRIM(first_name), 2) AS first_2_chars
FROM customers

-- Retrieve the last two characters of each first name
SELECT
    first_name,
    RIGHT(first_name, 2) AS last_2_chars
FROM customers

/* ==============================================================================
   7. SUBSTRING() | EXTRACTING SUBSTRINGS
============================================================================== */

-- Retrieve a list of customers' first names after removing the first character
SELECT
    first_name,
    SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS trimmed_name
FROM customers

/* ==============================================================================
   8. NESTING FUNCTIONS
============================================================================== */

-- Nesting
SELECT
first_name,
UPPER(LOWER(first_name)) AS nesting
FROM customers
