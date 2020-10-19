
> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you'll deploy an Azure Resource Manager (ARM) template from a sample repository that deploys a virtual network in your sandbox subscription. After the deployment is complete, you'll then deploy a template that is slightly different. It differs in the following ways:

- **Changed address space**. A change of address space in a virtual subnet.
- **Additional subnet**. An additional subnet in the virtual network.

The second deployment will include the what-if operation to review the expected changes.

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools?azure-portal=true). Be sure to install this extension in Visual Studio Code.

## What-if prerequisites

::: zone pivot="powershell"

[!include[](./powershell/3-exercise-whatif-powershell.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azurecli/3-exercise-whatif-azurecli.md)]

::: zone-end
