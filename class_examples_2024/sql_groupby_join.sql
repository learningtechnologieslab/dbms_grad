USE classicmodels;

SHOW tables;
DESCRIBE TABLE orders;

# WHERE Clause Examples
SELECT orderNumber, status, customerNumber 
FROM orders
#WHERE customerNumber = 181 AND YEAR(orderDate) = 2003;
#WHERE customerNumber BETWEEN 100 AND 120;
WHERE orderDate BETWEEN '1999-01-01' AND '2005-01-01';

# LIKE Operator
SELECT * FROM customers WHERE customerName = 'Atelier graphique';

# Wildcard - search beginning of string
SELECT * FROM customers WHERE customerName LIKE 'Am%';
SELECT * FROM customers WHERE LCASE(customerName) LIKE 'am%';
SELECT * FROM customers WHERE UCASE(customerName) LIKE 'AM%';

# Wildcard - search end of string
SELECT * FROM customers WHERE LCASE(customerName) LIKE '%m';

# Wildcard - search anywhere in the string
SELECT * FROM customers WHERE LCASE(customerName) LIKE '%m%';


# NULL values
SELECT * FROM customers WHERE state IS NULL;
SELECT * FROM customers WHERE state IS NOT NULL;

# AGGREGATION
SELECT * FROM payments;
SELECT MAX(amount) FROM payments;
SELECT MIN(amount) FROM payments;
SELECT AVG(amount) FROM payments;
SELECT SUM(amount) FROM payments;
SELECT COUNT(amount) FROM payments;

# GROUP BY
SELECT * FROM payments;

SELECT customerNumber, SUM(amount) 
FROM payments
WHERE customerNumber BETWEEN 100 AND 120
GROUP BY customerNumber;


SELECT customerNumber, SUM(amount) 
FROM payments
GROUP BY customerNumber
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT customerNumber, SUM(amount) 
FROM payments
WHERE YEAR(paymentDate) > 2002
GROUP BY customerNumber
HAVING SUM(amount) > 10000;

SELECT * FROM orderdetails;
SELECT productCode, SUM(quantityOrdered)
FROM orderdetails
GROUP BY productCode
ORDER BY SUM(quantityOrdered) DESC
LIMIT 3;



/*
customers = list of unique customer numbers
for each cust in customers:
	SELECT SUM(amount) WHERE customerNumber = cust.id
*/




# INNER JOIN
SELECT * FROM customers;
SELECT * FROM orders;

SELECT * 
FROM customers JOIN orders ON customers.customerNumber = orders.customerNumber;

SELECT c.customerNumber, customerName, orderNumber, orderDate
FROM customers AS c JOIN orders AS o 
ON c.customerNumber = o.customerNumber;

SELECT c.customerNumber, customerName, od.*
FROM customers AS c JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber;

SELECT c.customerNumber, customerName, SUM(quantityOrdered) AS TotalOrder
FROM customers AS c JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, customerName;


# LEFT JOIN
SELECT * FROM customers;
SELECT * FROM payments;

SELECT c.customerNumber, customerName, p.* 
FROM customers AS c JOIN payments AS p ON c.customerNumber = p.customerNumber; 

SELECT c.customerNumber, customerName, p.* 
FROM customers AS c LEFT JOIN payments AS p ON c.customerNumber = p.customerNumber; 

SELECT c.customerNumber, customerName, p.* 
FROM customers AS c LEFT JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE p.checkNumber IS NULL; 

# ERROR WITH FULL JOIN - DMITRIY WILL UPDATE EXAMPLE
/*
SELECT c.customerNumber, customerName, p.* 
FROM customers AS c FULL OUTER JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE p.checkNumber IS NULL; 
*/

SELECT c.customerNumber, customerName, 
MIN(py.amount), MAX(py.amount), AVG(py.amount)
FROM customers AS c
JOIN orders as o ON c.customerNumber = o.customerNumber
JOIN orderdetails as od ON o.orderNumber = od.orderNumber
JOIN products AS p ON od.productCode = p.productCode
JOIN payments AS py ON c.customerNumber = py.customerNumber
WHERE YEAR(paymentDate) = 2003
GROUP BY c.customerNumber, customerName
HAVING MIN(py.amount) > 1000;