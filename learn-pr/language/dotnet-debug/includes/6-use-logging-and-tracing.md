Now that the application is started development it is good to add additional diagnostics to the logic to help developers as they add new features. This can be accomplished by leveraging our new learnings on debug diagnostics.

## Write to the debug console

Before debugging the application let's add additional debug diagnostics. This will help  diagnose the application while it is being run under debug. 

At the top of the `Program.cs` file we will add a new `using` statement to bring in `System.Diagnostics` so we can use the `Debug` methods.

```csharp
using System;
using System.Diagnostics;
```

Add a `WriteLine` statement at the start of the `Fibonacci` method to get clarity when debugging through the code.

```csharp
Debug.WriteLine($"Entering {nameof(Fibonacci)} method");
Debug.WriteLine($"We are looking for the {n}th number");
```

At the end of our `for` loop we could print out every value, or use a  conditional print statement by using `WriteIf` or `WriteLineIf`. Add a print a line only when `sum` is 1 at the end of the for loop.

```csharp
for (int i = 2; i <= n; i++)
{                  
    sum = n1 + n2;
    n1 = n2;
    n2 = sum;
    Debug.WriteLineIf(sum == 1, $"sum is 1, n1 is {n1}, n2 is {n2}");    
}
```

Debug the application and you should see the following output:

```output
Entering Fibonacci method
We are looking for the 5th number
1 is 1, n1 is 1, n2 is 1
```

## Check for conditions with Assert

In some situations, you may want to stop the entire running application when a certain condition is not met. Using `Debug.Assert` allows you to check for a condition and output additional information about the state of the application. Let's add a check right before the return statement to ensure n2 is 5.

```csharp
// If n2 is 5 continue, else break.
Debug.Assert(n2 == 5, "The return value is not 5 and it should be.");
return n == 0 ? n1 : n2;
```
Our application logic is already correct so, let's update our `Fibonacci(5);` to `Fibonacci(6);` which will have a different result.

Debug the application and note that when `Debug.Assert` is run in the code the debugger stops the application so you can inspect variables, watch window, call stack, and more. It also outputs the message to the debug console.

```output
---- DEBUG ASSERTION FAILED ----
---- Assert Short Message ----
The return value is not 5 and it should be.
---- Assert Long Message ----

   at DotNetDebugging.Program.Fibonacci(Int32 n) in C:\Users\jamont\Downloads\DotNetDebugging\Program.cs:line 29
   at DotNetDebugging.Program.Main(String[] args) in C:\Users\jamont\Downloads\DotNetDebugging\Program.cs:line 10
```

Stop debugging, and then run the application without debug by entering the following command in the terminal:

```bash
dotnet run
```

Note that the application is terminated after the assertion has failed and information has been logged to the application output:

```output
Process terminated. Assertion failed.
The return value is not 5 and it should be.
   at DotNetDebugging.Program.Fibonacci(Int32 n) in C:\Users\jamont\Downloads\DotNetDebugging\Program.cs:line 29
   at DotNetDebugging.Program.Main(String[] args) in C:\Users\jamont\Downloads\DotNetDebugging\Program.cs:line 10
```

Now, let's run the application in `Release` configuration with the following command in the terminal:

```bash
dotnet run --configuration Release
```

Note that the application successfully runs to completion because we are no longer in the `Debug` configuration.

Congratulations, you have successfully and efficiently debugged code using features of .NET including `Debug.WriteLine` and `Debug.Assert`. Well done!
