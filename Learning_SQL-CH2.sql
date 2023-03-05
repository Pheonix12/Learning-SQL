# Chapter 2
# Creating and Populating a Database. 

-- SEQUEL Executaion order 
/* 
 * 1. FROM
 * 2. JOIN
 * 3. WHERE
 * 4. GROUP BY
 * 5. HAVING 
 * 6. SELECT
 * 7. ORDER BY
 * 8. LIMIT/OFFSET
*/

-- Show database list.
show databases;

-- Selecting a database to use.
use SAKILA;


# NOW()Function is Built-in MySQL funtion that returns the current date and 
# Time.
select NOW();

select now()
from dual; 

-- View Supported Character.
show character set;


/*# Temporal Data
	Along with strings and numbers, you will almost certainly be working with information
	about dates and/or times. This type of data is referred to as temporal, and some examples
	of temporal data in a database include:
		• The future date that a particular event is expected to happen, such as shipping a
		  customer’s order
		• The date that a customer’s order was shipped
		• The date and time that a user modified a particular row in a table
		• An employee’s birth date
		• The year corresponding to a row in a yearly_sales fact table in a data warehouse
		• The elapsed time needed to complete a wiring harness on an automobile assembly
		  line
		  
	Type 		Default format 			Allowable values
	Date 		YYYY-MM-DD 				1000-01-01 to 9999-12-31
	Datetime 	YYYY-MM-DD HH:MI:SS 	1000-01-01 00:00:00 to 9999-12-31 23:59:59
	Timestamp 	YYYY-MM-DD HH:MI:SS 	1970-01-01 00:00:00 to 2037-12-31 23:59:59
	Year 		YYYY 					1901 to 2155
	Time 		HHH:MI:SS 				−838:59:59 to 838:59:59
*/


-- Table Person
CREATE TABLE person
(	person_id SMALLINT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color ENUM('BR','BL','GR'),
	birth_date DATE,
	street VARCHAR(30),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
	CONSTRAINT pk_person PRIMARY KEY (person_id)
);

-- Modyfing a table. 
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

-- Describes Table
desc person;



-- Table Favorite Food
CREATE TABLE favorite_food
(	person_id SMALLINT UNSIGNED,
	food VARCHAR(20),
	CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
	CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
	REFERENCES person (person_id)
);
/*
 
* Since a perosn can have more than one favorite food, it takes more than just the perosn_id
column to guarantee uniqueness in the table. This table, therefore, has a two-column 
primary key: person_id 
* The favorite_food table contains another type of constraint which is called a foreign key
constraint. This constraints the value of the person_id column in the favorite_food table to 
include only values found in the person table. With this constraints in place, i will not be able to 
add a row to the favorite_food table indicating that person_id 27 likes pizza if there isn't
already a row in the person table having a person_id of 27. 

*/

desc favorite_food;



# Insert data

INSERT INTO person
(person_id, fname, lname, eye_color, birth_date)
VALUES (null, 'William','Turner', 'BR', '1972-05-27');
select * from person;

select person_id, fname, lname, birth_date
from person
where person_id = 1;


select person_id, fname, lname, birth_date
from person
where lname =  'Turner';

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza');
INSERT INTO favorite_food (person_id, food)
VALUES (1, 'cookies');
INSERT INTO favorite_food (person_id, food)
VALUES (1, 'nachos');


select food 
from favorite_food 
where person_id = 1
order by food;

INSERT INTO person
(person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
VALUES (null, 'Susan','Smith', 'BL', '1975-11-02','23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date
from person;

-- Update information on a table.
UPDATE person
SET street = '1225 Tremont St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138'
WHERE person_id = 1;

-- Deleting data on a table.
delete 
from person
where person_id = 2;


show tables;

-- Drops Table from databases. 
DROP TABLE favorite_food;
DROP TABLE person;



