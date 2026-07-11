using System;

// =========================================
// Product Class
// Represents a product in the e-commerce platform
// =========================================
class Product
{
    public int ProductId;
    public string ProductName;
    public string Category;

    public Product(int id, string name, string category)
    {
        ProductId = id;
        ProductName = name;
        Category = category;
    }
}

// =========================================
// Search Operations Class
// =========================================
class SearchOperations
{
    // Linear Search
    public static Product LinearSearch(Product[] products, int targetId)
    {
        foreach (Product product in products)
        {
            if (product.ProductId == targetId)
            {
                return product;
            }
        }

        return null;
    }

    // Binary Search
    public static Product BinarySearch(Product[] products, int targetId)
    {
        int left = 0;
        int right = products.Length - 1;

        while (left <= right)
        {
            int mid = left + (right - left) / 2;

            if (products[mid].ProductId == targetId)
            {
                return products[mid];
            }

            if (products[mid].ProductId < targetId)
            {
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
            }
        }

        return null;
    }
}

// =========================================
// Main Class
// =========================================
class Program
{
    static void Main()
    {
        // Sorted array for Binary Search
        Product[] products =
        {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Mobile", "Electronics"),
            new Product(103, "Shoes", "Fashion"),
            new Product(104, "Watch", "Accessories"),
            new Product(105, "Headphones", "Electronics")
        };

        Console.Write("Enter Product ID to search: ");
        int targetId = Convert.ToInt32(Console.ReadLine());

        // Linear Search
        Product linearResult =
            SearchOperations.LinearSearch(products, targetId);

        if (linearResult != null)
        {
            Console.WriteLine("\nLinear Search Result:");
            Console.WriteLine($"ID: {linearResult.ProductId}");
            Console.WriteLine($"Name: {linearResult.ProductName}");
            Console.WriteLine($"Category: {linearResult.Category}");
        }
        else
        {
            Console.WriteLine("\nProduct not found using Linear Search.");
        }

        // Binary Search
        Product binaryResult =
            SearchOperations.BinarySearch(products, targetId);

        if (binaryResult != null)
        {
            Console.WriteLine("\nBinary Search Result:");
            Console.WriteLine($"ID: {binaryResult.ProductId}");
            Console.WriteLine($"Name: {binaryResult.ProductName}");
            Console.WriteLine($"Category: {binaryResult.Category}");
        }
        else
        {
            Console.WriteLine("\nProduct not found using Binary Search.");
        }
    }
}
