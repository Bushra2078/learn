In this unit, you'll learn how to create an Azure Container Apps environment and an Azure for PostgreSQL database using Azure CLI. You will then configure your Quarkus application so it connects to the remote database instead of the local one.

Several targets are available to deploy a Quarkus application on Azure: from IAAS to FAAS. [Azure Container Apps](https://learn.microsoft.com/azure/container-apps/overview) sits between PAAS and FAAS. On one hand, it feels more PaaS, because you are not forced into a specific programming model and you can control the rules on which to scale out / scale in. On the other hand, it has quite some serverless characteristics like scaling to zero, event-driven scaling, per second pricing and the ability to leverage Dapr's event-based bindings.

![Azure Compute Services](../media/azure-compute-services.png)

Container Apps is built on top of [Azure Kubernetes Service](https://learn.microsoft.com/azure/aks/intro-kubernetes) (or AKS), including a deep integration with [KEDA](https://keda.sh) (event-driven auto-scaling for Kubernetes), [Dapr](https://dapr.io) (distributed application runtime) and [Envoy](https://www.cncf.io/projects/envoy) (a service proxy designed for cloud-native applications). The underlying complexity is completely abstracted for the end-user. So no need to configure your K8s service, deployment, ingress, volume manifests… You get a very simple API and user interface to configure the desired configuration for your containerized application. This simplification means also less control, hence the difference with AKS.

In Azure Container Apps, the applications need to be packaged into a Docker container. Azure Container Apps supports Docker containers built with Dockerfiles or containers built with Jib. The container has to be available on a container registry. Azure Container Apps supports Azure Container Registry, Docker Hub, and GitHub Container Registry. Once the application image is available in a registry, Azure Container Apps supports deploying from the Azure Portal, Azure CLI, GitHub Action and Azure DevOps.

Azure Container Apps has the following features:

* _Revisions_: automatic versioning that helps to manage the application lifecycle of your container apps
* _Traffic control_: split incoming HTTP traffic across multiple revisions for Blue/Green deployments and A/B testing
* _Ingress_: simple HTTPS ingress configuration, without the need to worry about DNS and certificates
* _Autoscaling_: leverage all KEDA-supported scale triggers to scale your app based on external metrics
* _Secrets_: deploy secrets that are securely shared between containers, scale rules and Dapr sidecars
* _Monitoring_: the standard output and error streams are automatically written to Log Analytics
* _Dapr_: through a simple flag, you can enable native Dapr integration for your Container Apps

Azure Container Apps introduces the following concepts:

* _Environment_: this is a secure boundary around a group of Container Apps. They are deployed in the same virtual network, these apps can easily intercommunicate easily with each other and they write logs to the same Log Analytics workspace. An environment can be compared with a Kubernetes namespace.
* _Container App_: this is a group of containers (pod) that is deployed and scale together. They share the same disk space and network.
* _Revision_: this is an immutable snapshot of a Container App. New revisions are automatically created and are valuable for HTTP traffic redirection strategies, such as A/B testing.

![Azure Container Apps Concepts](../media/aca-environment.png)

Let's see all these concepts in action by creating a Container App environment.
