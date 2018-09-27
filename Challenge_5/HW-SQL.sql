/* Create these queries to develop greater fluency in SQL, an important database language.*/

use sakila;
-- 1a. You need a list of all the actors who have Display the first and last names of all actors from the table actor.
select actor.first_name, actor.last_name from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. 
alter table actor 
add actor_name varchar(50);

SET SQL_SAFE_UPDATES = 0;
update sakila.actor
set actor.first_name = UPPER(first_name);

update sakila.actor
set actor.last_name = UPPER(last_name) ;

update sakila.actor
set actor_name = concat(first_name," ",last_name);


/*2a. You need to find the ID number, first name, and last name of an actor, 
of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
*/

select actor_id, first_name, last_name 
from actor
where first_name like 'Joe';



-- 2b. Find all actors whose last name contain the letters GEN:
select * from actor
where last_name like '%GEN%';


-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:

select * from actor 
where last_name like '%LI%'
order by last_name,first_name;


-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country 
from country
where country in ('Afghanistan', 'Bangladesh', 'China');



-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
alter table actor
add middle_name varchar(50) after first_name;



-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
alter table actor 
modify middle_name blob;



-- 3c. Now delete the middle_name column.
alter table actor
drop middle_name;



-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) as 'Counter last name'
from actor
group by last_name;




-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) as 'Counter last name'
from actor
group by last_name
having count(last_name) > 1;


/* 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, 
the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.*/
select first_name,actor_name from actor
where actor_name = 'HARPO WILLIAMS';

SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name='HARPO',actor_name = 'HARPO WILLIAMS'
WHERE actor_name='GROUCHO WILLIAMS';


/*
4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query,
 if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, 
 as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO,
 HOWEVER! (Hint: update the record using a unique identifier.)*/
 
 SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name='GROUCHO',actor_name = 'GROUCHO WILLIAMS'
WHERE actor_name='HARPO WILLIAMS';
 
 
-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
show create table address;


-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select s.first_name,s.last_name,a.address 
from staff s
join address a
on a.address_id = s.address_id; 



-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment. 
select s.staff_id, sum(p.amount) as 'total amount'
from payment p
inner join staff s 
on p.staff_id = s.staff_id

where p.payment_date between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
group by p.staff_id;


-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select f.title, count(fa.actor_id) as 'number of actors'
from film f
join film_actor fa
on f.film_id = fa.film_id
group by f.title;



-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title, count(i.film_id) as 'Number of copies'
from film f
join inventory i 
on f.film_id = i.film_id
where f.title= 'Hunchback Impossible';


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
-- ![Total amount paid](Images/total_payment.png)
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
from customer 
join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
Order by customer.last_name;


-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
-- films starting with the letters K and Q have also soared in popularity.
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 



select film.title
from film 
where film.language_id in
(select language.language_id
from language
where language.name ='English')
having film.title REGEXP '^[KQ]';


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select actor.actor_name 
from actor
where actor.actor_id in
(select film_actor.actor_id
from film_actor
where film_actor.film_id in
(select  film.film_id 
from film
where film.title = 'Alone Trip'));



-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.
select customer.first_name, customer.last_name, customer.email, country.country
from customer
join address
on customer.address_id = address.address_id
join city
on city.city_id = address.city_id
join country
on country.country_id = city.country_id
where country.country = 'Canada';

/*
7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as family films.*/

select film.title, film_category.category_id
from film
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
where category.category_id=8;


-- 7e. Display the most frequently rented movies in descending order. 
-- Check Solution
select film.title, count(film.title) as 'times of rented'
from film
join inventory
on film.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
group by film.title
order by count(film.title) desc;



-- 7f. Write a query to display how much business, in dollars, each store brought in.
select store.store_id, count(film.rental_rate) as 'Store revenue in dollar $'
from film
join inventory
on film.film_id = inventory.film_id
join store
on inventory.store_id = store.store_id
group by store.store_id;



-- 7g. Write a query to display for each store its store ID, city, and country.
select store.store_id, city.city,country.country
from store
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
group by store.store_id;



-- 7h. List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select category.category_id, category.name, sum(payment.amount) as 'Gross Revenue'
from category
join film_category
on category.category_id = film_category.category_id
join inventory
on film_category.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc limit 5;


/*
8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
*/
create view top_five_genres as  
select category.category_id, category.name, sum(payment.amount) as 'top_five_genres'
from category
join film_category
on category.category_id = film_category.category_id
join inventory
on film_category.film_id = inventory.film_id
join rental 
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by category.name
order by sum(payment.amount) desc limit 5;

-- 8b. How would you display the view that you created in 8a?
select * from top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

drop view top_five_genres;
