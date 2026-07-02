SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees
WHERE EmployeeID = 1;
GO