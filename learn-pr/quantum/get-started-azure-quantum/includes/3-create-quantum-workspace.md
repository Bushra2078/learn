With an active Azure subscription, your crew is ready to create an Azure Quantum workspace:

1. Open the main page of the [Azure portal](https://ms.portal.azure.com/?azure-portal=true).

1. Select **Create a resource**, type **Azure Quantum**, and press <kbd>Enter</kbd> to see the search results. On the results page, you should see a tile for the **Azure Quantum (preview)** service.

   ![Screenshot progression for the Azure Quantum preview service.](../media/3-azure-quantum-search.png)

1. Select **Azure Quantum (preview)** and then select **Create**. This step opens a form to create a workspace.

   ![Screenshot that shows creating a resource for the Azure Quantum preview service.](../media/3-azure-quantum-create.png)

1. Fill out the details of your workspace:
   * **Subscription:** The subscription that you want to associate with this workspace.
   * **Resource group:** The resource group that you want to assign this workspace to.
   * **Name:** The name of your workspace.
   * **Region:** The region for the workspace. For this preview, select  **(US) West US** (A user's default region is determined by their location. In this tutorial we use West US as a default region.)
   * **Storage Account**: The Azure storage account to store your jobs and results. If you don't have an existing storage account, select **Create a new storage account** and complete the necessary fields. For this preview, we recommend using the default values.

   ![Screenshot that shows the properties for the Azure Quantum workspace.](../media/3-azure-quantum-properties.png)

   >[!NOTE]
   > You must be an owner of the selected resource group to create a new storage account. For more information about how resource groups work in Azure, see [Control and organize Azure resources with Azure Resource Manager](/learn/modules/control-and-organize-with-azure-resource-manager/?azure-portal=true).

1. After you complete the information, select the **Providers** tab to add providers to your workspace. A provider gives you access to a quantum service, which can be quantum hardware, a quantum simulator, or an optimization service.

   ![Screenshot that shows providers for Azure Quantum.](../media/3-azure-quantum-preview-providers.png)

   >[!NOTE]
   > By default, the Azure Quantum service adds the Microsoft quantum solution provider to every workspace.

1. After you add the providers that you want to use, select **Review + create**.

1. Review the settings and approve the *terms and conditions of use* for the selected providers. If everything is correct, select **Create** to create your workspace.

   ![Screenshot that shows reviewing the settings and creating the workspace.](../media/3-azure-quantum-preview-terms.png)

   >[!NOTE]
   > Your jobs will be uploaded to your Azure storage account and will be subject to storage charges.

Congratulations! You're set up to start using the Azure Quantum service. Let's see some case studies of what you can do with Azure Quantum.

> [!NOTE]
> If you run into any issues with the setup or you can report an issue on [GitHub](https://github.com/MicrosoftDocs/quantum-docs/issues).
