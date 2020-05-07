In this part, you prepare your development environment to begin writing quantum programs.

To set up your development environment, you:

> [!div class="checklist"]
> * Install the QDK for Visual Studio Code.
> * Verify the installation by creating a basic Q# application.

But first, let's take a quick look at what you get with the Quantum Development Kit (QDK).

> [!NOTE]
> Before you proceed, make sure you have the latest version of [.NET Core](https://dotnet.microsoft.com/download?azure-portal=true) and [Visual Studio Code](https://code.visualstudio.com/download?azure-portal=true) installed on your computer.

## What's the Quantum Development Kit (QDK)?

The QDK gives you everything you need to start writing quantum programs. Included in the QDK is the Q# programming language.

Q# is a *domain-specific programming language* (DSL). A DSL is a computer language that's built for a specific kind of application, just like how HTML is built for web pages. Q# enables you to focus on your quantum algorithms without having to worry about many of the underlying details, such as physical layout of a quantum computer.

The QDK also includes:

* Q# libraries that help you build real-world quantum applications right away.
* Targets for which you can run your Q# programs.

    Targets include resource estimators and simulators for larger quantum programs, as well as a full-state quantum simulator, which behaves as a noise-free quantum computer.

    The simulator is useful for trying out new ideas, debugging programs, and learning about quantum physics, but it's suited for programs with relatively few qubits.

    You can also target your programs to run on real quantum hardware through Azure Quantum. (We'll discuss Azure Quantum later in this module.)
* Tools that help you integrate quantum programs with classical programs, including support for C#, F#, and Python.

## Install the QDK for Visual Studio Code

This step installs the QDK and adds extensions to Visual Studio Code that provide support for developing quantum algorithms in Q#.

1. Open Visual Studio Code.
1. Go to [Microsoft Quantum Development Kit for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode?azure-portal=true), select **Install**, then follow the installation steps.

## Verify the installation

To verify the installation, here you create a basic Q# application.

### Install the Quantum project templates

Project templates enable you to more quickly create Q# applications, libraries, and unit tests.

1. In Visual Studio Code, on the **View** menu, select **Command Palette**.
1. Enter **Q#: Install project templates**.

### Create a project

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *QuantumHello* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.
1. From the **View** menu, select **Explorer**.

    You see two files: *QuantumHello.csproj* and *Program.qs*.

    The *.csproj* file defines project settings. *Program.qs* contains a basic Q# program that prints a message to the console.

    ```qsharp
    namespace QuantumHello {

        open Microsoft.Quantum.Canon;
        open Microsoft.Quantum.Intrinsic;


        @EntryPoint()
        operation HelloQ() : Unit {
            Message("Hello quantum world!");
        }
    }
    ```

### Run the program

Now let's run the program to verify everything is set up correctly. You use the `dotnet` utility to run Q# programs.

1. From the **View** menu, select **Terminal** or **Integrated Terminal**.
1. Run `dotnet run`.

    ```bash
    dotnet run
    ```
1. The program prints this message:

    ```output
    Hello quantum world!
    ```

Great work. You just ran your first Q# program!

You likely noticed that this basic program doesn't involve any quantum computations. Shortly, you'll use quantum computation to create a random number generator.