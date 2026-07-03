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
    -- Validate salary first
    IF @Salary <= 0
    BEGIN
        RAISERROR ('Salary must be greater than zero.', 16, 1);
        RETURN; -- Stop execution
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