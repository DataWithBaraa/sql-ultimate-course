/* ==============================================================================
   SQL AI Prompts for SQL
---------------------------------------------------------------------------------
   This script contains a series of prompts designed to help both SQL developers
   and anyone interested in learning SQL improve their skills in writing,
   optimizing, and understanding SQL queries. The prompts cover a variety of
   topics, including solving SQL tasks, enhancing query readability, performance
   optimization, debugging, and interview/exam preparation. Each section provides
   clear instructions and sample code to facilitate self-learning and practical
   application in real-world scenarios.

   Table of Contents:
     1. Solve an SQL Task
     2. Improve the Readability
     3. Optimize the Performance Query
     4. Optimize Execution Plan
     5. Debugging
     6. Explain the Result
     7. Styling & Formatting
     8. Documentations & Comments
     9. Improve Database DDL
    10. Generate Test Dataset
    11. Create SQL Course
    12. Understand SQL Concept
    13. Comparing SQL Concepts
    14. SQL Questions with Options
    15. Prepare for a SQL Interview
    16. Prepare for a SQL Exam
=================================================================================
*/

-- Run this line first: every query in this script uses SalesDB
USE SalesDB;

/* ==============================================================================
   1. Solve an SQL Task
=================================================================================

In my SQL Server database, we have two tables:
The first table is `orders` with the following columns: order_id, sales, customer_id, product_id.
The second table is `customers` with the following columns:
customer_id, first_name, last_name, country.
Do the following:
    - Write a query to rank customers based on their sales.
    - The result should include the customer's customer_id, full name, country,
      total sales, and their rank.
    - Include comments but avoid commenting on obvious parts.
    - Write three different versions of the query to achieve this task.
    - Evaluate and explain which version is best in terms of readability and performance
*/

/* ==============================================================================
   2. Improve the Readability
=================================================================================

The following SQL Server query is long and hard to understand.
Do the following:
    - Improve its readability.
    - Remove any redundancy in the query and consolidate it.
    - Include comments but avoid commenting on obvious parts.
    - Explain each improvement to understand the reasoning behind it.
*/
-- Bad Formatted Query
WITH CTE_Total_Sales_By_Customer AS (
    SELECT
        c.CustomerID,
        c.FirstName + ' ' + c.LastName AS FullName,  SUM(o.Sales) AS TotalSales
    FROM  Sales.Customers c
    INNER JOIN
        Sales.Orders o ON c.CustomerID = o.CustomerID GROUP BY  c.CustomerID, c.FirstName, c.LastName
),CTE_Highest_Order_Product AS (
    SELECT
        o.CustomerID,
        p.Product, ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY o.Sales DESC) AS rn
    FROM Sales.Orders o
    INNER JOIN Sales.Products p ON o.ProductID = p.ProductID
),
CTE_Highest_Category AS (  SELECT
        o.CustomerID,  p.Category,
        ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY SUM(o.Sales) DESC) AS rn
    FROM Sales.Orders o
    INNER JOIN Sales.Products p ON o.ProductID = p.ProductID GROUP BY  o.CustomerID, p.Category
),
CTE_Last_Order_Date AS (
    SELECT
        CustomerID,
        MAX(OrderDate) AS LastOrderDate
    FROM  Sales.Orders
    GROUP BY CustomerID
),
CTE_Total_Discounts_By_Customer AS (
    SELECT o.CustomerID,  SUM(o.Quantity * p.Price * 0.1) AS TotalDiscounts
    FROM  Sales.Orders o INNER JOIN Sales.Products p ON o.ProductID = p.ProductID
    GROUP BY o.CustomerID
)
SELECT
    ts.CustomerID, ts.FullName,
    ts.TotalSales,hop.Product AS HighestOrderProduct,hc.Category AS HighestCategory,
    lod.LastOrderDate,
    td.TotalDiscounts
FROM CTE_Total_Sales_By_Customer ts
LEFT JOIN (SELECT CustomerID, Product FROM CTE_Highest_Order_Product WHERE rn = 1) hop ON ts.CustomerID = hop.CustomerID
LEFT JOIN (SELECT CustomerID, Category FROM CTE_Highest_Category WHERE rn = 1) hc ON ts.CustomerID = hc.CustomerID
LEFT JOIN CTE_Last_Order_Date lod ON ts.CustomerID = lod.CustomerID
LEFT JOIN  CTE_Total_Discounts_By_Customer td ON ts.CustomerID = td.CustomerID
WHERE  ts.TotalSales > 0
ORDER BY  ts.TotalSales DESC

/* ==============================================================================
   3. Optimize the Performance Query
=================================================================================

The following SQL Server query is slow.
Do the following:
    - Propose optimizations to improve its performance.
    - Provide the improved SQL query.
    - Explain each improvement to understand the reasoning behind it.
*/
-- Query with Bad Performance
SELECT
    o.OrderID,
    o.CustomerID,
    c.FirstName AS CustomerFirstName,
    (SELECT COUNT(o2.OrderID)
     FROM Sales.Orders o2
     WHERE o2.CustomerID = c.CustomerID) AS OrderCount
FROM
    Sales.Orders o
LEFT JOIN
    Sales.Customers c ON o.CustomerID = c.CustomerID
WHERE
    LOWER(o.OrderStatus) = 'delivered'
    OR YEAR(o.OrderDate) = 2025
    OR o.CustomerID =1 OR o.CustomerID =2 OR o.CustomerID =3
    OR o.CustomerID IN (
        SELECT CustomerID
        FROM Sales.Customers
        WHERE Country LIKE '%USA%'
    )

/* ==============================================================================
   4. Optimize Execution Plan
=================================================================================

The image is the execution plan of SQL Server query.
Do the following:
    - Describe the execution plan step by step.
    - Identify performance bottlenecks and issues.
    - Suggest ways to improve performance and optimize the execution plan.
*/

/* ==============================================================================
   5. Debugging
=================================================================================

The following SQL Server Query causing this error: "Msg 8120, Level 16, State 1, Line 5"
Do the following:
    - Explain the error message.
    - Find the root cause of the issue.
    - Suggest how to fix it.
*/

SELECT
    C.CustomerID,
    C.Country,
    SUM(O.Sales)                                               AS TotalSales,
    RANK() OVER (PARTITION BY C.Country ORDER BY O.Sales DESC) AS RankInCountry
FROM Sales.Customers C
LEFT JOIN Sales.Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Country;

/* ==============================================================================
   6. Explain the Result
=================================================================================

I didn't understand the result of the following SQL Server query.
Do the following:
    - Break down how SQL processes the query step by step.
    - Explaining each stage and how the result is formed.
*/
WITH Series AS (
    -- Anchor Query
    SELECT
    1 AS MyNumber
    UNION ALL
    -- Recursive Query
    SELECT
    MyNumber + 1
    FROM Series
    WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM Series;

/* ==============================================================================
   7. Styling & Formatting
=================================================================================

The following SQL Server query hard to understand.
Do the following:
    Restyle the code to make it easier to read.
    Align column aliases.
    Keep it compact - do not introduce unnecessary new lines.
    Ensure the formatting follows best practices.
*/
-- Bad Styled Query
with CTE_Total_Sales as
(Select
CustomerID, sum(Sales) as TotalSales
from Sales.Orders
group by CustomerID),
cte_customer_segments as
(SELECT CustomerID,
case when TotalSales > 100 then 'High Value'
when TotalSales between 50 and 100 then 'Medium Value'
else 'Low Value' end as CustomerSegment
from CTE_Total_Sales)
select c.CustomerID, c.FirstName, c.LastName,
cts.TotalSales, ccs.CustomerSegment
FROM sales.customers c
left join CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
left JOIN cte_customer_segments ccs ON ccs.CustomerID = c.CustomerID;

/* ==============================================================================
   8. Documentations & Comments
=================================================================================

The following SQL Server query lacks comments and documentation.
Do the following:
    Insert a leading comment at the start of the query describing its overall purpose.
    Add comments only where clarification is necessary, avoiding obvious statements.
    Create a separate document explaining the business rules implemented by the query.
    Create another separate document describing how the query works.
*/

WITH CTE_Total_Sales AS
(
SELECT
    CustomerID,
    SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
),
CTE_Customer_Segments AS (
SELECT
    CustomerID,
    CASE
        WHEN TotalSales > 100 THEN 'High Value'
        WHEN TotalSales BETWEEN 50 AND 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END CustomerSegment
FROM CTE_Total_Sales
)

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
ccs.CustomerSegment
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
ON ccs.CustomerID = c.CustomerID

/* ==============================================================================
   9. Improve Database DDL
=================================================================================
The following SQL Server DDL Script has to be optimized.
Do the following:
    - Naming: Check the consistency of table/column names, prefixes, standards.
    - Data Types: Ensure data types are appropriate and optimized.
    - Integrity: Verify the integrity of primary keys and foreign keys.
    - Indexes: Check that indexes are sufficient and avoid redundancy.
    - Normalization: Ensure proper normalization and avoid redundancy.

=================================================================================
   10. Generate Test Dataset
=================================================================================

I need dataset for testing the following SQL Server DDL
Do the following:
    - Generate test dataset as Insert statements.
    - Dataset should be realistic.
    - Keep the dataset small.
    - Ensure all primary/foreign key relationships are valid (use matching IDs).
    - Don't introduce any Null values.

=================================================================================
   11. Create SQL Course
=================================================================================

Create a comprehensive SQL course with a detailed roadmap and agenda.
Do the following:
    - Start with SQL fundamentals and advance to complex topics.
    - Make it beginner-friendly.
    - Include topics relevant to data analytics.
    - Focus on real-world data analytics use cases and scenarios.

=================================================================================
   12. Understand SQL Concept
=================================================================================

I want detailed explanation about SQL Window Functions.
Do the following:
    - Explain what Window Functions are.
    - Give an analogy.
    - Describe why we need them and when to use them.
    - Explain the syntax.
    - Provide simple examples.
    - List the top 3 use cases.

=================================================================================
   13. Comparing SQL Concepts
=================================================================================

I want to understand the differences between SQL Windows and GROUP BY.
Do the following:
    - Explain the key differences between the two concepts.
    - Describe when to use each concept, with examples.
    - Provide the pros and cons of each concept.
    - Summarize the comparison in a clear side-by-side table.

=================================================================================
   14. SQL Questions with Options
=================================================================================

Act as an SQL trainer and help me practice SQL Window Functions.
Do the following:
    - Make it interactive Practicing, you provide task and give solution.
    - Provide a sample dataset.
    - Give SQL tasks that gradually increase in difficulty.
    - Act as an SQL Server and show the results of my queries.
    - Review my queries, provide feedback, and suggest improvements.

=================================================================================
   15. Prepare for a SQL Interview
=================================================================================

Act as Interviewer and prepare me for a SQL interview.
Do the following:
    - Ask common SQL interview questions.
    - Make it interactive Practicing, you provide question and give answer.
    - Gradually progress to advanced topics.
    - Evaluate my answer and give me a feedback.

=================================================================================
   16. Prepare for a SQL Exam
=================================================================================

Prepare me for a SQL exam
Do the following:
    - Ask common SQL exam questions.
    - Make it interactive Practicing, you provide question and give answer.
    - Gradually progress to advanced topics.
    - Evaluate my answer and give me a feedback.
*/