During your journey as developer, there's always _that_ moment when you end up asking yourself:

> Why my code isn't working?

When there's a bug in your program, everyone usually has its own way of dealing with this problem.
You probably already have tried one or more of these debugging approaches yourself:

- Try running your program again, because it **should** work.
- Explain your issue to a rubber duck.
- Reading through your code again to find out the issue.
- Take a walk outside.
- Spam a few `console.log('here')` in your code.

While you might have various degrees of success with these methods, there's one other approach commonly regarded as being more often successful: using a debugger. But what's a debugger exactly?

A debugger is a software tool used to observe and control the execution flow of your program with an analytical approach. Its design goal is to help find the root cause of bug and help you resolve it. It works by either hosting your program in its own execution process, or by running as a separate process that is attached to your running program, like in the Node.js case.

Debuggers comes in different flavors, some working directly from the command line while others comes with a graphical user interface. In this module we'll use both the built-in command line debugger that comes with Node.js, and the integrated graphical debugger of Visual Studio Code (VS Code).

## Why use a debugger

If you're not running your code through a debugger, that means you're probably *guessing* what's happening in your program. The primary benefit of using a debugger is that you can *watch* your program running. You can follow your program execution one line of code at a time, avoiding the chance of guessing wrong.

Every debugger has its own set of features, but the two most important ones that come with almost all of them are:

- Control of your program execution. You can pause your program and make run it step by step, allowing you to see which code is executed and how it affects your program's state.
- Observation of your program's state. For example, you can look at your variables' value and function parameters at any point during your code execution.

Mastering debugger usage is an important skill for a developer, that is often overlooked. Not only it makes you more efficient at hunting bugs in your code, but it can also help understand quickly how a program works.

Let's discover that in the next section.
