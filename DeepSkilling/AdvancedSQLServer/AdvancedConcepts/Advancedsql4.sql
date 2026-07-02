-- 1 & 2: PIVOTing Monthly Sales Rows into Horizontal Columns
SELECT ProductID, ISNULL([January], 0) AS January, ISNULL([February], 0) AS February
FROM (
    SELECT ProductID, DATENAME(month, OrderDate) AS SaleMonth, Quantity
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
) AS SourceTable
PIVOT (
    SUM(Quantity)
    FOR SaleMonth IN ([January], [February])
) AS PivotedTable;

-- 3: UNPIVOTing cross-tab data back to normalized rows
-- (We use a temporary CTE representation of your pivoted summary to unpivot it back)
WITH PivotedSummary AS (
    SELECT ProductID, ISNULL([January], 0) AS January, ISNULL([February], 0) AS February
    FROM (
        SELECT ProductID, DATENAME(month, OrderDate) AS SaleMonth, Quantity
        FROM Orders o
        JOIN OrderDetails od ON o.OrderID = od.OrderID
    ) AS Src
    PIVOT (SUM(Quantity) FOR SaleMonth IN ([January], [February])) AS Pvt
)
SELECT ProductID, SaleMonth, TotalQuantity
FROM PivotedSummary
UNPIVOT (
    TotalQuantity FOR SaleMonth IN ([January], [February])
) AS UnpivotedTable;