USE classicmodels;

SELECT * FROM orders;

SELECT * FROM customers;

SELECT * 
FROM customers JOIN orders 
ON customers.customerNumber = orders.customerNumber;

# Error Code: 1052. Column 'customerNumber' in on clause is ambiguous

SELECT * 
FROM customers AS c JOIN orders AS o
ON c.customerNumber = o.customerNumber;

SELECT * FROM payments;

SELECT * 
FROM customers AS c JOIN orders AS o
ON c.customerNumber = o.customerNumber;


SELECT * 
FROM customers AS c JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN payments as p
ON c.customerNumber = p.customerNumber;

# Explicit Inner Join Notation
SELECT * 
FROM customers AS c JOIN orders AS o
ON c.customerNumber = o.customerNumber;

SELECT * FROM customers AS c, orders AS o
WHERE c.customerNumber = o.customerNumber;

SELECT c.customerNumber, customerName, amount
FROM customers AS c JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN payments as p
ON c.customerNumber = p.customerNumber;


SELECT c.customerNumber, customerName, SUM(amount)
FROM customers AS c JOIN orders AS o
ON c.customerNumber = o.customerNumber
JOIN payments as p
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, customerName;


SELECT c.customerNumber, p.amount FROM 
customers AS c
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.amount IS NULL;


SELECT c.customerNumber, p.amount FROM 
payments as p
RIGHT JOIN customers as c
ON p.customerNumber = c.customerNumber;


#SELECT c.customerNumber, p.amount FROM 
#payments as p
#FULL OUTER JOIN customers as c
#ON p.customerNumber = c.customerNumber;
#'''