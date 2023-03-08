# Explanation of SQL queries used

### 1. What are the 3 tiers of rental rates for films by most expensive?<BR>

````sql
SELECT DISTINCT(rental_rate) FROM film
ORDER BY rental_rate DESC;
````
The rental_rate column can be found in the film table. Calling Distinct() on the rental_rate will return the unique values in the rental_rate column. I then use the ORDER BY function and specify DESC to return the values from largest to smallest.

  
### 2. What is the total spend of all customers to the nearest whole number?
  
````sql
SELECT ROUND(SUM(amount),0) from payment;
````
The amount column in the payment table contains individual amounts from each transaction. Calling SUM() on the amount will give us the total of all values in this column. Then, using the ROUND(column_name,0) function allows us to return a whole number.
 
  
### 3. What is the customer id,name and email of our highest paying customer and how much did they spend?
  
````sql
SELECT customer.customer_id,first_name,last_name,email,SUM(amount) FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;
````
I used an inner join to link the customer and payment tables together. I asked for the required fields to be returned and created a link using the customer_id which both tables shared. The GROUP BY(customer.customer_id) statement collates all returned values by customer_id. Using ORDER BY and sorting by descending shows us the largest values first and we can find the largest by using LIMIT 1 to return only 1 row.  
  
  
### 4. Which staff member has handled the most payments?

````sql
SELECT first_name,last_name,COUNT(DISTINCT(payment_id)) as total_sales FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY total_sales DESC;
````
The SELECT statement includes the full name and a COUNT() of the distinct payment_id's. This is then renamed as an alias called total_sales.
 We then inner join with the payments table using the staff.id from both tables as matching values. The column name for the GROUP BY clause is specified as it is present in both tables. Finally, ORDER BY in DESC order returns the total_sales from largest to smallest. We can also use the alias in the ORDER BY clause rather than the original column name.
 
  
### 5. We are currently running a promotion in Texas and would like to send out an email to members based there.

````sql
SELECT email,district FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Texas';
````
We're looking for a specfic district for this question so the WHERE clause allows us to enter Texas as a string using ''. We also perform an inner join between address and customer using the address_id found in both tables. The SELECT clause returns the email as requested and also the district to ensure they're all from Texas.  
  
  
### 6. What is the name of the district with the highest total spend and what is the amount?

````sql
SELECT district,SUM(amount) FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY district
ORDER BY SUM(amount) DESC
LIMIT 1;
````
This question requires 2 seperate inner joins to return the required columns. First, we join address to customer using the address_id and then the payment table using the customer_id. GROUP BY(district) returns every district as it's own row and like in an earlier question, we use ORDER BY and LIMIT to return the largest value for SUM(amount).  
  
  
### 7. A customer is a huge fan of Nick Wahlberg and would like you to find the titles of films he has starred in that we have available.
  
````sql
SELECT title,first_name,last_name FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
````  
We're looking for films with Nick Wahlberg in so we specify this using the WHERE clause and setting the first_name and last_name.
This question also requires 2 inner joins between the actor and film_ator tables and the film_actor and film tables using 2 common columns.
