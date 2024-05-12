import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def create_table(conn):
    cursor = conn.cursor()

    with open('ddl.sql', 'r', encoding='utf-8') as sql_file:
        sql_script = sql_file.read()
        cursor.execute(sql_script)

    cursor.close()
    print("База данных успешно создана и таблицы добавлены.")

def insert_data(conn):
    def execute_sql_from_file(cursor, file_path):
        with open(file_path, 'r', encoding='utf-8') as sql_file:
            sql_script = sql_file.read()
            cursor.execute(sql_script)

    cursor = conn.cursor()

    sql_files = ["deliveries.sql", "employees.sql","goods_in_stock.sql","machines.sql",
                 "materials_delivery.sql","materials_in_stock.sql","parts.sql","production.sql","recipients.sql"]

    for file_path in sql_files:
        execute_sql_from_file(cursor, file_path)

    cursor.close()
    print("Данные добавлены.")

def visualize_data(conn):
    sql_query_1 = """
    SELECT m.Name, AVG(p.Weight) as average_weight
    FROM Parts p
    JOIN materials_in_stock m ON p.MaterialID = m.MaterialID
    GROUP BY m.Name;
    """

    sql_query_2 = """
    SELECT EXTRACT(MONTH FROM StartDate) AS start_month, COUNT(*) as employee_count
    FROM Employees
    WHERE EXTRACT(YEAR FROM StartDate) = 2024
    GROUP BY start_month
    ORDER BY start_month;
    """

    df_1 = pd.read_sql_query(sql_query_1, conn)
    df_2 = pd.read_sql_query(sql_query_2, conn)

    # Вывод полученных данных
    print(df_1)
    print(df_2)

    # Визуализация данных: построение графика среднего веса по названиям материалов
    plt.figure(figsize=(10, 6))
    sns.barplot(x='name', y='average_weight', data=df_1)
    plt.title('Средний вес деталей по названиям материалов')
    plt.xlabel('Материал')
    plt.ylabel('Средний вес (кг)')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()

    sns.barplot(x='start_month', y='employee_count', data=df_2)
    plt.title('Количество сотрудников, начавших работу в каждом месяце 2024 года')
    plt.xlabel('Месяц начала работы')
    plt.ylabel('Количество сотрудников')
    plt.xticks(range(0, 12), ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'], rotation=45)
    plt.tight_layout()
    plt.show()




def drop_all_tables(conn):
    cur = conn.cursor()

    cur.execute("""
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'
    """)

    tables = cur.fetchall()

    for table in tables:
        cur.execute(f"DROP TABLE IF EXISTS {table[0]} CASCADE;")
        print(f"Таблица {table[0]} была удалена.")

    cur.close()


if __name__ == '__main__':

    conn = psycopg2.connect(
        host="localhost",
        user="postgres",
        password="123",
        database="postgres"
    )

    conn.autocommit = True

    #create_table(conn)
    #insert_data(conn)
    #visualize_data(conn)

    #drop_all_tables(conn)

    conn.close()