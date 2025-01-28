SELECT * FROM monkeys.monkey_likes_foods;

SELECT * FROM monkeys WHERE monkey_id = 6;

SELECT * FROM classicmodels.products 
WHERE productVendor = 'Min Lin Diecast' AND buyPrice > 50;

SELECT * FROM monkeys WHERE monkey_id = 6;
UPDATE monkeys SET monkey_name = 'Penny' WHERE monkey_id = 6;

INSERT INTO monkeys (monkey_name, dob, species)
VALUES ('Betty', '1977-01-01', 'Spider Monkey');

SELECT * FROM monkeys WHERE monkey_name = 'Betty';


SELECT * FROM monkeys WHERE monkey_id = 7;

DELETE FROM monkeys WHERE monkey_id = 7;

SELECT * FROM monkeys;
SELECT * FROM classicmodels.orders;
SELECT * FROM sakila.film;


SELECT title, rental_rate FROM sakila.film;

SELECT * FROM sakila.film ORDER BY title DESC; 

SELECT * FROM sakila.film ORDER BY title DESC LIMIT 10; 


