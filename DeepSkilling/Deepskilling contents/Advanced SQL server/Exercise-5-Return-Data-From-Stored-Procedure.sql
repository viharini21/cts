-- ==========================================
-- Exercise 5 : Return Data From Stored Procedure
-- ==========================================

-- Create Tables

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE
);

-- Sample Data

INSERT INTO Departments VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT');

INSERT INTO Employees
(
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    JoinDate
)
VALUES
('John','Doe',1,50000,'2023-01-15'),
('Jane','Smith',1,60000,'2022-05-10'),
('Michael','Johnson',2,55000,'2021-03-20'),
('Emily','Davis',3,70000,'2020-07-30');

-- Create Procedure

CREATE PROCEDURE sp_GetEmployeeCount
(
    @DepartmentID INT
)
AS
BEGIN

    SELECT
        COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID = @DepartmentID;

END;

-- Execute Procedure

EXEC sp_GetEmployeeCount 1;