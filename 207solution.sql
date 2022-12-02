-- Lab | SQL Join (Part I)
-- In this lab, you will be using the Sakila database of movie rentals.

-- Instructions
--  1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.
--  2 Display the total amount rung up by each staff member in August of 2005.
--  3 Which actor has appeared in the most films?
--  4 Most active customer (the customer that has rented the most number of films)
--  5 Display the first and last names, as well as the address, of each staff member.
--  6 List each film and the number of actors who are listed for that film.
--  7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
--  8 List number of films per category.

--  1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.
USE sakilla;
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT COUNT(filmcategory.film_id) AS 'number_of_films', c.name AS 'category'
FROM film_category filmcategory
JOIN category c
USING(category_id)
GROUP BY c.category_id;

--  2 Display the total amount rung up by each staff member in August of 2005. Revenues from each staff.
SELECT ROUND(SUM(p.amount)) AS 'revenue', s.first_name
FROM payment p
JOIN staff s
ON (p.staff_id = s.staff_id)
WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY p.staff_id;

--  3 Which actor has appeared in the most films?
SELECT *
FROM actor; -- 200 actors insde actor_id
SELECT *
FROM film; -- 1000 films film_id, title
SELECT *
FROM film_actor; -- 1000 films film_id, title

SELECT *
FROM film_actor f INNER JOIN actor a ON f.actor_id = a.actor_id
GROUP BY f.actor_id
ORDER BY COUNT(f.actor_id) DESC
LIMIT 1;

--  4 Most active customer (the customer that has rented the most number of films)
SELECT customer.*, COUNT(*) AS nb_rentals
FROM customer
JOIN rental 
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY nb_rentals DESC
LIMIT 1;

--  5 Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address
FROM staff 
JOIN address ON staff.address_id = address.address_id;

--  6 List each film and the number of actors who are listed for that film.
SELECT f.title,  COUNT(a.actor_id) AS 'number of actors'
FROM film f 
JOIN film_actor a ON 
f.film_id = a.film_id
GROUP BY (f.title);

--  7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT CONCAT(c.first_name,' ', c.last_name) AS customer,
SUM(p.amount) AS payment
FROM customer c 
JOIN payment p ON
c.customer_id = p.customer_id
Group BY customer 
ORDER BY customer;

--  8 List number of films per category.
SELECT category.name AS category, COUNT(*) AS number_of_films
FROM category
JOIN film_category 
USING (category_id)
GROUP BY category.category_id;
