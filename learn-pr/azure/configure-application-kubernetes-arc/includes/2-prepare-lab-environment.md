In this exercise, you'll prepare your lab environment for the implementation of Azure App Service on Azure Arc enabled Kubernetes clusters. The exercise consists of the following tasks:

1. Install the prerequisite software tools.
1. Enable required preview features in the Azure subscription.
1. Install required Azure CLI extensions.

This exercise is the first in this module's sequence of exercises. They guide you through the process of implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment.
1. Set up a Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure Arc.
1. Implement App Service on the Azure Arc enabled Kubernetes cluster.
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster.
1. Clean up the lab environment.

:::image type="content" source="../media/2-exercise-1.png" alt-text="Depiction of this module's exercise sequence with additional substeps illustrated for the first exercise (Prepare the lab environment)." border="false":::

## Task 1: Install the prerequisite software tools

The implementation process relies on Azure CLI, kubectl, and Helm. An Azure portal-based implementation process isn't yet available.

> [!IMPORTANT]
> Skip this task when using [Azure Cloud Shell](https://shell.azure.com). Azure Cloud Shell provides a convenient lab environment. It has the prerequisite software tools already installed and simplifies authenticating to your Azure subscription. Azure Cloud Shell is available on the latest versions of Microsoft Edge, Google Chrome, Mozilla Firefox, and Apple Safari. However, Safari in private mode isn't supported.

> [!NOTE]
> This module's exercises use Azure Cloud Shell to implement Azure App Service on Kubernetes with Azure Arc.

- Azure CLI (version 2.19.1 or later). For installation instructions, refer to [the Install the Azure CLI page on Microsoft Docs](https://docs.microsoft.com/cli/azure/install-azure-cli).
- kubectl (version 1.13.2 or later). After you install Azure CLI, use it to install kubectl by running `az aks install-cli`.
- Helm (version 3.4.0 or later). For information about Helm and installation, refer to [the Install existing applications with Helm in Azure Kubernetes Service (AKS) page on Microsoft Docs](https://docs.microsoft.com/azure/aks/kubernetes-helm).

## Task 2: Enable required preview features in the Azure subscription

Azure App Service on Kubernetes with Azure Arc is available in preview mode only. You must explicitly opt in if you intend to use it in your Azure subscription. After you complete the opt-in process, perform the following steps to enable necessary functionality within your Azure subscription.

1. Start any Azure Cloud Shell-compatible web browser, navigate to [Azure Cloud Shell](https://shell.azure.com), and, if prompted, authenticate with a Microsoft account or an Azure AD account that has an Owner role in the Azure subscription.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**.

    > [!NOTE]
    > If this is the first time you're starting Azure Cloud Shell and you're presented with the **You have no storage mounted** message, select the subscription you're using in this lab, and then select **Create storage**.

1. From the Bash session in the **Azure Cloud Shell** pane, run the following commands. These commands enable all required resource providers and their respective preview features for all resources and locations you'll use:

    ```azurecli-interactive
    az feature register --namespace Microsoft.Kubernetes --name previewAccess
    az provider register --namespace Microsoft.Kubernetes --wait

    az feature register --namespace Microsoft.KubernetesConfiguration --name extensions
    az provider register --namespace Microsoft.KubernetesConfiguration --wait

    az feature register --namespace Microsoft.ExtendedLocation --name CustomLocations-ppauto
    az provider register --namespace Microsoft.ExtendedLocation --wait

    az provider register --namespace Microsoft.Web --wait
    ```

    > [!NOTE]
    > Wait for the commands to complete. This should take about 2 minutes.

1. Run the following command to determine whether you can create App Service Kubernetes Environments:

    ```azurecli-interactive
    az provider show -n Microsoft.Web --query "resourceTypes[?resourceType=='kubeEnvironments'].locations"
    ```

    > [!NOTE]
    > Verify that the output includes the entries representing the **East US** and **West Europe** locations before you proceed. If it doesn't, wait a few minutes and repeat this step.

## Task 3: Install required Azure CLI extensions

Use the following steps to install the Azure CLI extensions that are required to implement Azure App Service on Kubernetes with Azure Arc:

1. From the Bash session in the **Azure Cloud Shell** pane, run the following command to confirm you have the latest CLI version and extensions:

    ```azurecli-interactive
    az upgrade
    ```

1. Run the following commands to install the **connectedk8s** and **customlocation** Azure CLI extensions:

    ```azurecli-interactive
    az extension add --upgrade --yes -n connectedk8s
    az extension add --upgrade --yes -n customlocation
    ```

    > [!NOTE]
    > Wait for the installation to complete. This should take about 1 minute.

1. From the Bash session in the **Azure Cloud Shell** pane, run the following commands to ensure that you are using the latest version of the **appservice-kube** Azure CLI extension:

    ```azurecli-interactive
    az extension remove -n appservice-kube
    az extension add --yes --source "https://aka.ms/appsvc/appservice_kube-latest-py2.py3-none-any.whl"
    ```

    > [!NOTE]
    > To verify that the installation completed successfully, run the `az -v` command and examine its output. The output should include the **Extensions** section in the following format (the sample output references the minimum required versions, but the actual versions might be higher):
    >
    >```json
    >Extensions:
    >customlocation                     0.1.2
    >connectedk8s                       1.1.3
    >appservice-kube                    0.1.20
    >```

Congratulations! You completed the first exercise of this module. You've prepared your lab environment for implementation of Azure App Service on Kubernetes with Azure Arc.
