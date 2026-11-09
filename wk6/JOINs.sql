/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   CREATE TABLES 
=============================================================================== */

-- 1. Create the Customers table first (Parent table)
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT,
    Country TEXT,
    Score INTEGER
);

-- 2. Create the Orders table (Child table with Foreign Key)
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    ProductID INTEGER,
    CustomerID INTEGER,
    SalesPersonID INTEGER,
    OrderDate TEXT,
    ShipDate TEXT,
    OrderStatus TEXT,
    ShipAddress TEXT,
    BillAddress TEXT,
    Quantity INTEGER,
    Sales REAL,
    CreationTime TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- For the Multi JOIN part:

-- 3. Create the Products table
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Product TEXT NOT NULL,
    Category TEXT,
    Price REAL
);

-- 4. Create the Employees table
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT,
    Department TEXT,
    BirthDate TEXT, -- SQLite uses TEXT for dates
    Gender TEXT,
    Salary INTEGER,
    ManagerID INTEGER
);


/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.Sales
FROM Customers AS c
INNER JOIN Orders AS o
ON c.CustomerID = o.CustomerID;

-- LEFT JOIN
/* Get all customers along with their orders, 
   including those without orders */
SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.Sales
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID;


-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.Sales
FROM Customers AS c
RIGHT JOIN Orders AS o
ON c.CustomerID = o.CustomerID;

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.Sales
FROM Orders AS o
LEFT JOIN Customers AS c
ON c.CustomerID = o.CustomerID;

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.CustomerID,
    o.Sales
FROM Customers AS c
FULL JOIN Orders AS o
ON c.CustomerID = o.CustomerID;

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */
SELECT *
FROM Customers
CROSS JOIN Orders

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

SELECT 
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM Orders AS o
LEFT JOIN Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Employees AS e
ON o.SalesPersonID = e.EmployeeID;