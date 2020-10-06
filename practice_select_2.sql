-- Групповые операции по всей таблице

SELECT count( * ) AS Количество_треков
FROM tracks;

SELECT count( composer ) AS Количество_исполнителей
FROM tracks;

SELECT count(DISTINCT composer) AS Количество_исполнителей
FROM tracks;

SELECT sum(bytes),
  round(avg(bytes), 2),
  min(bytes),
  max(bytes)
FROM tracks;

SELECT sum(bytes) Сумма,
  round(avg(bytes), 2) Среднее,
  min(bytes) Минимум,
  max(bytes) Максимум
FROM tracks;

-- Группировка

SELECT unitprice Цена,
  count( * ) Количество
FROM tracks
GROUP BY unitprice;

SELECT composer,
  count(name),
  group_concat(name)
FROM tracks
GROUP BY composer;

SELECT composer,
  count( * ) AS Количество_треков-- 5
FROM tracks-- 1
WHERE composer IS NOT NULL-- 2
GROUP BY composer-- 3
HAVING count( * ) >= 20-- 4
ORDER BY Количество_треков DESC;-- 6

-- Используя таблицу customers из БД chinook, выполните следующие запросы.
--1) Сколько покупателей из каждой страны? Отсортируйте страны в порядке убывания покупателей.
SELECT Country as "Страна", COUNT(CustomerId) as "Колличество_покупателей"
from customers
GROUP BY Country
ORDER BY COUNT(CustomerId) DESC;
--2) Для тех стран, у которых покупатели больше чем из одного города, перечислите эти города через зяпятую.  
SELECT DISTINCT group_concat(City) as "Города"
from (
SELECT City, Country
  from customers
  WHERE Country in (Select Country
  from customers
  GROUP BY Country
  HAVING COUNT(DISTINCT City) > 1
));
--3) Покупатели из скольких штатов представлены в таблице? Выведите одну цифру.
SELECT
  COUNT(DISTINCT State) as "Колличество шататов"
from customers;
--4) Найдите страны, которые делятся на штаты. Укажите для этих стран количество штатов, откуда покупатели. Отсортируйте страны в порядке увеличения количества штатов.
SELECT Country as "Страна", COUNT(State) as "Колличество штатов" from customers
WHERE State IS NOT NULL
GROUP BY Country
ORDER BY COUNT(State);
--5) Сколько покупателей всего и сколько из них не указало компанию. Выведите две цифры.
SELECT
  COUNT(CustomerId) as "Покупателей",
  (COUNT(CustomerId) - COUNT(Company)) as "Покупатлей не указало компанию"
from customers;




