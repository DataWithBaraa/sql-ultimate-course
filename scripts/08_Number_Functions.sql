/* ==============================================================================
   SQL Number Functions Guide
---------------------------------------------------------------------------------
   This document provides an overview of SQL number functions, which allow
   performing mathematical operations and formatting numerical values.

   Table of Contents:
     1. ROUND() - ROUNDING NUMBERS
     2. ABS() - ABSOLUTE VALUE
=================================================================================
*/

/* ==============================================================================
   1. ROUND() - ROUNDING NUMBERS
============================================================================== */

-- Demonstrate rounding a number to different decimal places
SELECT
    3.516           AS original_number,
    ROUND(3.516, 2) AS round_2,
    ROUND(3.516, 1) AS round_1,
    ROUND(3.516, 0) AS round_0

/* ==============================================================================
   2. ABS() - ABSOLUTE VALUE
============================================================================== */

-- Demonstrate absolute value function
SELECT
    -10      AS original_number,
    ABS(-10) AS absolute_value_negative,
    ABS(10)  AS absolute_value_positive