USE sakila;

SELECT * FROM film;

SELECT * FROM film WHERE title LIKE 'A%';

SELECT * FROM film WHERE title LIKE '%A';

SELECT * FROM film WHERE description LIKE '%beautiful%';

SELECT * FROM film WHERE title LIKE 'A%' LIMIT 5;

SELECT * FROM film ORDER BY title ASC LIMIT 5 ;

SELECT * FROM film ORDER BY title DESC LIMIT 5 ;

SELECT * FROM film WHERE title LIKE 'A%' ORDER BY RAND() LIMIT 5 ;

SELECT SUM(length) FROM film WHERE length IS NOT NULL;

SELECT AVG(length) FROM film WHERE length IS NOT NULL;

SELECT MIN(length) AS min_len, 
MAX(length) AS max_len, 
COUNT(length) AS len_count
FROM film WHERE length IS NOT NULL;

SELECT DISTINCT(film_id) FROM inventory;

SELECT * FROM payment;

SELECT YEAR(MAX(payment_date)) FROM payment;

# Find top 5 highest spending customers
SELECT customer_id, SUM(amount)
FROM payment 
WHERE YEAR(payment_date) = 2006
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;


SELECT * FROM inventory;

SELECT film_id, COUNT(film_id) 
FROM inventory
GROUP BY film_id
ORDER BY COUNT(film_id);

SELECT film_id, COUNT(film_id) 
FROM inventory
#WHERE store_id = 2
GROUP BY film_id
HAVING COUNT(film_id) > 5;


SELECT film_id, COUNT(film_id), SUM(film_id)
FROM inventory
#WHERE store_id = 2
GROUP BY film_id
HAVING COUNT(film_id) > 5 AND SUM(film_id) > 150;

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT * 
FROM film JOIN film_actor ON film.film_id = film_actor.film_id;

SELECT * 
FROM film AS f JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id;

SELECT * 
FROM film AS f, film_actor AS fa, actor AS a
WHERE f.film_id = fa.film_id AND fa.actor_id = a.actor_id;


SELECT * 
FROM film AS f JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN language l ON f.language_id = l.language_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id;

SELECT * FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.inventory_id;

SELECT * FROM film AS f
RIGHT JOIN inventory AS i ON f.film_id = i.inventory_id;

SELECT * FROM inventory AS f
LEFT JOIN film AS i ON f.film_id = i.inventory_id;


#SELECT * FROM inventory AS i
#FULL JOIN film AS f ON f.film_id = i.inventory_id;

SELECT title, rating, COUNT(i.film_id)
FROM film AS f JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN language l ON f.language_id = l.language_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
JOIN inventory AS i ON f.film_id = i.inventory_id
WHERE release_year = 2006
GROUP BY title, rating
HAVING COUNT(i.film_id > 5);

SELECT c.name, first_name, last_name, COUNT(a.actor_id)
FROM film AS f JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name, last_name, first_name
HAVING COUNT(a.actor_id) > 5
ORDER BY last_name, first_name;

#GROUP BY title, rating

SELECT * FROM category;

