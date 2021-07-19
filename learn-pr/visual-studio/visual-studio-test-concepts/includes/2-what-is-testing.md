When you test, either by writing code or performing manual testing, you do so because you want to ensure that your software works as intended. This unit focuses on writing code that tests various parts of your application code. The test code won't ship with the application code. Think of test code as scaffolding that supports the software development process throughout your program's lifetime.

Let's start by defining testing with some examples before we dive into the concepts.

## The testing process

Testing involves a series of test methods that run against your product code and return a pass or fail result. The result is based on certain criteria that is asserted. Test results appear in a list of red "x" to represent failing tests and green "✔" to represent passing tests. These symbols make it easy to assess what functionality is working or not at a glance.

:::image type="content" source="../media/test-intro-testlist.png" alt-text="Screenshot of table showing how tests appear in a list with passing and failing results in Visual Studio Test Explorer.":::

## Test Method definition

Tests are very much like regular methods. They're organized within Test Classes, have method signatures, and accept parameters. Tests reference and call your product code (another way of saying your non-test code) and compare how it behaves to an expected outcome.

```csharp
[TestMethod]
public void AddTest()
{
    // Arrange
    var calculator = new Calculator();

    // Act
    var actual = calculator.Add(1, 1);

    // Assert
    Assert.AreEqual(2, actual);
}
```

In the code above, the product code is the `Calculator` class and its `Add()` method. The comparison happens when calling `Assert.AreEqual(2, actual)`. This pattern is something you find in most if not all test methods.
Here's how this test would appear in Visual Studio:
:::image type="content" source="../media/test-intro-testmethod.png" alt-text="Screenshot of Test method in Visual Studio editor. There is a call out where the test is referencing product code. Another call out highlights where results are asserted.":::

One difference between tests and product code is they don't run as part of your app's normal function. So instead of using F5 (or the large green run button at the top of your development environment) to run as you would your app, you choose which tests to run either via a Test Explorer or many other helpful editor tools. You can think of tests as scaffolding. Tests are there for support, but are not shipped with the app and because of this, they are run independently like their own app.

:::image type="content" source="../media/test-intro-runtests-collage.png" alt-text="Screenshot of buttons and commands for running or debugging tests from the Visual Studio Test Explorer or Editor.":::

## How can tests help prevent regressions in functionality?

Remember the phone number bug from the intro scenario? As soon as new code was added to accept international phone numbers, the function for adding domestic phone numbers broke! A test using domestic phone numbers as input may have caught this behavior change sooner. It would have tested not only the new functionality for international numbers, but also the old functionality for domestic phone numbers.

As we implement new code, it may not always occur to us what old scenarios could be impacted by new changes. The phone numbers are a simple example, but imagine apps with hundreds of different input formats and needing to check that code every time. Tests make it easy for all variations of the old behavior to be checked with a simple test run.

:::image type="content" source="../media/test-intro-phone-example.png" alt-text="Screenshot of a test titled CheckDomesticPhoneNumber in the Visual Studio editor showing a failure message.":::
