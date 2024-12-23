CREATE PROCEDURE GetBirthdayGreetings
    @StartDate DATE = NULL,  -- Начальная дата диапазона (опционально)
    @EndDate DATE = NULL     -- Конечная дата диапазона (опционально)
AS
BEGIN
    SET NOCOUNT ON;

    -- Проверяем, если задан только один параметр, то считаем диапазон от этой даты до самой даты
    IF @StartDate IS NOT NULL AND @EndDate IS NULL
    BEGIN
        SET @EndDate = @StartDate;
    END

    -- Если ни одна дата не указана, то будем использовать текущую дату
    IF @StartDate IS NULL AND @EndDate IS NULL
    BEGIN
        SET @StartDate = GETDATE();
        SET @EndDate = GETDATE();
    END

    -- Формируем поздравления, сравнивая только день и месяц
    SELECT
        c.FirstName,
        c.LastName,
        b.BirthdayDate,
        CONCAT('Поздравляем ', c.FirstName, ' ', c.LastName, 
               ' с днем рождения!') AS BirthdayGreeting
    FROM
        Birthdays b
    JOIN
        Contacts c ON b.ContactId = c.ContactId
    WHERE
        DATEPART(DAY, b.BirthdayDate) BETWEEN DATEPART(DAY, @StartDate) AND DATEPART(DAY, @EndDate)
        AND DATEPART(MONTH, b.BirthdayDate) BETWEEN DATEPART(MONTH, @StartDate) AND DATEPART(MONTH, @EndDate)
    ORDER BY
        DATEPART(MONTH, b.BirthdayDate), DATEPART(DAY, b.BirthdayDate);
END;

-- Создание процедуры для обновления имени и фамилии контакта с обновлением даты изменения данных
CREATE PROCEDURE UpdateContactName
    @ContactId INT,               -- Идентификатор контакта, чьи данные нужно обновить
    @NewFirstName NVARCHAR(50),   -- Новое имя контакта
    @NewLastName NVARCHAR(50)     -- Новая фамилия контакта
AS
BEGIN
    SET NOCOUNT ON;

    -- Проверяем, изменяются ли имя или фамилия
    IF EXISTS (SELECT 1 FROM Contacts WHERE ContactId = @ContactId AND 
               (FirstName <> @NewFirstName OR LastName <> @NewLastName))
    BEGIN
        -- Обновляем имя, фамилию и дату изменения
        UPDATE Contacts
        SET FirstName = @NewFirstName,
            LastName = @NewLastName,
            UpdatedAt = GETDATE()  -- Обновляем дату изменения данных
        WHERE ContactId = @ContactId;
        
        -- Возвращаем сообщение об успешном обновлении
        PRINT 'Контакт успешно обновлен.';
    END
    ELSE
    BEGIN
        -- Если имя и фамилия не изменились, выводим сообщение
        PRINT 'Имя и фамилия не изменились, обновление не требуется.';
    END
END;
