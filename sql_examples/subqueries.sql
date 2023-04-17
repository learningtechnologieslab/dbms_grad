USE sakila;

SELECT * FROM actor WHERE actor_id IN (3, 5, 7);

SELECT * FROM actor WHERE
actor_id = 3 OR actor_id = 5 OR actor_id = 7;

SELECT f.film_id, title FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
WHERE a.actor_id = 1;

SELECT film_id, title FROM film
WHERE film_id IN(
SELECT film_id FROM film_actor AS fa JOIN actor a ON fa.actor_id = a.actor_id
WHERE fa.actor_id = 1);

USE world;

SELECT * FROM city WHERE CountryCode = (
SELECT Code FROM country WHERE Name LIKE 'AFG%')
ORDER BY District;

USE sakila;
SHOW TABLES;

SELECT * FROM inventory
WHERE inventory_id BETWEEN 
(SELECT DISTINCT(inventory_id) FROM rental WHERE inventory_id = 2)
AND
(SELECT DISTINCT(inventory_id) FROM rental WHERE inventory_id = 10);


# Get a list of how many times each inventory item had been rented
SELECT i.inventory_id, title, COUNT(r.rental_id)
FROM film AS f JOIN inventory as i on f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY i.inventory_id, title;

# Get a list of how many times each movie  had been rented
SELECT title, COUNT(r.rental_id)
FROM film AS f JOIN inventory as i on f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY title;

# Get a list of how many times each inventory item had been rented
# with a subquery
SELECT i.inventory_id, title,
(SELECT COUNT(rental_id) FROM rental AS r WHERE r.inventory_id = i.inventory_id) AS rental_count
FROM film AS f JOIN inventory as i on f.film_id = i.film_id;

/*
for each row in dataset:
	lookup value in subquery
*/

SELECT * FROM film, inventory, rental
WHERE film.film_id = inventory.film_id 
AND rental.inventory_id = inventory.inventory_id;

SELECT * FROM film AS f 
JOIN inventory AS i ON f.film_id = i.film_id 
JOIN rental AS r ON i.inventory_id = r.inventory_id;

SELECT * FROM film AS f 
JOIN inventory AS i ON f.film_id = i.film_id 
JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN 
(
SELECT rental_id FROM payment WHERE amount > 5
);

SELECT i.inventory_id, title, 
(SELECT MAX(amount) FROM payment AS p WHERE p.rental_id = r.rental_id) AS max_pay
FROM film AS f 
JOIN inventory AS i ON f.film_id = i.film_id 
JOIN rental AS r ON i.inventory_id = r.inventory_id; 
