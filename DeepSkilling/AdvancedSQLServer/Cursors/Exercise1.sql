-- Declare local variables to hold the fetched column values
DECLARE @EmpID INT;
DECLARE @FName VARCHAR(50);
DECLARE @LName VARCHAR(50);
DECLARE @DeptID INT;
DECLARE @EmpSalary DECIMAL(10,2);
DECLARE @EmpJoinDate DATE;

-- 1. Declare the cursor
DECLARE emp_cursor CURSOR FOR
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
FROM Employees;

-- 2. Open the cursor
OPEN emp_cursor;

-- 3. Fetch the first row into the variables
FETCH NEXT FROM emp_cursor 
INTO @EmpID, @FName, @LName, @DeptID, @EmpSalary, @EmpJoinDate;

-- 4. Loop through and print the details of each employee
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Employee ID: ' + CAST(@EmpID AS VARCHAR(10)) + 
          ' | Name: ' + @FName + ' ' + @LName + 
          ' | Dept ID: ' + CAST(@DeptID AS VARCHAR(10)) + 
          ' | Salary: $' + CAST(@EmpSalary AS VARCHAR(10)) + 
          ' | Joined: ' + CAST(@EmpJoinDate AS VARCHAR(12));

    -- Fetch the next row
    FETCH NEXT FROM emp_cursor 
    INTO @EmpID, @FName, @LName, @DeptID, @EmpSalary, @EmpJoinDate;
END;

-- 5. Close and deallocate the cursor to free memory
CLOSE emp_cursor;
DEALLOCATE emp_cursor;
GO