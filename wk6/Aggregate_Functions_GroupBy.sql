/* ============================================================================== 
   SQL Aggregate Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL aggregate functions, which allow 
   performing calculations on multiple rows of data to generate summary results.

   Table of Contents:
     1. Basic Aggregate Functions
        - COUNT
        - SUM
        - AVG
        - MAX
        - MIN
     2. Grouped Aggregations
        - GROUP BY
=================================================================================
*/

/* ============================================================================== 
   BASIC AGGREGATE FUNCTIONS
=============================================================================== */
/*
In folder wk6, use wk6_joins_intro_jupyter.db
*/

-- Find the total number of customers
SELECT COUNT(*) AS total_customers
FROM Customers;

-- Find the total sales of all orders
SELECT SUM(sales) AS total_sales
FROM Orders;

-- Find the average sales of all orders
SELECT AVG(Sales) AS avg_sales
FROM Orders;

-- Find the highest score among customers
SELECT MAX(Score) AS max_score
FROM Customers;

SELECT MAX(CAST(Score AS INTEGER)) AS max_score
FROM Customers;

-- Find the lowest score among customers
SELECT MIN(Score) AS min_score
FROM Customers;

-- Find the earliest order date
SELECT MIN(OrderDate) AS min_order_date
FROM Orders;

-- Find the latest order date 
SELECT MAX(OrderDate) AS max_order_date
FROM Orders;

/* ============================================================================== 
   GROUPED AGGREGATIONS - GROUP BY
=============================================================================== */

-- Find the total number of customers for each country
SELECT 
    COUNT(*) AS total_customers,
    Country
FROM Customers
GROUP BY Country;

-- Find the total number of customers for each country and sort the results by total (lowest first)
SELECT 
    COUNT(*) AS total_customers,
    Country
FROM Customers
GROUP BY Country
ORDER BY total_customers ASC;


-- Find the highest score of customers for each country
SELECT 
    MAX(Score) AS max_score,
    Country
FROM Customers
GROUP BY Country;

SELECT 
    MAX(CAST(Score AS INTEGER)) AS max_score,
    Country
FROM Customers
GROUP BY Country;

-- Find the number of orders, total sales, average sales, highest sales, and lowest sales per customer
SELECT
    CustomerID,
    COUNT(*) AS total_orders,
    SUM(Sales) AS total_sales,
    AVG(Sales) AS avg_sales, -- ROUND(AVG(Sales), 2)
    MAX(Sales) AS highest_sales,
    MIN(Sales) AS lowest_sales
FROM Orders
GROUP BY CustomerID;

-- HAVING

-- Find the total number of customers for each country and only include countries that have more than one customer
SELECT 
    COUNT(*) AS total_customers,
    Country
FROM Customers
GROUP BY Country
HAVING total_customers > 1;

-- Find the total number of customers for each country and only include countries that have more than one customer. Do not include Germany
SELECT 
    COUNT(*) AS total_customers,
    Country
FROM Customers
WHERE Country != 'Germany'
GROUP BY Country
HAVING total_customers > 1;