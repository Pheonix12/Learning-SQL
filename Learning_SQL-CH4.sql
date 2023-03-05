/*
  		Two-condition evaluation using or
		Intermediate result 		Final result
		WHERE true OR true 				true
		WHERE true OR false 			true
		WHERE false OR true 			true
		WHERE false OR false 			false
		
		
		Three-condition evaluation using and, or
		Intermediate result 						Final result
		WHERE (true OR true) AND true 					true
		WHERE (true OR false) AND true 					true
		WHERE (false OR true) AND true 					true
		WHERE (false OR false) AND true 				false
		WHERE (true OR true) AND false 					false
		WHERE (true OR false) AND false 				false
		WHERE (false OR true) AND false 				false
		WHERE (false OR false) AND false 				false
		
		
		
		Three-condition evaluation using and, or, and not
		Intermediate result 						Final result
		WHERE NOT (true OR true) AND true 				false
		WHERE NOT (true OR false) AND true 				false
		WHERE NOT (false OR true) AND true 				false
		WHERE NOT (false OR false) AND true 			true
		WHERE NOT (true OR true) AND false 				false
		WHERE NOT (true OR false) AND false 			false
		WHERE NOT (false OR true) AND false 			false
		WHERE NOT (false OR false) AND false 			false
		
		
Building a Condition:	
A condition is made up of one or more expressions combined with one or more operators. 
An expression can be any of the following:
	• A number
	• A column in a table or view
	• A string literal, such as 'Maple Street'
	• A built-in function, such as concat('Learning', ' ', 'SQL')
	• A subquery
	• A list of expressions, such as ('Boston', 'New York', 'Chicago')
The operators used within conditions include:
	• Comparison operators, such as =, !=, <, >, <>, like, in, and between
	• Arithmetic operators, such as +, −, *, and /
	
	
 */


# Equality Condition 
/*A large percentage of the filter conditions that you write or come across will be of the
form 'column = expression' as in:
		title = 'RIVER OUTLAW'
		fed_id = '111-11-1111'
		amount = 375.25
		film_id = (SELECT film_id FROM film WHERE title = 'RIVER OUTLAW')
Conditions such as these are called equality conditions because they equate one
expression to another. The first three examples equate a column to a literal (two
strings and a number), and the fourth example equates a column to the value
returned from a subquery.
*/


SELECT c.email
FROM customer c
	INNER JOIN rental r 
	ON c.customer_id = r.customer_id 
WHERE date(r.rental_date) = '2005-06-14';


#Inequality conditions


SELECT c.email
FROM customer c
	INNER JOIN rental r 
	ON c.customer_id = r.customer_id 
WHERE date(r.rental_date) <> '2005-06-14';




























