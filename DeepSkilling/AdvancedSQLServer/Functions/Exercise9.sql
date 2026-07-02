-- Re-creating the 10% bonus function for Exercise 9 dependency tracking
CREATE FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

-- Creating the Nested Total Compensation Function
CREATE FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    -- Combines annual base earnings along with annual bonus allocations
    RETURN dbo.fn_CalculateAnnualSalary(@Salary) + (dbo.fn_CalculateBonus(@Salary) * 12);
END;
GO

-- Testing the nested output evaluation logic
SELECT 
    EmployeeID, 
    FirstName, 
    Salary, 
    dbo.fn_CalculateTotalCompensation(Salary) AS TotalAnnualCompensation
FROM Employees;
GO