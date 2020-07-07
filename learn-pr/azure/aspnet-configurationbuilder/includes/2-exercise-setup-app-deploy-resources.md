The example web app that's used in this module is based on part of an e-commerce system. The app enables a warehouse employee to update the details of products sold by the system and maintain the current stock levels.

In this unit, you download and test the app locally and then create the resources needed to deploy the app to Azure and configure it later in this module.
 
## Download and test the sample web app locally

1. In Windows Explorer, create a folder named *MigrationWorkshop* in a convenient place on your computer.
1. Open a command prompt window, and move to the *MigrationWorkshop* folder.
1. Download the sample app from the Microsoft repository on GitHub by running the following command:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

1. Start Visual Studio 2019.
1. Select **Open a project or solution**.

    > [!div class="mx-imgBorder"]
    > ![Image of Visual Studio 2019 start screen and the "Open a project or solution" link](..\media\2-open-project-or-solution.png)

1. Go to the *MigrationWorkshop* folder, select the *eShopModernizing* folder, select the *eShopLegacyWebFormsSolution* folder, select the **eShopLegacyWebForms** solution, and then select **Open**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Visual Studio 2019 "Open Project/Solution" window and the "eShopLegacyWebForms" solution](..\media\2-open-solution.png)

    The **Solution Explorer** window opens. If you're prompted to install additional components, select **Install**, as shown here:
    
    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window in Visual Studio. The user is being prompted to install additional components to support Visual Studio.**](..\media\2-install-components.png)
    
1. This project currently uses v2.0.1 of the *Microsoft.CodeDom.Providers.DotNetCompilerPlatform* assembly, which has an issue that requires restarting Visual Studio to refresh a cached value. To do so, do the following:

    a. Restart Visual Studio.  
    b. Open the **eShopLegacyWebForms** solution and, in the **Build** list, select **Rebuild Solution**.

1. In the **Solution Explorer** window, expand the **eShopLegacyWebForms** project, and select the *Web.config* file.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window and the "Web.config" file](..\media\2-open-web-config.png).

1. In the *Web.config* file, in the *\<appSettings\>* section, set the value of the **UseMockData** key to *false*. This setting causes the application to use data that's stored in a local SQL Server database:

    ```xml
    ...
    <appSettings>
        <add key="UseMockData" value="false" />
        <add key="UseCustomizationData" value="false" />
    </appSettings>
    ...
    ```

1. To build and run the application, select F5. The application opens a web browser and displays the **Catalog manager** page for the web app.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Catalog Manager** page for the sample application in a web browser window](..\media\2-catalog-manager.png)

    With **Catalog manager**, you can view the products sold by the organization, add new products, modify the details of existing products, and delete products.

1. Experiment with the application. Try adding, editing, and removing products. 

1. When you're done, close the browser. This action closes the app and returns you to Visual Studio.

## Create Azure resources for running the app as an Azure web app

1. In the Azure Cloud Shell window on the right, run the following commands to define the following PowerShell variables. 

    The commands that create the Azure resources in subsequent steps use these variables to name the resources. 
    
    Replace `<your-initials-with-suffix>` with your own initials and a numeric suffix of your choice. The purpose of the numeric suffix is to prevent two students with the same initials from using the same alias. 
    
    Replace `<your-password>` with a password of your choosing. This password is used by the instance of Azure SQL Database that the application connects to.  

    > [!NOTE]
    > The resource group `<rgn>[sandbox resource group name]</rgn>` has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

    ```PowerShell
    $useralias = "<your-initials-with-suffix>"
    ```

    ```PowerShell
    $serveradminpassword = "<your-password>"
    ```

    ```PowerShell
    $resourcegroupname = "<rgn>[sandbox resource group name]</rgn>"
    ```

1. To define further variables that are used to create the resources in this module, run the following commands:

    ```PowerShell
    $location = "eastus"
    $webappplanname = (-join($useralias,"-webappplan"))
    $webappname = (-join($useralias,"-webapp"))
    $serveradminname = "ServerAdmin"
    $servername = (-join($useralias, "-workshop-server"))
    $dbname = "eShop"
    ```

1. To create a new Azure App Service plan for hosting the web app, run the following PowerShell command:

    ```PowerShell
    New-AzAppServicePlan `
        -Name $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```
1. To create a web app by using the App Service plan, run the following PowerShell command:

    ```PowerShell
    New-AzWebApp `
        -Name $webappname `
        -AppServicePlan $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```

1. To assign a managed identity to the web app, run the following PowerShell command. You'll require this identity later.

    ```PowerShell
    Set-AzWebApp `
        -AssignIdentity $true `
        -Name $webappname `
        -ResourceGroupName $resourcegroupname
    ```

1. To create a new Azure SQL Database instance, run the following PowerShell command:

    ```PowerShell
    New-AzSqlServer `
        -ServerName $servername `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -SqlAdministratorCredentials $(New-Object `
            -TypeName System.Management.Automation.PSCredential `
            -ArgumentList $serveradminname, `
            $(ConvertTo-SecureString `
            -String $serveradminpassword `
            -AsPlainText -Force))
    ```
1. To open the SQL Database instance firewall to allow access to services hosted in Azure, run the following PowerShell command:

    ```PowerShell
    New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress "0.0.0.0" `
        -EndIpAddress "0.0.0.0"
    ```

1. To create a database in the SQL Database, run the following PowerShell command. The database will be populated later, when you migrate the web app.

    ```PowerShell
    New-AzSqlDatabase  `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -DatabaseName $dbName `
        -RequestedServiceObjectiveName "S0"
    ```