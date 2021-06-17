The most widely used branching statement is the `if` statement. The `if` statement relies on a Boolean expression that is enclosed in a set of parentheses. If the expression is true, the code following the if statement will be executed. If not, the .NET runtime will ignore the code and won't execute it.

## Create a random game

Let's invent a game to help us write `if` statements. We'll make up several rules to the game, then implement them in code.

We'll use the `Random.Next()` method to simulate rolling three 6-sided dice. We'll evaluate the values to calculate the score. If the score is greater than an arbitrary total, then we'll display a winning message to the user. Otherwise, we'll display a losing message to the user.

- If any two dice you roll result in the same value, you get two bonus points for rolling doubles.
- If all three dice you roll result in the same value, you get six bonus points for rolling triples.
- If the sum of the three dice rolls, plus any point bonuses, is 15 or greater, you win the game. Otherwise, you lose.

We'll add to the number of rules as we expand our understanding of the `if` statement.

> [!Important]
> We'll make extensive use of the `System.Random` class which we covered in the module "Call methods from the .NET Class Library using C#". If you need a refresher how `Random.Next()` works, please refer to that module.

### Step 1 - Write code that generates three random numbers and displays them in output

Delete the code from all previous steps by highlighting the code and selecting the backspace key on the keyboard.

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");
```

We create a new instance of the `System.Random` class and store the reference to that object in the `dice` variable. Then, we call the `Random.Next()` method on the `dice` object three times, providing both the lower and upper bounds to restrict the possible values between `1` and `6`. We save the three random numbers in the variables `roll1`, `roll2`, and `roll3`, respectively.

Next, we sum up the three dice rolls and save the value into the `total` variable.

Finally, we display all the values using string interpolation.

When you run the code, you should see the following message (the numbers will be different).

```output
Dice roll: 4 + 5 + 2 = 11
```
Step 1 was a setup step. Now, we can add the decision logic into our code to make the game more interesting.

### Step 2 - Add an if statement to display different messages based on the value of the total variable

Modify the code from the previous step to include the if statement.

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if (total > 14)
{
    Console.WriteLine("You win!");
}

if (total < 15)
{
    Console.WriteLine("Sorry, you lose.");
}
```

We added two `if` statements to handle the winning and losing scenarios. Let's focus on the first `if` statement.

The `if` statement is made up of three parts:

- The `if` keyword
- A *Boolean expression* between parenthesis `()`
- A *code block* defined by curly braces `{ }`

At run time, the Boolean expression `total > 14` is evaluated. If this is a true statement -- if the value of `total` is greater than `14` -- then the flow of execution will continue into the code defined in the code block. In other words, it will execute the code in the curly braces.

However, if the Boolean expression is false -- the value of `total` not greater than `14` -- then the flow of execution will skip past the code block. In other words, it will not execute the code in the curly braces.

Finally, the second `if` statement controls the message if the user loses. In the next unit, we'll use a variation on the `if` statement to shorten these two statements into a single statement and more clearly express our intent.

### What is a Boolean expression?

A Boolean expression is any code that returns a boolean value, either `true` or `false`. The simplest boolean expressions are simply the values `true` and `false`. Alternatively, a boolean expression could be the result of a method that returns the value `true` or `false`. For example, here's a simple code example using the `string.Contains()` method to evaluate whether one string contains another string.

```csharp-interactive
string message = "The quick brown fox jumps over the lazy dog.";
bool result = message.Contains("dog");
Console.WriteLine(result);

if (message.Contains("fox"))
{
    Console.WriteLine("What does the fox say?");
}
```

Since the `message.Contains("fox")` returns a `true` or `false` value, it qualifies as a boolean expression, and can be used in an `if` statement.

Other simple boolean expressions can be created by using operators to compare two values. Operators include:

- `==`, the "equals operator" to test for equality
- `>`, the "greater than operator", to test that the value on the left is greater than the value on the right
- `<`, the "less than operator" to test that the value on the left is less than the value on the right
- `>=`, the "greater than or equal to operator"
- `<=`, the "less than or equal to operator"
- and so on

> [!Note]
> We devote an entire module to Boolean expressions. There are many operators we can use to construct a boolean expression, and we'll only cover a few of the basics here. See the module "Evaluate boolean expressions to make decisions in C#".

In our example, we evaluated the Boolean expression `total > 14`. However, we could have chosen the boolean expression `total >= 15`, since in this case they're the same. Given that the rules to our game specify "If the two dice, plus any bonuses, is 15 or greater, you win the game", we should probably prefer the latter. We'll make that change in the next step of the exercise.

### What is a code block?

A code block is a collection of one or more lines of code that are defined by an opening and closing curly brace symbol `{ }`. It represents a complete unit of code that has a single purpose in our software system. In this case, at runtime, all lines of code in the code block are executed if the Boolean expression is true. Conversely, if the boolean expression is false, all lines of code in the code block are ignored.

There are code blocks at many levels in C#. In fact, .NET Editor hides the fact that our code is being executed inside of a code block that defines a method. You'll see this more acutely as you begin to write C# code using Visual Studio Code or the Visual Studio IDE.

Code blocks can contain other code blocks. We'll see that demonstrated later in this module as we nest one `if` statement inside of another.

> [!Note]
> We devote an entire module to code blocks. Code blocks are central to understanding code organization and structure, and define the boundaries of variable scope. See the module "Control variable scope and logic using code blocks in C#".

### Step 3 - Add another if statement to implement the doubles bonus

Next, let's implement the rule: "If any two dice you roll result in the same value, you get two bonus points for rolling doubles". Modify the code from the previous step to match the following code listing:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    Console.WriteLine("You rolled doubles! +2 bonus to total!");
    total += 2;
}

if (total >= 15)
{
    Console.WriteLine("You win!");
}

if (total < 15)
{
    Console.WriteLine("Sorry, you lose.");
}
```

Here we combine three boolean expressions to create one large Boolean expression in a single line of code. This is sometimes called a *compound condition*. We have one outer set of parenthesis that combines three inner sets of parenthesis separated by two pipe characters.

The double pipe characters `||` are the **logical OR** operator, which basically says "either the expression to my left OR the expression to my right must be true in order for the entire Boolean expression to be true". If both boolean expressions are false, then entire boolean expression is false. We use two logical OR operators so that we can extend the evaluation to a third boolean expression.

First, we evaluate `(roll1 == roll2)`. If that's true, then the entire expression is true. If it's false, we evaluate `(roll2 == roll3)`. If that's true, then the entire expression is true. If it's false, we evaluate `(roll1 == roll3)`. If that's true, then the entire expression is true. If that is false, then the entire expression is false.

If the large Boolean expression is true, then we execute the code block below. This time, there are two lines of code. The first line of code prints a message to the user. The second line of code increments the value of `total` by `2`.

Finally, we also changed the check to see if the user won to use the `>=` operator, which more closely resembles the requirement we created as we began, but should function identically to what we wrote previously.

```csharp
if (total >= 15)
```

### Step 4 - Add another if statement to implement the triples bonus

Next, let's implement the rule: "If all three dice you roll result in the same value, you get six bonus points for rolling triples."  Modify the code from the previous steps to match the following code listing:

```csharp-interactive
Random dice = new Random();

int roll1 = dice.Next(1, 7);
int roll2 = dice.Next(1, 7);
int roll3 = dice.Next(1, 7);

int total = roll1 + roll2 + roll3;

Console.WriteLine($"Dice roll: {roll1} + {roll2} + {roll3} = {total}");

if ((roll1 == roll2) || (roll2 == roll3) || (roll1 == roll3))
{
    Console.WriteLine("You rolled doubles! +2 bonus to total!");
    total += 2;
}

if ((roll1 == roll2) && (roll2 == roll3)) 
{
    Console.WriteLine("You rolled triples! +6 bonus to total!");
    total += 6;
}

if (total >= 15)
{
    Console.WriteLine("You win!");
}

if (total < 15)
{
    Console.WriteLine("Sorry, you lose.");
}
```

Here we combine two Boolean expressions to create one large boolean expression in a single line of code. We have one outer set of parenthesis that combines two inner sets of parenthesis separated by two ampersand characters.

The double ampersand characters `&&` are the **logical AND** operator, which basically says "only if both expressions are true, then the entire expression is true". In this case, if `roll1` is equal to `roll2`, and `roll2` is equal to `roll3`, then by deduction, `roll1` must be equal to `roll3`, and the user rolled triples.

If you run the code, you might see out like this:

```output
Dice roll: 3 + 6 + 1 = 10
Sorry, you lose.
```

Or, like this:

```output
Dice roll: 1 + 4 + 4 = 9
You rolled doubles! +2 bonus to total!
Sorry, you lose.
```

Or, like this:

```output
Dice roll: 5 + 6 + 4 = 15
You win!
```

Or, if you're lucky, you'll see this:

```output
Dice roll: 6 + 6 + 6 = 18
You rolled doubles! +2 bonus to total!
You rolled triples! +6 bonus to total!
You win!
```

But wait, should we really reward the player for getting both a triple bonus and a double bonus? After all, a triple implies that they also rolled a double. Ideally, this bonus doesn't *stack*. They should be two separate bonuses. We have our first bug in logic.

### Problems in our logic, and opportunities to improve the code

While this is a good start, and we've learned a lot about the `if` statement, Boolean expressions, code blocks, logical OR and AND operators, and so on, there's much that can be improved. We'll do that in the next unit.

## Recap

- Use an `if` statement to branch your code logic. The `if` decision statement will execute code in its code block if its Boolean expression equates to true. Otherwise, the runtime will skip over the code block and continue to the next line of code after the code block.
- A Boolean expression is any expression that returns a boolean value.
- Boolean operators will compare the two values on its left and right for equality, comparison, and more.
- A code block is defined by curly braces `{ }`. It collects lines of code that should be treated as a single unit.
- The logical AND operator `&&` aggregates two expressions so that both subexpressions must be true in order for the entire expression to be true.
- The logical OR operator `||` aggregates two expressions so that if either subexpression is true, the entire expression is true.