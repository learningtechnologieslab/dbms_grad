USE sakila;
SELECT * FROM payment;

/*
IF amount < 1 THEN print('low')
ELSE IF amount >1 AND amount < 3 THEN print('med')
ELSE print('high')
*/

SELECT amount,
CASE 
	WHEN amount < 1 THEN 'low'
    WHEN amount BETWEEN 1 AND 3 THEN 'medium'
    WHEN amount BETWEEN 4 AND 6 THEN 'high'
    WHEN amount > 6 THEN 'very high'
END AS amount_category
FROM payment;

SELECT * FROM category;
/*
IF category == 'Action' THEN print('pg13')
ELSE IF category = 'Documentary' THEN print('r')
*/
SELECT name,
CASE name
	WHEN 'Action' THEN 'PG13'
    WHEN 'Documentary' THEN 'R'
    WHEN 'Music' THEN 'PG'
    WHEN 'Sci-Fi' THEN 'TV-14'
    ELSE ''
END AS rating
FROM category;

SELECT name,
CASE 
	WHEN name = 'Action' THEN 'PG13'
    WHEN name = 'Documentary' THEN 'R'
    WHEN name = 'Music' THEN 'PG'
    WHEN name = 'Sci-Fi' THEN 'TV-14'
    ELSE ''
END AS rating
FROM category;

/***** IF FUNCTION *******/
SELECT amount, if(amount < 5, 'low', 'high') AS amount_category
FROM payment;

SELECT amount, 
CASE 
	WHEN amount < 5 THEN 'low'
    ELSE 'high'
END AS amount_category
FROM payment;

SELECT amount, if(amount BETWEEN 1 and 5, 'low', 'high') AS amount_category
FROM payment;

/************ IFNULL() *******************/
SELECT *, IFNULL(original_language_id, 'unavailable') FROM film;
