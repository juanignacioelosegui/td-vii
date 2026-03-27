--	Ejercicio 1
SELECT * FROM INVOICE	--	Elegir todas las columnas de la tabla 
WHERE billing_country IN ('Germany', 'Italy', 'France') -- antes que poner billing_country = '' muchas veces
ORDER BY billing_city;	-- ASC por default

--	Ejercicio 2 (está mal)
SELECT t.name	--	Agarrar las columnas que me piden
	, t.album_id
	, t.composer
	, g.name
FROM track t	--	
	, genre g;

--	Ejercicio 3
SELECT t.name	--	Agarrar las columnas que me piden
	, t.album_id
	, t.composer
	, g.name
FROM track t
INNER JOIN genre g
ON t.genre_id = g.genre_id
INNER JOIN media_type m
ON m.media_type_id = t.media_type_id;

--	Ejercicio 4
SELECT ar.name	--	Agarrar nombres
FROM artist ar	--	de los artistas
LEFT JOIN album al ON ar.artist_id = al.artist_id 	-- agarro de todos, los que NO tienen
WHERE al.artist_id IS NULL;

--	Ejercicio 5
SELECT ar.name, al.title
FROM artist ar
LEFT JOIN album al ON ar.artist_id = al.artist_id;

--	Ejercicio 6
SELECT al.title, ar.name
FROM album al
RIGHT OUTER JOIN artist ar ON ar.artist_id = al.artist_id;

--	Ejercicio 7
SELECT * FROM track t
WHERE album_id = (SELECT album_id 
					FROM album 
					WHERE title = 'Led Zeppelin I')
	
--	Ejercicio 8
SELECT t.name, t.composer
FROM track t WHERE t.track_id NOT IN (SELECT il.track_id FROM invoice_line il)

--	Ejercicio 9
WITH precio_playlist AS (
	SELECT pl.playlist_id playlist, pl.name nombre_playlist,
	SUM(t.UnitPrice) precio
	FROM playlist pl
	INNER JOIN playlist_track pt
	ON pl.playlist_id = pt.playlist_id
	INNER JOIN track t
	ON t.track_id = pt.track_id
	GROUP BY playlist, nombre_playlist	
)

SELECT * precio_playlist
WHERE precio = (SELECT MAX(precio) FROM precio_playlist)