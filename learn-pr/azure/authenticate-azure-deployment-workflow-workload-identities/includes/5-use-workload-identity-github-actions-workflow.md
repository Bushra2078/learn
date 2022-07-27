After you create a workload identity and assign it access to your Azure environment, it's time to use it in your GitHub Actions workflow. In this unit, you learn about the two changes that you need to make to your workflow definition.

## Allow the workflow to request tokens from Azure Active Directory

You need to allow your deployment workflow to request tokens from Azure Active Directory (Azure AD). In your workflow, add the `permissions` property:

:::code language="yaml" source="code/5-workflow.yml" range="5-7" :::

## Sign in to Azure

Your deployment workflow uses the `azure/login` action to sign in to Azure. When you use a workload identity, you need to specify three inputs:

| Input | Description |
|-|-|
| `client-id` | The application ID for the application registration. Ensure you use the application ID and not the object ID. |
| `tenant-id` | The unique identifier for your Azure AD tenant (directory). |
| `subscription-id` | The Azure subscription ID that you'll deploy to. |

When you define the values, you might choose to specify them directly in your workflow definition file:

TODO example

However, some organizations treat these identifiers as secret data, or don't allow identifiers to be committed to Git repositories. You can also use GitHub secrets to specify the values:

:::code language="yaml" source="code/5-workflow.yml" range="16-20" :::

Throughout the Microsoft Learn learning paths for Bicep, we use secrets to store and manage these identitifers. You can decide which approach works best for your organization.

## Deploy to Azure

After your workflow has signed in to Azure, you can deploy a Bicep file by using the `azure/arm-deploy` action. The following workflow definition shows a complete Bicep deployment workflow that uses workflow identities:

:::code language="yaml" source="code/5-workflow.yml" :::
