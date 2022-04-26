
In the following exercise, you will deploy an AKS cluster to represent the AKS cluster that the deployment team at Songify had set up earlier. Then you will apply patch updates and upgrade that AKS cluster. 

 :::image type="content" source="../media/4-apply-patches-and-upgrade-aks-cluster.png" border="false" alt-text="An image that shows the process of the lab from applying patch upgrades first to the out of support version before upgrading to the latest supported version.":::

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create an AKS cluster

1. Create a resource group with the following command.

    ```azurecli
    az group create -l westus -n myResourceGroup
    ```

1. Run the following command in the Sandbox Azure Cloud Shell to check the current list of Kubernetes versions supported by Azure Kubernetes Service.

    ```azurecli-interactive
    az aks get-versions -l westus -o table
    ```

    You should see a list similar to the one below:

     :::image type="content" source="../media/4-current-aks-version-list.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service.":::

1. Select the oldest supported Kubernetes version from the list and store it inside a variable, *KV*.

    ```azurecli-interactive
    KV=1.18.17
    ```

     :::image type="content" source="../media/4-select-oldest-supported-kubernetes-version.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service with the oldest supported version outlined in a red box.":::

1. Run the next command to find the resource group name and store in inside a variable, *RG*.

    ```azurecli-interactive
    az group list -o table 
    RG=myResourceGroup
    ```

     :::image type="content" source="../media/4-find-resource-group.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the name, location, and status of the resource group used in the lab.":::

1. Run the following command to create an AKS cluster using the oldest supported Kubernetes version. 

    ```azurecli-interactive
    CLUSTERNAME=myakscluster
    az aks create -n $CLUSTERNAME -g $RG --kubernetes-version $KV --generate-ssh-keys
    ```

    Make sure your AKS cluster has been successfully provisioned before moving onto the next step. You can check by running the following command.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Upgrade the AKS cluster

1. First check if you need to upgrade your existing AKS clusters by running the following command.

    ```azurecli-interactive
    az aks get-upgrades -n $CLUSTERNAME -g $RG -o table
    ```

    You will see the versions available for upgrades are the next three supported Kubernetes versions from the current AKS cluster version.

    For example:

     :::image type="content" source="../media/4-only-next-3-versions-available-for-upgrade.png" border="true" alt-text="A screenshot that shows the expected output of the command should show the current Kubernetes version list supported by Azure Kubernetes Service with the n-1 and n-2 versions outlined in a red box.":::

1. Let's try to upgrade to the latest supported Kubernetes version immediately by running the following command.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG -k [latest-version] # e.g. 1.21.1
    ```

    You should see an error message similar to the one below:

    ```output
    Operation failed with status: 'Bad Request'. Details: Upgrading Kubernetes version 1.18.17 to 1.21.1 is not allowed. Available upgrades: 1.18.19,1.19.9,1.19.11. Please see https://aka.ms/aks-supported-k8s-ver for version details.
    ```

    When upgrading your AKS clusters, you cannot skip minor versions. This means if you are running version 1.18.x, you cannot immediately upgrade to version 1.20.x and above.

    However, you can skip patch version upgrades within a minor version.

## Apply patches updates

1. Run the following command to apply patch updates to the current AKS cluster.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-patch-version] # e.g. 1.18.19
    ```

    Wait until the patch upgrade is completed before by moving onto the next step by running the following command.

    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```

    > [!NOTE]
    > It is possible to apply upgrades only to the control plane in the AKS cluster or only to the nodes in the AKS cluster by including the optional parameters `--control-plane-only` or `--node-image-only` when running the upgrade command. If the optional parameters are not included, both the control plane and nodes in the AKS cluster are upgraded.

    Once complete, run the following command to confirm the patch upgrade. Check the `KubernetesVersion` is the next patch version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Upgrade to the next minor version

1. Run the following command to upgrade the AKS cluster to the next supported Kubernetes minor version.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-minor-version] # e.g. 1.19.11
    ```

    Wait until the minor upgrade is completed before by moving onto the next step by running the following command.

    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```

    Once complete, run the following command to confirm the upgrade. Check the `KubernetesVersion` is the next minor version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

1. Finally, run the following command to upgrade the cluster to the latest stable Kubernetes version supported by Azure Kubernetes Service.

    ```azurecli-interactive
    az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [latest-stable-version] # e.g. 1.20.7
    ```

    Wait until the upgrade is completed before by moving onto the next step by running the following command.

    ```azurecli-interactive
    az aks wait -g $RG -n $CLUSTERNAME --update
    ```

    Once complete, run the following command to confirm the upgrade. Check the `KubernetesVersion` is the latest stable Kubernetes version.

    ```azurecli-interactive
    az aks show -n $CLUSTERNAME -g $RG -o table
    ```

## Clean up your resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal:

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the resource group **myResourceGroup**, or the resource group name that you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources that you created in this module.
