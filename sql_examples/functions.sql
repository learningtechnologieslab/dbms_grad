USE sakila;

/** DETERMINISTIC FUNCTION **/
DELIMITER @@;

CREATE function fn_add_numbers(n1 double, n2 double)
RETURNS double
deterministic
BEGIN
	SET @result = n1 + n2;
	return @result;

END;

SELECT fn_add_numbers(5, 5);

/**** NON-DETERMINISTIC FUNCTION ****/
SELECT * FROM payment;

DELIMITER $$;
CREATE FUNCTION fn_customer_spending(cust_id int)
RETURNS double
READS SQL DATA
BEGIN
	return (SELECT SUM(amount) FROM payment WHERE customer_id = cust_id);
END;

SELECT fn_customer_spending(1);
# 118.68
# 164.69
#SELECT SUM(amount) FROM payment WHERE customer_id = 1

#SELECT * FROM payment WHERE customer_id = 1;
#UPDATE payment SET amount = 50 WHERE payment_id = 9;


/***** FUNCTIONS ARE READ-ONLY ******/
DELIMITER @@;
CREATE FUNCTION fn_a(test double)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	UPDATE payment SET amount = 50 WHERE payment_id = 9;
	return 'hello';
END;

SELECT fn_a(1);