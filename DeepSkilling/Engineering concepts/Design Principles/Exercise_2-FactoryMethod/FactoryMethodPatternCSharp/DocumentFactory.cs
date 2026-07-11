namespace FactoryMethodPatternCSharp
{
    // Creator
    public abstract class DocumentFactory
    {
        public abstract IDocument CreateDocument();
    }
}
