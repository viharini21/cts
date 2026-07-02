-- a) Recursive CTE Calendar
WITH CalendarCTE AS (
    SELECT CAST('2025-01-01' AS DATE) AS CalendarDate
    UNION ALL
    SELECT DATEADD(day, 1, CalendarDate)
    FROM CalendarCTE
    WHERE CalendarDate < '2025-01-31'
)
SELECT CalendarDate FROM CalendarCTE
OPTION (MAXRECURSION 31);

-- b) MERGE Statement (Updates price if product matches, inserts if brand new)
MERGE Products AS Target
USING StagingProducts AS Source
ON (Target.ProductID = Source.ProductID)
WHEN MATCHED THEN
    UPDATE SET Target.Price = Source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Category, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Category, Source.Price);