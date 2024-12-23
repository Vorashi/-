-- Триггер для обновления поля UpdatedAt в таблице Contacts при изменении данных в таблице Phones
CREATE TRIGGER trg_UpdateContactWhenPhoneChanged
ON Phones
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновляем поле UpdatedAt в таблице Contacts для каждого обновленного телефонного номера
    UPDATE c
    SET c.UpdatedAt = GETDATE()
    FROM Contacts c
    INNER JOIN inserted i ON c.ContactId = i.ContactId;
    
    PRINT 'Дата изменения контакта обновлена после изменения телефонного номера.';
END;

-- Триггер для обновления поля UpdatedAt в таблице Contacts при изменении данных в таблице Addresses
CREATE TRIGGER trg_UpdateContactWhenAddressChanged
ON Addresses
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновляем поле UpdatedAt в таблице Contacts для каждого обновленного адреса
    UPDATE c
    SET c.UpdatedAt = GETDATE()
    FROM Contacts c
    INNER JOIN inserted i ON c.ContactId = i.ContactId;
    
    PRINT 'Дата изменения контакта обновлена после изменения адреса.';
END;