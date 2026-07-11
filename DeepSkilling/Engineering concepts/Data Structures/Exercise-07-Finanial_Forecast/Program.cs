using System;

class Program
{
    // Recursive method
    public static double PredictFutureValue(double amount, double growthRate, int years)
    {
        // Base Case
        if (years == 0)
            return amount;

        // Recursive Case
        return PredictFutureValue(
            amount * (1 + growthRate / 100),
            growthRate,
            years - 1
        );
    }

    static void Main()
    {
        // Predefined values
        double initialAmount = 10000;
        double growthRate = 10;
        int years = 3;

        double futureValue =
            PredictFutureValue(initialAmount, growthRate, years);

        Console.WriteLine($"Initial Amount : {initialAmount}");
        Console.WriteLine($"Growth Rate    : {growthRate}%");
        Console.WriteLine($"Years          : {years}");
        Console.WriteLine($"Future Value   : {futureValue:F2}");
    }
}