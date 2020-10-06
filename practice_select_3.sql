-- Вертикальное соединение

SELECT name,
       composer
  FROM tracks
 WHERE composer = 'AC/DC'
UNION ALL
SELECT name,
       composer
  FROM tracks
 WHERE composer = 'U2'
ORDER BY name;

SELECT composer,
       count(name) 
  FROM tracks
 GROUP BY composer
HAVING composer IN ('AC/DC', 'U2');
 
-- Горизонтальное соединение

SELECT *
  FROM tracks
       CROSS JOIN
       genres;-- декартово произведение

SELECT *
  FROM tracks,
       genres;-- декартово произведение

SELECT *
  FROM genres
       JOIN
       tracks;-- декартово произведение

SELECT *
  FROM genres
       INNER JOIN
       tracks ON genres.GenreId = tracks.GenreId;-- внутреннее соединение

SELECT genres.GenreId,
       genres.Name Genre_name,
       trackid,
       tracks.Name Track_name
  FROM genres
       INNER JOIN
       tracks ON genres.GenreId = tracks.GenreId;

SELECT g.GenreId,
       g.Name Genre_name,
       trackid,
       t.Name Track_name
  FROM genres AS g
       INNER JOIN
       tracks AS t ON g.GenreId = t.GenreId;

SELECT *
  FROM genres
       LEFT JOIN
       tracks ON genres.GenreId = tracks.GenreId; --внешнее левое соединение

SELECT *
  FROM genres;

INSERT INTO genres (GenreId, name)
       VALUES (26, 'Соседский шансон');

SELECT *
  FROM genres
       RIGHT JOIN
       tracks ON genres.GenreId = tracks.GenreId;
       
-- RIGHT and FULL OUTER JOINs are not currently supported

SELECT *
  FROM genres
       LEFT JOIN
       tracks ON genres.GenreId = tracks.GenreId
UNION ALL
SELECT *
  FROM genres
       LEFT JOIN
       tracks ON genres.GenreId = tracks.GenreId
 WHERE genres.GenreId IS NULL;-- FULL OUTER JOIN

/* Используя таблицы БД chinook, выполните следующие запросы.
1) Перечислите названия альбомов группы Queen. 
2) Выведите названия треков в формате AAC audio file и названия альбомов с исполнителями, откуда эти треки.
3) Выведите наименования и исполнителей треков из плейлиста Heavy Metal Classic.
4) Кто купил трек Angel в исполнении группы Aerosmith (Steven Tyler)? 
   Выведите имя, фамилию, страну и город покупателей.
*/





