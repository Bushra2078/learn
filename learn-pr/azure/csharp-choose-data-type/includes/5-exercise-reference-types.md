Reference types include arrays, classes, and strings.  Reference types are treated differently from value types with regards to the way values are stored when the application is executing.

In this exercise, we'll learn how reference types are different from value types, and how to use the `new` operator to associate a variable with a value in the computer's memory.

## How reference types are different from value types

A value type variable will store its values directly in an area of storage called the *stack*.  The **stack** is memory allocated to the code that is currently running on the CPU (also known as the stack frame, or activation frame).  When the stack frame has finished executing, the values in the stack are removed.

A reference type variable will store its values in a separate memory region called the *heap*.  The **heap** is a memory area that is shared across many applications running on the operating system at the same time.  The .NET Runtime communicates with the operating system to determine what memory addresses are available, and requests an address where it can store the value.  The .NET Runtime stores the value, then returns the memory address to the variable.  When your code uses the variable, the .NET Runtime seemlessly looks up the address stored in the variable and retrieves the value that's stored there.

Let's write some code that illustrates these ideas more clearly.

### Step 1: Delete or comment out code from previous exercises.

Select the code from the previous exercise and select the backspace or `del` key.  Optionally, comment out the previous code in the .NET Editor.

### Step 2: Define a reference type variable.

The following code defines a variable that can hold a value of type `int` array.

```csharp-interactive
int[] data;
```
At this point, `data` is merely a variable that could hold a reference, or rather, a memory address of a value in the heap.  Since it is not pointing to a memory address, it is called a *null reference*.

### Step 3: Create an instance of `int` array using the `new` keyword.

Modify the code from step 3 to create and assign a new instance of `int` array using the following code.

```csharp-interactive
int[] data;
data = new int[3];
```
The `new` keyword tells the .NET Runtime to create an instance of `int` array then coordinate with the operating system to store it in memory.  The .NET Runtime complies and returns a memory address of the new `int` array.  Finally, the memory address is stored in the variable data.  The `int` array's elements default to the value `0` since that is the default value of an `int`.

### Step 4: Modify the code example to perform both operations in a single line of code.

The two lines of code in Step 3 are typically shortened to a single line of code to both declare the variable and create a new instance of the `int` array.  Modify the code from Step 3 to the following.

```csharp-interactive
int[] data = new int[3];
```
While there is no output to observe, hopefully this exercise added clarity to how the C# syntax relates to the steps of the process of working with reference types.

### Working with the reference type string

The `string` data type is also a reference type.  You might be wondering why we do not use the `new` operator when declaring a string.  This is purely a convenience afforded by the designers of C#.  Since the `string` data type is used so frequently, we can use this format:

```csharp-interactive
string shortenedString = "Hello World!";
Console.WriteLine(shortenedString);
```
Behind the scenes, the following code is executed.

```csharp
System.String fullString = new System.String("Hello World!");
Console.WriteLine(shortenedString);
```

> [!NOTE]
> When the language designers create a simplified shortcut, it is sometimes known as "syntactic sugar".  You will likely see this phrase used in articles, videos and in presentations.

## Recap

- Value types can hold smaller values and are stored in the stack.  Reference types can hold large values, and a new instance of a reference type is created using the `new` operator.  Reference type variables hold a reference (the memory address) to the actual value stored in the heap.
- Reference types include arrays, strings, and classes.