USE classicmodels;

SELECT * FROM products WHERE buyPrice > 50 ORDER BY productLine DESC LIMIT 10;

# Where Clause
# Operators
SELECT * FROM products WHERE buyPrice >= 50 and buyPrice <= 100;
SELECT * FROM products WHERE buyPrice BETWEEN 50 and 100;

# IN Operator

SELECT * FROM products WHERE productCode = 'S10_1949'
OR productCode = 'S10_2016' OR productCode = 'S10_4698';

SELECT * FROM products 
WHERE productCode IN ('S10_1949', 'S10_2016', 'S10_4698');

# LIKE operator
SELECT * FROM products WHERE productName LIKE '%Harley%';

# Aggregate Functions
SELECT AVG(buyPrice) FROM products WHERE buyPrice IS NOT NULL;
SELECT SUM(buyPrice) FROM products WHERE buyPrice IS NOT NULL;
SELECT COUNT(buyPrice) FROM products WHERE buyPrice IS NOT NULL;
SELECT MIN(buyPrice) FROM products WHERE buyPrice IS NOT NULL;
SELECT MAX(buyPrice) FROM products WHERE buyPrice IS NOT NULL;

# GROUP BY
#SELECT MIN(weight), MAX(weight) FROM visit WHERE fk_patient_id = 3;

SELECT productLine, MIN(buyPrice), MAX(buyPrice), AVG(buyPrice) 
FROM products
GROUP BY productLine;

SELECT productLine, productScale, SUM(MSRP) 
FROM products
GROUP BY productLine, productScale 
ORDER BY productLine;

SELECT customerNumber, MAX(amount), SUM(amount)
FROM payments
GROUP BY customerNumber
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT customerNumber, MAX(amount), SUM(amount)
FROM payments
WHERE amount > 100
GROUP BY customerNumber
HAVING SUM(amount) >= 500000
ORDER BY SUM(amount) DESC
LIMIT 5;

# STEP 1: WHERE filtering
SELECT *
FROM payments
WHERE amount > 100;

# STEP 2: GROUPING
SELECT customerNumber
FROM payments
WHERE amount > 100
GROUP BY customerNumber;

# STEP 3: AGGREGATION
SELECT customerNumber, MAX(amount), SUM(amount)
FROM payments
WHERE amount > 100
GROUP BY customerNumber;

# STEP 4: Filter grouping and aggregation results
# using the HAVING clause
SELECT customerNumber, MAX(amount), SUM(amount)
FROM payments
WHERE amount > 100
GROUP BY customerNumber
HAVING SUM(amount) >= 500000;


# INNER JOIN
SELECT * 
FROM orders JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber;

SELECT * 
FROM orders AS o JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber;

SELECT o.orderNumber, productCode, 
shippedDate, quantityOrdered, priceEach
FROM orders AS o JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber;

#Error Code: 1052. Column 'orderNumber' in on clause is ambiguous


# Tripple Inner Join

SELECT customerName, o.orderNumber, productCode, 
shippedDate, quantityOrdered, priceEach
FROM orders AS o JOIN orderdetails AS od 
ON o.orderNumber = od.orderNumber
JOIN customers AS c
ON o.customerNumber = c.customerNumber;

# Quad join
SELECT customerName, o.orderNumber, p.productCode, 
shippedDate, quantityOrdered, priceEach, productName
FROM orders AS o JOIN orderdetails AS od 
ON o.orderNumber = od.orderNumber
JOIN customers AS c
ON o.customerNumber = c.customerNumber
JOIN products AS p
ON od.productCode = p.productCode;


# LEFT JOIN
SELECT * FROM
customers AS c
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE amount IS NULL;

#SELECT COUNT(*) FROM customers;
#SELECT COUNT(*) FROM payments;
