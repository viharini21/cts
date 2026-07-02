CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)
AS
BEGIN
    -- Check if target department contains any active staff
    IF EXISTS (SELECT 1 FROM Employees WHERE DepartmentID = @DepartmentID)
    BEGIN
        UPDATE Employees
        SET Salary = Salary + @BonusAmount
        WHERE DepartmentID = @DepartmentID;
    END
    ELSE
    BEGIN
        PRINT 'No employees found in the specified department.';
    END
END;
GO

-- Test Execution
EXEC sp_GiveBonus @DepartmentID = 1, @BonusAmount = 500.00;
GO