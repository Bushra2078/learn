With an active Azure subscription, your crew is ready for creating a Quantum
Workspace.

## Create a quantum workspace

You use the Azure Quantum service by adding a **quantum workspace** resource to your Azure subscription in the Azure portal. A quantum workspace resource, or workspace for short, is a collection of assets associated with running quantum or optimization applications.

1. Open the main page of the [Azure portal](todo).

1. Click **Create a resource**, type **Azure Quantum**, and press enter to see the search results. On the results page, you should see a tile for the **Azure Quantum (preview)** service.

   ![Tile for the Azure Quantum (preview)
   service](azure-quantum-preview-search.png)

1. Click **Azure Quantum (preview)** and then click  **Create**. This opens a form to create a Quantum Workspace.

   ![Create resource for the Azure Quantum (preview)
   service](azure-quantum-preview-create.png)

1. Fill out the details of your Workspace:
   - **Subscription:** The subscription that you want to associate with this
     Workspace.
   - **Resource group:** The resource group that you want to assign this Workspace to.
   - **Name:** The name of your Quantum Workspace.
   - **Region:** The region for the Workspace. For this private preview, select  **(US) West US**.
   - **Storage Account**: The Azure storage account to store your jobs and results. If you don't have an existing storage account, click **Create a new storage account** and complete the necessary fields. For this preview, we recommend using the default values.

   ![Properties for the Azure Quantum Workspace](azure-quantum-preview-properties.png)

   >[!NOTE]
   > You must be an Owner of the selected resource group to create a new storage account. For more information about how resource groups work in Azure, see [Control and organize Azure resources with Azure Resource Manager](https://docs.microsoft.com/learn/modules/control-and-organize-with-azure-resource-manager/).

1. After completing the information, click the **Providers** tab to add providers to your Workspace. A provider gives you access to a quantum service, which can be quantum hardware, a quantum simulator, or an optimization service.

   ![Providers for Azure Quantum](azure-quantum-preview-providers.png)

   >[!NOTE]
   > By default, the Azure Quantum service adds the Microsoft Quantum Solution provider to every Workspace.

1. After adding the providers that you want to use, click **Review + create**.

1. Review the settings and approve the *Terms and Conditions of Use* of
   the selected providers. If everything is correct, click on **Create** to create your Quantum Workspace.

   ![Review and create the Workspace](azure-quantum-preview-terms.png)

   >[!NOTE]
   > Your jobs will be uploaded to the Azure storage account created above and will be subject to storage charges.

Congratulations, you are set up to start using the Azure Quantum service. Let's see
some case studies of what you can do with Azure Quantum.
