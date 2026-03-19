USE classicmodels;

SELECT * FROM customers;

SELECT * FROM customers
WHERE customerNumber = 103 OR customerNumber = 112
OR customerNumber = 114;

SELECT * FROM customers 
WHERE customerNumber IN (103, 112, 114);

SELECT * FROM customers
WHERE customerNumber NOT IN
(SELECT DISTINCT customerNumber FROM payments);

SELECT * FROM customers AS c
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.customerNumber IS NULL;

SELECT * FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE amount > (SELECT AVG(amount) FROM payments);

SELECT customerNumber, customerName,
(SELECT SUM(amount) FROM payments AS p 
WHERE p.customerNumber = c.customerNumber) AS totalPayment
FROM customers AS c;

USE classicmodels;
CREATE TABLE employees_audit ( 
    id int(11) NOT NULL AUTO_INCREMENT, 
    employeeNumber int(11) NOT NULL, 
    lastname varchar(50) NOT NULL, 
    changedon datetime DEFAULT NULL, 
    action varchar(50) DEFAULT NULL, 
    PRIMARY KEY (id) 
 );


DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW BEGIN
 
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedon = NOW(); 
END $$
DELIMITER ;

SELECT * FROM employees_audit;

UPDATE employees SET lastName = 'FIRED' 
WHERE employeeNumber = 1076;

SET @employee_id = 1076;
SELECT * FROM employees 
WHERE employeeNumber = @employee_id;

# DECLARE employee_id AS INT DEFAULT 0;

# Imagine this is JAVA:
/*
int result;
int addNumbers(int a, int b){
	result =  a + b;
    return;
}
*/

SELECT NOW();
SELECT CURDATE();
SELECT SUM(amount) FROM payments;


DELIMITER $$
 
CREATE FUNCTION addTwoNumbers(num1 double, num2 double) 
	RETURNS double
    	DETERMINISTIC
BEGIN
    	DECLARE sumOfTwoNumbers double;
 
    	SET sumOfTwoNumbers = num1 + num2;
 
 	RETURN (sumOfTwoNumbers);
END $$
DELIMITER ;

SELECT addTwoNumbers(1, 2);


DELIMITER $$
 
CREATE FUNCTION calculateCustomerPayments(custNumber int) 
	RETURNS double
	READS SQL DATA
BEGIN
    	DECLARE totalPayments double;
 
    	SET totalPayments = (SELECT SUM(amount) 
			FROM payments WHERE customerNumber = custNumber);
 
 	RETURN totalPayments;
END $$
DELIMITER ;

SELECT * FROM payments;


SELECT calculateCustomerPayments(103);

SELECT *, calculateCustomerPayments(c.customerNumber)
FROM customers AS c;




USE sakila;

SELECT f.film_id, title, rental_rate, rating, inventory_id, store_id, a.actor_id, 
first_name, last_name
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN film_actor AS fi ON f.film_id = fi.film_id
JOIN actor AS a ON fi.actor_id = a.actor_id;

SELECT * FROM vw_film_actor_inventory WHERE film_id = 1;


SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id;
