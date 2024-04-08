-- 1. Получить все доставки определенному получателю (например, RecipientID = 1)
SELECT * FROM Deliveries WHERE RecipientID = 1;

-- 2. Получить общее количество поставленных деталей каждыму получателю
SELECT RecipientID, SUM(Quantity) as TotalQuantity FROM Deliveries GROUP BY RecipientID;

-- 3. Получить список получателей, получивших более 100 единиц товара
SELECT RecipientID FROM Deliveries GROUP BY RecipientID HAVING SUM(Quantity) > 100;

-- 4. Выбрать работников, которые устроились на завод позже '2024-01-01'
SELECT * FROM Employees WHERE StartDate > '2024-01-01';

-- 5. Выбрать всех работников с именем Иван
SELECT * FROM Employees WHERE FirstName = 'Иван';

-- 6. Получить самый часто встречающийся материал изделий
SELECT Material, COUNT(*) AS MaterialCount FROM Part GROUP BY Material ORDER BY MaterialCount DESC LIMIT 1;

-- 7. Получить количество станков находящихся в эксплуатации
SELECT COUNT(*) FROM Machines WHERE DecommissionDate IS NULL;

-- 8. Получить дату, когда было поставлено наибольшее количество деталей
SELECT Date FROM Deliveries GROUP BY Date ORDER BY SUM(Quantity) DESC LIMIT 1;

-- 9. Получить самую легкую производимую деталь из Стали
SELECT * FROM Part WHERE Material = 'Сталь' ORDER BY Weight ASC LIMIT 1;

-- 10. Получить количество производимых деталей типа "Крепеж"
SELECT COUNT(*) FROM Part WHERE Type = 'Крепеж';
