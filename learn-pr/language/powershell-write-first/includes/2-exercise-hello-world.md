One of the best ways to learn to code is to write many tiny programs. These programs highlight
fundamentals of programming and important techniques you'll use to write larger programs.

## Write your first lines of code

In this exercise, you'll complete a longstanding tradition among software developers to print the
phrase "Hello World!" to a command line or console window. You'll see that you can learn a lot, even
from a simple exercise like this.

### Step 1: Type the code into the Cloud Shell

The Azure Cloud Shell provides an in-browser experience will help us in this tutorial approach. The
Azure Cloud Shell is on the right-hand side of the web page. This behaves like a normal PowerShell
terminal window in a sandbox environment. You can type commands directly into the window, or run
scripts you have written and get the results in the Cloud Shell.

For our scenarios, we'll be using an available version of Visual Studio Code in the Cloud Shell to
write and run scripts.

Type this code into the Cloud Shell terminal on the right:

```powershell
New-Item HelloWorld.ps1
code HelloWorld.ps1
```

The `New-Item` command will create a new `.ps1` file in the current directory. The `.ps1` file
extension is the file extension for PowerShell scripts.

The `code` command followed by the file name of the script you want to open will open the file in
Visual Studio Code. Another window opens that allows you to write and edit scripts and save them to
run in the Cloud Shell. If you want to open a file stored in another location, instead of just the
filename, you can define a full file path.

In the opened VSCode window, type the following code:

```powershell
Write-Output 'Hello World!'
```

Once you have the code fully typed, press <kbd>Ctrl</kbd>+<kbd>s</kbd> to save your code and then
<kbd>Ctrl</kbd>+<kbd>q</kbd> to quite VSCode.

We'll explain how and why it works soon. But first, you should see it running to make sure you
didn't type it incorrectly. To do that, you will need to run your code.

> [!NOTE]
> You might be tempted to use the `Copy` button on the code sample to skip all the typing. However,
> we encourage you to type this line of code yourself. Typing the code yourself builds muscle memory
> an helps you gain insights that you wouldn't get otherwise.

### Step 2: Run the script

You'll run the script from the Cloud Shell by typing the following command:

```powershell
. ./HelloWorld.ps1
```

> [!NOTE]
> Be sure to use the period at the beginning of a command. This tells PowerShell to run the script
> or file being called.

### Step 3: Observe the result

You should see the following output in the Cloud Shell:

```Output
Hello World!
```

### What to do if you see an error message

Unlike many languages, PowerShell is a forgiving language. Where other languages require every
character to be precise, PowerShell is more relaxed. It's case insensitive, meaning it doesn't care
if you accidentally have an upper or lowercase where you aren't supposed to. It will interpret
`Write-Output` and `write-output` the same. So, the main thing to watch out for is misspellings or
not having a space where you should.

If you do encounter and error, it might look something like this:

```Output
Write-Outpu: The term 'Write-Outpu' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

In this example, I had written `Write-Outpu` instead of `Write-Output` and PowerShell told me it
couldn't find the command I specified.

Reading these errors are helpful in finding out what caused them. When you run a program and you get
an error, the error will often have the line number where the issue occurred, a description of the
error, and sometimes a suggestion to fix it.

> [!NOTE]
> Not all errors are as easy to read and understand. Some might take a little bit of testing and
> investigation to figure out what is causing the issue.

### Step 4: Create a new file and write code to receive input

Open the **HelloWorld.ps1** file using the same command as earlier. Then, modify the code you wrote
in the editor to comment it out by adding a `#` before the command. Add the following lines of
code and the result should look like this:

```powershell
# Write-Output -InputObject 'Hello World!'

$name = Read-Host -Prompt "Please enter your name"
Write-Output "Congratulations $name! You have written your first code with PowerShell!"
```

Do the same thing as before, press <kbd>Ctrl</kbd>+<kbd>s</kbd> to save your code and then
<kbd>Ctrl</kbd>+<kbd>q</kbd> to quite VSCode. Now, you should run the script with the same command:

```powershell
. ./HelloWorld.ps1
```

Now you should receive a prompt asking you for your name. Type in your name and press
<kbd>Enter</kbd>.

The output should show the following message with your name inserted.

```Output
Congratulations Chase! You have written your first code PowerShell!
```

You create a code comment by prefixing a line with the `#` character. This technique can be useful
in avoiding code you don't want to run right now but don't want to remove entirely. Comments are
also used to add information for yourself or others that will read your code later on. Comments can
be placed anywhere in your code and any text after the `#` on the same line will be commented out.

### How did your program work

You invoked a cmdlet called `Write-Output`. Cmdlets are compiled C# gives you access to the [.NET] framework](https://docs.microsoft.com/dotnet/core/introduction)
and are the main way you use PowerShell. The command syntax is a `Verb-Noun` format. This makes it
easy to understand what the code is trying to do. Do something to a thing.

`Hello World!` and the congratulatory sentence are both **string** inputs for the `Write-Output`
cmdlet to process and output. A string is a simple data type that computers use. We will learn about
data types in a later module.

`Read-Host` allows you to write a message to prompt the user for input. You define the message for
the user with the `-Prompt` parameter. Parameters allow the cmdlet to take input from a user. That
input is stored in a **variable** called `$name` and then we use the `Write-Output` cmdlet to
display the custom message in the Cloud Shell terminal.

We'll learn more about variables in a later module. For now, just think of them as a way to store
something in it to make your code more flexible. Instead of having to type a name into every
program, you can store a value in a variable and reuse it to get different results. You define a
variable with the dollar symbol (`$`) at the beginning of a word. After the word, use an equal sign
(`=`) followed by the value you want to store in the variable. In this example, we stored your name.
Variables can be named anything, but it's best to name them something that helps you understand
what it's storing and where to use it. For example, `$name` is storing your name.

Many cmdlets work similarly to the example above. You'll provide an input to the cmdlet, the
cmdlet will do something, then the cmdlet provides an output. This can be something like writing
to the output pane, computing an equation, changing something in the environment, or many other
things.

### Recap

Lets take a moment to recap what we learned from this first unit.

- **Cmdlets** are the main way to interact with PowerShell and are written in a `Verb-Noun` format.
- **Parameters** take input so the cmdlet can provide output or take action.
- PowerShell is a relaxed language. It's case insensitive by default.
- PowerShell errors can be helpful in identifying issues and reading the errors carefully can save
  time.
- **Variables** are used to store values you want to use dynamically in your programs.
