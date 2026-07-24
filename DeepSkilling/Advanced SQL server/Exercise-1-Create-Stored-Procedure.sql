-- ==========================================
-- Exercise 1 : Ranking and Window Functions
-- ==========================================

-- Create Products Table

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Sample Data

INSERT INTO Products VALUES
(1,'Laptop','Electronics',80000),
(2,'Mobile','Electronics',60000),
(3,'Tablet','Electronics',40000),
(4,'Smart Watch','Electronics',20000),

(5,'Shoes','Fashion',3000),
(6,'Jacket','Fashion',5000),
(7,'Watch','Fashion',7000),
(8,'T-Shirt','Fashion',1500),

(9,'Sofa','Furniture',25000),
(10,'Dining Table','Furniture',35000),
(11,'Chair','Furniture',5000);

-- Ranking Functions

SELECT
    ProductID,
    ProductName,
    Category,
    Price,

    ROW_NUMBER() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS RowNumber,

    RANK() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS RankNumber,

    DENSE_RANK() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS DenseRankNumber

FROM Products;

-- Top 3 Products in each Category

WITH ProductRanking AS
(
    SELECT
        ProductID,
        ProductName,
        Category,
        Price,

        ROW_NUMBER() OVER
        (
            PARTITION BY Category
            ORDER BY Price DESC
        ) AS RowNumber

    FROM Products
)

SELECT *
FROM ProductRanking
WHERE RowNumber <= 3;