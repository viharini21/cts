CREATE OR ALTER PROCEDURE AddEmployee (
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN
    -- Raise an error (Severity 16) for negative salary
    IF @Salary < 0
    BEGIN
        RAISERROR ('Salary cannot be negative.', 16, 1);
        RETURN;
    END
    -- Raise a warning (Severity 10) for low salary
    ELSE IF @Salary < 1000
    BEGIN
        -- Severity 10 does not jump to the CATCH block
        RAISERROR ('Warning: Salary is below the standard minimum of 1000.', 10, 1);
    END

    BEGIN TRY
        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Insert Employee', ERROR_MESSAGE());
        
        THROW;
    END CATCH
END;