USE classicmodels;
-- SQL Script with Examples for Lecture 4 Topics

-- 1. FROM Clause: Selecting data from tables

-- Example 1: Select all columns from the customers table
SELECT * FROM customers;

-- Example 2: Select specific columns from the employees table
SELECT employeeNumber, lastName, firstName, jobTitle FROM employees;

-- Example 3: Selecting orders from the year 2003
SELECT * FROM orders 
WHERE YEAR(orderDate) = 2003;

-- 2. WHERE Clause: Filtering data based on conditions

-- Example 1: Find all customers in France
SELECT * FROM customers 
WHERE country = 'France';

-- Example 2: Find employees with a job title of 'Sales Rep'
SELECT * FROM employees 
WHERE jobTitle = 'Sales Rep';

-- Example 3: Find orders with a status of 'Shipped'
SELECT * FROM orders 
WHERE status = 'Shipped';

-- 3. LIKE Clause: Searching with wildcards

-- Example 1: Find customers whose contact name starts with 'A'
SELECT * FROM customers 
WHERE contactFirstName LIKE 'A%';

-- Example 2: Find employees whose last name contains 'son'
SELECT * FROM employees 
WHERE lastName LIKE '%son%';

-- Example 3: Find product names that end with 'Car'
SELECT * FROM products 
WHERE productName LIKE '%Car';

-- 4. LIMIT Clause: Restricting the number of results

-- Example 1: Retrieve only 5 customers
SELECT * FROM customers 
LIMIT 5;

-- Example 2: Retrieve the first 10 orders sorted by order date
SELECT * FROM orders 
ORDER BY orderDate 
LIMIT 10;

-- Example 3: Retrieve the top 3 most expensive products
SELECT * FROM products 
ORDER BY buyPrice DESC 
LIMIT 3;

-- 5. Aggregate Functions: Performing calculations on data

-- Example 1: Find the total number of customers
SELECT COUNT(*) AS totalCustomers FROM customers;

-- Example 2: Find the average price of all products
SELECT AVG(buyPrice) AS avgPrice FROM products;

-- Example 3: Find the maximum credit limit among customers
SELECT MAX(creditLimit) AS maxCredit FROM customers;

-- 6. GROUP BY Clause: Grouping data for aggregation

-- Example 1: Count the number of customers per country
SELECT country, COUNT(*) AS customerCount 
FROM customers 
GROUP BY country;

-- Example 2: Find the total sales per product line
SELECT productLine, SUM(quantityOrdered * priceEach) AS totalSales 
FROM orderdetails 
JOIN products USING (productCode) 
GROUP BY productLine;

-- Example 3: Find the average credit limit per country
SELECT country, AVG(creditLimit) AS avgCreditLimit 
FROM customers 
GROUP BY country;

-- 7. HAVING Clause: Filtering groups

-- Example 1: Show only countries with more than 5 customers
SELECT country, COUNT(*) AS customerCount 
FROM customers 
GROUP BY country 
HAVING COUNT(*) > 5;

-- Example 2: Show only product lines with total sales above 100,000
SELECT productLine, SUM(quantityOrdered * priceEach) AS totalSales 
FROM orderdetails 
JOIN products USING (productCode) 
GROUP BY productLine 
HAVING totalSales > 100000;

-- Example 3: Show only countries where the average credit limit is above 50,000
SELECT country, AVG(creditLimit) AS avgCreditLimit 
FROM customers 
GROUP BY country 
HAVING avgCreditLimit > 50000;

-- 8. String Functions: Manipulating text

-- Example 1: Concatenate first and last name of employees
SELECT CONCAT(firstName, ' ', lastName) AS fullName FROM employees;

-- Example 2: Convert all product names to uppercase
SELECT UPPER(productName) AS upperProductName FROM products;

-- Example 3: Extract the first 5 characters from product names
SELECT SUBSTRING(productName, 1, 5) AS shortName FROM products;

-- 9. SQL Joins: Combining multiple tables

-- Example 1: INNER JOIN to list orders with customer details
SELECT orders.orderNumber, customers.customerName, orders.status 
FROM orders 
INNER JOIN customers ON orders.customerNumber = customers.customerNumber;

-- Example 2: LEFT JOIN to list all employees and their office locations
SELECT employees.firstName, employees.lastName, offices.city 
FROM employees 
LEFT JOIN offices ON employees.officeCode = offices.officeCode;

-- Example 3: JOIN with alias to list products and their respective product lines
SELECT p.productName, pl.textDescription 
FROM products p 
JOIN productlines pl ON p.productLine = pl.productLine;
