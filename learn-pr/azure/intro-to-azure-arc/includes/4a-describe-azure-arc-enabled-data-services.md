Contoso, a global entity, hosts multiple SQL Server instances with various versions today in their on-premises environment. The IT staff also wants to explore multi-cloud strategy in order to leverage cloud service providers around the world. Azure Arc-enabled data services provides a single pane of glass and unified tools for management, deployment, and being data sovereignty compliance in certain markets.

## What is Azure Arc-enabled data services?

Using Azure Arc-enabled SQL Managed Instance, you can enroll all of your database instances located anywhere to Azure and then manage these databases in a consistent way. Azure Arc-enabled data services:

- Enables you to be on an evergreen SQL instance
- Provides flexible scaling options - meaning you can easily add or remove CPU and Memory from instances in a heartbeat
- Takes advantage of cloud billing models
- Provides a platform as a service (PaaS)-like  experience on-premises and across multiple clouds
- Comes with high availability, monitoring services, automated upgrades, patching, backup and restore services out of the box

## Management capability comparison between various SQL services

The following chart compares management capabilities by deployment model:

:::image type="content" source="../media/4a-management-capabilities-by-deployment-model.png" alt-text="A chart that compares the management capabilities by deployment model." border="false" lightbox="../media/4a-management-capabilities-by-deployment-model.png" :::

## Connected and disconnected modes

Since Contoso has operational capabilities in countries where data is required to be on-premises due to regulations and low latency needs, Azure Arc-enabled data services is a perfect solution for them. Since the data is stored in country, you can meet regulation compliance or data sovereignty requirements. The underlying latency issues are also resolved by enabling the databases locally or in close proximity to operations.

The disconnected mode of deployments doesn't automatically load any data sets back to Azure. For example billing files, logs, and metrics aren't loaded automatically. Inventory information is only used for billing purposes. Manually export and load the billing file to Azure portal at least monthly. Although disconnected mode doesn't automatically load the file, you still get the scaling, evergreen SQL and other benefits from the solution.

In the direct connected mode, you get the full benefits of Azure Monitor (including alerts), inventory, and management capabilities via the Azure portal. In the connected mode, deployment data is still processed on-premises and you can optionally upload logs to Azure. The inventory information is only a metadata representation of assets that you have.

## SKU comparison

Today Azure Arc-enabled SQL Managed instance comes in two different types of SKU offerings.

- Business Critical = Enterprise Edition
- General Purpose = Standard Edition 

|Area  |Business Critical  | General Purpose  |
|---------|---------|---------|
|SQL feature set | Same as Enterprise Edition | Same as Standard Edition|
|CPU limit per instance |Unlimited|24 cores|
|Memory limit per instance |Unlimited| 127 GB |
|High availability|Contained availability groups over Kubernetes redeployment|Single instance with Kubernetes redeploy + shared storage|
|Read scale out |Availability group |None|
|Disaster recovery |Available via failover groups |Available via failover groups |
|Scale up/down |Available |Available |
|Monitoring |Built-in available locally. Optionally export to Azure Monitor |Built-in available locally. Optionally export to Azure Monitor |
|Logging |Built-in available locally. Optionally export to Azure Log Analytics|Built-in available locally. Optionally export to Azure Log Analytics.|
|Point in time restore |Built-in |Built-in |
|AHB exchange rates for IP component of price|1:1 Enterprise Edition</br>4:1 Standard Edition |1:4 Enterprise Edition</br>1:1 Standard Edition|
|Dev/test pricing|No cost|No cost|

## How does Azure Arc-enabled data service operate?

The Azure Arc-enabled SQL Managed Instance operates on any Kubernetes cluster and hardware that you have.

Azure Arc-enabled data service is deployed and managed via an agent-based solution. The agent that gets deployed to the environment is called the data controller. This agent acts as the Kubernetes orchestrator for the solution. To run the services in direct connected mode, you must have:

- Access to a Kubernetes cluster that is sized appropriately for your workload
- The supported Azure CLI version (>= 2.16.0 and <= 2.29.0)
- The following `arcdata` and associated k8s CLI extensions:
  - `arcdata`
  - `connectedk8s`
  - `customlocation`
  - `k8s-configuration`
  - `k8s-extension`

    To add any of the above extensions, run:

    ```azurecli
    az extension add --name <extension>
    ```

You must also:
- Meet the appropriate network requirements for connecting a Kubernetes cluster to Azure Arc.
- Read write many drives “Required for Business Critical SKU” 
- Register providers for Azure Arc-enabled Kubernetes:
  - Microsoft.Kubernetes.
  - Microsoft.KubernetesConfiguration.
  - Microsoft.ExtendedLocation.
- Create a destination Resource Group in your Azure subscription.
