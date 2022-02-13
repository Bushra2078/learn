In the previous exercise, you published the CDN and website modules to your toy company's registry. Now, you want to show the toy dog development team how to use the modules for their own deployment.

In this exercise, you create a Bicep file that includes modules from your private registry. During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep file.
> * Add references to the modules in the registry.
> * Build and inspect the Bicep file to understand how the module restore process works.
> * Switch to using a registry alias.
> * Deploy your Bicep file to Azure.

## Create a Bicep file

1. In Visual Studio Code, create a new file named *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> on Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you save the file. For example, you might want to create a *templates* folder to save it in.

## Add the modules to the Bicep file

1. In the *main.bicep* file, add the following parameters and variables:

   ::: code language="bicep" source="code/7-main-no-alias.bicep" range="1-10" :::

1. Below the parameters and variables, add the website module from your registry. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ::: code language="bicep" source="code/7-main-no-alias.bicep" range="12-20" :::

   Notice that Bicep shows some red squiggly lines underneath the module identifier when you start typing, but then the squiggly lines go away. This behavior happens because the Bicep extension for Visual Studio Code reads the module from the registry and saves it to your local file system.

1. Below the module you just created, add the CDN module from your registry. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ::: code language="bicep" source="code/7-main-no-alias.bicep" range="22-28" :::

1. Save the file.

## Build and inspect your Bicep file

Here, you build the Bicep file to a JSON ARM template. You don't normally need to do this, but it's helpful when you're learning how modules work.

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command to build the Bicep file to a JSON file.

   ```azurecli
   az bicep build --file main.bicep
   ```

   Bicep creates a file named *main.json* in the same folder as the *main.bicep* file.

1. Open the *main.json* file.

   Notice that in the `resources` section of the JSON ARM template, starting at around line 134, there are some resources with the type `Microsoft.Resources/deployments`. These resources represent the module deployments. Within each deployment, you'll see the resources that were defined in the module you added from the registry.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command to build the Bicep file to a JSON file.

   ```powershell
   bicep build main.bicep
   ```

   Bicep creates a file named *main.json* in the same folder as the *main.bicep* file.

1. Open the *main.json* file.

   Notice that in the `resources` section of the JSON ARM template, starting at around line 134, there are some resources with the type `Microsoft.Resources/deployments`. These resources represent the module deployments. Within each deployment, you'll see the resources that were defined in the module you added from the registry.

::: zone-end

## Create a registry alias

You decide to create a registry alias instead of embedding the registry URL in your Bicep file. This approach makes the Bicep file easier to read.

1. In Visual Studio Code, create a new file named *bicepconfig.json*. Ensure you create it in the same folder as the *main.bicep* file.

1. Paste the following into the *bicepconfig.json* file. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ::: code language="json" source="code/5-bicepconfig.json" :::

1. Save the file.

## Use the registry alias

Here, you update your Bicep file to use the registry alias instead of referring directly to the registry.

1. Open the *main.bicep* file.

1. Find the definition of the `website` module, and change the definition to include the registry alias:

   ::: code language="bicep" source="code/7-main-alias.bicep" range="12-20" highlight="1" :::

   > [!TIP]
   > Ensure you change the beginning of the module path from `br:` to `br/`. Also, after `ToyCompanyRegistry`, change the slash (`/`) character to a colon (`:`).

1. Make a similar change to the `cdn` module:

   ::: code language="bicep" source="code/7-main-alias.bicep" range="22-28" highlight="1" :::

1. Save the file.

## Deploy to Azure

In the Visual Studio Code **Terminal**, deploy the template to Azure by running the following command. This process can take a couple of minutes to complete, and then you'll have a successful deployment.

::: zone pivot="cli"

```azurecli
az deployment group create \
   --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

### Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page. 
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. On the left menu, select **Deployments**.

   :::image type="content" source="../media/7-deployments.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the Deployments menu item highlighted." :::

   Notice that three deployments are listed: *main*, which represents the deployment of your parent Bicep file, and *cdn* and *website*, which represent the modules that you included in your *main.bicep* file.

1. Select the **main** deployment and expand **Deployment details**.

   Notice that both of the modules are listed, and that their types are displayed as `Microsoft.Resources/deployments`. The `toy-dog-website` module is listed twice because its output are also referenced within the template.

   :::image type="content" source="../media/7-deployment-modules.png" alt-text="Screenshot of the Azure portal that shows the deployment details for the main deployment." :::

1. Select the **toy-dog-cdn** and **toy-dog-website** deployments, and review the resources deployed in each. Notice that they correspond to the resources defined in the respective module.
