CREATE PROCEDURE sp_GetTotalSalaryByDepartment
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- Test Execution using a local tracking variable
DECLARE @SalaryOutput DECIMAL(10,2);
EXEC sp_GetTotalSalaryByDepartment @DepartmentID = 1, @TotalSalary = @SalaryOutput OUTPUT;
SELECT @SalaryOutput AS DepartmentTotalSalary;
GO