An [Azure Virtual Network (VNet)](/azure/virtual-network/virtual-networks-overview) is similar to a traditional network but with the added benefits provided by Azure infrastructure.

VNets enable your resources, such as virtual machines (VMs) and ML workspaces, to securely communicate with each other and other networks or the internet.

A Machine Learning engineer can use them in a variety of scenarios, such as linking a VM to data stored on-premises, restricting access to a training API so that only personnel from their lab can see it, or exposing an inference endpoint to the internet.

In this exercise, we'll create a VNet and use it to secure access to our existing [ML Workspace](http://URL_FOR_EX1).

## Prerequisites

- Basic knowledge of networking concepts.
- An Azure account and a subscription.
- A resource group Azure Machine Learning Workspace as created in the [previous exercise](http://URL_FOR_EX1).

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com).

## Create a VNet

Let's create a VNet for this exercise:

1. In the Azure portal, select **Create Resource**:
    
    :::image type="content" source="../media/resource_group_1.png" alt-text="Screenshot showing the Azure portal with a red box around resource groups.":::

2. Select **Create a resource** in the upper left-hand corner of the portal.

3. In the search box, enter **Virtual Network**. Select **Virtual Network** in the search results.

4. In the **Virtual Network** page, select **Create**.

    :::image type="content" source="../media/create_vnet.png" alt-text="Screenshot showing the virtual network page with a red box around create.":::

5. In **Create virtual network**, enter or select this information in the **Basics** tab:

    <!-- :::image type="content" source="./media/quick-create-portal/create-virtual-network.png" alt-text="Create virtual network Azure portal" border="true"::: -->

    :::image type="content" source="../media/vnet_form1.png" alt-text="Screenshot showing how to fill in the Azure Virtual Network form.":::

   | Setting              | Value                                                                                                 |
   | -------------------- | ----------------------------------------------------------------------------------------------------- |
   | **Project details**  |                                                                                                       |
   | Subscription         | Select your subscription.                                                                             |
   | Resource group       | Enter <b>MLResourceGroup</b> (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                                                                       |
   | Name                 | Enter **MLVNet**.                                                                                     |
   | Region               | Select **(US) East US**.                                                                              |

6. Select the **IP Addresses** tab, or select the **Next: IP Addresses** button at the bottom of the page.

   > [!TIP]
   > If your screen comes with the IPv4 address space and _default_ subnet setup like in the image below, skip to step 10.

    :::image type="content" source="../media/vnet_form2.png" alt-text="Screenshot showing Azure Virtual Network IP Addresses page.":::

7. In **IPv4 address space**, select the existing address space and change it to **10.1.0.0/16**.

8. Select **+ Add subnet**, then enter **default** for **Subnet name** and **10.1.0.0/24** for **Subnet address range**.

9. Select **Add**.

10. Select the **Review + create** tab or select the **Review + create** button.

11. Select **Create** and wait a few moments for the deployment to finish:

    :::image type="content" source="../media/vnet_deployment.png" alt-text="Screenshot showing the deployment complete page from step 11.":::

> [!IMPORTANT]
> For simplicity, we are creating a single subnet for our Virtual Network.
> A subnet is a range of IP addresses in the VNet.
> We could split a VNet into multiple subnets for organization and security, for example, a _training_ subnet that only Data Scientists could use, and an _inference_ subnet that is publicly available.

## Testing workspace access

We just added a VNet to our resource group, but is it restricting access to our __ml-workspace__?

<a name="studio"></a>We can test that using [Azure Machine Learning Studio](/azure/machine-learning/overview-what-is-machine-learning-studio) to access the contents of the workspace.

> [!TIP]
> The Azure Machine Learning Workspace is a web portal with high-level
> tools for model training, deployment, and asset management.

1. Select the __ml-workspace__ in the list of recent resources:

    :::image type="content" source="../media/workspace1.png" alt-text="Screenshot showing the Azure portal with a red box around ml-workspace.":::

2. Select the __Studio web URL__ for your workspace:

    :::image type="content" source="../media/workspace2.png" alt-text="Screenshot showing the studio web url to select.":::

3. Azure Machine Learning Studio should open in a new tab or window. Scroll down until you can see the tabs below (Runs, Compute, Models, and Datasets):

    :::image type="content" source="../media/workspace-no-warnings.png" alt-text="Screenshot showing the workspace with no warnings.":::

Each tab above represents a "folder" that stores the resources you and your team would use in Machine Learning.

Although you probably don't have any objects there yet, like in the image above, there should be no warnings or error messages, meaning that there's no network access restrictions on those resources yet.

## Secure network access to the ML Workspace

So far we've created two independent resources:

- An ML workspace (**ml-workspace**)
- A VNet (**MLVNet**)

We now have to connect these two so that the workspace network traffic has to go through our VNet. In other words, we want our workspace available **only** to resources that are connected to the **MLVNet** virtual network.

To accomplish that, we need to define a [Private Endpoint](/azure/private-link/private-endpoint-overview) for the _ml-workspace_ resource.

> [!TIP]
> A Private Endpoint is a network interface that uses a private IP Address from your VNet to create secure and private connections to a resource.

## Create a Private Endpoint

1. Go to "Home", select **Resource Groups**, select the **MLResourceGroup** resource group, and then select your **ml_workspace** workspace:

    :::image type="content" source="../media/ml_workspace_home.png" alt-text="Screenshot showing the machine learning workspace page.":::

2. In the left-hand menu, select **Private endpoint connections**:

    :::image type="content" source="../media/pvt1.png" alt-text="Screenshot showing where to select private endpoint connections with a red box.":::

3. Select **Private Endpoint** and fill the form with the following values:

    :::image type="content" source="../media/pvt2.png" alt-text="Screenshot showing how to fill in the private endpoint form.":::

   | Setting              | Value                                                                                                 |
   | -------------------- | ----------------------------------------------------------------------------------------------------- |
   | **Project details**  |                                                                                                       |
   | Subscription         | Select your subscription.                                                                             |
   | Resource group       | Enter <b>MLResourceGroup</b> (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                                                                       |
   | Name                 | Enter **MLPrivateEndpoint**.                                                                          |
   | Region               | Select **(US) East US**.                                                                              |

4. Select the **Next: Resource >** button.

5. In the **Resource** tab, use the values below

    :::image type="content" source="../media/pvt3.png" alt-text="Screenshot showing how to fill in the resources form.":::

   | Setting              | Value                                                   |
   | -------------------- | ------------------------------------------------------- |
   | **Project details**  |                                                         |
   | Subscription         | Select your subscription.                               |
   | Resource type        | Enter <b>Microsoft.MachineLearninService/workspaces</b> |
   | **Instance details** |                                                         |
   | Resource \*          | Select **ml-workspace**.                                |
   | Target subresource  | Select **amlworkspace**.                                |

6. Select the **Next: Configuration >** button.

   Leave the suggested defaults:

    :::image type="content" source="../media/pvt4.png" alt-text="Screenshot showing how to fill in the configuration form.":::

   | Setting                         | Value                     |
   | ------------------------------- | ------------------------- |
   | Virtual Network \*              | **MLVNet**                |
   | Subnet \*                       | **default (10.1.0.0/24)** |
   | Integrate with private DNS zone | **Yes**                   |

7. Select **Review + Create** to validate the deployment, then select **Create** to deploy the endpoint (this can take a few moments):

    :::image type="content" source="../media/pvt_final.png" alt-text="Screenshot showing the deployment complete page.":::

## Testing the network configuration

We can make sure our workspace is inside the VNet now by testing if we still have access to its resources:

1. Reload the Azure Machine Learning Studio window (you can select the following link to see the instructions again [here](#studio)):

    :::image type="content" source="../media/workspace-with-warnings.png" alt-text="Screenshot showing the workspace with warnings on the page.":::

2. As the warning shows, access to those resources is now blocked. That happens because your workspace is now inside the VNet, and it's configured to block all requests that don't originate from within the *default* subnet we created (remember we're trying to access it from the __outside__ of the network perimeter).

### Congratulations!

You've just secured the network access to your ML workspace.

Notice that in the same way you can't access it, neither can other resources in your organization.

Opening things up so that resources can connect requires some strategical planning!

We recommend reading our [how to secure a workspace using a vnet](/azure/machine-learning/how-to-secure-workspace-vnet) guide for more in-depth reference.

## Summary

In this unit you've covered the following topics:

- What a Virtual Network is and some of its uses
- Creating an Azure Virtual Network
- Creating subnets in a Virtual Network
- How to use Private Endpoints to secure network access to you Machine Learning workspaces
- Accessing a workspace using Azure Machine Learning Studio and check if resources are blocked

## More Resources

To read more about Azure networking visit:

- [What is Azure Virtual Network?](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network concepts and best practices](/azure/virtual-network/concepts-and-best-practices)
- [Secure Azure Machine Learning workspace resources using virtual networks (VNets)](/azure/machine-learning/how-to-network-security-overview)
- [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview)