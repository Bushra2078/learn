In your toy company, you've been publishing your Bicep modules into a registry, but you've been running the publishing process manually from your own computer. Now, you want to create a workflow to handle the publishing process.

In this exercise, you'll:

> [!div class="checklist"]
> * Create a container registry for your Bicep modules.
> * Add a lint job to the workflow.
> * Add a workflow job to publish the module to your registry.
> * Verify that your workflow runs successfully.
> * Check the published module in your registry.

## Create a container registry

Before you can publish modules, you need to create a registry for your organization to use. Here, you use the Azure portal to create a registry.

1. In your browser, [create a new container registry within the Azure portal](https://portal.azure.com/#create/Microsoft.ContainerRegistry?azure-portal=true).

1. In the **Basics** tab, select your target subscription and the **ToyReusable** resource group you created earlier.

1. Enter a name for your registry, and a location that's close to you.

    > [!IMPORTANT]
    > The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. You should see a checkmark next to the registry name indicating that the name you chose is available.

1. For **SKU**, select 'Basic'.

   Leave the default values for the other configuration settings.

1. Select **Review + create**.

   :::image type="content" source="../media/6-create-registry.png" alt-text="A screenshot of the Azure portal that shows the container registry creation page.":::

1. Review the settings, then select **Create**.

   Wait for the deployment to complete, which usually takes 1-2 minutes.

1. When the **Deployment succeeded** message appears, select **Go to resource** to open the container registry.

   :::image type="content" source="../media/6-registry-created.png" alt-text="A screenshot of the Azure portal that shows the container registry deployment, with the 'Go to resource button' highlighted.":::

1. In the container registry's **Overview**, note the value of the *Login server* setting. It will look like *yourregistryname.azurecr.io*.

   :::image type="content" source="../media/6-registry-login-server.png" alt-text="A screenshot of the Azure portal that shows the container registry's details, with the login server highlighted.":::

   You'll need this value shortly.

## Add a module metadata file

In the preceding unit, you learned about the importance of having a versioning strategy for your modules. You also learned how to use module metadata files to specify the major and minor version number of your module within a workflow. Here, you add a metadata file for your storage account module.

1. In Visual Studio Code, expand the *modules* folder in the root of your repository. Then, expand the *storage-account* folder.

1. Create a new file named *metadata.json*.

   :::image type="content" source="../media/6-visual-studio-code-metadata-json.png" alt-text="A screenshot of Visual Studio Code showing the location of the metadata dot J S O N file.":::

1. Add the following content to the file:

   :::code language="json" source="code/6-metadata.json" :::

   Notice that, in the metadata file, you separately define the major and minor version numbers. Your workflow will combine these numbers, along with the workflow's run number, into a complete version number each time the workflow runs.

1. Save your changes to the file.

## Update your workflow definition and add a lint job

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the *.github* folder in the root of the repository. Then, expand the *workflows* folder.

1. Open the file named *module-storage-account.yml*.

   :::image type="content" source="../media/6-visual-studio-code-workflow.png" alt-text="A screenshot of Visual Studio Code showing the location of the workflow definition file.":::

1. On line 14, update the value of the `MODULE_REGISTRY_SERVER` environment variable to your container registry's server name, which you copied earlier in this exercise. 

   For example, if your registry's login server is *yourregistryname.azurecr.io*, line 14 would look like the below:

   :::code language="yaml" source="code/6-workflow.yml" range="12-16" highlight="3" :::

1. At the bottom of the file, where there's comment saying _To be added_, add the following *lint* job definition:

   :::code language="yaml" source="code/6-workflow.yml" range="18-24" :::

## Add a publish job to your workflow

Now, you can add a second job to publish the module to your container registry.

1. At the bottom of the *storage-account.yml* file, add the first part of the *publish* job's definition:

   :::code language="yaml" source="code/6-workflow.yml" range="26-34" :::

   The steps check out the code from your repository and sign in to Azure.

1. Below the code you just added, add a step to read the version number from your module's *metadata.json* file and set it as an environment variable:

   :::code language="yaml" source="code/6-workflow.yml" range="35-39" :::

   The step runs a script, which uses the jq command-line application to parse the JSON file.

1. Below the step you just created, add a step to publish the module to the registry:

   :::code language="yaml" source="code/6-workflow.yml" range="40-47" :::

   Notice that this step constructs the value of the `--target` argument dynamically. It combines the value of the registry server, the module name, and the version number.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your *storage_account_module.yml* file looks like the following:

   :::code language="yaml" source="code/6-workflow.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish jobs to storage account module workflow"
   git push
   ```

## Trigger the workflow

1. In your browser, navigate to your GitHub repository and select the **Actions** tab.

1. Select the **module-storage-account** workflow.

   Notice that a workflow run is already in progress. The push trigger fired because you modified the *metadata.json* file within the module's folder.

1. Select the latest run in the list.

   :::image type="content" source="../media/6-workflow-runs-list.png" alt-text="A screenshot of GitHub that highlights the latest run of the module's workflow.":::

   Wait for the workflow run to finish. The Bicep module is published to your container registry.

   Note the workflow's run number, which is probably **3**.

## Review the module in the registry

You can also view the published module in the Azure portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Navigate to the **ToyReusable** resource group.

1. Select the container registry you created previously.

1. Select the **Repositories** blade from the menu. Then, select the **modules\storage-account** repository, which represents the module that your workflow published.

   :::image type="content" source="../media/6-registry-portal.png" alt-text="A screenshot of the Azure portal that shows a Bicep module in the container registry.":::

   Notice that there's a single *tag*, which matches the version number of the module that your workflow published. The major version (1) and minor version (2) match the version numbers you defined in the *metadata.json* file, and the revision number (3) matches the workflow's run number.

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code terminal, run the following command:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyReusable --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyReusable -Force
```

::: zone-end
