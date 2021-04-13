The first step toward an the deployment of an Azure landing zone is the implementation of a Cloud Adoption Framework template. When you're following the *start small and expand* approach, you start with the CAF Migration landing zone blueprint.

## Deploy the blueprint sample

Starting with an empty Azure subscription, you'll deploy the blueprint sample by doing the following tasks:

- Create a new blueprint from the sample.
- Mark your copy of the sample as **Published**.
- Assign your copy of the blueprint to a current subscription.

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) before you begin.

## Create a new blueprint from the sample

First, implement the blueprint sample by creating a new blueprint in your environment.

1. Select **All services** on the left pane. Search for and select **Blueprints**.

1. From the **Getting started** page on the left, select the **Create** button under **Create a blueprint**.

1. Find the **CAF Migration landing zone** blueprint sample under **Other Samples** and select **Use this sample**.

1. Enter the basics of the blueprint sample:
   - For **Blueprint name**, provide a name for your copy of the sample CAF Migration landing zone blueprint.
   - For **Definition location**, use the ellipsis and select the management group to which you'll save your copy of the sample.

1. Select the **Artifacts** tab at the top of the page or **Next: Artifacts** at the bottom of the page.

1. Review the list of artifacts that make up the blueprint sample. Many of the artifacts have parameters that we'll define later. Select **Save Draft** when you've finished reviewing the blueprint sample.

## Publish the sample copy

Your copy of the blueprint sample has now been created in your environment. It's created in **Draft** mode and must be in **Published** mode before you can assign and deploy it. The copy of the blueprint sample can be customized to your environment and needs, but that modification might move it away from the guidance for the CAF Migrate landing zone blueprint.

1. Select **All services** on the left pane. Search for and select **Blueprints**.

1. Select the **Blueprint definitions** page on the left. Use the filters to find your copy of the blueprint sample and then select it.

1. Select **Publish blueprint** at the top of the page. 

1. In the new page on the right:

   1. For **Version**, provide a version for your copy of the blueprint sample. This property is useful for later modifications. 
   1. For **Change notes**, provide notes such as "first version published from the CAF Migration landing zone blueprint sample." 
   1. Select **Publish** at the bottom of the page.

## Assign the sample copy

After the copy of the blueprint sample has been successfully published, you can assign it to a subscription within the management group where it was saved. This procedure is where you provide parameters to make your deployment of a copy of the blueprint sample unique.

1. Select **All services** on the left pane. Search for and select **Blueprints**.

1. Select the **Blueprint definitions** page on the left. Use the filters to find your copy of the blueprint sample and then select it.

1. Select **Assign blueprint** at the top of the blueprint definition page.

1. Provide the parameter values for the blueprint assignment:
   - Make the following selections under **Basics**:
     - **Subscriptions**: Select one or more of the subscriptions that are in the management group where you saved your copy of the blueprint sample. If you select more than one subscription, the parameters that you enter will be used to create an assignment for each subscription.
     - **Assignment name**: The name is pre-populated for you based on the name of the blueprint. Change as needed or leave as is.
     - **Location**: Select a region in which to create the managed identity. Azure Blueprints uses this managed identity to deploy all artifacts in the assigned blueprint.
     - **Blueprint definition version**: Pick a **Published** version of your copy of the blueprint sample.
   - Under **Lock assignment**, select the blueprint lock setting for your environment.
   - Under **Managed identity**, choose either the default **system assigned** identity option or the **user assigned** identity option.
   - Under **Blueprint parameters**, define the following parameters. Many of the artifacts in the blueprint definition use these parameters to provide consistency.

       - **Organization**: Enter your organization's name. It must be unique.
       - **AzureRegion**: Select one Azure region for deployment.

   - The parameters defined in the **Artifact parameters** section apply to the artifact under which they're defined. These parameters are dynamic because they're defined during the assignment of the blueprint.

1. After you've entered all parameters, select **Assign** at the bottom of the page. The blueprint assignment is created and artifact deployment begins. Deployment takes roughly five minutes. To check on the status of deployment, open the blueprint assignment.

> [!WARNING]
> The Azure Blueprints service and the built-in blueprint samples are *free of cost*. Azure resources are [priced by product](https://azure.microsoft.com/pricing/?azure-portal=true). Use the [pricing calculator](https://azure.microsoft.com/pricing/calculator/?azure-portal=true) to estimate the cost of running resources that this blueprint sample deploys.

## Artifact parameters

The following table lists the parameters for blueprint artifacts:

|Artifact name|Artifact type|Parameter name|Description|
|-|-|-|-|
| Deploy VNet landing zone | Azure Resource Manager template | `IPAddress_space` | **Locked** - Provide the first two octets (for example, 10.0). |
| Deploy Key Vault | Azure Resource Manager template | `KV-AccessPolicy` | **Locked** - The group or user object ID to grant permissions to in Azure Key Vault. |
| Deploy Log Analytics | Azure Resource Manager template | `LogAnalytics_DataRetention` | **Locked** - The number of days that data will be retained in Log Analytics. |
| Deploy Log Analytics | Azure Resource Manager template | `LogAnalytics_Location` | **Locked** - The region used for establishing the workspace. |
| Deploy Azure Migrate | Azure Resource Manager template | `Azure_Migrate_Location`| **Locked** - Select the region to deploy Azure Migrate. |
