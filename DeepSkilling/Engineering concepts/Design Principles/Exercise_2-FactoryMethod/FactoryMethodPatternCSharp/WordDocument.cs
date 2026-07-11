namespace FactoryMethodPatternCSharp
{
    public class WordDocument : IDocument
    {
        public void Open()
        {
            System.Console.WriteLine("Opening Word Document");
        }
    }
}
