-- Групповые операции по всей таблице
SELECT
  count(*) AS Количество_треков
FROM
  tracks;

SELECT
  count(composer) AS Количество_исполнителей
FROM
  tracks;

SELECT
  count(DISTINCT composer) AS Количество_исполнителей
FROM
  tracks;

SELECT
  sum(bytes),
  round(avg(bytes), 2),
  min(bytes),
  max(bytes)
FROM
  tracks;

SELECT
  sum(bytes) Сумма,
  round(avg(bytes), 2) Среднее,
  min(bytes) Минимум,
  max(bytes) Максимум
FROM
  tracks;

-- Группировка
SELECT
  unitprice Цена,
  count(*) Количество
FROM
  tracks
GROUP BY
  unitprice;

SELECT
  composer,
  count(name),
  GROUP_CONCAT(name)
FROM
  tracks
GROUP BY
  composer;

SELECT
  composer,
  count(*) AS Количество_треков -- 5
FROM
  tracks -- 1
WHERE
  composer IS NOT NULL -- 2
GROUP BY
  composer -- 3
HAVING
  count(*) >= 20 -- 4
ORDER BY
  Количество_треков DESC;

-- 6
-- Используя таблицу customers из БД chinook, выполните следующие запросы.
--1) Сколько покупателей из каждой страны? Отсортируйте страны в порядке убывания покупателей.
SELECT
  Country AS "Страна",
  COUNT(CustomerId) AS "Колличество_покупателей"
FROM
  customers
GROUP BY
  Country
ORDER BY
  COUNT(CustomerId) DESC;

--2) Для тех стран, у которых покупатели больше чем из одного города, перечислите эти города через зяпятую.  
SELECT
  DISTINCT GROUP_CONCAT(City) AS "Города"
FROM
  (
    SELECT
      City,
      Country
    FROM
      customers
    WHERE
      Country IN (
        SELECT
          Country
        FROM
          customers
        GROUP BY
          Country
        HAVING
          COUNT(DISTINCT City) > 1
      )
  );

--3) Покупатели из скольких штатов представлены в таблице? Выведите одну цифру.
SELECT
  COUNT(DISTINCT State) AS "Колличество шататов"
FROM
  customers;

--4) Найдите страны, которые делятся на штаты. Укажите для этих стран количество штатов, откуда покупатели. Отсортируйте страны в порядке увеличения количества штатов.
SELECT
  Country AS "Страна",
  COUNT(State) AS "Колличество штатов"
FROM
  customers
WHERE
  State IS NOT NULL
GROUP BY
  Country
ORDER BY
  COUNT(State);

--5) Сколько покупателей всего и сколько из них не указало компанию. Выведите две цифры.
SELECT
  COUNT(CustomerId) AS "Покупателей",
  (COUNT(CustomerId) - COUNT(Company)) AS "Покупатлей не указало компанию"
FROM
  customers;