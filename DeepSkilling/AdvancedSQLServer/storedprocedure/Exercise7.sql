CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

-- Test Execution
EXEC sp_UpdateEmployeeSalary @EmployeeID = 1, @NewSalary = 5500.00;
GO