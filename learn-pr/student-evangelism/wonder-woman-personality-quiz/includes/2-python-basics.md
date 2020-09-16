Before you dive into the full personality quiz, let's walk through the basics for commanding Python. If you already know how to use variables, functions, and conditionals, you can skip to the next unit in this module.

## Comments

First, we can write comments to ourselves that Python will ignore. On any line where we use the `#` symbol, Python ignores everything after.

Try adding the following line to your file:

```python
# this is a comment that won't be interpreted as a command
```

Press the **Play** button, and you should see the same behavior as before.

> [!div class="mx-imgBorder"]
> ![Screenshot that shows a Python comment and the unchanged result.](../media/comments.png)

## Variables

If you want Python to remember something, you can command it to "write it down" by using a variable.

The following command tells Python to remember the value `1984` by using a variable named `year` with the special assignment (`=`) operator. Anytime after this command, when Python sees `year`, it will substitute the current value.

```python
# use a variable named year to "remember" the value 1984
year = 1984
```

Try it out by replacing the commands in your file with the following. The `print` command can, if you put an `f` before what you want printed, use curly braces ({}) to surround a variable name. This will make Python print out the value of the variable.

```python
# use a variable named year to "remember" the value 1984
year = 1984

# print a message to see what year it is
print( f"The year is {year}..." )
```

Press the **Play** button, and you should see the year print out.

> [!div class="mx-imgBorder"]
> ![Screenshot that shows the output to printing the value of a variable.](../media/quiz-print-variable.png)

We can update the value of a variable by using the same assignment (`=`) operator. Python will figure out the right side before storing it in the variable. Because `year` already has a value, this command will ask Python to first substitute the current value of `year` (which is `1984`), add 36 to it, and then store that value in the variable `year`. This effectively overwrites the value that was written down originally. Try it out by replacing the commands in your file with the following.

```python
# use a variable named year to "remember" the value 1984
year = 1984
        
# print a message to see what year it is
print( f"The year is {year}..." )

year = year + 36

# print a message to see what year it is now
print( f"The year is now {year}..." )
```

Press the **Play** button, and you should see the years print out.

> [!div class="mx-imgBorder"]
> ![Screenshot that shows updating a variable in Python.](../media/updating-variable.png)

## Conditionals

Python can perform commands depending on some condition. We're used to conditionals in the real world: "If you've been lassoed, then you're compelled to tell the truth." The keyword here is `if`, which is followed by a condition, where we check whether or not the lasso of truth is around you. When the condition is met, the subsequent command must be followed. Python code only expects a condition to either be met or not — it's either true or false.

To get a little more comfortable, consider the following strategy for how to spend a day. (The following is not code. It's just plain text to explain a scenario.)

```txt
if it's raining cats and dogs
    find a cat
    if the cat is hungry
        find some milk
        give the milk to the cat
    else
        pet the cat until it purrs or scratches you
else
    be happy that it's not raining animals
    frolic outside
```

How might this play out? It might be the case that:

- It's raining cats and dogs.
- The cat that you find is hungry.

In this scenario, you'll do three things:

- You find a cat.
- You find some milk.
- You give the milk to the cat.

What if instead:

- It's not raining cats and dogs.

In this scenario, you'll do two things:

- You are happy that it's not raining animals.
- You frolic outside.

There are a few more possible scenarios, but let's move on to how we can use conditionals to command Python in our year example.

## Conditionals in Python

Python expects a particular *syntax* (formulation of the commands). We won't go in depth here. Instead, just try out this example by adding the following to your file. (If you're wondering what the `==` is doing, that is how we quiz if two numbers are equal. Remember that a single `=` means assignment of a variable, so the computer would be confused.)

```python
# if we're in 1984
if year == 1984:
    print( "I left you a message on your answering machine!" )
# if we're in 2020
if year == 2020:
    print( "I left you a voicemail!" )
```

Press the **Play** button, and you should see state-of-the-art messaging.

> [!div class="mx-imgBorder"]
> ![Screenshot that shows output from the conditional statement.](../media/quiz-output-conditionals.png)

How would you change the year so that you get a message on your answering machine instead?

### Booleans (extra)

Python puts a special meaning on the words "true" and "false," and calls them Boolean values. It turns out that Booleans are studied in computer science (and philosophy), and there's an entire subject called Boolean logic! 

You might be comfortable with arithmetic, where numbers are operated on to produce other numbers: 1 + 2 is 3. The operands are the numbers 1 and 2, and the operator is the addition operator (+). 

In Boolean logic, Boolean values (true or false) are operated on to produce other Boolean values. We might say, "If it is cold outside AND it is raining, then grab a parka." Then both conditions must be met (must be true) for us to grab a parka. Here the operands are whether or not it is cold outside and whether or not it is raining; the AND operator

Now that we have a handle on some of the basics, let's move on to making the quiz.

*WONDER WOMAN 1984 TM & © DC and WBEI. RATED PG-13*
