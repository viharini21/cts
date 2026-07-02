CREATE PROCEDURE sp_UpdateSalaryWithErrorHandling
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        -- Raise custom validation error if input boundary check fails
        IF @NewSalary < 0
        BEGIN
            RAISERROR('Salary value cannot be a negative amount.', 16, 1);
        END

        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;
    END TRY
    BEGIN CATCH
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS CustomErrorMessage,
            ERROR_SEVERITY() AS ErrorSeverity;
    END CATCH
END;
GO

-- Test Execution (Triggers the custom error block handling gracefully)
EXEC sp_UpdateSalaryWithErrorHandling @EmployeeID = 3, @NewSalary = -1500.00;
GO