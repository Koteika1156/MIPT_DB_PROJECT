
-- Функция для добавления нового материала в Materials_in_stock.

CREATE OR REPLACE FUNCTION AddNewMaterial(material_name VARCHAR, material_weight FLOAT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Materials_in_stock (Name, Weight) VALUES (material_name, material_weight);
END;
$$ LANGUAGE plpgsql;

-- Функция процедура для обновления количества детали в Goods_in_stock.

CREATE OR REPLACE FUNCTION UpdatePartQuantity(part_id BIGINT, new_quantity INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Goods_in_stock SET Quantity = new_quantity WHERE PartID = part_id;
END;
$$ LANGUAGE plpgsql;

-- Функция для проверки наличия необходимых товаров на складе перед оформлением заказа.

CREATE OR REPLACE FUNCTION CheckInventoryForOrder(part_id BIGINT, required_quantity INT)
RETURNS BOOLEAN AS $$
DECLARE
    available_quantity INT;
BEGIN
    SELECT Quantity INTO available_quantity
    FROM Goods_in_stock
    WHERE PartID = part_id;

    IF available_quantity >= required_quantity THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;