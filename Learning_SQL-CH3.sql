USE sakila;

SELECT first_name, last_name
FROM customer c 
WHERE last_name = 'ZIEGLER';


SELECT *
FROM category c;


/*
	Query clauses
	Clause name 		Purpose
	select 				Determines which columns to include in the query’s result set
	from 				Identifies the tables from which to retrieve data and how the tables should be joined
	where 				Filters out unwanted data
	group by 			Used to group rows together by common column values
	having 				Filters out unwanted groups
	order by 			Sorts the rows of the final result set by one or more columns
*/


#The select clause determines which of all possible columns should be included in the query’s result set.

SELECT *
FROM `language`;

SELECT language_id, name, last_update
FROM `language` l;

SELECT name
FROM `language` l;

SELECT language_id,
		'COMMON' language_usage,
		language_id * 3.1415927 lang_pi_value,
		upper(name) language_name
FROM language;

SELECT actor_id 
FROM film_actor
ORDER BY actor_id;

SELECT DISTINCT actor_id
FROM film_actor 
ORDER BY actor_id;

/*
	Keep in mind that generating a distinct set of results requires the
	data to be sorted, which can be time consuming for large result
	sets. Don’t fall into the trap of using distinct just to be sure there
	are no duplicates; instead, take the time to understand the data you
	are working with so that you will know whether duplicates are
	possible.
*/


#The from clause defines the tables used by a query, along with the means of linking the tables together.

/*
	Four different types of tables meet this relaxed definition:
		• Permanent tables (i.e., created using the create table statement)
		• Derived tables (i.e., rows returned by a subquery and held in memory)
		• Temporary tables (i.e., volatile data held in memory)
		• Virtual tables (i.e., created using the create view statement)
*/

SELECT concat(cust.last_name, ', ',cust.first_name) full_name
FROM 
(	SELECT first_name, last_name, email
	FROM customer
	WHERE first_name = 'JESSIE'
) cust;



-- Temporal Tables

CREATE TEMPORARY TABLE actor_j
(	actor_id SMALLINT(5),
	first_name varchar(45),
	last_name varchar(45)
);

INSERT INTO actor_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

SELECT * FROM actor_j;


/*
	Most database servers also drop the temporary table when the session
	ends. The exception is Oracle Database, which keeps the definition
	of the temporary table available for future sessions.
*/


-- VIEW

CREATE VIEW cust_vw AS 
SELECT customer_id, first_name, last_name, active
FROM customer;

SELECT first_name, last_name
FROM cust_vw
WHERE active = 0;

SELECT customer.first_name, customer.last_name,
time(rental.rental_date) rental_time
FROM customer 
INNER JOIN rental 
ON customer.customer_id = rental.customer_id 
WHERE date(rental.rental_date) = '2005-06-14';

SELECT c.first_name, c.last_name,
	time(r.rental_date) rental_time
FROM customer c
	INNER JOIN rental r
	ON c.customer_id = r.customer_id
WHERE date(r.rental_date)= '2005-06-14';

SELECT c.first_name, c.last_name,
	time(r.rental_date) rental_time
FROM customer AS c
	INNER JOIN rental AS r
	ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';


-- The where clause is the mechanism for filtering out unwanted rows from your result set.

SELECT title
FROM film 
WHERE rating = 'G' AND rental_duration  >=7;


SELECT title, rating, rental_duration
FROM film
WHERE (rating = 'G' AND rental_duration  >=7)
OR (rating = 'PG-13' AND rental_duration  <4);


-- The GROUP BY and HAVING clauses


SELECT c.first_name, c.last_name, count(*)
FROM customer c
INNER JOIN rental r 
ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING count(*) >= 40;



-- The ORDER BY clause

SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r 
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY c.last_name;



SELECT c.first_name, c.last_name,
time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
 WHERE date(r.rental_date) = '2005-06-14'
ORDER BY c.last_name, c.first_name;


-- Ascending Versus Descending Sort Order

SELECT c.first_name, c.last_name,
time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY time(r.rental_date) desc;

-- Sorting via Numeric Placeholders

SELECT c.first_name, c.last_name,
time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r 
ON c.customer_id = r.customer_id
WHERE date(r.rental_date)= '2005-06-14'
ORDER BY 3 DESC;




# Exercise

#3.1

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
--ORDER BY 3, 2;
ORDER BY a.last_name, a.first_name;

#3.2

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
-- WHERE a.last_name IN ('WILLIAMS', 'DAVIS');
WHERE last_name = 'WILLIAMS'
OR last_name = 'DAVIS';

#3.3

SELECT DISTINCT customer_id
FROM rental
WHERE date(rental_date) = '2005-07-05'
ORDER BY customer_id;

#3.4 

SELECT c.email, r.return_date
FROM customer c 
INNER JOIN rental r 
ON c.customer_id = r.customer_id 
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 DESC;










