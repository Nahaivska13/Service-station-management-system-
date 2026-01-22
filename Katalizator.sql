CREATE DATABASE Katalizator;

USE Katalizator;

-- Створення таблиці для послуг
CREATE TABLE services (
 service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    service_type VARCHAR(255),
    work_time INT,
    work_cost DECIMAL(10, 2), 
    warranty VARCHAR(255)
);

-- Створення таблиці для запчастин
CREATE TABLE parts (
    part_id INT AUTO_INCREMENT PRIMARY KEY,
    part_name VARCHAR(255) NOT NULL,
    part_cost DECIMAL(10, 2),
    quantity_in_stock INT,
    supplier_id INT
);

 -- Зовнішній ключ до таблиці постачальників
ALTER TABLE parts
ADD CONSTRAINT fk_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- Створення таблиці для клієнтів
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    car_reg_number VARCHAR(255) NOT NULL,
    owner_name VARCHAR(255) NOT NULL,
	owner_surname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email_clients VARCHAR(255),
    car_make VARCHAR(255),
    car_model VARCHAR(255),
    car_year INT
);

-- Створення таблиці для працівників
CREATE TABLE workers (
    worker_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_name VARCHAR(255) NOT NULL,
    worker_surname VARCHAR(255) NOT NULL,
    position VARCHAR(255),
    specialization VARCHAR(255),
    work_experience INT, 
    salary DECIMAL(10, 2), 
    work_schedule VARCHAR(255) 
);

-- Створення таблиці для постачальників
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(255),
    supplier_rating DECIMAL(3, 2), 
    supplier_address VARCHAR(255)
);

-- Створення таблиці для замовлень клієнтів
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT, 
    worker_id INT, 
    service_id INT, 
    part_id INT,
    order_date DATETIME, 
    expected_finish_date DATETIME, 
    order_status VARCHAR(255)
);

Use Katalizator;

-- Зовнішній ключ на запчастини
USE Katalizator;
ALTER TABLE orders
ADD CONSTRAINT fk_part_id 
FOREIGN KEY (part_id) 
REFERENCES parts(part_id);

-- Зовнішній ключ на послугу
ALTER TABLE orders
ADD CONSTRAINT fk_client_id
FOREIGN KEY (client_id)
REFERENCES clients(client_id);

 -- Зовнішній ключ на працівника
ALTER TABLE orders
ADD CONSTRAINT fk_worker_id
FOREIGN KEY (worker_id)
REFERENCES workers(worker_id);

-- Зовнішній ключ на послугу
ALTER TABLE orders
ADD CONSTRAINT fk_service_id
FOREIGN KEY (service_id)
REFERENCES services(service_id);

/*Вибірка окремих полів*/
USE Katalizator;
SELECT position FROM workers;

/*Вибірка всіх полів*/
USE Katalizator;
SELECT * FROM clients;

/*Сортування за кількома полями*/
USE Katalizator;
SELECT 
    orders.order_id, 
    orders.order_date, 
    orders.order_status, 
    clients.owner_name, 
    clients.owner_surname, 
    services.service_name,
    parts.part_name
FROM orders
JOIN clients ON orders.client_id = clients.client_id
JOIN services ON orders.service_id = services.service_id
JOIN parts ON orders.part_id = parts.part_id
ORDER BY orders.order_date DESC, orders.order_status ASC;

/*Вибірка даних з використанням розділів GROUP BY і HAVING*/
USE Katalizator;
SELECT 
    workers.worker_id, 
    CONCAT(workers.worker_name, ' ', workers.worker_surname) AS full_name, 
    SUM(services.work_cost) AS total_earnings
FROM workers
JOIN orders ON workers.worker_id = orders.worker_id
JOIN services ON orders.service_id = services.service_id
GROUP BY workers.worker_id, full_name
HAVING total_earnings > 5800;

/*Групування та сортування*/
USE Katalizator;
SELECT 
    order_status, 
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

/*Створення об'єднання таблиць INNER*/
USE Katalizator;
SELECT 
    orders.order_id, 
    clients.owner_name, 
    clients.owner_surname, 
    orders.order_status, 
    orders.order_date
FROM orders
INNER JOIN clients ON orders.client_id = clients.client_id;

/*Створення об'єднання таблиць LEFT JOIN*/ 
USE Katalizator;
SELECT 
    orders.order_id AS order_id, 
    orders.order_date AS order_date, 
    CONCAT(workers.worker_name, ' ', workers.worker_surname) AS worker_full_name, 
    workers.position AS worker_position, 
    orders.order_status AS order_status
FROM orders
LEFT JOIN workers 
    ON orders.worker_id = workers.worker_id;

/*Створення об'єднання таблиць RIGHT JOIN*/ 
USE Katalizator;
SELECT 
    services.service_name, 
    services.service_type, 
    orders.order_id, 
    orders.order_status
FROM services
RIGHT JOIN orders ON services.service_id = orders.service_id;

/*Фільтрування. AND*/
USE Katalizator;
SELECT * 
FROM parts
WHERE part_cost > 300 AND quantity_in_stock > 20;

/*Фільтрування. OR*/
USE Katalizator;
SELECT 
    c.client_id, 
    c.owner_name, 
    c.owner_surname, 
    c.car_reg_number, 
    c.car_make, 
    c.car_model, 
    c.car_year
FROM clients c
WHERE c.car_reg_number = 'AB123CD' OR c.car_make = 'Toyota';

/*Фільтрування. NOT */
USE Katalizator;
SELECT * 
FROM suppliers
WHERE NOT supplier_address = '707 Body Rd, Rome, Italy';

/*Діапазон*/
USE Katalizator;
SELECT 
    worker_id, 
    worker_name, 
    worker_surname, 
    work_experience, 
    salary 
FROM workers 
WHERE work_experience BETWEEN 1 AND 3;

/*Належність до множини. IN*/
USE Katalizator;
SELECT 
    client_id, 
    owner_name, 
    owner_surname,
    car_make, 
    car_model 
FROM clients 
WHERE car_model IN ('Focus', 'A4', 'X5');

/*Належність до множини. NOT IN*/
USE Katalizator;
SELECT 
    worker_id, 
    worker_name, 
    worker_surname, 
    position,
    specialization 
FROM workers 
WHERE specialization NOT IN ('Installation and calibration of car electronics', 'Electrical system diagnostics and repairs');

/*Відповідність шаблону.LIKE*/
USE Katalizator;
SELECT 
    service_id, 
    service_name, 
    service_type, 
    work_cost 
FROM services 
WHERE service_name LIKE '%Body%';

/*Відповідність шаблону.NOT LIKE*/
USE Katalizator;
SELECT 
    client_id, 
    car_make, 
    car_model
FROM clients 
WHERE car_make NOT LIKE 'M%';

/*Існування*/
USE Katalizator;
SELECT 'Клієнти з роком випуску машини 2021 - існують'
WHERE EXISTS (
    SELECT 1
    FROM clients
    WHERE car_year = 2021
);

/*Перевірка на невизначене значення NULL*/
USE Katalizator;
SELECT 
    client_id, 
    owner_name, 
    owner_surname, 
    phone_number
FROM clients
WHERE phone_number IS NULL;

INSERT INTO clients 
    (client_id,car_reg_number, owner_name, owner_surname, phone_number, email_clients, car_make, car_model, car_year)
VALUES 
    (16, 'AI8812BD', 'Maria', 'Khomenko', NULL, 'khomenko1@example.com', 'Toyota', 'Corolla', 2020);
    
/*Перевірка на невизначене значення. NOT NULL*/
USE Katalizator;
SELECT 
    order_id, 
    client_id, 
    worker_id, 
    order_status
FROM orders
WHERE worker_id IS NOT NULL;

/*Використання агрегатних функцій.COUNT()*/
USE Katalizator;
SELECT COUNT(*) AS quantity_in_stock
FROM parts;

/*Використання агрегатних функцій.SUM()*/
USE Katalizator;
SELECT SUM(quantity_in_stock) AS total_parts
FROM parts;

/*Використання агрегатних функцій.AVG()*/
USE Katalizator;
SELECT AVG(salary) AS average_salary
FROM workers;

/*Використання агрегатних функцій.MIN()*/
USE Katalizator;
SELECT MIN(part_cost) AS min_price
FROM parts;

/*Використання агрегатних функцій.MAX()*/
USE Katalizator;
SELECT MAX(part_cost) AS max_price
FROM parts;

/*Використання виразу CASE у вибірках даних.*/
USE Katalizator;
SELECT 
    part_id AS product_id,
    part_name AS product_name,
    part_cost AS cost,
    'Part' AS product_category,
    CASE
        WHEN part_cost > 500 THEN 'Premium'
        WHEN part_cost BETWEEN 200 AND 500 THEN 'Standard'
        ELSE 'Economy'
    END AS price_category
FROM parts;

/*Оператор UNION*/
USE Katalizator;
SELECT part_name AS product_name, 'Part' AS category
FROM parts
UNION
SELECT service_name AS product_name, 'Service' AS category
FROM services;

/*Операції реляційної алгебри. Обʼєднання*/
SELECT worker_surname AS surname
FROM workers
UNION ALL
SELECT owner_surname AS surname
FROM clients;

/*Операції реляційної алгебри. Перетин*/
USE Katalizator;
SELECT parts.part_id
FROM parts
INNER JOIN orders ON parts.part_id = orders.part_id;

/*Операції реляційної алгебри. Віднімання*/
USE Katalizator;
SELECT order_id, order_date, order_status
FROM orders
LEFT JOIN parts ON orders.part_id = parts.part_id;

/*Операції реляційної алгебри. Декартовий добуток*/
USE Katalizator;
SELECT parts.part_id, parts.part_name, parts.part_cost, parts.quantity_in_stock,
       services.service_id, services.service_name, services.service_type, services.work_time, services.work_cost
FROM parts
CROSS JOIN services;

/*Операції реляційної алгебри. Вибірка*/
USE Katalizator;
SELECT * FROM parts
WHERE supplier_id = 2;

/*Операції реляційної алгебри. Проєкція*/
USE Katalizator;
SELECT part_name, part_cost 
FROM parts;

/*Операції реляційної алгебри. Зʼєднання*/
USE Katalizator;
SELECT 
    orders.order_id, 
    clients.owner_name, 
    clients.owner_surname, 
    orders.order_date, 
    orders.order_status
FROM 
    orders
JOIN 
    clients 
ON 
    orders.client_id = clients.client_id;

/*Операції реляційної алгебри. Ділення*/
SELECT p.part_id, p.part_name
FROM parts p
WHERE NOT EXISTS (
    SELECT o.client_id
    FROM orders o
    WHERE NOT EXISTS (
        SELECT ord.part_id
        FROM orders ord
        WHERE ord.client_id = o.client_id
          AND ord.part_id = p.part_id
    )
);


INSERT INTO orders (client_id, worker_id, service_id, part_id, order_date, expected_finish_date, order_status)
VALUES 
(1, 1, 1, 1, '2024-12-10 13:00:00', '2024-12-10 13:00:00', 'Completed'),  
(1, 1, 1, 2, '2024-12-10 13:00:00', '2024-12-10 17:00:00', 'Completed'), 
(1, 1, 1, 3, '2024-12-10 13:00:00', '2024-12-10 11:00:00', 'Completed');




