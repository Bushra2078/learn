In the previous exercise, you deployed Azure Firewall. Now you need to route all network traffic through the firewall and filter the traffic by using firewall rules. When you're done, Azure Firewall will protect outbound network traffic for Azure Virtual Desktop.

## Route all traffic through the firewall

For the subnet used by the session host, configure the outbound default route to go through the firewall. You'll complete the following three steps.

1. Create a route table in the same resource group as your session host VMs and firewall.
1. Associate the route table to the subnet that your session host VMs uses.
1. On the route table, add the route to the firewall.

After you complete those steps, all traffic will route to Azure Firewall.

### Create route table

First, create a route table named "firewall-route".

1. In [Azure portal](https://portal.azure.com?azure-portal=true), search for and select **Route tables**.
1. Select **+ New**.
1. Use the following values.

    |Field |Value |
    |---------|---------|
    |Subscription  |  Your subscription    |
    |Resource group    |   learn-firewall-rg    |
    |Region  |   Select the same location that you used previously.   |
    |Name |   firewall-route   |

1. Select **Review + create** > **Create**.

1. After deployment completes, select **Go to resource**.

### Associate route table to workload's subnet

Now, associate "firewall-route" to the host pool's subnet.

1. On firewall-route, under **Settings**, select **Subnets**.
:::image type="content" source="../media/7-firewall-route-subnet.png" alt-text="Screenshot that shows the subnet option under settings for the firewall route.":::
1. Select **Associate**.
1. Select the following values.

    |Field |Value  |
    |---------|---------|
    |Virtual network    |  hostVNet      |
    |Subnet |  hostSubnet      |

1. Select **OK**.

### Add route to route table

The last step is to add a route to Azure Firewall on the route table. After you complete this step, all network traffic on the host pool virtual network will route through Azure Firewall.

1. Under **Settings**, select **Routes**.

    :::image type="content" source="../media/7-firewall-route-routes.png" alt-text="Screenshot that shows the routes option under settings on the firewall route table.":::
1. Select **Add**.
1. Enter the following values.

    |Field |Value  |
    |---------|---------|
    |Route name    |  fw-rt       |
    |Address prefix |  0.0.0.0/0       |
    |Next hop type   |  Virtual appliance     |
    |Next hop address   |  Paste in the private IP address for the firewall from previous exercise unit.    |

11. Select **OK**.

## Create application rule collection

By default, the firewall denies access to everything. So you need to configure conditions under which traffic is allowed through the firewall.

Create an application rule collection with rules to allow Azure Virtual Desktop access to several Fully Qualified Domain Names (FQDNs).

1. In the Azure portal, search for and select **Firewalls**.
1. Select the **learn-fw** firewall.
1. Under **Settings**, select **Rules (classic)**.
:::image type="content" source="../media/7-firewall-rules-classic.png" alt-text="Screenshot that shows the rules classic option under settings in the firewall.":::
1. Select the **Application rule collection** tab > **Add application rule collection**.
:::image type="content" source="../media/7-firewall-rules-classic-application-rule-collection.png" alt-text="Screenshot that shows the application rule collection tab with the add application rule collection option.":::
1. Enter the following information.

    |Field  |Value  |
    |---------|---------|
    |Name     |     app-coll01    |
    |Priority    |    200     |
    |Action     |  Allow       |
1. Under **Rules**, in the **FQDNs tags** section, enter the following information.
 
    |Field  |Value  |
    |---------|---------|
    |Name     |     allow-virtual-desktop    |
    |Source type    | IP address        |
    |Source     |   Address space for hostVNet like 10.0.0.0/16     |
    |FQDN tags    |  Windows Virtual Desktop       |

1. Under **Rules**, in the **Target FQDNs** section, enter the following information.
 
    |Field  |Value  |
    |---------|---------|
    |Name     |     allow-storage-service-bus-accounts    |
    |Source type    | IP address        |
    |Source     |   Address space for hostVNet like 10.0.0.0/16     |
    |Protocol:Port   |   https     |
    |Target FQDNs   | *xt.blob.core.windows.net, *eh.servicebus.windows.net, *xt.table.core.windows.net   |

1. When you're done, the form looks like the following image.
:::image type="content" source="../media/7-firewall-rules-classic-application-rule-collection-form.png" alt-text="Screenshot that shows the application rule collection form filled out.":::
1. Select **Add**.

## Create network rule collection

Let's say our scenario uses Azure AD DS so you don't need to create a network rule to allow DNS. But you do need to create a rule to allow traffic from your Azure Virtual Desktop VMs to the Windows Activation Service.

1. On **learn-fw** >  **Rules (classic)**, select 
1. 
## Check your work

At this point, you've routed all network traffic for Azure Virtual Desktop through the firewall. Let's make sure the firewall is working as expected.

1. In Cloud Shell, run the following command.

    ```powershell
    "rdgateway", "rdbroker","rdweb"|% `
    {Invoke-RestMethod -Method:Get `
    -Uri https://$_.wvd.microsoft.com/api/health}|ft `
    -Property Health,TimeStamp,ClusterUrl
     ```

1. You should see something like the following results where all three component services are listed as healthy. 

   :::image type="content" source="../media/7-check-firewall-results.png" alt-text="Screenshot of firewall results where all three component services show as healthy.":::

    If one or more components are not healthy, the firewall is not working.