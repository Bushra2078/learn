In this unit, you will create, build, and run a new ASP.NET Core web application on your local machine. You will need Visual Studio 2019 installed with the **ASP.NET and web development** and **Azure development** workloads installed.

## Create an ASP.NET Core project

The first step is to start Visual Studio and create a local ASP.NET Core web application.

1. Open Visual Studio 2019 on your local machine.

1. From the Visual Studio landing page, click **Create a new project**.

1. In the search box, enter **Web**.

1. From the search results, select **ASP.NET Core Web Application**.

1. In the new project dialog, set the **Name** field to **AlpineSkiHouse**.

1. Select a **Location** for your new solution.

1. Click the **Create** button to create your project.

1. In the **Create a new ASP.NET Core web application** dialog box, you will see a selection of starting templates. For this exercise, select **Web Application**, and then click **Create** to create your project.

    :::image type="content" source="../media/3-aspnet-templates.png" alt-text="New Project Dialog." loc-scope="vs":::

    > [!NOTE]
    > You can also select different starting templates in this dialog box depending on your web development requirements. At the top of the dialog box, you are also able to select the version of ASP.NET Core. You should select ASP.NET Core 3.1 or later.

1. You should now have your new ASP.NET Core web application solution.

    :::image type="content" source="../media/3-new-solution.png" alt-text="New Project Dialog." loc-scope="vs":::

## Build and test on your local machine

Now, let's build and test your application on your local machine before deploying to Azure.

1. Run the app

    Press <kbd>F5</kbd> to build the project and run in debug mode.

    Press <kbd>Ctrl+F5</kbd> to build the project and run without attaching the debugger.

    > [!TIP]
    > Launching the app in non-debug mode allows you to make code changes, save the file, refresh the browser, and see the code changes. Many developers prefer to use non-debug mode to quickly launch the app and view changes.

1. Visual Studio starts the IIS Express web browser and loads the app.

    :::image type="content" source="../media/3-webapp-launch-windows.png" alt-text="The web app running in a browser." loc-scope="other":::

    When Visual Studio creates a web project, a random port is used for the web server. In the preceding image, the port number is 44381. When you run the app, you'll likely see a different port number.

    > [!IMPORTANT]
    > You might notice the section at the top of the web page that provides a place for your privacy and cookie use policy. Select **Accept** to consent to tracking. This app doesn't track personal information. The template-generated code includes assets to help meet General Data Protection Regulation (GDPR).

You've now created a web application from the sample template and it is running locally. The next step is to deploy it to Azure.