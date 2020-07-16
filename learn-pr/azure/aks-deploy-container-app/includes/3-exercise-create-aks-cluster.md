In this exercise, you'll create an AKS cluster to deploy a sample component for your video rendering service. You'll create an AKS cluster that uses several nodes to meet the demand of many customers using the service. You decide to use the *Single Control Plane and Multiple Nodes* architecture since it provides the best way to create and manage workload resources.

## Create a new cluster

You start the AKS cluster deployment by provisioning the cluster within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI. 

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Log in to the Azure Cloud Shell with the account you wish to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. Run the `az group create` command to create a resource group. You'll deploy all resources into this new resources group.

    ```azurecli
    az group create \
        --name contoso-aks \
        --location eastus
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group contoso-aks \
        --name contoso-kubernetes-cluster \
        --node-count 3 \
        --enable-addons http_application_routing \
        --generate-ssh-keys \
        --dns-name-prefix contoso-kubernetes-$RANDOM \
        --node-vm-size Standard_B2s
    ```

    The above command creates a new AKS cluster named `contoso-kubernetes-cluster` within the `contoso-aks` resource group. The cluster will have three nodes defined by the `--node-count` parameter. The `--node-vm-size` parameter configures the cluster nodes as `Standard_B2s` sized VMs, and the HTTP application routing addon is enabled via the `--enable-addons` flag. Finally, the command sets the DNS name for your cluster to `contoso-kubernetes` using the `--dns-name-prefix` parameter.

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by using the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials \
        --name contoso-kubernetes-cluster \
        --resource-group contoso-aks
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl allows you to manage multiple clusters from a single command-line interface.

1. Execute the ` kubectl get nodes` command to check that you can connect to your cluster and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

    You should receive a list of three available nodes.
