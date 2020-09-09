Your company is experiencing increased demand for its video rendering service because of its international expansion. You're looking for ways to scale the product to provide a better experience for all customers. You want to understand how to deploy applications to an Azure Kubernetes Service (AKS) cluster and allow customers access to the application's services.

You created an AKS cluster and deployed your web application to the Kubernetes cluster. When you deployed the web app, you used the Kubernetes declarative paradigm to describe what you wanted to create. This way, you can keep the app's version history and make future deployments easily reproducible.

Imagine how it would be to deploy this application onto multiple virtual machines or another environment without Kubernetes. You would have to re-create your environment with each new deployment and configure additional services to manage user requests between these instances. AKS simplifies the implementation of Kubernetes clusters and provides all the orchestration features you need to manage cloud-native applications.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Open the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select **Resource groups** on the left.

1. Find the **rg-contoso-video** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context aks-contoso-video
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context aks-contoso-video from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [AKS documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Prepare an application for AKS](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-prepare-app?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Integrate Azure Container Registry with AKS](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [HTTP application routing](https://docs.microsoft.com/azure/aks/http-application-routing?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Azure CLI documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Azure CLI command docs](https://docs.microsoft.com/cli/azure/aks?view=azure-cli-latest&WT.mc_id=deploycontainerapps_summary-learn-ludossan#az-aks-create)
- [Kubernetes ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
- [Kubernetes documentation](https://kubernetes.io/docs/home/)
- [Kubernetes service types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
- [Azure Kubernetes Service (AKS) Production Baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
