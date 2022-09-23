Azure enables you to take action on the metrics you're capturing. You can create alerts that email you, or start automations with runbooks.

Now, you'll create an alert based on your web server's CPU usage. If the CPU usage goes above the set threshold of 90 percent for five minutes, you get an email.

In this unit, you'll add an alert for your virtual machine (VM). Next, you'll cause the VM CPU usage to spike, and receive the alert email.

## Create an alert based on CPU usage

If CPU usage goes above 90 percent for one minute, you'd like to get a notification.

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and sign in with the account that you used to enable the sandbox.

1. On the Azure portal menu, or from the **Home** page, select **Virtual machines**.

1. Select the **monitored-linux-vm** virtual machine that you created. The **monitored-linux-vm** virtual machine pane appears.

1. On the left menu pane, scroll down to **Monitoring**, and select **Alerts**. The **Alerts** pane appears for the **monitored-linux-vm** virtual machine.

1. On the top menu, select **Create** > **Alert rule**.

    :::image type="content" source="../media/8-metrics-new-alert-rule-button.png" alt-text="Screenshot that shows the menu selections for opening the Alerts pane and creating an Alert Rule for a virtual machine.":::

The **Create an alert rule** pane appears with the **Select a signal** pane open on the right.

### Select the resource

When you open the **Alerts** pane from the menu of your virtual machine, the resource for your alert rule is automatically set to that virtual machine.

To verify, select the **Scope** tab on the **Create an alert rule** pane, and confirm that **monitored-linux-vm** is listed under **Resource**.

:::image type="content" source="../media/8-alert-scope-vm.png" alt-text="Screenshot that shows the VM selected on the pane for selecting a resource.":::

To set a different resource, you would choose **Select scope** and make the setting in the **Select a resource** pane.

:::image type="content" source="../media/8-alert-select-a-resource-vm.png" alt-text="Screenshot that shows the Select a resource pane.":::

### Create the condition

1. On the **Create an alert rule** pane, open the **Condition** tab, the **Select a signal** pane opens on the right.
  
1. In the **Search by signal name** search box, search for and select **Percentage CPU**.

    :::image type="content" source="../media/8-configure-signal-logic-percentage-cpu.png" alt-text="Screenshot that shows 'Percentage CPU' selected as the signal name.":::

    The **Create an alert rule** pane reappears.

1. Under **Alert logic**, confirm or enter the following values.

   | Setting | Value  |
   |---------|---------|
   | Threshold |   Static     |
   | Aggregation type   |  Average       |
   | Operator |    Greater than or equal to     |
   | Threshold value   |    90     |

    :::image type="content" source="../media/8-alert-logic.png" alt-text="Screenshot that shows the section for alert logic filled out.":::

### Add an action

1. On the **Create an alert rule** pane, open the **Actions** tab and select **Create action group**. The **Create an action group** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  |Value  |
    |---|---|
    | **Project details** |
    | Subscription  | Concierge Subscription |
    | Resource group  | <rgn>[sandbox resource group name]</rgn> |
    | Region  | Global |
    | **Instance details** |
    | Action group name | *Email alerts* |

    :::image type="content" source="../media/8-create-action-group-basics.png" alt-text="Screenshot that shows the 'Add action group' pane filled out.":::

1. Select **Next: Notifications**, and enter the following values for each setting.

    | Setting  |Value  |
    |---|---|
    | **Notifications** |
    | Notification type      | Email/SMS/Push/Voice |
    | Name     | *High CPU usage*       |

    The **Email/SMS message/Push/Voice** pane appears.

1. Tick the **Email** checkbox, and enter your email address to receive the alert notification. If this pane doesn't appear, select **Edit** for the notification type.
  
    :::image type="content" source="../media/8-create-action-group-notifications-email.png" alt-text="Screenshot that shows the 'Email/SMS/Push/Voice' pane.":::

1. On the **Email/SMS message/Push/Voice** pane, select **OK**.

1. On the **Create an action group** pane, select **Review + create**, and then select **Create**. You should see a notification that your action group was successfully created.

### Enter alert rule details

1. On the **Create an alert rule** pane, select the **Details** tab and enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | Alert rule name | *Web server CPU running hot*    |
    | Alert rule description | *Email alert notifies when the CPU is over 90%* |

    :::image type="content" source="../media/8-alert-rule-details.png" alt-text="Screenshot that shows the fields for alert details.":::

1. Select **Review + create**, and then select **Create**. You should see a notification that your Alert rule was successfully created.

## Trigger the alert

1. In the left menu pane, go to the **Overview** pane for the **monitored-linux-vm** virtual machine.

1. In the upper menu bar, select **Connect**, and then select **SSH**. The **Connect** pane for your VM appears.

    :::image type="content" source="../media/8-vm-overview-connect-button.png" alt-text="Screenshot that shows the 'Connect' button on the VM overview pane.":::

1. Under step 4 on the **Connect** page, copy the **azureuser**@ and IP address that follows.

1. In Azure Cloud Shell to the right, enter *SSH*, and paste what you copied in the previous step. It should look like the following command.

    ```bash
    ssh azureuser@<ipaddress>
    ```

    If Cloud Shell times out, select **Reconnect**.

1. When you're prompted, enter *yes* to connect to the VM.

1. Run the following command to update the list of available updates.

    ```bash
    sudo apt-get update
    ```

1. Run the following command to install the stress tool on the VM.

    ```bash
    sudo apt-get install stress
    ```

1. Run the following command to stress the VM's CPU.

    ```bash
    sudo stress --cpu 16 -v -t 10m
    ```

1. Return to the Azure portal and in the upper left corner, select the **&#9776;** icon, and then select **Dashboard**. The **KPI Dashboard** appears.

1. On the **Max cpu/usage_active for monitored-linux-vm** graph, select the ellipses (**...**) on the upper right, and then select **Refresh**.

1. After a few minutes, the CPU should approach 100 percent, and you'll receive an alert email.

    :::image type="content" source="../media/8-alert-email.png" alt-text="Screenshot of the alert email.":::
