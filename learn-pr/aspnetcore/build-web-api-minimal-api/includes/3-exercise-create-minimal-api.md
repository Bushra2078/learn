You're a developer for a company, and you and your company have heard about the new minimal API. Your manager has asked you to create a project for it so that you can discuss whether to use it on your next project.

## Scaffold a project

First, you need to scaffold a project. You've installed .NET 6 and you're ready to go.

1. Create a web API by running `dotnet new`:

   ```bash
   dotnet new web -o PizzaStore -f net6.0
   ```

   You should see the _PizzaStore_ directory.

1. Run the app by calling `dotnet run`. It builds the app and hosts it on a port from 5000 to 5300. HTTPS has a port selected for it in the range of 7000 to 7300.

   > [!NOTE]
   > If you want to override the random port selection behavior, you can set the ports to use in _launchSettings.json_.

   ```bash
   dotnet run
   ```

   Here's what the output can look like in the terminal:

   ```output
   Building...
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: https://localhost:7200
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5100
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /<path>/PizzaStore
   ```

1. In your browser, go to the indicated port. According to the terminal *http://localhost:{PORT}*, you should see the text "Hello World!"

Congratulations! You've created an API by using a minimal API template.

## Add Swagger

Use Swagger to ensure that you have a self-documenting API, where the docs change when you change the code.

1. Install the Swashbuckle package:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.2.3
    ```

1. Verify the install by opening _PizzaStore.csproj_. You should have an entry that looks like this one:

    ```xml
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.2.3" />
    ```

Next, configure your project to use Swagger.

1. Open _Program.cs_ and add the highlighted code:

   :::code language="csharp" source="../code/create-minimal-api-add-swagger.cs" highlight="1, 5-9, 18-22":::

1. Rerun the project and go to the app's address, *http://localhost:{PORT}/swagger*.

   You should see the following output:

   :::image type="content" source="../media/swagger.png" alt-text="Screenshot of a Swagger UI for your API.":::
