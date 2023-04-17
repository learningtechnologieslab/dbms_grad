use sakila;

DELIMITER $$;
CREATE FUNCTION fn_reads_sql()
RETURNS double
READS SQL DATA
BEGIN
	SET @val = (SELECT MAX(amount) FROM payment);
    RETURN @val;
    #RETURN 5;
END;

DELIMITER @@;
CREATE FUNCTION fn_update_sql_data(cust_id INT)
RETURNS bit
MODIFIES SQL DATA
BEGIN
	UPDATE payments SET amount = 10000 WHERE customer_id = cust_id;
    RETURN 1;
END;

DELIMITER @@;
CREATE FUNCTION fn_no_sql(n1 int, n2 int)
returns int
deterministic 
no sql
begin
	return n1 + n2;
end;

SELECT UUID();
SELECT NOW();
SELECT SUBSTR("HELLO WORLD", 5);

DELIMITER @@;
CREATE FUNCTION fn_clean_string(str VARCHAR(1000))
returns VARCHAR(1000)
deterministic
CONTAINS SQL
BEGIN
	SET @clean = (SELECT SUBSTRING(LOWER(str), 5, 5));
    RETURN @clean;
END;





