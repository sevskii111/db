SELECT *
  FROM tracks;

SELECT name,
       composer
  FROM tracks;

SELECT DISTINCT composer
  FROM tracks;

SELECT name Наименование,
       composer AS Исполнитель
  FROM tracks;

SELECT name
  FROM tracks
 WHERE composer = 'AC/DC';

SELECT *
  FROM tracks
 WHERE unitprice != 0.99;

SELECT name,
       composer
  FROM tracks
 WHERE composer IN ('AC/DC', 'U2');

SELECT *
  FROM tracks
 WHERE milliseconds BETWEEN 0 AND 10000;

SELECT *
  FROM tracks
 WHERE name LIKE 'my %';

SELECT *
  FROM tracks
 WHERE name REGEXP '^My .*';

SELECT name Наименование,
       composer AS Исполнитель,
       bytes Байт
  FROM tracks
 WHERE composer IS NOT NULL
 ORDER BY Исполнитель,
          Байт DESC;

SELECT name,
       composer,
        8 * bytes / (milliseconds / 1000) / 1024 AS bps
  FROM tracks
 ORDER BY bps;
 


-- Используя таблицу customers из БД chinook, выполните следующие запросы. 
-- Из каких стран покупатели? Выведите список стран без повторений в алфавитном порядке. 
SELECT DISTINCT country
 FROM customers 
 ORDER BY country;

-- Выведите покупателей из Бразилии. Указать имя и фамилию. Отсортировать по фамилии.
SELECT firstname, lastname 
FROM customers 
where country = "Brazil" 
ORDER BY lastname;

-- У какого города почтовый индекс 11230?
SELECT billingcity 
from invoices 
WHERE billingpostalcode = "11230" 
LIMIT 1;

-- Выведите всех покупателей с почтой gmail. Указать имя, фамилию и почту.
--SELECT firstname, lastname, email FROM customers WHERE email REGEXP "@gmail\.com$"; 😢
SELECT firstname, lastname, email 
FROM customers 
WHERE email like "%@gmail.com";

-- Выведите имя, фамилию и компанию корпоративных покупателей, отсортированных по наименованию компании.
SELECT firstname, lastname, company 
from customers 
WHERE company IS NOT NULL 
ORDER BY company;

-- Выведите имя, фамилию, город и страну всех европейских покупателей. Отсортируйте по стране, внутри - по городу, внутри города - по фамилии.
SELECT firstname, lastname, city, country 
FROM customers 
WHERE country not in ("Brazil", "Canada", "USA", "Australia", "Argentina", "Chili", "India") 
ORDER BY country, city, lastname;
