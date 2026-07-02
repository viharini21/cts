-- Re-creating dropped procedure for execution check
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- Execution Command: Retrieves IT department records (DepartmentID = 3)
EXEC sp_GetEmployeesByDepartment @DepartmentID = 3;
GO