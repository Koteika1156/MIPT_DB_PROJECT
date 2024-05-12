-- Триггер, который проверяет, является ли уровень запасов детали низким после обновления, и выдает уведомление.

CREATE OR REPLACE FUNCTION CheckStockLevel()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Quantity < 10 THEN
        RAISE NOTICE 'Stock for part % is low.', NEW.PartID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER LowStockAfterUpdate
AFTER UPDATE ON Goods_in_stock
FOR EACH ROW
EXECUTE FUNCTION CheckStockLevel();

-- Триггер, который гарантирует, что EndDate для сотрудника не может быть перед StartDate.

CREATE OR REPLACE FUNCTION ValidateEndDate()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.EndDate IS NOT NULL AND NEW.EndDate < NEW.StartDate THEN
        RAISE EXCEPTION 'EndDate cannot be before StartDate.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CheckEndDateBeforeInsertOrUpdate
BEFORE INSERT OR UPDATE ON Employees
FOR EACH ROW
EXECUTE FUNCTION ValidateEndDate();

-- Триггер, который предотвращает добавление или обновление материала с названием, которое уже существует в таблице Materials_in_stock, гарантируя уникальность названий материалов.

CREATE OR REPLACE FUNCTION EnsureUniqueMaterialName()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Materials_in_stock WHERE Name = NEW.Name AND MaterialID != NEW.MaterialID) THEN
        RAISE EXCEPTION 'Material with name "%" already exists.', NEW.Name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerEnsureUniqueMaterialNameBeforeInsertOrUpdate
BEFORE INSERT OR UPDATE ON Materials_in_stock
FOR EACH ROW
EXECUTE FUNCTION EnsureUniqueMaterialName();