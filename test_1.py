# test_queries.py
import psycopg2
from psycopg2.extras import DictCursor
from datetime import datetime

# Функция для установления соединения с базой данных
def connect_db():
    return psycopg2.connect(
        host="localhost",
        user="postgres",
        password="123",
        database="postgres"
    )


# Функция для выполнения запросов
def execute_query(query):
    with connect_db() as conn:
        with conn.cursor(cursor_factory=DictCursor) as cursor:
            cursor.execute(query)
            return cursor.fetchall()

# Тест 1: Получить все доставки определенному получателю
def test_deliveries_to_recipient():
    result = execute_query("SELECT * FROM Deliveries WHERE RecipientID = 1;")
    assert result is not None
    assert len(result) > 0
    for record in result:
        assert record['recipientid'] == 1

# Тест 2: Получить общее количество поставленных деталей каждым получателю
def test_total_quantity_per_recipient():
    result = execute_query("SELECT RecipientID, SUM(Quantity) as TotalQuantity FROM Deliveries GROUP BY RecipientID;")
    assert result is not None
    for record in result:
        assert record['totalquantity'] is not None
        assert record['totalquantity'] > 0

# Тест 3: Получить список получателей, получивших более 100 единиц товара
def test_recipients_with_over_100_units():
    result = execute_query("SELECT RecipientID FROM Deliveries GROUP BY RecipientID HAVING SUM(Quantity) > 100;")
    assert result is not None
    for record in result:
        assert record['recipientid'] is not None

# Тест 4: Выбрать работников, которые устроились на завод позже '2024-01-01'
def test_employees_started_after():
    result = execute_query("SELECT * FROM Employees WHERE StartDate::date > '2024-01-01';")
    assert result is not None
    for record in result:
        assert record['startdate'] > datetime.strptime('2024-01-01', '%Y-%m-%d').date()

# Тест 5: Выбрать всех работников с именем Иван
def test_employees_named_ivan():
    result = execute_query("SELECT * FROM Employees WHERE FirstName = 'Иван';")
    assert result is not None
    for record in result:
        assert record['firstname'] == 'Иван'

# Тест 6: Получить самый часто встречающийся материал изделий
def test_most_common_material():
    result = execute_query("SELECT MaterialID, COUNT(*) AS MaterialCount FROM Parts GROUP BY MaterialID ORDER BY MaterialCount DESC LIMIT 1;")
    assert result is not None
    assert len(result) == 1
    assert result[0]['materialcount'] is not None

# Тест 7: Получить количество станков находящихся в эксплуатации
def test_operational_machines_count():
    result = execute_query("SELECT COUNT(*) FROM Machines WHERE DecommissionDate IS NULL;")
    assert result is not None
    assert result[0]['count'] > 0

# Тест 8: Получить дату, когда было поставлено наибольшее количество деталей
def test_date_with_max_deliveries():
    result = execute_query("SELECT Date FROM Deliveries GROUP BY Date ORDER BY SUM(Quantity) DESC LIMIT 1;")
    assert result is not None
    assert len(result) == 1
    assert result[0]['date'] is not None

# Тест 9: Получить самую легкую производимую деталь из Стали
def test_lightest_steel_part():
    result = execute_query("SELECT p.* FROM Parts p JOIN Materials_in_stock m ON p.MaterialID = m.MaterialID WHERE m.Name = 'Сталь' ORDER BY p.Weight ASC LIMIT 1;")

    assert result is not None
    assert len(result) == 1
    assert result[0]['weight'] is not None

# Тест 10: Получить количество производимых деталей типа "Крепеж"
def test_count_fixtures_parts():
    result = execute_query("SELECT COUNT(*) FROM Parts WHERE Type = 'Крепеж';")
    assert result is not None
    assert result[0]['count'] > 0