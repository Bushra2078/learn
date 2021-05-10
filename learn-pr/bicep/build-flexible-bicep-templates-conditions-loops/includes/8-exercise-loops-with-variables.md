For your toy company, you need to deploy virtual networks in each country you're launching the teddy bear into. Also, your developers have asked you to give them the fully qualified domain names (FQDNs) of each of the regional SQL servers you've deployed. In this exercise you'll add the virtual network and its configuration into your Bicep code, and you'll output the SQL server FQDNs. During this exercise you'll:

> [!div class="checklist"]
> * Update your Bicep code to specify a parameter for the virtual network's subnets.
> * Add a variable loop to create a subnet array, which you'll use in the virtual network resource declaration.
> * Add an output loop to create the list of SQL server FQDNs.
> * Deploy the Bicep file and verify the deployment.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Add the virtual network into your Bicep file

1. Open the *main.bicep* file.

1. Below the parameter declarations, add the following parameters:

   ::: code language="bicep" source="code/8-template.bicep" range="15-28" :::

1. Below the parameters, add a blank line and then add the `subnetProperties` variable loop:

   ::: code language="bicep" source="code/8-template.bicep" range="30-35" :::

1. At the bottom of the file, underneath the `databases` module loop, add the following resource loop:

   ::: code language="bicep" source="code/8-template.bicep" range="46-57" :::

   > [!NOTE]
   > This example uses the same address space for all of the virtual networks.
   > Normally, when you create multiple virtual networks, you'd set their address space to be different in case you ever need to connect them together.

   When you're finished, your *main.bicep* file should look like this:

   ::: code language="plaintext" source="code/8-template.bicep" highlight="15-35, 46-57" :::

1. Save the changes to the file.

## Add outputs to the database module

1. Open the *modules/database.bicep* file.

1. Add the following outputs to the bottom of the file:

   ```bicep
   output serverName string = sqlServer.name
   output location string = location
   output serverFullyQualifiedDomainName string = sqlServer.properties.fullyQualifiedDomainName
   ```

1. Save the changes to the file.

## Flow the outputs through the parent Bicep file

1. Open the *main.bicep* file.

1. At the bottom fo the file, add the following output loop:

   ```bicep
   output serverInfo array = [for i in range(0, length(locations)): {
     name: databases[i].outputs.serverName
     location: databases[i].outputs.location
     fullyQualifiedDomainName: databases[i].outputs.serverFullyQualifiedDomainName
   }]
   ```

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file vnet.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile vnet.bicep
```

::: zone-end

You'll see ```Running...``` in the terminal. Wait for deployment to finish.

## Verify the deployment

After deployment is finished, you want to verify that new virtual network is deployed and it has subnet configuration as specified in parameter value.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Select virtual network ```vnet``` and select Subnets under Settings category in left menu.

1. Verify that deployed subnets have names and IP addresses that were specified in parameter ```subnetDefinitions``` default value.

    :::image type="content" source="../media/8-varloop-deployment.png" alt-text="Screenshot of the Azure portal interface for virtual network subnets after deployment." border="true":::
