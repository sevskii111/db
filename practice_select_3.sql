-- Вертикальное соединение
SELECT
  name,
  composer
FROM
  tracks
WHERE
  composer = 'AC/DC'
UNION
ALL
SELECT
  name,
  composer
FROM
  tracks
WHERE
  composer = 'U2'
ORDER BY
  name;

SELECT
  composer,
  count(name)
FROM
  tracks
GROUP BY
  composer
HAVING
  composer IN ('AC/DC', 'U2');

-- Горизонтальное соединение
SELECT
  *
FROM
  tracks
  CROSS JOIN genres;

-- декартово произведение
SELECT
  *
FROM
  tracks,
  genres;

-- декартово произведение
SELECT
  *
FROM
  genres
  JOIN tracks;

-- декартово произведение
SELECT
  *
FROM
  genres
  INNER JOIN tracks ON genres.GenreId = tracks.GenreId;

-- внутреннее соединение
SELECT
  genres.GenreId,
  genres.Name Genre_name,
  trackid,
  tracks.Name Track_name
FROM
  genres
  INNER JOIN tracks ON genres.GenreId = tracks.GenreId;

SELECT
  g.GenreId,
  g.Name Genre_name,
  trackid,
  t.Name Track_name
FROM
  genres AS g
  INNER JOIN tracks AS t ON g.GenreId = t.GenreId;

SELECT
  *
FROM
  genres
  LEFT JOIN tracks ON genres.GenreId = tracks.GenreId;

--внешнее левое соединение
SELECT
  *
FROM
  genres;

INSERT INTO
  genres (GenreId, name)
VALUES
  (26, 'Соседский шансон');

SELECT
  *
FROM
  genres
  RIGHT JOIN tracks ON genres.GenreId = tracks.GenreId;

-- RIGHT and FULL OUTER JOINs are not currently supported
SELECT
  *
FROM
  genres
  LEFT JOIN tracks ON genres.GenreId = tracks.GenreId
UNION
ALL
SELECT
  *
FROM
  genres
  LEFT JOIN tracks ON genres.GenreId = tracks.GenreId
WHERE
  genres.GenreId IS NULL;

-- Используя таблицы БД chinook, выполните следующие запросы.
-- Перечислите названия альбомов группы Queen. 
SELECT
  GROUP_CONCAT(Title)
FROM
  albums
  INNER JOIN artists ON artists.Name = "Queen";

-- Выведите названия треков в формате AAC audio file и названия альбомов с исполнителями, откуда эти треки.
SELECT
  tracks.Name,
  tracks.Composer,
  albums.Title
FROM
  tracks
  INNER JOIN media_types ON media_types.Name = "AAC audio file"
  INNER JOIN albums ON albums.AlbumId = tracks.AlbumId;

-- Выведите наименования и исполнителей треков из плейлиста Heavy Metal Classic.
SELECT
  tracks.Name,
  tracks.Composer
FROM
  playlist_track
  INNER JOIN (
    SELECT
      Name,
      PlaylistId
    FROM
      playlists
    WHERE
      playlists.Name = "Heavy Metal Classic"
  ) AS playlists ON playlists.PlaylistId == playlist_track.PlaylistId
  INNER JOIN tracks ON tracks.TrackId = playlist_track.TrackId;

-- Кто купил трек Angel в исполнении группы Aerosmith (Steven Tyler)? Выведите имя, фамилию, страну и город покупателей.
SELECT
  FirstName,
  LastName,
  Country,
  City
FROM
  invoice_items
  INNER JOIN (
    SELECT
      *
    FROM
      tracks
    WHERE
      tracks.Name = "Angel"
      AND tracks.Composer LIKE "%Steven Tyler%"
  ) AS tracks ON tracks.TrackId = invoice_items.TrackId
  INNER JOIN invoices ON invoice_items.InvoiceId = invoices.InvoiceId
  INNER JOIN customers ON customers.CustomerId = invoices.CustomerId;