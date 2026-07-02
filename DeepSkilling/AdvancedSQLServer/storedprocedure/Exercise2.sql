ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate -- Added Salary
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO