The company needed to deploy its infrastructure from the ground up. So we created an AKS cluster and deployed a ping application to check it's working properly.

We used Kubernetes' declarative paradigm to help us describe what we wanted to create, this way we can keep a version history and make it easily reproducible. AZ CLI allowed us to connect to our managed Kubernetes service with AKS without having to worry about infrastructure and to get up and running fast.

Imagine how would it be to deploy this application on a VM or another environment without Kubernetes. Having AKS to manage the heavy lifting for us, it made possible not only to save much time but to make our deployment much simpler.

## Learn more

- [AKS Documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Trident's documentation on cluster architectures](https://netapp-trident.readthedocs.io/en/stable-v19.01/dag/kubernetes/kubernetes_cluster_architecture_considerations.html#cluster-architectures)
- [Prepare an application for AKS](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-prepare-app?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Integrating ACR with AKS](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Private AKS Clusters](https://docs.microsoft.com/azure/aks/private-clusters?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [AKS Network Policies](https://docs.microsoft.com/azure/aks/use-network-policies?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [AKS Network Policies [video]](https://azure.microsoft.com/resources/videos/azure-friday-secure-traffic-between-pods-using-network-policies-in-azure-kubernetes-service-aks/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [HTTP Application Routing](https://docs.microsoft.com/azure/aks/http-application-routing?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [Azure CLI documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)
- [AZ CLI command docs](https://docs.microsoft.com/cli/azure/aks?view=azure-cli-latest&WT.mc_id=learndeploycontainerappsaks-learn-ludossan#az-aks-create)
- [Azure Service Principals](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?WT.mc_id=learndeploycontainerappsaks-learn-ludossan#create-a-service-principal)
- [Kubernetes' Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
- [Kubernetes documentation](https://kubernetes.io/docs/home/)
- [Kubernetes Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
