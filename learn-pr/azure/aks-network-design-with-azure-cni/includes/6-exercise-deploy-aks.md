We're now going to use the information we collected in the previous modules to deploy an Azure Kubernetes Service cluster.

In this unit, you'll deploy virtual networks, subnets, and identities and then deploy an Azure Kubernetes Service cluster using the Azure CNI networking plug-in.

We've approached our company's IT department. We've provided the information we've gathered about our application's requirements, virtual machine size, and network size. The IT department has provided some network address ranges that we can use for our Azure Kubernetes Service cluster. The following table lists our requirements and the IP addresses provided by our IT department in response.

Item | Description | IP Addresses
--- | --- | ---
Azure Kubernetes Service subnet | IP addresses for the nodes and pods in the cluster, 248 usable IP addresses required | 10.150.20.0/24
Kubernetes service subnet | IP addresses used inside the cluster for Kubernetes services. Must not conflict with other virtual networks or on-premises networks | 10.240.0.0/24
DNS service IP address | Must be in the Kubernetes service subnet, but can't be the first IP address from the available range  | 10.240.0.10

- For the **Azure Kubernetes Service Subnet**, we determined that we needed 248 usable IP addresses. Your IT department has given the network 10.150.20.0/24, which will provide 251 usable IP addresses after you've accounted for the five addresses that Azure reserves in every subnet.

- The **Kubernetes service subnet** is a group of IP addresses that aren't used in any other Azure virtual networks and doesn't conflict with any on premises network ranges. This address range is only ever used inside the cluster. Your IT department has indicated that you should use 10.240.0.0/24.

- The **DNS service IP address** is a single IP address within the **Kubernetes service subnet** range of addresses, but can't be the first IP address in that range. You've decided to use 10.240.0.10 as the DNS IP address.

## Create the virtual network and subnet

For this exercise, we'll create a virtual network and subnet. In a real world environment, you may have a team in your IT department responsible for managing networks and they may create these resources for you.

In Azure Cloud Shell, run the following command to create the **AKSVirtualNetwork** virtual network:

```bash
az network vnet create \
    --name AKSVirtualNetwork \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --address-prefixes 10.150.0.0/16  \
    --location westeurope
```

Next, in Azure Cloud Shell, run the following command to create the **AKSSubnet** subnet:

```bash
az network vnet subnet create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --vnet-name AKSVirtualNetwork \
    --name AKSSubnet \
    --address-prefixes 10.150.20.0/24
```

## Create an Azure Managed Identity

We need to create an Azure Managed Identity. The Azure Kubernetes Service uses this identity to access resources within the Azure subscription. The following two lines will create an Azure Managed Identity, then store its unique ID value in an environment variable for later use.

```bash
az identity create -n AKSIdentity -g <rgn>[sandbox resource group name]</rgn>
identityId=$(az identity show --name AKSIdentity -g <rgn>[sandbox resource group name]</rgn> --query id -o tsv)
```

## Create the Azure Kubernetes Service cluster

Now we'll create the AKS cluster and will pass in the values we've determined previously to configure the cluster as required.

We need to know the resource ID of the subnet we created previously. We can store it in an environment variable that we can use later.

```bash
subnetId=$(az network vnet subnet list --vnet-name AKSVirtualNetwork --resource-group <rgn>[sandbox resource group name]</rgn> --query "[?name=='AKSSubnet'].id" -o tsv)
```

In Azure Cloud Shell, run the following command to create the **AKSCluster** Azure Kubernetes Service cluster:

```bash
az aks create \
    --name AKSCluster \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --location westeurope \
    --network-plugin azure \
    --vnet-subnet-id $subnetId \
    --service-cidr 10.240.0.0/24 \
    --dns-service-ip 10.240.0.10 \
    --generate-ssh-keys \
    --enable-managed-identity \
    --assign-identity $identityId \
    --node-vm-size  Standard_F8s_v2 \
    --node-count 3 \
    --enable-cluster-autoscaler \
    --min-count 3 \
    --max-count 7
```

Let's walk through what the above command is doing:

Command fragment | Description
--- | ---
az aks create | Command to create an AKS cluster instance.
--name **AKSCluster** | The name of the cluster being created.
--resource-group **<rgn>[sandbox resource group name]</rgn>** | The resource group where the cluster should be created.
--location **westeurope** | The Azure region where the cluster should be created.
--network-plugin **azure** | Tell the AKS creation process that we want to use the Azure CNI networking plug-in.
--vnet-subnet-id **$subnetId** | The resource ID of the subnet that we created earlier. The subnet is the 10.150.20.0/24 address range that was given to us by the IT department.
--service-cidr **10.240.0.0/24** | The Kubernetes service address range that was given to us by the IT department.
--dns-service-ip **10.240.0.10** | The IP address we've decided to use for DNS.
--generate-ssh-keys | Creates a set of SSH keys that are used to secure the nodes.
--enable-managed-identity | Enables use of Azure Managed Identity for access to resource in the Azure subscription.
--assign-identity **$identityId** | Passes the ID value of the Azure Managed Identity that we created earlier.
--node-vm-size **Standard_F8s_v2** | We determined previously that an F8s v2 virtual machine would be the best option for our application.
-- node-count **3** | We want to start with three nodes.
-- enable-cluster-autoscaler | We want to enable the Kubernetes Cluster Autoscaler so that our cluster will scale up and down as demand on the application dictates.
--min-count **3** | Tell the autoscaler that we don't want to run fewer than three nodes.
--max-count **7** | Tell the autoscaler that we don't want to run more than 7 nodes. Remember that we've sized our network for 7 nodes plus 1 spare node for upgrades.

Once the cluster has been deployed, we can use the following command to confirm the details of the node pool:

```bash
az aks nodepool list --cluster-name AKSCluster --resource-group <rgn>[sandbox resource group name]</rgn> -o table
```

The output should look like this

```output
Name       OsType    VmSize           Count    MaxPods    ProvisioningState    Mode
---------  --------  ---------------  -------  ---------  -------------------  ------
nodepool1  Linux     Standard_F8s_v2  3        30         Succeeded            System
```

From the output, we can see that we have three nodes and a MaxPods value of 30.

Let's check how many IP addresses have been allocated.

```bash
az network vnet subnet list --vnet-name AKSVirtualNetwork --resource-group <rgn>[sandbox resource group name]</rgn> --query "[].ipConfigurations.length(@)" -o tsv
```

This command uses a JMESPath query string to determine how many `ipConfigurations` are defined in the subnet. The answer should be **93**. 

We've deployed three nodes to start with, so each node has one IP address each. We've left the maximum pods value at its default setting of 30, so each node has 30 IP addresses pre-allocated for pods to use. The total number of IP addresses that has been allocated so far is **3 x nodes + (30 pods * 3 nodes) = 93**

Finally, let's scale up the cluster and add one more node.

```bash
az aks scale --name AKSCluster --resource-group <rgn>[sandbox resource group name]</rgn> --node-count=4
```

Once the scale command completes, let's confirm the new details for our node pool:

```bash
az aks nodepool list --cluster-name AKSCluster --resource-group <rgn>[sandbox resource group name]</rgn> -o table
```

The output should reflect that we now have four nodes.

```output
Name       OsType    VmSize           Count    MaxPods    ProvisioningState    Mode
---------  --------  ---------------  -------  ---------  -------------------  ------
nodepool1  Linux     Standard_F8s_v2  4        30         Succeeded            System
```

Now, we can rerun the command to get a count of IP addresses.

```bash
az network vnet subnet list --vnet-name AKSVirtualNetwork --resource-group <rgn>[sandbox resource group name]</rgn> --query "[].ipConfigurations.length(@)" -o tsv
```

This time, the result is **124**, which is 31 more than last time. That's one more IP address for the new node, plus 30 more IP addresses pre-allocated for pods for that node.