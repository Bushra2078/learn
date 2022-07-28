Before using quantum computers to solve important problems, your first task is to improve current security protocols by creating random passwords.

You're likely already familiar with the concept of a random number generator (RNG). Classical computers don't produce random numbers, but rather _pseudorandom_ numbers. A pseudorandom number generator generates a deterministic sequence of numbers based on some initial value, called a _seed_. To better approximate random values, this seed is often the current time from the CPU's clock.

You would like to use truly random numbers so no galactic hacker can find out the sequence of random numbers used to generate passwords and thus jeopardize space fleet security. To do so, you need to build a quantum random number generator (QRNG). With a quantum random number generator, passwords will be truly random and more secure.

A QRNG is a perfect introduction to quantum computing because it illustrates quantum behavior and requires only a few lines of code.

You start by taking a qubit in a basis state, for example zero. The first step of the QRNG is to use an `H` operation to put the qubit into an equal superposition. The measurement of this state results in a zero or a one with 50% probability of each outcome. The value of this bit is truly random, there's no way of knowing what you will get after the measurement. But how can you use this behavior to generate larger numbers to use as a valid password?

Let's say you repeat the process four times, generating this sequence of binary digits:

$${0, 1, 1, 0}$$

If you concatenate, or combine, these bits into a bit string, you can form a larger number. In this example, the bit sequence ${0110}$ is equivalent to six in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

If you repeat this process many times, you can combine multiple bits to form any large number. Now you can provide your superior with that number as a secure password, since you can be sure that no space hacker could determine the results of the sequence of measurements.

You build out your quantum random number generator in two phases. In this chapter, you build out the first phase, which is to generate a single random bit.

To do so, you:

> [!div class="checklist"]
> * Create a Q# project.
> * Add code that uses the `H` operation to put a qubit into superposition and then measure its value.
> * Run the program.

In the next section, you build out the second phase, which combines random bits to form a larger number.

> [!NOTE]
> Keep in mind that because you're using the simulator to run your Q# program, you still get pseudorandom results. But after you verify your program through the simulator, you can run the same program on a quantum computer to get truly random results that measure fundamental physical processes.

## Create the Q# project

To begin with, you create a Q# project just like you did earlier.

1. On the **View** menu, select **Command Palette**.
1. Enter **Q#: Create New Project**.
1. Select **Standalone console application**.
1. Select a directory to hold your project, such as your home directory. Enter *QuantumRNG* as the project name, then select **Create Project**.
1. From the window that appears at the bottom, select **Open new project**.

You see two files: the project file *QuantumRNG.csproj* and *Program.qs*, which contains starter code.

## Define the GenerateRandomBit operation

To define the full operation:

1. Replace the contents of *Program.qs* with this code:

    [!code-qsharp[](code/4-program-2.qs?highlight=7-9)]

    Let's take a look at this code. You define the `GenerateRandomBit` operation. This operation takes no input and produces a value of type `Result`. The `Result` type represents the result of a measurement and can have two possible values: `Zero` and `One`. 

1. Add this code to the `GenerateRandomBit` operation:

    [!code-qsharp[](code/4-program-3.qs?highlight=9-16)]

    `EntryPoint` tells the Q# compiler to begin executing the program here. In Q#, qubits are allocated through the `use` keyword. When a qubit is allocated, it is always in the `Zero` state. The `H` operation places the qubit in superposition. To measure a qubit, you use the operation [M](/qsharp/api/qsharp/microsoft.quantum.intrinsic.m?azure-portal=true), which returns the measured value (a zero or a one).

## Run the program

Let's try out your random bit generator. To do so:

1. In Visual Studio Code, go to the terminal. If you closed the terminal, on the **View** menu, select **Terminal** or **Integrated Terminal**.
1. Run `dotnet run`.

    ```bash
    dotnet run
    ```

    You see either "Zero" or "One" in the output. Here's an example:

    ```output
    Zero
    ```

1. Run the program again. This time, you can skip the build phase by using the `--no-build` flag.

    ```bash
    dotnet run --no-build
    ```

    Again, you see either "Zero" or "One" in the output:

    ```output
    One
    ```

Next, you'll implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number.

Leave your project open in Visual Studio Code for the next part.
