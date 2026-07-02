-- 1. Using ROW_NUMBER() (Strict sequential numbers: 1, 2, 3...)
WITH RankedProductsRows AS (
    SELECT ProductID, ProductName, Category, Price,
           ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRowNo
    FROM Products
)
SELECT * FROM RankedProductsRows WHERE PriceRowNo <= 3;

-- 2. Using RANK() (Skips rank positions if there's a tie: 1, 2, 2, 4...)
WITH RankedProductsRank AS (
    SELECT ProductID, ProductName, Category, Price,
           RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRank
    FROM Products
)
SELECT * FROM RankedProductsRank WHERE PriceRank <= 3;

-- 3. Using DENSE_RANK() (Consecutive ranks even with ties: 1, 2, 2, 3...)
WITH RankedProductsDense AS (
    SELECT ProductID, ProductName, Category, Price,
           DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceDenseRank
    FROM Products
)
SELECT * FROM RankedProductsDense WHERE PriceDenseRank <= 3;