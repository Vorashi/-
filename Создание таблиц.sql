USE AddressBook;

-- Создаем таблицу для хранения контактов
CREATE TABLE Contacts (
    ContactId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Создаем таблицу для хранения адресов
CREATE TABLE Addresses (
    AddressId INT PRIMARY KEY IDENTITY(1,1),
    ContactId INT NOT NULL,
    Street NVARCHAR(100) NOT NULL,
    CityId INT NOT NULL,
    ZipCode NVARCHAR(20) NOT NULL,
    FOREIGN KEY (ContactId) REFERENCES Contacts(ContactId)
);

-- Создаем таблицу для хранения регионов
CREATE TABLE Region (
	RegionId INT PRIMARY KEY IDENTITY(1,1),
	Region NVARCHAR(50) NOT NULL,
	FOREIGN KEY (RegionId) REFERENCES City(RegionId)
);

-- Создаем таблицу для хранения городов
CREATE TABLE City (
	CityId INT PRIMARY KEY IDENTITY(1,1),
	City NVARCHAR(50) NOT NULL,
	RegionId INT NOT NULL,
	FOREIGN KEY (CityId) REFERENCES Addresses(CityId)
);

-- Создаем таблицу для хранения телефонных номеров
CREATE TABLE Phones (
    PhoneId INT PRIMARY KEY IDENTITY(1,1),
    ContactId INT NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    FOREIGN KEY (ContactId) REFERENCES Contacts(ContactId)
);

-- Создаем таблицу для хранения информации о характере знакомства или родства
CREATE TABLE Relationships (
    RelationshipId INT PRIMARY KEY IDENTITY(1,1),
    ContactId INT NOT NULL,
    RelationshipType NVARCHAR(50) NOT NULL, -- Например, "Друг", "Коллега", "Родственник"
    FOREIGN KEY (ContactId) REFERENCES Contacts(ContactId)
);

-- Создаем таблицу для хранения информации о местах работы или учебы
CREATE TABLE WorkOrStudy (
    WorkOrStudyId INT PRIMARY KEY IDENTITY(1,1),
    ContactId INT NOT NULL,
    OrganizationName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL, -- Например, "Менеджер", "Студент"
    FOREIGN KEY (ContactId) REFERENCES Contacts(ContactId)
);

-- Таблица для хранения дней рождения
CREATE TABLE Birthdays (
    BirthdayId INT PRIMARY KEY IDENTITY(1,1),
    ContactId INT NOT NULL,
    BirthdayDate DATE NOT NULL,
    FOREIGN KEY (ContactId) REFERENCES Contacts(ContactId)
);
