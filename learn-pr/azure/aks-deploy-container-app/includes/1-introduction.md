Imagine you work for a growing video editing company that provides a cloud-based video rendering service. Your company is experiencing increased demand for its video rendering service because of its international expansion and is looking for ways to scale the product to provide a better experience to all customers. Management tasked you to assess which Azure service would improve the ability to deploy your video rendering service and meet demand quickly.

You've identified Azure Kubernetes Service (AKS) as a potential solution, as it meets the requirements to allow your application to handle the company's increased growth. You want to understand how to deploy applications to an AKS cluster and allow customers access to the application's services.

In this module, you'll deploy Kubernetes workloads declaratively to an AKS cluster using manifest files.  You will create different deployment manifest files that allow you to deploy and expose your application to your users.  

## Learning objectives

By the end of this module, you will be able to:

- Create and set up an Azure Kubernetes Cluster
- Deploy Kubernetes workloads using deployment YAML files
- Expose Kubernetes workloads using services and ingress
- Integrate Azure Container Registry to deploy container images

## Prerequisites

- Familiarity with Kubernetes concepts. If you're new to Kubernetes, start with the [basics of Kubernetes](https://azure.microsoft.com/topic/what-is-kubernetes/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Familiarity with [Git](https://docs.microsoft.com/contribute/git-github-fundamentals?WT.mc_id=deploycontainerapps_intro-learn-ludossan) and [GitHub](https://github.com)
- Familiarity with [Docker](https://docker.com) and Docker images
- An active Azure [subscription](https://azure.microsoft.com/free/services/kubernetes-service/?azure-portal=true&WT.mc_id=deploycontainerapps_intro-learn-ludossan).
- Ability to use the [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan)
- Ability to create a Docker container. If you're new to Docker, start with the [intro to containers](https://docs.microsoft.com/learn/modules/intro-to-containers/?WT.mc_id=deploycontainerapps_intro-learn-ludossan)

All exercises will use [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview?WT.mc_id=deploycontainerapps_intro-learn-ludossan), which already has all needed tooling installed. If you prefer to run the examples in your own terminal, you'll need to have the following tooling installed first:
    - [Azure CLI](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan)
    - [Kubectl](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_intro-learn-ludossan#connect-to-the-cluster)
