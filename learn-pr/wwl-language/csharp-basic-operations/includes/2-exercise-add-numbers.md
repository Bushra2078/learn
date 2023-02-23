Often, we'll want to perform mathematical operations on numeric data. We'll start with addition in this unit and expand to other operations in the next unit, because there's an important lesson to learn about how the C# compiler parses and interprets your code.

## Step 1: Add two numeric values

To add two numbers together, we'll use the *addition operator*, which is the plus symbol `+`. Yes, the same plus symbol `+` that you use for string concatenation is also the one you'll use for addition. The reuse of one symbol for multiple purposes is sometimes called "overloading the operator," and it happens frequently in C#.

In this instance, the C# compiler understands what you're attempting to do. The compiler parses your code and sees that the `+` (the operator) is surrounded by two numeric values (the operands). Given the data types of the variables (both are `int`s), the compiler figures out that you intended to add those two values.

Add the following code in the .NET Editor:

```csharp-interactive
int firstNumber = 12;
int secondNumber = 7;
Console.WriteLine(firstNumber + secondNumber);
```

Now, run the code. You'll get the following result in the output console:

```output
19
```

### Step 2: Mix data types to force implicit type conversions

What happens if we try to use the `+` symbol with both `string` and `int` values?

Modify the code you just ran to match the following code:

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine(firstName + " sold " + widgetsSold + " widgets.");
```

Now, run the code. You'll get the following result in the output console:

```output
Bob sold 7 widgets.
```

In this case, the C# compiler understands that we want to use the `+` symbol to concatenate the two operands. It deduces this because the `+` symbol is surrounded by operands of `string` and `int` data types, so it attempts to implicitly convert the `int` variable `widgetsSold` into a `string` temporarily so it can concatenate it to the rest of the string. The C# compiler tries to help you when it can, but ideally, you'd be explicit about your intentions.

> [!NOTE]
> There's a lot more to converting one data type into another. The [Convert data types using casting and conversion techniques in C#](/training/modules/csharp-convert-cast/) module can help you understand how to convert values from one data type to another.

### Step 3: Attempt a more advanced case of adding numbers and concatenating strings

Modify the code in the .NET Editor to match the following code:

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine(firstName + " sold " + widgetsSold + 7 + " widgets.");
```

When you run the code, you'll get the following output:

```output
Bob sold 77 widgets.
```

Instead of adding the `int` variable `widgetsSold` to the literal `int` `7`, the compiler treats everything as a string and concatenates it all together.

### Step 4: Add parentheses to make our intention clear to the compiler

Modify the code in the .NET Editor to match the following code:

```csharp-interactive
string firstName = "Bob";
int widgetsSold = 7;
Console.WriteLine(firstName + " sold " + (widgetsSold + 7) + " widgets.");
```

When you run the code, you'll get the following output:

```output
Bob sold 14 widgets.
```

The parentheses symbol `()` becomes another overloaded operator. In this case, the opening and closing parentheses form the *order of operations* operator, just like you might use in a mathematical formula. We indicate that we want the innermost parentheses resolved first, resulting in the addition of `int` values `widgetsSold` and the value `7`. Once that's resolved, the code will implicitly convert the result to a string so that it can be concatenated with the rest of the message.

> [!NOTE]
> You should probably avoid performing both a calculation and concatenation in a single line of code. The point here is to help you understand how to view operators and operands the way the compiler does.

## Recap

Here are the primary ideas you should take away from this exercise:

- You can perform mathematical-like addition operations on numbers.
- Both string concatenation and addition use the plus `+` symbol. This is called *overloading an operator*, and the compiler infers the proper use based on the data types on which it's operating.
- When it can, the C# compiler will implicitly convert an `int` into a `string` if it's obvious that the developer is trying to concatenate the string representation of a number for presentation purposes.
- You can use parentheses to define an order of operations to explicitly tell the compiler that you want to perform certain operations before other operations.
