CREATE PROCEDURE sp_GetEmployeesDynamic
    @FilterColumn NVARCHAR(50),
    @FilterValue NVARCHAR(50)
AS
BEGIN
    DECLARE @DynamicSQL NVARCHAR(MAX);
    DECLARE @ParameterDefinition NVARCHAR(500);

    -- Sanitize input by checking against known column options to avoid SQL injection vulnerability
    IF @FilterColumn IN ('FirstName', 'LastName', 'DepartmentID')
    BEGIN
        SET @DynamicSQL = N'SELECT * FROM Employees WHERE ' + QUOTENAME(@FilterColumn) + N' = @Value';
        SET @ParameterDefinition = N'@Value NVARCHAR(50)';
        
        EXEC sp_executesql @DynamicSQL, @ParameterDefinition, @Value = @FilterValue;
    END
    ELSE
    BEGIN
        RAISERROR('Invalid column filter parameter provided.', 16, 1);
    END
END;
GO

-- Test Execution
EXEC sp_GetEmployeesDynamic @FilterColumn = 'LastName', @FilterValue = 'Smith';
GO