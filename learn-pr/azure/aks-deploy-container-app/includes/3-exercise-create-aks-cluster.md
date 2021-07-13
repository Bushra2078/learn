In this exercise, you'll create an AKS cluster that uses several nodes to meet the demand of many customers using the service. You decide to use the *single control plane and multiple nodes* architecture because it provides the best way to create and manage workload resources.

AKS Supports both Linux and Windows node pools, however the cluster must be created with additional **pre-requisites** and commands if you're going to use windows node pools. Please make a selection above, based on which type of node pools you want to add.

AKS cluster can be provisioned through Azure portal or Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

::: zone pivot="linux"

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select *Bash* as the running shell.

1. Create variables for the configuration values you'll reuse throughout the exercises.

    ```bash
    RESOURCE_GROUP=rg-cluster
    CLUSTER_NAME=aks-contoso
    ```

1. Run the `az group create` command to create a resource group. You'll deploy all resources into this new resources group.

    ```azurecli
    az group create --name $RESOURCE_GROUP --location eastus
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $CLUSTER_NAME \
        --node-count 2 \
        --enable-addons http_application_routing \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --network-plugin azure
    ```

    The above command creates a new AKS cluster named `aks-contoso` within the `rg-contoso` resource group. The cluster will have two nodes defined by the `--node-count` parameter. We're using only two nodes here for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. The HTTP application routing add-on is enabled via the `--enable-addons` flag. These nodes will be part of **System** mode.

1. Run the `az aks nodepool add` command to add additional node pool of linux operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name nplinux \
        --node-count 2 \
        --node-vm-size Standard_B2s
    ```

    The above command adds a new node pool (**User mode**) to an existing AKS cluster (created in previous command). This new node pool can be used to host applications and workloads, instead of using **System** node pool, which gets created during previous command `az aks create`.

::: zone-end

::: zone pivot="windows"

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.

1. Create variables for the configuration values you'll reuse throughout the exercises.

    ```bash
    RESOURCE_GROUP=rg-cluster
    CLUSTER_NAME=aks-contoso
    ```

1. Run the `az group create` command to create a resource group. You'll deploy all resources into this new resources group.

    ```azurecli
    az group create --name $RESOURCE_GROUP --location eastus
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $CLUSTER_NAME \
        --node-count 2 \
        --enable-addons http_application_routing \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --network-plugin azure \
        --windows-admin-username localadmin
    ```

   The above command creates a new AKS cluster named `aks-contoso` within the `rg-contoso` resource group. The cluster will have two nodes defined by the `--node-count` parameter. We're using only two nodes here for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. The HTTP application routing add-on is enabled via the `--enable-addons` flag. These nodes will be part of **System** mode.

    The `--windows-admin-username` parameter is used to setup administrator credentials for Windows containers. The above command will prompt to set a password at the command line. The password has to meet [**Windows Server password requirements**](https://docs.microsoft.com/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

1. Run the `az aks nodepool add` command to add additional node pool of Windows operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name npwin \
        --node-count 2 \ 
        --node-vm-size Standard_B2s \
        --os-type Windows 
    ```

    The above command adds a new node pool (**User mode**) to an existing AKS cluster (created in previous command). This new node pool can be used to host applications and workloads, instead of using **System** node pool, which gets created during previous command `az aks create`.
    The `--os-type` parameter is used to specify operating system of the node pool. If not specified, it will use Linux as operating system for the nodes.

::: zone-end

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by running the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl enables you to manage multiple clusters from a single command-line interface.

1. Run the `kubectl get nodes` command to check that you can connect to your cluster, and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

   You should receive a list of four available nodes for two node pools.

::: zone pivot="linux"

   ```output
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-21895026-vmss000000   Ready    agent   245s   v1.19.9
    aks-nodepool1-21895026-vmss000001   Ready    agent   245s   v1.19.9
    aks-nplinux-21895026-vmss000000     Ready    agent   105s   v1.19.9
    aks-nplinux-21895026-vmss000001     Ready    agent   105s   v1.19.9
    ````

::: zone-end

::: zone pivot="windows"
  
```output
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-40010859-vmss000000   Ready    agent   245s   v1.19.9
    aks-nodepool1-40010859-vmss000001   Ready    agent   245s   v1.19.9
    aksnpwin000000                      Ready    agent   105s   v1.19.9
    aksnpwin000001                      Ready    agent   105s   v1.19.9
````

::: zone-end
