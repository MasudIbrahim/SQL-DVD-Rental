-- 1. What are the 3 tiers of rental rates for films by most expensive?
SELECT DISTINCT(rental_rate) FROM film
ORDER BY rental_rate DESC;
-- The 3 tiers are $4.99, $2.99 and $0.99

-- 2. What is the total spend of all customers to the nearest whole number?
SELECT ROUND(SUM(amount),0) from payment;
-- $61312

-- 3. What is the customer id,name and email of our highest paying customer and how much did they spend?
SELECT customer.customer_id,first_name,last_name,email,SUM(amount) FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;
-- Our highest paying customer is Eleanor Hunt who's customer id is 148 and email is eleanor.hunt@sakilacustomer.org. She has spent $211.55 in total.

-- 4. Which staff member has handled the most payments?
SELECT COUNT(DISTINCT(payment_id)) FROM payment
--14596 individual transactions
SELECT first_name,last_name,COUNT(DISTINCT(payment_id)) as total_sales FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY total_sales DESC;
--The staff member with most payments handled was Jon Stephens with 7304 to Mike Hillyer's 7292.

-- 5. We are currently running a promotion in Texas and would like to send out an email to members based there.
SELECT email,district FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Texas';
-- We have 5 customers based in Texas and their emails are:jennifer.davis@sakilacustomer.org, kim.cruz@sakilacustomer.org, richard.mccrary@sakilacustomer.org, bryan.hardison@sakilacustomer.org, ian.still@sakilacustomer.org

-- 6. What is the name of the district with the highest total spend and what is the amount?
SELECT district,SUM(amount) FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY district
ORDER BY SUM(amount) DESC
LIMIT 1;
-- Buenos Aires with a total spend of $1029.48


-- 7. A customer is a huge fan of Nick Wahlberg and would like you to find the titles of films he has starred in that we have available. 
SELECT title,first_name,last_name FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
-- We have 25 films available starring Nick Wahlberg.(Will not list due to number)


