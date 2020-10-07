/*  Создать базу данных сотрудников организации.
    Организация состоит из отделов.
    Каждый сотрудник относится к одному отделу.
*/

CREATE TABLE IF NOT EXISTS departments (
    dep_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name     TEXT
);
-- SQLite supports PRIMARY KEY, UNIQUE, NOT NULL, and CHECK column constraints.

INSERT INTO departments (name)
VALUES  ('Администрация'),
        ('Отдел главного конструктора'),
        ('Сборочный цех'),
        ('Какой-то отдел');

SELECT *
  FROM departments;

SELECT rowid, dep_id, name
  FROM departments;-- 9,223,372,036,854,775,807

DELETE FROM departments
      WHERE name = 'Какой-то отдел';

INSERT INTO departments (name)
VALUES ('Бухгалтерия');

INSERT INTO departments (dep_id, name)
VALUES (4, 'Хозяйственный отдел');

INSERT INTO departments (rowid, name)
VALUES (100, 'Отдел снабжения');

DROP TABLE departments;
 
CREATE TABLE IF NOT EXISTS employees (
    employee_id    integer     PRIMARY KEY,
    first_name     text        NOT NULL,
    last_name      text        NOT NULL,
    dep_id         integer,
    FOREIGN KEY (dep_id)
       REFERENCES departments (dep_id)
           ON UPDATE CASCADE
           ON DELETE CASCADE
);
/*
SET NULL
SET DEFAULT
RESTRICT
NO ACTION == RESTRICT
CASCADE
*/
INSERT INTO employees (employee_id, first_name, last_name, dep_id)
VALUES  (215, 'Анна', 'Сидорова', 1),
        (222, 'Жанна', 'Иванова', 3),
        (249, 'Эльвира', 'Кузнецова', 3),
        (251, 'Лидия', 'Петрова', 4),
        (288, 'Ольга', 'Васильева', 4);
        
SELECT *
  FROM employees;

INSERT INTO employees (employee_id, first_name, last_name, dep_id)
VALUES  (300, 'Груша', 'Зимняя', 10);

UPDATE departments
SET dep_id = 40
WHERE name = 'Хозяйственный отдел';

DELETE FROM departments
WHERE dep_id = 40;

INSERT INTO departments
VALUES (4, 'Хозяйственный отдел');

/* Добавим в таблицу employees новое поле*/
DROP TABLE employees;

CREATE TABLE IF NOT EXISTS employees (
    employee_id    integer     PRIMARY KEY,
    first_name     text        NOT NULL,
    last_name      text        NOT NULL,
    dep_id         integer,
    phone          text        UNIQUE 
                               CHECK (length(phone) = 10),
    FOREIGN KEY (dep_id)
       REFERENCES departments (dep_id)
           ON UPDATE CASCADE
           ON DELETE CASCADE
);

ALTER TABLE employees
ADD COLUMN phone text CHECK (length(phone) = 10);

INSERT INTO employees (first_name, last_name, dep_id, phone)
VALUES  ('Анна', 'Сидорова', 1, '9115214152');
        
SELECT * FROM employees;

INSERT INTO employees (first_name, last_name, dep_id, phone)
VALUES  ('Жанна', 'Иванова', 2, '455');

INSERT INTO employees (first_name, last_name, dep_id, phone)
VALUES  ('Эльвира', 'Кузнецова', 2, Null),
        ('Лидия', 'Петрова', 2, Null);
        
CREATE TABLE IF NOT EXISTS employees (
    employee_id    integer     PRIMARY KEY,
    first_name     text        NOT NULL,
    last_name      text        NOT NULL,
    dep_id         integer,
    phone          text        UNIQUE,
    email          text        DEFAULT '@org.org',
    hiring_year    integer,     
    CHECK (length(phone) = 10 AND
            hiring_year <= 2020),
    FOREIGN KEY (dep_id)
       REFERENCES departments (dep_id)
           ON UPDATE CASCADE
           ON DELETE CASCADE
);

ALTER TABLE existing_table
RENAME TO new_table;

ALTER TABLE table_name
ADD COLUMN column_definition;

ALTER TABLE table_name
RENAME COLUMN current_name TO new_name;

/* Отразить в базе данных факт участия сотрудников организации в проектах.
   Сотрудник может принимать участие в нескольких проектах или не участвовать совсем.
*/
CREATE TABLE projects (
    project_id  integer PRIMARY KEY,
    name        text    UNIQIE
);

INSERT INTO projects (name)
VALUES  ('Космос'),
        ('Океан');
        
CREATE TABLE commitment (
    project_id  integer,
    employee_id integer,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) 
      REFERENCES projects (project_id) 
         ON DELETE SET NULL 
         ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) 
      REFERENCES employees (employee_id) 
         ON DELETE SET NULL 
         ON UPDATE CASCADE
);

INSERT INTO commitment
VALUES (1, 1),
       (2, 1),
       (2, 3); 
       
SELECT name, first_name, last_name, count(project_id)
    FROM employees 
    INNER JOIN commitment USING (employee_id)
    INNER JOIN departments USING (dep_id)
    GROUP BY employee_id
    ORDER BY name;

DROP TABLE commitment;
