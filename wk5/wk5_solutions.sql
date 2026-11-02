/*
The next tables belong to the Exercise: Online Bookstore
*/

CREATE TABLE authors (
    author_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT    NOT NULL
                       CHECK (length(trim(first_name) ) > 0),
    last_name  TEXT    NOT NULL
                       CHECK (length(trim(last_name) ) > 0),
    biography  TEXT
);


CREATE TABLE books (
    book_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title            TEXT    NOT NULL
                             CHECK (length(trim(title) ) > 0),
    isbn             TEXT    NOT NULL
                             UNIQUE
                             CHECK (length(trim(isbn) ) >= 10),
    publication_year INTEGER CHECK (publication_year >= 1455 AND
                                    publication_year <= strftime('%Y', 'now') ),
    price            REAL    NOT NULL
                             CHECK (price >= 0.0),
    author_id        INTEGER NOT NULL
                             REFERENCES authors (author_id) ON DELETE RESTRICT,
    stock_quantity   INTEGER NOT NULL
                             DEFAULT (0) 
                             CHECK (stock_quantity >= 0) 
);

CREATE TABLE customers (
    customer_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name       TEXT    NOT NULL
                             CHECK (length(trim(first_name) ) > 0),
    last_name        TEXT    NOT NULL
                             CHECK (length(trim(last_name) ) > 0),
    email            TEXT    UNIQUE
                             NOT NULL
                             CHECK (email LIKE '%_@__%._%'),
    phone            TEXT    CHECK (phone IS NULL OR
                                    length(phone) >= 7),
    shipping_address TEXT    NOT NULL
                             CHECK (length(trim(shipping_address) ) > 0) 
);


CREATE TABLE orders (
    order_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    order_date   TEXT    NOT NULL,
    total_amount REAL    NOT NULL
                         CHECK (total_amount >= 0.0),
    quantity     INTEGER NOT NULL
                         DEFAULT (1) 
                         CHECK (quantity > 0),
    customer_id  INTEGER NOT NULL
                         REFERENCES customers (customer_id) ON DELETE RESTRICT,
    book_id      INTEGER NOT NULL
                         REFERENCES books (book_id) ON DELETE RESTRICT
);

-- Insert values into the 'authors' table
INSERT INTO authors(first_name, last_name, biography)
VALUES ('Albert', 'Einstein', 'Nobel Prize winner in Physics');

/* 
   Table: employees
   Description: This script creates the 'employees' tables for the class exercise on week 5
   Date: October 2026
*/

CREATE TABLE employees (
    employee_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name  TEXT    NOT NULL
                        CHECK (length(trim(first_name) ) > 0),
    last_name   TEXT    NOT NULL
                        CHECK (length(trim(last_name) ) > 0),
    department  TEXT    NOT NULL
                        CHECK (department IN ('Marketing', 'Sales', 'Customer Support', 'Engineering') ),
    hired_date  TEXT    NOT NULL
);

/* 
   Table: products
   Description: This script creates the 'products' tables for the class exercise on week 5
   Date: October 2026
*/

CREATE TABLE products (
    product_ID      INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name    TEXT    NOT NULL
                            CHECK (length(trim(product_name) ) > 0),
    category        TEXT    NOT NULL,
    price           REAL    NOT NULL
                            CHECK (price > 0),
    units_in_stock  INTEGER NOT NULL
                            DEFAULT (0) 
                            CHECK (units_in_stock >= 0),
    units_sold      INTEGER NOT NULL
                            DEFAULT (0) 
                            CHECK (units_sold >= 0),
    discounted_date TEXT    -- Nullable by default
);


-- Retrieve all employees hired in 2024.
SELECT employee_ID, first_name, last_name, department, hired_date
FROM employees
WHERE hired_date LIKE '2024%'; -- from date

-- Filter for products that have a recorded discounted_date (ignoring active products where the date is NULL
SELECT product_ID, product_name, category, price, discounted_date
FROM products
WHERE discounted_date IS NOT NULL 
  AND length(trim(discounted_date)) > 0;

-- List all team members who joined the company after June 1st, 2023.
SELECT first_name, last_name, department, hired_date
FROM employees
WHERE hired_date > '2023-06-01'
ORDER BY hired_date ASC;

-- List all products discontinued between June 1, 2023, and January 31, 2025.
SELECT product_name, category, price, discounted_date
FROM products
WHERE discounted_date BETWEEN '2023-06-01' AND '2025-01-31';

-- Filter for employees whose hiring month falls between January (01) and March (03).
SELECT first_name, last_name, department, hired_date
FROM employees
WHERE strftime('%m', hired_date) IN ('01', '02', '03')
ORDER BY hired_date;