The Create an Azure Sentinel playbook exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

## Task 1: Deploy Azure Sentinel

1. Select the following link:

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FWayPointVenturesOrg%2Ftemplates%2Fmain%2Fsentinel-deploy%2FSentinelTemplate.json)

2. You will be prompted to sign in to your Azure subscription.
3. On the **Custom deployment** page, provide the following information:

|||
| --- | --- |
| **Subscription** | Select your Azure subscription. |
| **Resource Group*** | Select **Create new** and provide a name for the resource group such as **azure-sentinel-rg**.|
| **Locations*** | From the drop-down menu, select the location where you want to deploy the Azure Sentinel. |
| **Workspace name***  | Provide a unique name for the Azure Sentinel workspace such as ***yourname*-sentinel**. |
| **Location** | Accept the default value of **[resourceGroup().location]**. |
| **Simplevm Name** | Accept the default value of **simple-vm**.|
| **Simplevm WIndows OS Version** | Accept the default value of **2016-Datacenter**.|

4. Select the **I agree to the terms and conditions stated above** check box, and then select **Purchase**.

:::image type="content" source="../media/02-Custom-Deployment.PNG" alt-text="Screenshot of the Custom Deployment page." border="true":::

> [!Note]
> Wait for the deployment to complete. The deployment should take less than 5 minutes.

## Task 2: Configure Azure Sentinel Connectors

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar, in the **Configuration** section, select **Data connectors**.
3. In the **Data connectors** pane, search for and select **Azure Activity**. In the details pane, select **Open connector page**.
4. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.
5. Select your subscription, and then select **Connect**.
6. When you receive a status of **Connected**, close all open blades to return to the **Azure Sentinel | Data connector** blade.

:::image type="content" source="../media/02-Azure-Sentinel-Connector.png" alt-text="Screenshot that displays the Azure Sentinel connector." border="true":::

> [!Note]
> The connector for Azure Activity could take 15 minutes until Azure Sentinel displays a date. You can continue performing the rest of the steps and continue with the subsequent units in this module.

## Task 3: Create an analytics rule 

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar, in the **Configuration** section, select **Analytics**.
3. On the **Azure Sentinel | Analytics** page, select **Create** and then select **Scheduled Query Rule**.
4. On the **General** page, provide the inputs in the following table, and then select  **Next:Set rule logic**.

  |||
  | --- | --- |
  | Name | Provide a descriptive name to explain what type of suspicious activity the alert detects. |
  | Description | Enter a detailed description that will help other security analysts understand what the rule does. |
  | Tactics | From the **Tactics** drop-down menu, choose one among the available categories of attacks to classify the rule following the MITRE tactics. |
  | Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
  | Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generate large number of false    positives. |

5. On the **Set rule logic** page, in the **Rule query** section, enter the following query:

```kusto
  AzureActivity
  | where OperationName == 'Delete Virtual Machine'
  | where ActivityStatus == 'Accepted'
  | extend AccountCustomEntity = Caller
  | extend IPCustomEntity = CallerIpAddress
```

6. In the **Query Scheduling** section, you can configure how often the query should run. Select query to run on every 5 min.
7. Accept the default values for all other settings and then select **Next: Incident setting (preview)**.
8. On the **Incident setting (preview)** tab, ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule. And then select **Next: Automated response**.
9.	On the **Automated response** tab, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.
10.	Select **Next:Review**.
11.	On the **Review and Create** page, verify that the validation passed, and then select **Create**.

## Check the resources created

1. In the Azure portal, search for **Resource groups**.
1. Select **azure-sentinel-rg**.
1. Sort the list of resources by **Type**.
1. The resource group should contain the resources shown in the following table.

    | Name  | Type  | Description |
    |---|---|---|
    | ***yourname*-sentinel** | Log Analytics Workspace | Log Analytics workspace used by Azure Sentinel. |
    | **SecurityInsights(*yourname*-sentinel** | Solution | Security insights for Azure Sentinel. |
    | **simple-vm**| Virtual machine | Virtual machine used in the demonstration. |
    | **simple-vmNetworkInterface** | Network interface | Network interface for the VM. |
    | **st1*xxxxx*** | Storage account | Storage account used by the virtual machine. |
    | **vnet1** | Virtual network | Virtual network for the virtual machine. |
