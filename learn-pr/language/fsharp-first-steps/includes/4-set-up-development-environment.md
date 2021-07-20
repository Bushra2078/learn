In this exercise, you'll set up your F# development environment by installing the .NET SDK, Visual Studio Code, and the F# Ionide extension.

## Install .NET SDK

To get started writing code with F#, you'll need to install the .NET SDK.

1. [Download and install .NET SDK](https://dotnet.microsoft.com/download/dotnet) for your operating system.
1. Verify that the .NET SDK has installed successfully
    1. Open the terminal
    1. Enter the following .NET CLI command

        ```dotnetcli
        dotnet --version
        ```

    1. Output similar to the following appears in the console. Your version might be different but as long as version information is output to the console, it means everything is installed correctly.

        ```console
        5.0.302
        ```

## Install Visual Studio Code & Ionide F# extension

Once you have the .NET SDK installed, install Visual Studio Code and the Ionide extension.

1. [Download and install Visual Studio Code](https://code.visualstudio.com/#alt-downloads) for your operating system.
1. After you install Visual Studio Code, open it.
1. Select the **Extensions** icon from the **Activity Bar** to open the Extensions view.
1. In the Extensions view, search for "Ionide-fsharp".
1. Select **Install**.

:::image type="content" source="../media/install-ionide.png" alt-text="Screenshot of Visual Studio Code extensions view displaying F# Ionide extension install page.":::