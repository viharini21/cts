-- A) GROUPING SETS: Specific summary combinations
SELECT c.Region, p.Category, SUM(od.Quantity) AS TotalQuantitySold
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY GROUPING SETS ((c.Region, p.Category), (c.Region), (p.Category), ());

-- B) ROLLUP: Hierarchical subtotals (Region > Category) + Grand Total
SELECT c.Region, p.Category, SUM(od.Quantity) AS TotalQuantitySold
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ROLLUP (c.Region, p.Category);

-- C) CUBE: Every possible combination of subtotals across both columns
SELECT c.Region, p.Category, SUM(od.Quantity) AS TotalQuantitySold
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY CUBE (c.Region, p.Category);