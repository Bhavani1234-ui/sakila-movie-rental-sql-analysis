-- Sakila DVD Rental Database Analysis Script

-- 1) All PG-13 films with rental rate of 2.99 or lower
SELECT *
FROM film
WHERE rating = 'PG-13' AND rental_rate <= 2.99;

-- 2) All films that have deleted scenes
SELECT * 
FROM film
WHERE special_features LIKE '%Deleted Scenes%';

-- 3) All active customers
SELECT *
FROM customer
WHERE active = 1;

-- 3.1) How many active customers
SELECT COUNT(active) AS total_active_customers
FROM customer
WHERE active = 1;

-- 4) Names of customers who rented a movie on 26th July 2005
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, r.rental_date, r.rental_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-07-26';

-- 5) Distinct names of customers who rented a movie on 26th July 2005
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE DATE(rental_date) = '2005-07-26';

-- 5.1) How many distinct last names we have in the data?
SELECT COUNT(DISTINCT last_name) AS count_last_name 
FROM customer;

-- 6) How many rentals do we have on each day?
SELECT DATE(rental_date) AS rental_day, COUNT(*) AS daily_rentals
FROM rental
GROUP BY DATE(rental_date)
ORDER BY rental_day ASC;

-- 6.1) What is the busiest day so far?
SELECT DATE(rental_date) AS busiest_date, COUNT(*) AS rental_count
FROM rental
GROUP BY DATE(rental_date)
ORDER BY rental_count DESC
LIMIT 1;

-- 7) All Sci-fi films in our catalogue
SELECT fc.film_id, f.title, c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi';

-- 8) Customers and how many movies they rented from us so far
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, COUNT(r.rental_id) AS count_of_movies
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY count_of_movies DESC;

-- 9) Which movies should we discontinue from our catalogue (less than 5 lifetime rentals)
WITH low_rentals AS (
    SELECT inventory_id, COUNT(*) AS rental_count
    FROM rental r
    GROUP BY inventory_id
    HAVING COUNT(*) < 5
)
SELECT DISTINCT low_rentals.inventory_id, i.film_id, f.title
FROM low_rentals
JOIN inventory i ON i.inventory_id = low_rentals.inventory_id
JOIN film f ON f.film_id = i.film_id;

-- 10) Which movies are not returned yet?
SELECT r.rental_date, r.customer_id, i.film_id, f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE r.return_date IS NULL;

-- 11) How much money and rentals we make for Store 1 by day?
SELECT i.store_id, DATE(p.payment_date) AS payment_day, SUM(p.amount) AS total_revenue, COUNT(r.rental_id) AS total_rentals
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
WHERE i.store_id = 1
GROUP BY i.store_id, DATE(p.payment_date)
ORDER BY payment_day ASC;