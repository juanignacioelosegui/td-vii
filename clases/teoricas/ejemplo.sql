SELECT
    i.invoice_id,
    ,i.total
    ,c.first_name

FROM invoice i, customer customer
WHERE i.customer_id = c.customer_id
ORDER BY total desc
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY

-- Ejercicio Integrador 1
SELECT
    t.name
    , t.milliseconds
FROM track t
    , public.playlist_track plt
    , public.playlist pl
WHERE t.track_id = plt.track_id
    AND plt.playlist_id = pl.playlist_id
    AND pl.name = 'Classical'
    AND t.composer IS NOT NULL
ORDER BY t.milliseconds DESC LIMIT 5

-- Ejercicio Integrador 2
SELECT t.name AS trackName
    , t.composer
    , al.title
    , ar.name AS artistName
FROM track t
    , album al
    , artist ar
    , invoice_line il
    , invoice i
WHERE '2021-03-25 16:11:35' > i.invoice_date
AND il.invoice_id = i.invoice ID
-- completar