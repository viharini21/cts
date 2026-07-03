CREATE OR ALTER PROCEDURE TransferEmployee (
    @EmployeeID INT,
    @NewDepartmentID INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRY
            -- Check if the target department exists
            IF NOT EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @NewDepartmentID)
            BEGIN
                RAISERROR ('Department does not exist.', 16, 1);
            END

            -- Perform the update
            UPDATE Employees
            SET DepartmentID = @NewDepartmentID
            WHERE EmployeeID = @EmployeeID;
        END TRY
        BEGIN CATCH
            -- Inner catch logs the error
            INSERT INTO AuditLog (Action, ErrorMessage)
            VALUES ('Transfer Employee - Validation', ERROR_MESSAGE());

            -- Re-raise to trigger outer catch
            THROW;
        END CATCH
    END TRY
    BEGIN CATCH
        -- Outer catch block handles execution failures
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('Transfer Employee - Execution Failed', ERROR_MESSAGE());
        
        THROW;
    END CATCH
END;