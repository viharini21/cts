-- 1. First modify the bonus calculation rule back to 15%
ALTER FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- 2. Alter the nested structure to compute using the updated bonus rates
ALTER FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary) + (dbo.fn_CalculateBonus(@Salary) * 12);
END;
GO

-- Test Verification run to observe the modified, higher payout values
SELECT 
    EmployeeID, 
    FirstName, 
    Salary, 
    dbo.fn_CalculateTotalCompensation(Salary) AS UpdatedAnnualCompensation
FROM Employees;
GO