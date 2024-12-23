CREATE VIEW vw_ContactDetails AS
SELECT 
    c.ContactId,
    c.FirstName,
    c.LastName,
    a.Street,
    ci.City,
    r.Region,
    a.ZipCode,
    p.PhoneNumber
FROM 
    Contacts c
LEFT JOIN 
    Addresses a ON c.ContactId = a.ContactId
LEFT JOIN 
    City ci ON a.CityId = ci.CityId
LEFT JOIN 
    Region r ON ci.RegionId = r.RegionId
LEFT JOIN 
    Phones p ON c.ContactId = p.ContactId;
	
CREATE VIEW vw_ContactRelationships AS
SELECT 
    c.ContactId,
    c.FirstName,
    c.LastName,
    r.RelationshipType
FROM 
    Contacts c
LEFT JOIN 
    Relationships r ON c.ContactId = r.ContactId;

CREATE VIEW vw_ContactBirthdaysAndWork AS
SELECT 
    c.ContactId,
    c.FirstName,
    c.LastName,
    b.BirthdayDate,
    w.OrganizationName,
    w.Position
FROM 
    Contacts c
LEFT JOIN 
    Birthdays b ON c.ContactId = b.ContactId
LEFT JOIN 
    WorkOrStudy w ON c.ContactId = w.ContactId;
