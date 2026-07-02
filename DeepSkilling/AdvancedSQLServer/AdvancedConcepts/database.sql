CREATE DATABASE OnlineRetailStore;
GO

USE OnlineRetailStore;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE StagingProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT
);

INSERT INTO Customers VALUES 
(1, 'Alice', 'North'), (2, 'Bob', 'South'), (3, 'Charlie', 'North'), (4, 'David', 'East');

INSERT INTO Products VALUES 
(101, 'Laptop', 'Electronics', 1200.00),
(102, 'Phone', 'Electronics', 800.00),
(103, 'Headphones', 'Electronics', 150.00),
(104, 'Desk Chair', 'Furniture', 250.00),
(105, 'Dining Table', 'Furniture', 600.00),
(106, 'Sofa', 'Furniture', 900.00);

INSERT INTO StagingProducts VALUES 
(101, 'Laptop', 'Electronics', 1150.00),
(107, 'Tablet', 'Electronics', 400.00);   

INSERT INTO Orders VALUES 
(1, 1, '2025-01-05'), (2, 1, '2025-01-12'), (3, 2, '2025-01-15'), 
(4, 1, '2025-02-02'), (5, 1, '2025-02-10'), (6, 3, '2025-01-20');

INSERT INTO OrderDetails VALUES 
(1, 1, 101, 1), (2, 2, 102, 2), (3, 3, 104, 1), 
(4, 4, 103, 4), (5, 5, 101, 1), (6, 6, 105, 1);
GO