# Sharpen your test writing skills

* You can brush up on different types of tests and more testing concepts in the [Testing concept learning module](../../visual-studio-test-concepts/resources/design-doc.md).
* There are many tools out there to help you write good tests that help make your tests easy to understand, avoid repetition, and help you test any architecture. Let's go over some popular ones and their advantages.

## Fluent Assertions

[Fluent assertions](https://fluentassertions.com/) is a popular set of extension methods provided by the .NET community that can help you clearly identify your assertion methods. It uses more human-readable language making it easier to write and read tests.

```csharp
using FluentAssertions;
...
[TestMethod]
public void AddTest()
{
    var calculator = new Calculator();
    var actual = calculator.Add(1, 1);

    // Fluent assertion
    actual.Should().Be(2).And.NotBe(1);
}
```

  ![image](../media/test-fluent-assertion.png)

## Data driven tests

[Data driven tests](https://docs.microsoft.com/visualstudio/test/how-to-create-a-data-driven-unit-test) (also known as parameterized testing or DDT) allows you to run the same test method a number of times with a variety of parameters. This allows you to avoid repetition in your code while also checking the same function with a whole set of different data inputs. You can input data in-line as shown in the example below or even connect to a database the get input.

```csharp
[DataTestMethod]
[DataRow(1, 1, 2)]
[DataRow(2, 2, 4)]
[DataRow(3, 3, 6)]
[DataRow(0, 0, 1)] // The test run with this row fails
public void AddDataTests(int x, int y, int expected)
{
    var calculator = new Calculator();
    var actual = calculator.Add(x, y);
    Assert.AreEqual(expected, actual);
}
```

  ![image](../media/data-driven-test.png)

## Mocking

* Sometimes the architecture of your code is not as modular as you may want in order to unit test it well. In order to isolate the parts of your code that you are testing without re-writing it you may want to use a mocking framework. Mocking helps you isolate the code you are trying to test by creating stubs or shims of that code's dependencies. This allows the code you are testing to make the required calls to its dependencies without actually testing the dependencies. This helps you focus a unit test down to precisely the behavior you want to test. There are many popular mocking frameworks available including [MOQ](https://github.com/Moq/moq4/wiki/Quickstart) and [Microsoft Fakes](https://docs.microsoft.com/visualstudio/test/isolating-code-under-test-with-microsoft-fakes).
* You can find a [full tutorial for Microsoft Fakes here](https://docs.microsoft.com/visualstudio/test/using-stubs-to-isolate-parts-of-your-application-from-each-other-for-unit-testing), but let's explore a short overview.
  * Note that Microsoft Fakes is only available with Visual Studio Enterprise.
  * Navigate to the test project you want to isolate in the Solution Explorer, right-click on the project that you want to mock under the Project node, and select 'Add Fakes Assembly'

  ![image](../media/test-add-fakes.png)

  * Add the using statements to the test file in which you'd like to use shims and stubs.

    ```csharp
    using LearnMyCalculatorApp.Fakes;
    using Microsoft.QualityTools.Testing.Fakes;
    ```

  * Now you can create stubs or shims for different parts of your code like the example below. In the below test I don't want to really call the Calculator's `Divide` method, I just want to pretend for now that it always returns `1` so I can focus on testing other parts of my code. The shim allows me to do that.

    ```csharp
    [TestMethod]
    public void DivideByZeroWithFakesShim()
    {
        using (ShimsContext.Create())
        {
            // Define what the Divide shim should return
            ShimCalculator.AllInstances.DivideInt32Int32 = (x, y, z) => { return 1; };
    
            var calculator = new Calculator();
            
            // This really calls the DivideInt32Int32
            // defined above to always return 1
            // instead of actually calling Divide
            var actual = calculator.Divide(1, 0); 
            Assert.AreEqual(1, actual);
        }
    }
    
    ```

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->