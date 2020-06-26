In this exercise, you add a parameter to define the Azure Storage Account name at execute time. You then add a parameter to define what Storage Account SKU is allowed and define which one to use for this deployment. You also add usefulness to the template by adding an output that can be used later in the deployment process.

## Create parameters for the template

Here, you make your template more flexible by adding parameters that can be set at runtime. Create a parameter for the ```storageName``` value.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser between the curly braces in the *parameters* attribute. ```"parameters":{},```
1. Press <kbd>Enter</kbd> and then type **par**. You see a list of related snippets. Choose **arm-param**. This adds a generic parameter to the template. It will look like this:

    ```json
     "parameters": {
        "parameter1": {
        "type": "string",
        "metadata": {
            "description": "description"
        }
      }
    },
    ```

1. Change the parameter to be called **storageName**, leave the type as a string, add a **minLength** value of **3**, a **maxLength** value of **24**, and add a description value of **The name of the Azure storage resource"**.
1. The parameter block should look like this:

    ```json
    "parameters": {
       "storageName": {
           "type": "string",
           "minLength": 3,
           "maxLength": 24,
           "metadata": {
                "description": "The name of the Azure storage resource"
            }
       }
   },
    ```

1. Use the new parameter in the ```resources``` block in both the ```name``` and ```displayName``` values. The entire file will look like this:

   [!code-json[](code/parameter2.json?highlight=5-12,17,21)]

1. Save the file.

### Deploy the parameterized template

Here, you change the name of the deployment to better reflect what this deployment does and fill in a value for the new parameter.

1. Run the following Azure CLI commands in the terminal. This is the same code you used previously, however the name of the deployment is changed and you need to fill in a unique name for the ```storageName``` parameter. Remember, this must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addnameparameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageName={your-unique-name}
    ```

1. In your browser, navigate back to Azure. Go to your resource group and see that there are now *3 Succeeded* deployments. Select this link.
1. Notice that all three deployments are in the list.
1. Explore the  *addnameparameter* deployment as you did previously.

### Add another parameter to limit allowed values

Here you use parameters to limit the values allowed for a parameter.

1. Place your cursor after the closing curly brace for the ```storageName```parameter. Add a comma and press the <kbd>Enter</kbd> key.
1. Again, type **par** and choose **arm-param**.
1. Change the new generic parameter to this:

    ```json
    "storageSKU": {
       "type": "string",
       "defaultValue": "Standard_LRS",
       "allowedValues": [
         "Standard_LRS",
         "Standard_GRS",
         "Standard_RAGRS",
         "Standard_ZRS",
         "Premium_LRS",
         "Premium_ZRS",
         "Standard_GZRS",
         "Standard_RAGZRS"
       ]
     }
    ```

      Here you are listing the values that this parameter will allow. If the template is run with a value that is not allowed, the deployment will fail.

1. Add a comment to this parameter.

    :::image type="content" source="../media/5-add-comments.png" alt-text="The azuredeploy.json file with the comment This is the allowed values for an Storage Account above the storageSKU parameter" border="true":::

    Azure Resource Manager templates support ```//``` and ```/* */``` comments.

1. Update *resources* to use the ```storageSKU``` parameter. Take advantage of the intellisense in Visual Studio Code to make this easier.

    ```json
    "sku": {
         "name": "[parameters('storageSKU')]"
       }
    ```

1. The entire file will look like this:

    [!code-json[](code/parameter3.json?highlight=13-26,40)]

1. Save the file.

### Deploy the template

Here you deploy successfully using a ```storageSKU``` parameter that is in the allowed list, then you try to deploy the template using a ```storageSKU``` parameter that is not in the allowed list. The second deployment will fail as expected.

1. Run the following commands to deploy the template. You need to fill in a unique name for the ```storageName``` parameter. Remember, this must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addSkuParameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Standard_GRS storageName={your-unique-name}
    ```

      Allow this deployment to finish. This deployment succeeds as expected.

1. Run the following commands to deploy the template with a parameter that is not allowed. Here. you changed the ```storageSKU``` parameter to **Basic**. You need to fill in a unique name for the ```storageName``` parameter. Remember, this must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addSkuParameter-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Basic storageName={your-unique-name}
    ```

    This deployment fails. Notice the error.

    :::image type="content" source="../media/3-deploy-validation-failed.png" alt-text="Terminal window showing the deployment validation error." border="true":::

## Add output to the template

Here you add to the ```outputs``` section of the template to output the endpoints for the storage account resource.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser between the curly braces in the outputs attribute. ```"outputs":{},```
1. Press <kbd>Enter</kbd> and then type **out**. You see a list of related snippets. Choose **arm-output**. This adds a generic output to the template. It will look like this:

    ```json
    "outputs": {
        "output1": {
        "type": "string",
        "value": "value"
      }
    ```

1. Change **"output1"** to **"storageEndpoint"**, the value of ```type``` to **"object"**, and the value of ```value``` to **"[reference(parameters('storageName')).primaryEndpoints]"**. This is the expression we discussed in the previous unit that gets the endpoint data, and because we specified *object* as the type, it will return the object in JSON format.

    ```json
    "outputs": {
       "storageEndpoint": {
           "type": "object",
           "value": "[reference(parameters('storageName')).primaryEndpoints]"
       }
    ```

1. Save the file.

### Deploy the template with an output

Here, you deploy the template and see the endpoints output as JSON. You need to fill in a unique name for the ```storageName``` parameter. Remember, this must be unique across all of Azure. You can use the unique name you created in the last section. In that case, Azure will update the resource instead of creating a new one.

1. Run the following commands to deploy the template. Be sure to replace the *{your-unique-name} with a string unique to you.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addoutputs-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storageSKU=Standard_LRS storageName={your-unique-name}
    ```

1. Notice the output.

    :::image type="content" source="../media/3-add-output-result.png" alt-text="Terminal window showing the primary endpoints output as JSON." border="true":::

1. In the portal, navigate to your *addOutputs* deployment. You can find your output there as well.

    :::image type="content" source="../media/3-portal-outputs.png" alt-text="Azure portal showing the output selection in the left menu." border="true":::
