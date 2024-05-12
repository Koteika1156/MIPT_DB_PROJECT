-- Тест 1: Получить все доставки определенному получателю
SELECT *
FROM Deliveries
 WHERE RecipientID = 1;

-- Тест 2: Получить общее количество поставленных деталей каждым получателем
SELECT RecipientID, SUM(Quantity) as TotalQuantity
FROM Deliveries
GROUP BY RecipientID;

-- Тест 3: Получить список получателей, получивших более 100 единиц товара
SELECT RecipientID
FROM Deliveries
GROUP BY RecipientID
HAVING SUM(Quantity) > 100;

-- Тест 4: Выбрать работников, которые устроились на завод позже '2024-01-01'
SELECT *
FROM Employees
WHERE StartDate > '2024-01-01';

-- Тест 5: Выбрать всех работников с именем Иван
SELECT *
FROM Employees
WHERE FirstName = 'Иван';

-- Тест 6: Получить самый часто встречающийся материал изделий
SELECT MaterialID, COUNT(*) AS MaterialCount
FROM Parts
GROUP BY MaterialID
ORDER BY MaterialCount
DESC LIMIT 1;

-- Тест 7: Получить количество станков находящихся в эксплуатации
SELECT COUNT(*)
FROM Machines
WHERE DecommissionDate IS NULL;

-- Тест 8: Получить дату, когда было поставлено наибольшее количество деталей
SELECT Date
FROM Deliveries
GROUP BY Date
ORDER BY SUM(Quantity)
DESC LIMIT 1;

-- Тест 9: Получить самую легкую производимую деталь из Стали
SELECT p.*
FROM Parts p
JOIN Materials_in_stock m
ON p.MaterialID = m.MaterialID
WHERE m.Name = 'Сталь'
ORDER BY p.Weight
ASC LIMIT 1;

-- Тест 10: Получить количество производимых деталей типа "Крепеж"
SELECT COUNT(*)
FROM Parts
WHERE Type = 'Крепеж';