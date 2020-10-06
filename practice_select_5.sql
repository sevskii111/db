/* 1) Найти всех артистов без альбомов.
 Вывести их имена/названия групп.
 */
SELECT
    Name
FROM
    artists
    LEFT JOIN albums USING(ArtistId)
WHERE
    Title IS NULL
ORDER BY
    Name;

/* Второй вариант запроса с EXCEPT
 */
SELECT
    Name
FROM
    artists
EXCEPT
SELECT
    DISTINCT Name
FROM
    albums
    INNER JOIN artists USING(ArtistId)
ORDER BY
    Name;

/* 2) Отнести каждый трек к соответствующей категории в зависимости от размера файла.
 */
SELECT
    name,
    bytes,
    CASE
        WHEN bytes < 1000000 THEN '0'
        WHEN bytes > 1000000
        AND bytes < 10000000 THEN '1'
        ELSE '2'
    END bytes_cat
FROM
    tracks
ORDER BY
    bytes_cat;

/* Второй вариант запроса с IIF()
 */
SELECT
    name,
    bytes,
    IIF(
        bytes < 1000000,
        '0',
        IIF(
            bytes > 1000000
            AND bytes < 10000000,
            '1',
            '2'
        )
    ) bytes_cat
FROM
    tracks
ORDER BY
    bytes_cat;

-- The iif() function was introduced in SQLite 3.32.0, which was released on 22 May 2020.
/*  Задания.
 1) Вывести треки (id, наименование и исполнителя), на которые не было заказов.
 Отсортируйте по id трека. Выполните запрос двумя или более способами.
 
 2) Найдите наиболее покупаемые треки в Германии. 
 Выведите наименование, исполнителей и количество покупок только тех треков, которые хоть раз покупались.
 Отсортируйте по количеству покупок по убыванию, внутри - по исполнителю (null в конце группы),
 внутри исполнителя - по наименованию трека.
 
 3) Отнесите каждый трек к одной из трех категорий 
 в зависимости от его продолжительности: менее 3 минут, от 3 до 7 минут и более 7 минут.
 Посчитайте количество треков и среднюю продолжительность трека в каждой категории.
 */