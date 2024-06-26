/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

	SELECT DISTINCT(title) AS 'Name_Movies'
	FROM film;

/*2. Muestra los nombres de todas las películas que 
tengan una clasificación de "PG-13".*/

	SELECT title AS 'Name_Movies', rating
	FROM film
	WHERE rating = "PG-13";

/*3. Encuentra el título y la descripción de todas las 
películas que contengan la palabra "amazing" en su descripción.*/

	SELECT title AS 'Name_Movies', description
	FROM film
	WHERE description LIKE '%amazing%';

/*4. Encuentra el título de todas las películas que tengan una 
duración mayor a 120 minutos.*/

	SELECT title AS 'Name_Movies', length AS 'Movie_length'
    FROM film
	WHERE length > 120;

/*5. Recupera los nombres de todos los actores.*/

	SELECT first_name, last_name
    FROM actor;
     
/* 6. Encuentra el nombre y apellido de los actores que 
tengan "Gibson" en su apellido.*/
	
    SELECT first_name, last_name
    FROM actor
    WHERE last_name LIKE 'Gibson';
	
/* 7. Encuentra los nombres de los actores que tengan 
un actor_id entre 10 y 20.*/
	
	SELECT actor_id AS 'Actor_Id_Number', first_name, last_name
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20;

/* 8. Encuentra el título de las películas en la tabla film que no sean ni 
"R" ni "PG-13" en cuanto a su clasificación.*/

	SELECT title AS 'Name_Movies', rating
    FROM film
	WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13";
    
/* 9. Encuentra la cantidad total de películas en cada clasificación 
de la tabla film y muestra la clasificación junto con el recuento.*/
	
    SELECT DISTINCT rating, COUNT(*) AS 'Total_Movies'
    FROM film
    GROUP BY rating;
    
/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente
 y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
 
	SELECT customer.customer_id, 
			customer.first_name, 
			customer.last_name, 
			COUNT(rental.rental_id) AS 'Rental_Movies'
    FROM customer
    INNER JOIN rental
		ON customer.customer_id = rental.customer_id
	GROUP BY customer.customer_id;
            
	-- Opción CTE
    WITH Customer_Rental_Movies AS (
			SELECT customer.customer_id, 
					customer.first_name, 
					customer.last_name, 
					COUNT(rental.rental_id) AS 'Rental_Movies'
			FROM customer
			INNER JOIN rental ON customer.customer_id = rental.customer_id
			GROUP BY customer.customer_id
								)
	SELECT *
    FROM Customer_Rental_Movies;
    
    
/* 11. Encuentra la cantidad total de películas alquiladas por categoría 
y muestra el nombre de la categoría junto con el recuento de alquileres.*/

-- conectar las tablas por el id en común desde film hasta rental

	SELECT category.name AS 'Category_Name',
			COUNT(rental.rental_id) AS 'Rental_Number'
    FROM category
		INNER JOIN film_category ON category.category_id = film_category.category_id
        INNER JOIN film ON film_category.film_id = film.film_id
        INNER JOIN inventory ON inventory.film_id = film.film_id
		INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
	GROUP BY category.name;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación 
de la tabla film y muestra la clasificación junto con el promedio de duración.*/

	SELECT rating, AVG(length) AS 'Average_Length_Film'
    FROM film
    GROUP BY rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película 
con title "Indian Love".*/

SELECT film.title AS 'Name_Movie',
		actor.first_name AS 'First_name_actor', 
		actor.last_name AS 'Last_name_actor'
FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
	INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

/*14. Muestra el título de todas las películas que contengan la palabra 
"dog" o "cat" en su descripción.*/

	SELECT title AS 'Name_Movies', description
	FROM film
	WHERE description LIKE '%dog%' OR description LIKE '%cat%';

/* 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.*/
	
    SELECT actor.actor_id, 
			actor.first_name, 
			actor.last_name
    FROM actor
	LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
    WHERE film_actor.actor_id IS NULL;
    
/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
	
    SELECT title AS 'Name_Movies', release_year
    FROM film
    WHERE release_year BETWEEN 2005 AND 2010;

/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

	SELECT film.title AS 'Name_Movie', 
			category.name AS 'Renge_Movies'
	FROM film
		INNER JOIN film_category ON film.film_id = film_category.film_id
		INNER JOIN category ON film_category.category_id = category.category_id
	WHERE category.name = 'Family';

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

	SELECT actor.first_name, 
			actor.last_name,
            COUNT(film_actor.film_id) AS 'Total_Movies'
    FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id,
			actor.first_name, 
			actor.last_name
    HAVING COUNT(film_actor.film_id) > 10;
    
/* 19. Encuentra el título de todas las películas que son "R" y tienen una 
duración mayor a 2 horas en la tabla film.*/

	SELECT title AS 'Name_Movie', 
			length AS 'Duration', 
			rating
    FROM film
    WHERE rating = 'R' AND length > 120;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración 
superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

	SELECT category.name AS 'Renge_Movies', 
			AVG(film.length) AS 'Average_Length_Film'
	FROM film
		INNER JOIN film_category ON film.film_id = film_category.film_id
		INNER JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
	HAVING Average_Length_Film > 120;
	
    
/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el 
nombre del actor junto con la cantidad de películas en las que han actuado.*/

	SELECT actor.first_name, 
			actor.last_name,
            COUNT(film_actor.film_id) AS 'Total_Movies'
    FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id,
			actor.first_name, 
			actor.last_name
    HAVING COUNT(film_actor.film_id) >= 5;

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días 
y luego selecciona las películas correspondientes.*/

-- Creo que se puede valorar, a no ser que la variable no diga eso
	SELECT film.title AS 'Name_Movie', 
			rental_duration AS 'Rental_days'
	FROM film
		JOIN inventory ON film.film_id = inventory.film_id
	WHERE inventory.inventory_id IN (
							SELECT rental.inventory_id
							FROM rental
							WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5
									);
                                    
-- Normal, sin subcon
	SELECT DISTINCT title AS 'Name_Movie',
					DATEDIFF(rental.return_date, rental.rental_date) AS 'Days_Rented'
	FROM film
		JOIN inventory ON film.film_id = inventory.film_id
		JOIN rental ON inventory.inventory_id = rental.inventory_id
	WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5;
							

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en 
ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar 
los actores que han actuado en películas de la categoría "Horror" 
y luego exclúyelos de la lista de actores.*/

SELECT actor.first_name, 
		actor.last_name
FROM actor
WHERE actor.actor_id NOT IN (
			SELECT DISTINCT film_actor.actor_id
			FROM film_actor
				INNER JOIN film_category ON film_actor.film_id = film_category.film_id
				INNER JOIN category ON film_category.category_id = category.category_id
			WHERE category.name = 'Horror'
							);


/* BONUS */

/* 24. BONUS: Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla film.*/

	WITH Comedy_Movies_180 AS (
			SELECT film.title, category.name, film.length
			FROM film
				INNER JOIN film_category ON film.film_id = film_category.film_id
				INNER JOIN category ON film_category.category_id = category.category_id
			WHERE length > 180 AND category.name = 'Comedy'
							)
							
	SELECT title AS 'Name_Movie', 
			name AS 'Renge_Movies', 
			length AS 'Movie_length'
	FROM Comedy_Movies_180;
    
/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. 
La consulta debe mostrar el nombre y apellido de los actores y el número de películas 
en las que han actuado juntos.*/

-- No fue facil, le dije al chagpt que me ayudara, pero cambian los datos segun que!
	
    SELECT a1.first_name AS 'Actor1_first_name', a1.last_name AS 'Actor1_last_name',
		   a2.first_name AS 'Actor2_first_name', a2.last_name AS 'Actor2_last_name',
		   COUNT(*) AS 'Movies_together'
	FROM film_actor fa1
		JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
		JOIN actor a1 ON fa1.actor_id = a1.actor_id
		JOIN actor a2 ON fa2.actor_id = a2.actor_id
	GROUP BY a1.first_name, a1.last_name, 
			a2.first_name, a2.last_name
	HAVING COUNT(*) > 0
	ORDER BY Movies_together DESC;
            