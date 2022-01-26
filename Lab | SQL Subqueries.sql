use sakila;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, count(i.film_id) AS 'number_of_copies'
FROM film AS f
INNER JOIN inventory AS i
USING (film_id)
GROUP BY f.title
HAVING f.title = 'Hunchback Impossible';

-- plain answer, only subquery:
select count(*) num_of_copies from inventory
	where film_id = (select film_id from film where title="Hunchback Impossible"); 
    
-- 2. List all films whose length is longer than the average of all the films.
select title, length from film 
where length > (select avg(length) from film)
order by length;

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
select a.first_name,a.last_name from actor as a
inner join film_actor as fa
using(actor_id)
where film_id = (select film_id from film where title="Alone Trip")
order by a.last_name;

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.