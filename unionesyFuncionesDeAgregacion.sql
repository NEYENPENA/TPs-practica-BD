/* Microdesafio - paso 1 
Utilizando la base de datos de películas queremos conocer, por un lado, los títulos y el
nombre del género de todas las series de la base de datos. Por otro, necesitamos listar los
títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada
uno de ellos.*/

SELECT series.title AS "titulo serie", genres.name, episodes.title AS "titulo episodio", actors.first_name, actors.last_name
FROM series
INNER JOIN genres ON genres.id = series.genre_id
INNER JOIN seasons ON seasons.serie_id = series.id
INNER JOIN episodes ON episodes.season_id = seasons.id
INNER JOIN actor_episode ON actor_episode.episode_id = episodes.id
INNER JOIN actors ON actors.id = actor_episode.actor_id
ORDER BY first_name

/* Microdesafio - paso 2
Para nuestro próximo desafío necesitamos obtener a todos los actores o actrices (mostrar
nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada
actor/actriz. */

SELECT DISTINCT actors.first_name, actors.last_name
FROM actors
INNER JOIN actor_movie ON actor_movie.actor_id = actors.id
INNER JOIN movies ON movies.id = actor_movie.movie_id
WHERE movies.title LIKE "%guerra%galaxias%"

/* Microdesafio - paso 3 
Debemos listar los títulos de cada película con su género correspondiente. En el caso de
que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda
podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista.*/

SELECT movies.id, movies.title, COALESCE (genres.name, "no tiene genero") AS genero
FROM movies
LEFT JOIN genres ON genres.id = movies.genre_id

/* Micro desafío - Paso 4:
Necesitamos mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
la particularidad de que a la columna que mostrará dicha cantidad la renombraremos: “Duración”.*/

SELECT series.title, DATEDIFF(end_date, release_date) AS "Duración"
FROM series

/* Micro desafío - Paso 5:
Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres.*/
SELECT *
FROM actors 
WHERE length (first_name) > 6
ORDER BY first_name

/*Debemos mostrar la cantidad total de los episodios guardados en la base de datos.*/
SELECT COUNT(id) AS "Episodios totales"
FROM episodes

/* Para el siguiente desafío nos piden que obtengamos el título de todas las series y el total
de temporadas que tiene cada una de ellas. */
SELECT series.title, COUNT(seasons.id) AS "total temporadas"
FROM series
INNER JOIN seasons ON seasons.serie_id = series.id
GROUP BY series.title

/* Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor
o igual a 3. */
SELECT genres.name AS genero, COUNT(movies.id) AS total
FROM genres
INNER JOIN movies ON movies.genre_id = genres.id
group BY genres.name
HAVING COUNT(movies.id) >= 3