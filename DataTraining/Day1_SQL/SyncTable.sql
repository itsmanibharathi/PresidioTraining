CREATE DATABASE try_sp;

GO;

USE try_sp;

CREATE TABLE Users (
    userId INT PRIMARY KEY IDENTITY(1,1), 
    name NVARCHAR(100) NOT NULL,           
    age INT NOT NULL,
	updatedAt DATETIME
);
 
Insert into Users (name , age) values('sachin',44),('dhoni',42),('rohit' , 36),('kholi',35)
 
select * from users

CREATE TABLE TargetUsers (
    userId INT,
    name NVARCHAR(100) NOT NULL,
    age INT NOT NULL,
    createdAt DATETIME,
    updatedAt DATETIME,  
    isDeleted BIT DEFAULT 0,  
    PRIMARY KEY (userId, updatedAt)  
);

CREATE or ALTER PROCEDURE SyncTables
AS
BEGIN
    INSERT INTO TargetUsers (userId, name, age, createdAt, updatedAt, isDeleted)
   SELECT
        u.userId,
        u.name,
        u.age,
        CASE
            WHEN t.userId IS NULL THEN GETDATE()
            ELSE t.createdAt
        END AS createdAt,
        GETDATE() AS updatedAt,  
        0 AS isDeleted 
    FROM
        Users u
    LEFT JOIN
        TargetUsers t
    ON
        u.userId = t.userId
        AND t.updatedAt = (SELECT MAX(updatedAt) FROM TargetUsers WHERE userId = u.userId)
    WHERE
        t.userId IS NULL
        OR (u.name <> t.name OR u.age <> t.age OR t.updatedAt < u.updatedAt);

    -- Mark records in TargetUsers as deleted if they no longer exist in Users
    UPDATE TargetUsers
    SET isDeleted = 1,  
        updatedAt = GETDATE() 
    WHERE userId NOT IN (
        SELECT userId 
        FROM Users
    ) AND isDeleted = 0;
END;

UPDATE Users SET age = 10 
WHERE userId =1

DELETE  Users WHERE userId =1

select * from Users;
SELECT * from TargetUsers;


SELECT 
    u.userId, 
    u.name, 
    u.age, 
    CASE 
        WHEN t.userId IS NULL THEN GETDATE()  
        ELSE t.createdAt
    END AS createdAt,
    GETDATE() AS updatedAt,  
    0 AS isDeleted  
FROM 
    Users u
LEFT JOIN 
    TargetUsers t 
ON 
    u.userId = t.userId 
    AND t.updatedAt = (SELECT MAX(updatedAt) FROM TargetUsers WHERE userId = u.userId)
WHERE 
    t.userId IS NULL  
    OR t.updatedAt < GETDATE();



