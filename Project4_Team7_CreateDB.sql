USE master

go

DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'Project4_Team7'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

--SELECT @SQL 
EXEC(@SQL)

IF EXISTS(select * from sys.databases where name='Project4_Team7')
DROP DATABASE Project4_Team7

CREATE DATABASE Project4_Team7;

USE Project4_Team7;

CREATE TABLE Users (
UserID INT IDENTITY(1,1),
Pass VARCHAR(255) NOT NULL,
PRIMARY KEY (UserId)
);

CREATE TABLE Classes(
ClassID INT IDENTITY(1,1),
ClassName VARCHAR(100),
ClassNumber INT NOT NULL,
PRIMARY KEY (ClassID)
);

CREATE TABLE Login(
UserID INT,
ClassID INT,
Last_Login DATETIME,
FOREIGN KEY (UserID) REFERENCES Users(UserID),
FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
CONSTRAINT UQ_Login UNIQUE (UserID,ClassID)
);

CREATE TABLE Student(
UserID INT,
ClassID INT,
Enrolled BIT,
FOREIGN KEY (UserID) REFERENCES Users(UserID),
FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
CONSTRAINT UQ_Student UNIQUE (UserID,ClassID)
);