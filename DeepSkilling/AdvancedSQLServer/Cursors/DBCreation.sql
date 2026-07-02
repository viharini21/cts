USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CursorPracticeDB')
BEGIN
    ALTER DATABASE CursorPracticeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CursorPracticeDB;
END
GO

CREATE DATABASE CursorPracticeDB;
GO

USE CursorPracticeDB;
GO

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10, 2) NOT NULL,
    JoinDate DATE NOT NULL
);
GO

-- Insert Sample Data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'), 
(2, 'IT'), 
(3, 'Finance');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2019-03-22'),
(3, 'Bob', 'Johnson', 3, 5500.00, '2021-07-30');
GO