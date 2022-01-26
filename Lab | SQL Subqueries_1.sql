use sakila;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
-- using joins
SELECT f.title, count(i.film_id) AS 'number_of_copies'
FROM film AS f
INNER JOIN inventory AS i
USING (film_id)
GROUP BY f.title
HAVING f.title = 'Hunchback Impossible';

-- using subquery
select count(*) num_of_copies from inventory
where film_id = (select film_id from film where title="Hunchback Impossible"); 
    
-- 2. List all films whose length is longer than the average of all the films.
select title, length from film 
where length > (select avg(length) from film)
order by length;

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
select last_name, first_name from actor 
where actor_id in (select actor_id from film_actor
where film_id in (select film_id from film where title = "Alone Trip"));

/*4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
category -> film_category --> film*/
select c.name, f.title from category as c
inner join film_category as fc
using (category_id)
inner join film as f
using (film_id)
where c.name = "Family";

/*5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
 Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
 using subqueries*/
select first_name, last_name, email from customer
where address_id in (select address_id from address 
where city_id in (select city_id from city 
where country_id = (select country_id from country where country = 'Canada')));

-- using joins
-- customer -> address -> city -> country
select c.first_name, c.last_name, c.email from customer as c
inner join address as a
using (address_id)
inner join city as ci
using (city_id)
inner join country as co
using (country_id)
where co.country = "Canada";

/*6. Which are films starred by the most prolific actor? 
Most prolific actor is defined as the actor that has acted in the most number of films. 
First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.*/

select title from film 
where film_id in (select film_id from film_actor
where actor_id = (select actor_id from film_actor
group by actor_id
order by count(actor_id) desc limit 1));

-- 7. Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
-- customer -> rental -> inventory -> film
select title from film 
where film_id in (select film_id from inventory
where inventory_id in (select inventory_id from rental
where customer_id = (select customer_id from payment 
							group by  customer_id
							order by sum(payment.amount) desc limit 1)));

-- 8. Customers who spent more than the average payments.

create temporary table sakila.total_payment_customer
select customer_id, sum(payment.amount) as total_payment from payment 
									group by customer_id
									order by sum(payment.amount);

create temporary table sakila.total_payment_customer2  -- to tap in a second time (subquery)
select customer_id, sum(payment.amount) as total_payment from payment 
									group by customer_id
									order by sum(payment.amount);

select first_name, last_name from customer
	where customer_id in (select customer_id from total_payment_customer
		where total_payment > (select avg(total_payment) from total_payment_customer2))
								order by last_name;