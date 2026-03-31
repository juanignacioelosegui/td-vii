/*
	#####################
	Juan Ignacio Elosegui
	#####################
*/

--	Ejercicio 1
SELECT * FROM EMPLOYEE;

--	Ejercicio 2
SELECT DISTINCT billing_city FROM invoice;
/* DISTINCT para que no haya repetidos. */

--	Ejercicio 3
SELECT e.first_name
	, e.last_name
	, e.state
FROM employee e 
WHERE city = 'Calgary';

--	Ejercicio 4
SELECT t.name
	, t.milliseconds
	, t.bytes
FROM track t
WHERE t.milliseconds > 500000;

--	Ejercicio 5
SELECT * FROM invoice i
WHERE i.billing_country IN ('Germany', 'France', 'Italy')
ORDER BY i.billing_city ASC;

--	Ejercicio 6
SELECT DISTINCT billing_city FROM invoice
WHERE billing_city LIKE 'B%'
ORDER BY billing_city DESC;

--	Ejercicio 7
SELECT DISTINCT t.name
	, t.album_id
	, t.composer
	, g.name
FROM track t
	, genre g
WHERE t.genre_id = g.genre_id;

--	Ejercicio 8
SELECT DISTINCT t.name
	, t.album_id
	, t.composer
	, g.name
	, m.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
JOIN media_type m ON t.media_type_id = m.media_type_id;
/* Los JOIN hacen lo mismo que el punto 7, sólo que más legible */

--	Ejercicio 9
SELECT g.name
	, COUNT(t.track_id) AS numCounts
FROM genre g
LEFT JOIN track t ON g.genre_id = t.genre_id
GROUP BY g.genre_id, g.name
ORDER BY numCounts DESC;

--	Ejercicio 10
SELECT DISTINCT ar.name FROM artist ar
LEFT JOIN album al ON ar.artist_id = al.artist_id
WHERE al.album_id IS NULL;