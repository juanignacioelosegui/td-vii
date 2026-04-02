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

--	Ejercicio 11
SELECT ar.name
	, COUNT(t.track_id) AS cantTracks
FROM artist ar
JOIN track t ON ar.name = t.composer
WHERE ar.name LIKE 'M%'
GROUP BY ar.artist_id, ar.name
HAVING COUNT(t.track_id) > 25
ORDER BY cantTracks DESC;

--	Ejercicio 12
SELECT ar.name
	, al.title
FROM artist ar
INNER JOIN album al ON ar.artist_id = al.artist_id;
/* Muestro únicamente los artistas que tienen álbumes */

--	Ejercicio 13
SELECT al.title
	, ar.name
FROM album al
INNER JOIN artist ar ON al.artist_id = ar.artist_id;

--	Ejercicio 14
WITH playlist_precio AS (
    SELECT p.playlist_id, p.name, SUM(t.unit_price) AS PrecioTotal
    FROM playlist p
    JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
    JOIN track t ON pt.track_id = t.track_id
    GROUP BY p.playlist_id, p.name
)
SELECT * FROM playlist_precio
WHERE PrecioTotal = (SELECT MAX(PrecioTotal) FROM playlist_precio);

--	Ejercicio 15
WITH albumesPorPlaylist AS (
	SELECT p.playlist_id, COUNT(DISTINCT t.album_id) AS cantAlbumes
	FROM playlist p
	JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
	JOIN track t ON pt.track_id = t.track_id
	GROUP BY p.playlist_id
)

SELECT AVG(cantAlbumes) FROM albumesPorPlaylist;

--	Ejercicio 16
SELECT * 
FROM track
WHERE album_id = (
	SELECT album_id
	FROM album 
	WHERE album.title = 'Led Zeppelin I');

--	Ejercicio 17
SELECT DISTINCT p.name
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
WHERE p.playlist_id NOT IN (
	/* crear conjunto de playlists prohibidas */
    SELECT pt2.playlist_id
    FROM playlist_track pt2
	/* qué canciones NO queremos? */
    WHERE pt2.track_id IN (
        SELECT t.track_id
        FROM track t
        JOIN album al ON t.album_id = al.album_id
        JOIN artist ar ON al.artist_id = ar.artist_id
        WHERE ar.name IN ('AC/DC', 'Audioslave', 'Chris Cornell')
    )
);

--	Ejercicio 18
SELECT DISTINCT t1.name
	, t1.composer 
FROM track t1
WHERE t1.track_id NOT IN (
	SELECT t2.track_id
	FROM track t2
	JOIN invoice_line il ON t2.track_id = il.track_id
);

--	Ejercicio 19
SELECT t1.name, t1.composer 
/* no uso DISTINCT pq EXCEPT ya los filtra a los duplicados */
FROM track t1
EXCEPT /* excepto las tuplas que cumplan con: */
/* selecciono tuplas que fueron facturadas */
SELECT t2.name, t2.composer
FROM track t2
JOIN invoice_line il ON t2.track_id = il.track_id;

--	Ejercicio 20
WITH track_info AS (
    SELECT t.track_id,
           ar.name AS ArtistName,
           al.title AS AlbumTitle,
           t.name AS TrackName,
           LENGTH(t.name) AS LargoNombre
    FROM track t
    JOIN album al ON t.album_id = al.album_id
    JOIN artist ar ON al.artist_id = ar.artist_id
)
SELECT track_id, ArtistName, AlbumTitle, TrackName
FROM track_info
WHERE LargoNombre = (SELECT MAX(LargoNombre) FROM track_info);