-- ==========================================
-- Exercise 1 : Create Stored Procedure
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
(3,'IT'),
(4,'Marketing');

-- Create Stored Procedure

CREATE PROCEDURE sp_InsertEmployee
(
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
)
AS
BEGIN

    INSERT INTO Employees
    (
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        JoinDate
    )
    VALUES
    (
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate
    );

END;

-- Execute Procedure

EXEC sp_InsertEmployee
    'John',
    'Doe',
    1,
    50000,
    '2025-01-15';

EXEC sp_InsertEmployee
    'Jane',
    'Smith',
    2,
    60000,
    '2025-02-10';

-- Verify Data

SELECT * FROM Employees;