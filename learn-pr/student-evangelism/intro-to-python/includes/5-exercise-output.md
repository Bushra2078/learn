In this exercise, you will use the REPL to declare variables and run statements. 

## Try your first Python statement

Python supports an interactive console experience, which allows you to type in commands and see the results immediately.

1. In a console, type `python` to start the Python interpreter in the interactive mode.

   ```bash
   python
   ```

   You should see output that looks similar to:

    ```output
    Python 3.5.2 (default, Nov 12 2018, 13:43:14)
    [GCC 5.4.0 20160609] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    ```

    The `>>>` is the interpreter waiting for you to type a Python command.

1. Type the following statement into the interpreter.

    ```python
    print('Hello World!')
    ```

   It should echo the text directly back to you, then create another prompt waiting for the next command.

    ```output
    Hello World!
    >>>
    ```

## Declare and output variables

With the REPL running, let's create variables next.

1. Type the following code to declare a variable:

   ```python
   PI = 3.14
   ```

1. Type the name of the variable `PI` to echo out its value:

   ```python
   PI
   ```

   Your output should show its value:

   ```output
   3.14
   ```
