WITH CustomerOrderCounts AS (
    SELECT o.CustomerID, COUNT(o.OrderID) AS OrderCount
    FROM Orders o
    GROUP BY o.CustomerID
)
SELECT c.CustomerID, c.Name, coc.OrderCount
FROM CustomerOrderCounts coc
JOIN Customers c ON c.CustomerID = coc.CustomerID -- Fixed the missing '=' typo from the PDF instruction sheet
WHERE coc.OrderCount > 0;