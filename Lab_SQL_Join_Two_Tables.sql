use sakila;

-- 1. Which actor has appeared in the most films?
select a.first_name, a.last_name, count(f.film_id) as number_films from actor as a
inner join film_actor as f
on a.actor_id = f.actor_id
group by a.actor_id
order by number_films desc
limit 1;
-- Gina Degeneres has appeared in 42 films

-- 2. Most active customer (the customer that has rented the most number of films)
select c.first_name, c.last_name, count(r.rental_id) as rented_films from customer as c
inner join rental as r
on c.customer_id = r.customer_id
group by c.customer_id
order by rented_films desc
limit 1;
-- Eleanor Hunt has rented 46 films

-- 3. List number of films per category.
select c.name, count(f.film_id) as films_per_cat from film_category as f
left join category as c
on f.category_id=c.category_id
group by c.category_id
order by c.name;

-- 4. Display the first and last names, as well as the address, of each staff member.
select  s.first_name, s.last_name, a.address, a.district from staff as s
inner join address as a
on s.address_id=a.address_id
order by s.last_name;

-- 5. Display the total amount rung up by each staff member in August of 2005.
select s.first_name, s.last_name, sum(p.amount),p.staff_id from payment as p 
inner join staff as s
on p.staff_id=s.staff_id
where p.payment_date like "2005-08-%"
group by s.staff_id;
-- Mike Hillyer rung up $11853.65 and Jon Stephens rung up $12218.48

-- 6. List each film and the number of actors who are listed for that film.
select f.title, fa.film_id, count(fa.actor_id) from film_actor as fa
left join film as f
on fa.film_id=f.film_id
group by film_id;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name. 

select c.first_name, c.last_name, p.customer_id, sum(p.amount) from payment as p
inner join customer as c
on p.customer_id = c.customer_id
group by c.customer_id
order by c.last_name;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood 
-- This query might require using more than one join statement. Give it a try.
-- rental (join on inventory_id), inventory (join on film_id) film

select f.title, count(r.rental_id) from rental as r
inner join inventory as i
on r.inventory_id = i.inventory_id
inner join film as f 
on i.film_id = f.film_id
group by f.film_id
order by  count(r.rental_id) desc limit 1

-- Bucket Brotherhood was rented 34 times.