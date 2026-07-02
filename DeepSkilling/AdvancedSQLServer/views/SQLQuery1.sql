
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EmployeeManagement')
BEGIN
    ALTER DATABASE EmployeeManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmployeeManagement;
END
GO

CREATE DATABASE EmployeeManagement;
GO

USE EmployeeManagement;
GO


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT REFERENCES Departments(DepartmentID), -- Fixed constraint syntax
    Salary DECIMAL(10, 2),
    JoinDate DATE
);
GO

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(10, 'IT & Engineering'),
(20, 'Human Resources'),
(30, 'Finance');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1001, 'Robert', 'Miller', 10, 5500.00, '2024-03-12'),
(1002, 'Sophia', 'Davis', 10, 6800.00, '2024-07-19'),
(1003, 'James', 'Wilson', 20, 4200.00, '2025-02-01'),
(1004, 'Emily', 'Anderson', 30, 7500.00, '2023-09-15');
GO



CREATE VIEW vw_EmployeeBasicInfo AS
SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;
GO


-- Exercise 2: Add Computed Column - Full Name
CREATE VIEW vw_EmployeeFullName AS
SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    DepartmentID,
    Salary
FROM Employees;
GO


CREATE VIEW vw_EmployeeAnnualSalary AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    (Salary * 12) AS AnnualSalary
FROM Employees;
GO


CREATE VIEW vw_EmployeeReport AS
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName,
    (e.Salary * 12) AS AnnualSalary,
    ((e.Salary * 12) * 0.10) AS Bonus
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;
GO


SELECT * FROM vw_EmployeeBasicInfo;
SELECT * FROM vw_EmployeeFullName;
SELECT * FROM vw_EmployeeAnnualSalary;
SELECT * FROM vw_EmployeeReport;