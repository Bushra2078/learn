In this exercise, you'll create a parameter file that provide inputs to the Bicep template that you previously created. In the same parameter file, you'll also add Key Vault references to provide sensitive information.

During the process, you'll:

> [!div class="checklist"]
> * Add some secure parameters.
> * Create a parameter file.
> * Test the deployment to ensure that the parameter file is valid.
> * Create a key vault and secrets.
> * Update the parameter file to refer to the key vault secrets.
> * Re-test the deployment to ensure that the parameter file is still valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Remove the default value for the App Service plan SKU

To make your template work across environments, the App Service plan SKU details will be provided in a parameter file rather than by a default value.

1. In the *main.bicep* file in Visual Studio Code, update the `appServicePlanSku` parameter to remove its default value:

   :::code language="plaintext" source="code/6-template.bicep" range="19-20" highlight="2" :::

## Add new parameters

Now you need to add a SQL server and database. First, you'll add parameters for the administrator login and password, and the database SKU. You'll set those later.

1. In the *main.bicep* file in Visual Studio Code, add the `sqlServerAdministratorLogin`, `sqlServerAdministratorPassword`, and `sqlDatabaseSku` parameters below the current parameter declarations. When you're finished, your parameter declarations should look like this:

   :::code language="plaintext" source="code/6-template.bicep" range="1-34" highlight="25-34" :::

   Notice that you're not specifying default values for the `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters, since it's bad security practice to add default values for secure parameters. Also, you're not specifying a default value for the `sqlDatabaseSku`. You'll specify this in a parameter file shortly.

## Add new variables

1. In the *main.bicep* file in Visual Studio Code, add the `sqlServerName` and `sqlDatabaseName` variables under the existing variables. When you're finished, your variable declarations should look like this:

   :::code language="plaintext" source="code/6-template.bicep" range="36-39" highlight="3-4" :::

### Add SQL server and database resources

1. In the *main.bicep* file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/6-template.bicep" range="60-77" :::

1. Save the changes to the file.

## Create a parameter file

1. Open Visual Studio Code, and open the folder where the _main.bicep_ file is located. In the same folder, create a new file called _main.parameters.dev.json_.

1. In the *main.parameters.dev.json* file, add the following code:

    :::code language="json" source="code/6-parameters-1.json" :::

1. Save the changes to the file.

## Deploy the Bicep template with the parameter file

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. Notice that you are providing a parameter file for the deployment.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. Notice that you are providing a parameter file for the deployment.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.dev.json
```

::: zone-end

Notice that you're prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment. You don't need to specify `solutionName` since it has a default value specified in the template. You don't need to specify the other parameter values because their values are specified in the parameter file.

> [!TIP]
> When you enter the secure parameters, the values you choose need to follow some rules:
> 
> - `sqlServerAdministratorLogin` must not be an easily guessable login name like `admin` or `root`. It can only contain alphanumeric characters, and must start with a letter.
> - `sqlServerAdministratorPassword` must be at least 8 characters long and includes lowercase letters, uppercase letters, numbers, and symbols. See the [SQL Azure password policy](/sql/relational-databases/security/password-policy#password-complexity) for more information on the password complexity.
> 
> If the parameter values don't meet the requirements, Azure SQL won't deploy your server.
> 
> Also, **make sure you keep a note of the login and password that you enter**. You'll use them again shortly.

The deployment may take a couple of minutes to finish.

## Create a key vault and secrets

Your toy company already has a key vault with the secrets they need for their deployments. To simulate this, you'll create a new key vault and add some secrets to use.

In the terminal, execute the following commands to create the key vault and secrets. Update the variable values before you execute these commands.

> [!CAUTION]
> Make sure you use the same login and password that you used in the previous step. If you don't, the next deployment won't complete successfully.

::: zone pivot="cli"

```azurecli
keyVaultName='YOUR-KEY-VAULT-NAME' # A unique name for the key vault.
login='YOUR-LOGIN' # The login that you used in the previous step.
password='YOUR-PASSWORD' # The password that you used in the previous step.

az keyvault create --name $keyVaultName --location westus --enabled-for-template-deployment true
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password
```

> [!NOTE]
> Notice that you are setting the `--enabled-for-template-deployment` setting on the vault. This allows Azure to use the secrets from your vault during deployments. If you don't set this then, by default, your deployments can't access secrets in your vault.
>
> Also, whoever executes the deployment must also have permission to access the vault. Since you created the key vault, you're the owner so you won't have to explicitly grant the permission in this exercise. For your own vaults, [you need to grant access to the secrets](/azure/azure-resource-manager/templates/key-vault-parameter#grant-access-to-the-secrets).

::: zone-end

::: zone pivot="powershell"

```azurepowershell
$keyVaultName = 'YOUR-KEY-VAULT-NAME' # A unique name for the key vault.
$login = 'YOUR-LOGIN' # The login that you used in the previous step.
$password = 'YOUR-PASSWORD' # The password that you used in the previous step.

$sqlServerAdministratorLogin = ConvertTo-SecureString $login -AsPlainText -Force
$sqlServerAdministratorPassword = ConvertTo-SecureString $password -AsPlainText -Force

New-AzKeyVault -VaultName $keyVaultName -Location westus -EnabledForTemplateDeployment
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorLogin' -SecretValue $sqlServerAdministratorLogin
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorPassword' -SecretValue $sqlServerAdministratorPassword
```

> [!NOTE]
> Notice that you are setting the `-EnabledForTemplateDeployment` setting on the vault. This allows Azure to use the secrets from your vault during deployments. If you don't set this then, by default, your deployments can't access secrets in your vault.
>
> Also, whoever executes the deployment must also have permission to access the vault. Since you created the key vault, you're the owner so you won't have to explicitly grant the permission in this exercise. For your own vaults, [you need to grant access to the secrets](/azure/azure-resource-manager/templates/key-vault-parameter#grant-access-to-the-secrets).

::: zone-end

### Get the key vault's resource ID

To be able to use the key vault secrets in your deployment, you need the resource ID of the vault. Run the following command to retrieve the key vault's resource ID.

::: zone pivot="cli"

```azurecli
az keyvault show --name $keyVaultName --query id --output tsv
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
(Get-AzKeyVault -Name $keyVaultName).ResourceId
```

::: zone-end

The resource ID will look something like this:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets
```

Copy the resource ID. You'll use this in the next step.

## Add key vault reference to parameter file

1. In *main.parameters.dev.json* file, append the following code after the `sqlDatabaseSku` parameter's closing brace. Make sure that you replace `YOUR-KEY-VAULT-RESOURCE-ID` with the value of the key vault resource ID you copied in the previous step. After you're done, your parameters file should look like this:

   :::code language="json" source="code/6-parameters-2.json" highlight="17-32" :::

1. Save the changes to the file.

## Deploy the Bicep template with parameter file and Azure key vault references

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. You are providing a parameter file along with a Bicep file.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. You are providing a parameter file along with a Bicep file.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.dev.json
```

::: zone-end

Notice that you're not prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment this time. Azure retrieves the values from your key vault instead.
