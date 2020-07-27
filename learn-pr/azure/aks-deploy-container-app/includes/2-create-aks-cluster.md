Your company is looking at ways to deploy your cloud-based video rendering service. You've chosen Azure Kubernetes Service (AKS) as your cloud-native development platform. However, before you can deploy any application, you need to create your AKS cluster.

We'll review a few concepts that allow you to deploy a new AKS cluster successfully.

## Kubernetes clusters

Kubernetes is based on clusters. Instead of having a single VM, it uses several machines working as one. These VMs are called nodes. Kubernetes is a cluster-based orchestrator and provides your application several benefits such as availability, monitoring, scaling, and rolling updates.

## Cluster nodes

A cluster is node-based. There are two types of nodes in a Kubernetes cluster that provides specific functionality.

- **Control plane nodes**:  These nodes host the cluster's control plane aspects and are reserved for services controlling the cluster. They're responsible for providing the API you and all the other nodes use to communicate. No workloads are deployed or scheduled on these nodes.

- **Nodes**: These nodes are responsible for executing custom workloads and applications, such as components from your cloud-based video rendering service.

## Cluster architectures

A cluster architecture allows you to conceptualize the number of control planes and node you'll deploy in your Kubernetes cluster.

For example, the number of nodes in a cluster should always be more than two. When a node becomes unavailable, the Kubernetes scheduler will try to reschedule all the workloads running on this node onto the remaining nodes in the cluster.

There are two popular cluster architectures for Kubernetes-based deployments.

## Single control plane and multiple nodes

:::image type="content" source="../media/2-1-diagram.png" alt-text="A diagram that depicts a Single control plane and multiple nodes in an cluster configuration.":::

The single control plane and multiple node architecture is the most common architectural pattern. While this pattern is the easiest to deploy, it doesn't provide high availability to your cluster's core management services.

If the control plane node becomes unavailable for any reason, no other interaction can happen with the cluster. Even by you as an operator, or by any workloads that use Kubernetes' APIs to communicate until, at least, the API server is back online.

Despite being less available than others, this architecture should be enough for most situations. It's less likely that the core management services become unavailable compared to a node going offline. The control plane nodes are subject to fewer modifications than nodes and more resilient.

However, if you're dealing with a production scenario, this architecture might not be the best solution.

## Single control plane and a single node

:::image type="content" source="../media/2-2-single-diagram.png" alt-text="A diagram that depicts a Single control plane and single node in an cluster configuration.":::

The single control plane and a single node is a variant of the previous architecture and used in development environments. This architecture provides only one node, hosting both the control plane and a worker node. It's useful when testing or experimenting with different Kubernetes concepts. The single control plane and a single node limit cluster scaling and makes this architecture not suitable for production and staging use.

## How to configure an AKS cluster

When you create a new AKS cluster, you have several different items of information that you need to configure.  Each item impacts the final configuration of your cluster.

These items include:

- Node pools
- Node count
- Automatic routing

## Node pools

You create *node pools* to group nodes in your AKS cluster. When you create a node pool, you specify the VM size for each node in the node pool. Node pools use virtual machine scale sets as the underlying infrastructure to allow the cluster to scale the number of nodes in a node pool when needed. New nodes created in the node pool, will always be the same size as you specified when creating the node pool.

:::image type="content" source="../media/2-3-nodepool-diagram.png" alt-text="A diagram that depicts a Kubernetes cluster with two node pools. The first node pool uses NC24s_v2 VMs and the second node pool uses B2s standard VMs.":::

## Node count

The node count is the number of nodes your cluster will have in a node pool. Nodes are Azure virtual machines (VMs), and you can change their size and count to match your usage pattern.

You can change the node count later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

## Automatic routing

A Kubernetes cluster blocks all external communications by default. For example, assume you deploy a website that is accessible to all clients. You need to manually create an **Ingress* with an exception that allows incoming client connections to that particular service. This configuration requires network-related changes that forward requests from the client to an internal IP on the cluster, and finally to your application. Depending on your specific requirements, this process can be complicated.

AKS allows you to overcome the complexity by enabling what is called HTTP application routing. This add-on makes it easy to access applications on the cluster through an automatically deployed Ingress Controller.

### Ingress Controllers

Ingress Controllers provide the capability to deploy and expose your applications to the world without the need to configure network-related services.

:::image type="content" source="../media/2-4-http-application-routing-diagram.png" alt-text="A HTTP Application Routing Diagram that shows how an Ingress controller that listens for ingress resources and creates DNS rules to make applications available to external clients.":::

Ingress Controllers create a reverse-proxy server that automatically allows for all the requests to be served from a single DNS output. You don't have to create a DNS record every time a new service is deployed. The ingress controller will take care of it. When a new ingress is deployed to the cluster, the Ingress Controller creates a new record on an Azure-managed DNS zone and link it to an existing load balancer. This functionality allows for easy access to the resource through the Internet without the need for additional configuration.

Despite the advantages, HTTP application routing is better suited to more basic clusters. It doesn't provide the amount of customization needed for a more complex configuration. If you plan to deal with more complex clusters, there are better-suited options like the official Kubernetes Ingress Controller.
