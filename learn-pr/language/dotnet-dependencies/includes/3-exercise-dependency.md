The developers at Tailwind Traders realize that they're about to put extensive resources into developing apps for the .NET platform. These apps are going to display many data to users that are human readable include dates, times, and numbers. .NET has the capabilities to do this, but the developers are certain someone has solved this problem. So they need a framework, and after some searching, they've found Humanizer in the NuGet package registry. It seems to be widely used and promises to meet all of your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers, and quantities. At this point, they just want you to install Humanizer, write a couple of data manipulations, and run them to see if Humanizer delivers on its promise.

## Creating a sample .NET project

In order to set up our .NET project to work with dependencies we will use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project really easy. If you do not wish to use another code editor you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named `DotNetDependencies` in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new console
    ```

    This command creates a **Program.cs** file in your folder with a basic "Hello World" program already written, along with a C# project file named **DotNetDependencies.csproj**.
        
    You should now have access to these files:
    ```bash
    -| bin
    -| obj
    -| DotNetDependencies.csproj
    -| Program.cs
    ```

1. In the terminal window, copy and paste the following command to run the "Hello World" program.

    ```dotnetcli
    dotnet run
    ```

The terminal window displays "Hello World!" as output.

:::image source="../media/new-dotnet-project.png" alt-text="Screenshot of Visual Studio Code with a new console application.":::

## Set up Visual Studio Code for .NET debugging

Open *Program.cs* by clicking on it.

The first time you open a C# file in Visual Studio Code, you will receive a prompt to install recommended extensions for C#. Click the **Install** button in the prompt.

:::image source="../media/install-recommended-extensions.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

Visual Studio Code will install the **C#** extension, and will show an additional prompt to add required assets to build and debug your project. Click the **Yes** button. 

:::image source="../media/install-required-assets.png" alt-text="Screenshot of Visual Studio Code debug tab.":::

You can close the tab titled "Extension: C#" to focus on the code we'll be writing.

## Add a NuGet package by using the dotnet tool 

1. Open Program.cs. It should look like this:
    
    ```csharp
    using System;

    namespace DotNetDependencies
    {
        class Program
        {
            static void Main(string[] args)
            {   
                Console.WriteLine("Hello World");
            }
        }    
    }
    ```

    The preceding function is run at the start of the application and outputs a string to the console. Let's add Humanizer and manipulate data and write it to the console.

1. Install the Humanizer library by running this command:

    ```dotnetcli
    dotnet add package Humanizer --version 2.7.9
    ```


    Open the **DotNetDependencies.csproj** file and find the `ItemGroup` section. You should now have an entry that looks like this one:

    ```xml
    <ItemGroup>
        <PackageReference Include="Humanizer" Version="2.7.9 />
    </ItemGroup>
    ```

1. Add the following content at the top of the Program.cs file to initialize Humanizer:

    ```csharp
    using Humanizer;
    ```

1. Add the following content to the Program.cs file under the `Program` class

    ```csharp
    static void HumanizeQuantities()
    {
        Console.WriteLine("case".ToQuantity(0));
        Console.WriteLine("case".ToQuantity(1));
        Console.WriteLine("case".ToQuantity(5));
    }

    static void HumanizeDates()
    {
        Console.WriteLine(DateTime.UtcNow.AddHours(-24).Humanize());
        Console.WriteLine(DateTime.UtcNow.AddHours(-2).Humanize());
        Console.WriteLine(TimeSpan.FromDays(1).Humanize());
        Console.WriteLine(TimeSpan.FromDays(16).Humanize());
    }
    ```

1. Update the `Main` method to call the new methods:
    
    ```csharp
    static void Main(string[] args)
    {   
        Console.WriteLine("Quantities:");
        HumanizeQuantities();

        Console.WriteLine("\nDate/Time Manipulation:");
        HumanizeDates();
    }
    ```

1. Run the application by typing this command in the terminal:

    ```dotnetcli
    dotnet run
    ```

    You should see the following output:

    ```output
    Quantities:
    0 cases
    1 case
    5 cases

    Date/Time Manipulation:
    yesterday
    2 hours ago
    1 day
    2 weeks
    ```

Congratulations. You've managed to successfully install Humanizer as a dependency and write logic for application code to make data more human readable. Humanizer seems to deliver on its promise, and Tailwind Traders is likely to be happy with this evaluation.
