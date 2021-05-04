Sometimes you need to pass sensitive values into your deployments, like logins, passwords, and API keys. However, you need to ensure these values are protected. In some situations, you don't want the person who's creating the deployment to know the secret values. Other times, someone will enter the parameter value when they create the deployment, but you need to make sure the secret values aren't logged. In this unit, you'll learn about the ways you can protect your parameters.

> [!TIP]
> The best approach is to avoid using credentials entirely. [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) can enable the components of your solution to securely communicate with one another without any credentials. Managed identities are not available for every resource, but it's a good idea to use them wherever you can. Where you can't, you can use the approaches described below.

## Define secure parameters

The `@secure` decorator can be applied to string and object parameters that might contain secret values. When you define a parameter as `@secure`, Azure won't make the parameter values available in the deployment logs. Also, if you create the deployment interactively using the Azure CLI or Azure PowerShell and you need to enter the values during the deployment, the terminal will not display the text on your screen.

As part of the HR application migration, you need to deploy an Azure SQL server and database. You'll provision the server with an administrator login and password. Since they are so sensitive, you need these values to be secured. Here is an example declaration to create two string parameters for the SQL server's administrator details:

```bicep
@secure()
param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorPassword string
```

Note that neither parameter has a default value specified. It's a good practice not to specify a default value for usernames, passwords, and other secrets. Otherwise, if someone deploys your template and doesn't realize they should override the value, they will weaken their security because they'll get a default value instead of something they've chosen themselves.

> [!TIP]
> Make sure you don't create outputs for sensitive data. Output values can be accessed by anyone who has access to the deployment history, and they are not appropriate for handling secrets.

## Avoid using parameter files for secrets

As you learned in the previous unit, parameter files are a great way to specify a set of parameter values. You'll often create parameter files for each environment you're deploying to. However, you should generally avoid using parameter files to specify secret values. Parameter files are often saved to a centralized version control system, like Git, which lots of people might have access to in the future. You should never save sensitive data to version control systems since they aren't designed to store this sort of information.

## Integrate with Azure Key Vault

Azure Key Vault is a service designed to store and provide access to secrets. You can integrate your Bicep templates with Key Vault by using a parameter file with a reference to a Key Vault secret.

You can use this feature by referring to the key vault and secret in your parameter file. The value is never exposed because you only reference its identifier, which by itself isn't anything secret. When you deploy the template, Resource Manager will contact the key vault and retrieve the data.

> [!TIP]
> You can refer to secrets in key vaults that are located in a different resource group or subscription than the one you're deploying to.

:::image type="content" source="../media/5-parameter-file-key-vault.png" alt-text="Diagram that shows a parameter file reference Azure Key Vault and pass secret to Bicep template to deploy Azure resources" border="false":::

Here's a parameter file that uses Azure Key Vault references to look up the SQL server administrator login and password to use:

:::code language="json" source="code/5-key-vault-parameters.json" highlight="6-11,14-19":::

Notice that instead of specifying a `value` for each of the parameters, this file has a `reference` object, which contains details of the key vault and secret.

> [!IMPORTANT]
> Your key vault must be configured to allow Resource Manager to access the data in the key vault during template deployments. Also, the user who deploys the template must have permission to access the key vault. You'll learn how to do this in the next unit.

> [!NOTE]
> Currently Bicep doesn't support Key Vault references for modules.
