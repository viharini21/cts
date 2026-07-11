## Getting Started 
Automated Testing: Using software/scripts to automatically test another software.
Benefits: Faster, reusable, accurate, saves time, supports continuous testing, reduces long-term cost.
Unit Test: Tests a single method/function.
Integration Test: Tests interaction between modules.
System Test: Tests the complete application.
Acceptance Test: Verifies software meets customer requirements.
Regression Test: Ensures existing features still work after changes.
Smoke Test: Quick check that major functionality works.
Performance Test: Measures speed, scalability, and responsiveness.
Test Pyramid: Many Unit Tests, fewer Integration Tests, very few UI Tests.
NUnit: Popular C# testing framework using attributes like [Test], [TestFixture], Assert.AreEqual(), and Visual Studio's Test Explorer.
TDD: Follow Red → Green → Refactor: write the test first, make it pass with minimal code, then improve the code safely.

## Fundamentals of Unit Testing
| Topic               | One-Line Definition                                                                    |
| ------------------- | -------------------------------------------------------------------------------------- |
| Good Unit Test      | Fast, independent, repeatable, isolated, and easy to understand.                       |
| What to Test        | Business logic, calculations, validation rules, and method behavior.                   |
| What Not to Test    | Framework code, simple getters/setters, UI, and third-party libraries.                 |
| Naming Tests        | Use `MethodName_Condition_ExpectedResult` for clear, descriptive names.                |
| Black-box Testing   | Test functionality based only on inputs and outputs, without seeing the internal code. |
| SetUp               | Runs before each test to initialize objects or test data.                              |
| TearDown            | Runs after each test to clean up resources.                                            |
| Parameterized Tests | Run the same test with multiple input values using attributes like `[TestCase]`.       |
| Ignoring Tests      | Use `[Ignore]` to temporarily skip a test.                                             |
| Trustworthy Tests   | Should be deterministic, independent, focused, and give reliable results every time.   |
