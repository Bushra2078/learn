The example web application used by this module is based on part of an e-commerce system. The sample web application enables a warehouse employee to update the details of products sold by the system, and maintain the current stock levels.

Here, you'll download and test the application locally, and then create the resources needed to deploy the application to Azure and configure it. You'll do the deployment and configuration in a later unit in this module.

## Download and test the sample web application locally

1. Using Windows Explorer, create a folder named **MigrationWorkshop** in a convenient place on your computer.
1. Open a command prompt window, and move to the **MigrationWorkshop** folder.
1. Run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

1. Start Visual Studio 2019.
1. Click **Open a project or solution**.

    > [!div class="mx-imgBorder"]
    > ![Image of Visual Studio 2019 start screen. The user has selected **Open a project or solution**](..\media\2-open-project-or-solution.png)

1. Browse to the **MigrationWorkshop** folder, move to the **eShopModernizing** folder, move to the **eShopLegacyWebFormsSolution** folder, select the **eShopLegacyWebFormsSolution**, and then click **Open**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Open Project/Solution dialog box in Visual Studio 2019. The user has selected the **eShopLegacyWebForms** solution](..\media\2-open-solution.png)

    You might be prompted to install additional components in the Solution Explorer window:

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window in Visual Studio. The user is being prompted to install additional components to support Visual Studio.**](..\media\2-install-components.png)

    If this occurs, click **Install** to install the required items, and follow the instructions.

1. This project currently uses v2.0.1 of the **Microsoft.CodeDom.Providers.DotNetCompilerPlatform** assembly, which has an issue that requires restarting Visual Studio to refresh a cached value. Perform the following steps to:

    1. Close Visual Studio, and start it again.
    2. Open the **eShopLegacyWebFormsSolution** solution, and on the **Build** menu, select **Rebuild Solution**.

1. In the **Solution Explorer** window, expand the **eShopLegacyWebForms** project, and select the **Web.config** file.

    > [!div class="mx-imgBorder"]
    > ![Image of Solution Explorer window. The user has selected the **Web.config** file](..\media\2-open-web-config.png).

1. In the **Web.config** file, in the **appSettings** section, set the value of the **UseMockData** key to **false**. This setting will cause the application to use data stored in a local SQL Server database:

    ```xml
    ...
    <appSettings>
        <add key="UseMockData" value="false" />
        <add key="UseCustomizationData" value="false" />
    </appSettings>
    ...
    ```

1. Press **F5** to build and run the application. The application will open a web browser and display the **Catalog Manager** page for the web application.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Catalog Manager** page for the sample application in a web browser window](..\media\2-catalog-manager.png)

    The Catalog Manager enables you to view the products sold by the organization, add new products, modify the details of existing products, and delete products.

1. Experiment with the application; try adding, editing, and removing products. Close the web browser when you've finished. This action will stop the application and return you to Visual Studio.

## Create Azure resources for running the application as an Azure web app

1. In the Cloud Shell window on the right, run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

1. Run the commands shown below to define the following PowerShell variables. The commands that create the Azure resources in subsequent steps use these variables to name the resources. Replace ***\<your-initials-with-suffix\>*** with your own initials and a numeric suffix of your choice. The purpose of the numeric suffix is to prevent two students with the same initials attempting to use the same alias. Also, replace ***\<your-password\>*** with a password of your choosing. This password will be used by the instance of Azure SQL Database that the application connects to.  

    > [!NOTE]
    > The resource group <rgn>[sandbox resource group name]</rgn> has been created automatically. Use this as your resource group name, you will not have permission to create additional resource groups in the sandbox.

    ```PowerShell
    $useralias = "<your-initals-with-suffix>"
    ```

    ```PowerShell
    $serveradminpassword = "<your-password>"
    ```

    ```PowerShell
    $resourcegroupname = "<rgn>[sandbox resource group name]</rgn>"
    ```

1. Move to the **~/eShopModernizing/Setup** folder.

    ```PowerShell
    cd ~/eShopModernizing/Setup
    ```

1. Run the following PowerShell scripts:

    ```PowerShell
    . ./environment.ps1
    ./setup.ps1
    ```

    > [!NOTE]
    > The "." and the space characters at the start of the first command above are important. Don't omit them.

    Wait for the script to create the resources used by the lab before continuing.

1. Run the following PowerShell script tp verify that the resources have been created successfully:

    ```PowerShell
    ./verify.ps1
    ```

    You should see the following messages:

    ```output
    The app service plan was created
    The web app was created
    The database server was created
    The database was created
    ```
