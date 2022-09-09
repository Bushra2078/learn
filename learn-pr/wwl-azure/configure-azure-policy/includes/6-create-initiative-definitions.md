After you determine your policy definitions, the next step is to create an initiative definition for your policies. An initiative definition has one or more policy definitions. One example for using initiative definitions is to ensure your resources are compliant with security regulations.

> [!Tip]
> Even if you have only a few policy definitions in your organization, we recommend creating and applying an initiative definition.

## Create an initiative definition

When you create an initiative definition, be sure the definition uses the specific JSON format required by Azure. For more information, see [Azure Policy definition structure](/azure/governance/policy/concepts/initiative-definition-structure).

Here's an example of how to create a new initiative definition in the Azure portal:

:::image type="content" source="../media/create-initiative-definition-e1198a51.png" alt-text="Screenshot that shows how to create a new initiative definition.":::

## Use built-in initiative definitions

You can create your own initiative definitions, or use built-in definitions in Azure Policy. You can sort the [list of built-in initiatives](/azure/governance/policy/samples/built-in-initiatives) by category to search for definitions for your organization.

Here are some examples of built-in initiative definitions:

- **Audit machines with insecure password security settings**: Use this initiative to deploy an audit policy to specified resources in your organization. The definition evaluates the resources to check for insecure password security settings. This initiative is located under the Guest Configuration category.

- **Configure Windows machines to run Azure Monitor Agent and associate them to a Data Collection Rule**: Use this initiative to monitor and secure your Windows VMs, virtual machine scale sets, and Arc machines. The definition deploys the Azure Monitor Agent extension and associates the resources with a specified Data Collection Rule. This initiative is located under the Monitoring category.

- **ISO 27001:2013**: Use this initiative to apply policies for a subset of ISO 27001:2013 controls. This initiative is located under the Regulatory Compliance category.