By default, storage accounts accept connections from clients on any network. To limit access to selected networks, you must first change the default action. You can restrict access to specific IP addresses, ranges, or virtual networks.

> [!IMPORTANT]
> Changing network rules can affect your application's ability to connect to Azure Storage. If you set the default network rule to *deny*, you'll block all access to the data unless specific network rules *grant* access. Before you change the default rule to deny access, be sure to use network rules to grant access to any allowed networks.

## Manage default network access rules

You can manage default network access rules for storage accounts through the Azure portal, PowerShell, or the Azure CLI.

Follow these steps to change default network access in the Azure portal.

1. Go to the storage account you want to secure.

1. Select **Networking** in the left-hand pane.

1. To restrict access to only selected networks and IPs, select **Enabled from selected virtual networks and IP addresses**. To enable public network access for all networks, including the internet, select **Enabled from all networks**.

1. To apply your changes, select **Save**.

:::image type="content" source="../media/5-firewall.png" alt-text="Screenshot showing the firewall options for storage accounts.":::