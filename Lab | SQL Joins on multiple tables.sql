use sakila;
-- 1. Write a query to display for each store its store ID, city, and country.
/*from "store" table get "store_id" and "address_id"
join with "address" table on "address_id" to get "city_id"
join with "city" table  on "city_id" to get "city" and "country_id"
join with "country" table  on "country_id" to get "country"*/

select s.store_id, c.city, co.country from store as s
inner join address as a
on s.address_id = a.address_id
inner join city as c
on a.city_id = c.city_id
inner join country as co
on c.country_id = co.country_id
group by c.city

-- 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as business from payment as p
inner join staff as st
on p.staff_id = st.staff_id
inner join store as s
on s.store_id = st.store_id
group by s.store_id

-- 3. What is the average running time(length) of films by category?
/* get "length" from "film" table
join with "film_category" table to get "category_id"
join with "category" table to get "name"*/

select avg(f.length), c.name as avg_film_length from film as f
inner join film_category as fc
on f.film_id = fc.film_id
inner join category as c
on fc.category_id = c.category_id
group by c.name;

-- 4. Which film categories are longest(length)? (Hint: You can rely on question 3 output.)
select avg(f.length), c.name as avg_film_length from film as f
inner join film_category as fc
on f.film_id = fc.film_id
inner join category as c
on fc.category_id = c.category_id
group by c.name 
order by avg(f.length) desc;
-- The longest film categories are Sports, Games and Foreign.


-- 5. Display the most frequently (number of times) rented movies in descending order.
-- rental -> inventory -> film
select f.title, count(r.rental_id) as num_rent from rental as r
inner join inventory as i
on i.inventory_id =  r.inventory_id
inner join film as f
on f.film_id = i.film_id
group by f.film_id
order by num_rent desc;

-- 6 List the top five genres in gross revenue in descending order.
select c.name from payment as p
inner join customer as co
on co.customer_id = p.customer_id
inner join inventory as i
on co.store_id = i.store_id
inner join film_category as fc
on i.film_id = fc.film_id
inner join category as c
on c.category_id = fc.category_id
group by c.category_id
order by sum(p.amount) desc limit 5;


-- 7 Is "Academy Dinosaur" available for rent from Store 1? Yes.
select f.title, i.store_id from store as s
inner join inventory as i
on s.store_id = i.store_id
inner join film as f
on i.film_id = f.film_id
where f.title = "Academy Dinosaur" and i.store_id = "1"