CREATE OR ALTER PROCEDURE BatchInsertEmployees
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Simulating multiple employee inserts
        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (101, 'John', 'Doe', 'john.doe@email.com', 5000, 1);

        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (102, 'Jane', 'Smith', 'jane.smith@email.com', 6000, 2);

        -- Commits only if ALL inserts above are successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- If an error occurs, rollback any successful inserts in this batch
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        -- Log the error that caused the rollback
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Batch Insert Employees', ERROR_MESSAGE());
    END CATCH
END;