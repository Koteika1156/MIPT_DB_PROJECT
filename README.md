# Структура базы данных

## Таблица: Работники
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| EmployeeID | BIGSERIAL | Id работника | NOT NULL, PRIMARY KEY |
| FirstName | VARCHAR(50) | Имя работника | NOT NULL, LENGTH >= 1 |
| LastName | VARCHAR(50) | Фамилия работника | NOT NULL, LENGTH >= 1 |
| Position | VARCHAR(50) | Должность работника | NOT NULL, LENGTH >= 1 |
| StartDate | DATE | Дата начала работы | NOT NULL |
| EndDate | DATE | Дата конца работы |  |

## Таблица: Материалы на складе
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| MaterialID | BIGSERIAL | Id материала | NOT NULL, PRIMARY KEY |
| Name | VARCHAR(50) | Название материала | NOT NULL, LENGTH >= 1 |
| Weight | FLOAT | Вес материала  | NOT NULL, >= 0 |

## Таблица: Производимые товары
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| PartID | BIGSERIAL | Id товара | NOT NULL, PRIMARY KEY |
| Name | VARCHAR(50) | Название товара | NOT NULL, LENGTH >= 1 |
| Type | VARCHAR(50) | Категория товара | NOT NULL, LENGTH >= 1 |
| MaterialID | BIGINT | Id материала | NOT NULL, > 0 |
| Weight | FLOAT | Вес | NOT NULL, >= 0 |

## Таблица: Парк станков
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| MachineID | BIGSERIAL | Id станка | NOT NULL, PRIMARY KEY |
| Name | VARCHAR(50) | Название станка | NOT NULL, LENGTH >= 1 |
| Type | VARCHAR(50) | Тип станка | NOT NULL, LENGTH >= 1 |
| CommissionDate | DATE | Дата ввода в эксплуатацию | NOT NULL |
| DecommissionDate | DATE | Дата вывода из эксплуатации |  |

## Таблица: Производственный журнал
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| ProductionID | BIGSERIAL | Id записи | NOT NULL, PRIMARY KEY |
| MachineID | BIGINT | Id используемого станка | NOT NULL, > 0 |
| PartID | BIGINT | Id произведенной детали | NOT NULL, > 0 |
| EmployeeID | BIGINT | Id работника | NOT NULL, > 0 |
| Quantity | INT | Количество произведенный деталей | NOT NULL, > 0 |
| Date | DATE | Дата производства | NOT NULL |

## Таблица: Получатели
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| RecipientID | BIGSERIAL | Id получателя | NOT NULL, PRIMARY KEY |
| Name | VARCHAR(50) | Получатель | NOT NULL, LENGTH >= 1 |
| Address | VARCHAR(100) | Адресс получателя | NOT NULL, LENGTH >= 1 |
| ContactPerson | VARCHAR(50) | Контактное лицо | NOT NULL, LENGTH >= 1 |
| Phone | VARCHAR(15) | Контактный номер | NOT NULL, LENGTH >= 1 |

## Таблица: Журнал доставок
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| DeliveryID | BIGSERIAL | Id доставки | NOT NULL, PRIMARY KEY |
| RecipientID | BIGINT | Id получателя | NOT NULL, > 0 |
| StockProductID | BIGINT | Id доставляемой детали со склада | NOT NULL, > 0 |
| Quantity | INT | Количество отправленных деталей | NOT NULL, > 0 |
| Date | DATE | Дата доставки | NOT NULL |

## Таблица: Поставка материалов
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| MDID | BIGSERIAL | Id поставки | NOT NULL, PRIMARY KEY |
| MaterialID | BIGINT | Id материала | NOT NULL, >= 0 |
| Weight | FLOAT | Вес полученных материалов  | NOT NULL, > 0 |
| Date | DATE | Дата доставки | NOT NULL |

## Таблица: Товары на складе
| Field | Type | Description | Constraints |
| --- | --- | --- | --- |
| StockProductID | BIGSERIAL | Id товара на складе | NOT NULL, PRIMARY KEY |
| PartID | BIGINT | Id произведенной детали | NOT NULL, >= 0 |
| Quantity | INT | Количество | NOT NULL, >= 0 |