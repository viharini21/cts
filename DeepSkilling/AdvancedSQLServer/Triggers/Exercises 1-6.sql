-- =========================================================
-- STEP 1: CREATE DATABASE FROM SCRATCH
-- =========================================================
USE master;
GO

-- If the database somehow exists partially, drop it cleanly
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TriggerPracticeDB')
BEGIN
    ALTER DATABASE TriggerPracticeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TriggerPracticeDB;
END
GO

CREATE DATABASE TriggerPracticeDB;
GO

-- Switch focus to the new database context immediately
USE TriggerPracticeDB;
GO


-- =========================================================
-- STEP 2: CREATE BASE TABLES & SCHEMAS
-- =========================================================
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Fixed the 'Join Date' space typo from the PDF layout
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10, 2) NOT NULL,
    JoinDate DATE NOT NULL
);
GO


-- =========================================================
-- STEP 3: INSERT ASSIGNMENT DATA
-- =========================================================
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'), (2, 'Finance'), (3, 'IT'), (4, 'Marketing');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2022-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2021-03-22'),
(3, 'Michael', 'Johnson', 3, 7000.00, '2020-07-30'),
(4, 'Emily', 'Davis', 4, 5500.00, '2019-11-05');
GO


-- =========================================================
-- EXERCISE 1: AFTER TRIGGER (SALARY AUDIT LOG)
-- =========================================================
-- 1. Create tracking table
CREATE TABLE EmployeeChanges (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- 2. Deploy AFTER UPDATE trigger rule
CREATE TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
        SELECT 
            i.EmployeeID,
            d.Salary AS OldSalary,
            i.Salary AS NewSalary
        FROM inserted i
        JOIN deleted d ON i.EmployeeID = d.EmployeeID;
    END
END;
GO


-- =========================================================
-- EXERCISE 2: INSTEAD OF TRIGGER (PREVENT DELETIONS)
-- =========================================================
CREATE TRIGGER trg_InsteadOfDeleteEmployee
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletions are strictly prohibited from the Employees table.', 16, 1);
END;
GO


-- =========================================================
-- EXERCISE 6: COMPUTED COLUMN VIA TRIGGER (ANNUAL SALARY)
-- =========================================================
-- 1. Add the column layout
ALTER TABLE Employees ADD AnnualSalary DECIMAL(10,2);
GO

-- 2. Populate values for initial rows
UPDATE Employees SET AnnualSalary = Salary * 12;
GO

-- 3. Automate calculation via a dedicated trigger
CREATE TRIGGER trg_UpdateAnnualSalary
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        UPDATE e
        SET e.AnnualSalary = i.Salary * 12
        FROM Employees e
        JOIN inserted i ON e.EmployeeID = i.EmployeeID;
    END
END;
GO