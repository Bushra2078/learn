Here, we'll discuss how Firewall Manager works and what tasks you can accomplish by using it. We'll also determine how firewall policy rules work. As previously described, a policy is the fundamental building block of Firewall Manager. You create policies and associate them with Azure Firewall instances in secured virtual hubs or hub virtual networks.

The following diagram displays a typical configuration. It includes a global administrator who is creating and associating policies at the top level. These policies are associated with both a secured virtual hub and two hub virtual networks. A local admin also can configure and associate policies with one of the hub virtual networks.

:::image type="content" source="../media/policy-overview.png" alt-text="A typical Firewall Manager configuration, with both a global and local admin who are creating and associating properties as previously decribed.":::

Azure Firewall policies consist of rules and settings that control traffic in protected resources. In this unit, you'll learn about:

- Azure Firewall policies, rules, and <!-- ?ID/SME: In Unit 1, we capitalize "Threat Intelligence" but here we have it lowercase. And then in the table below, we've got it all capped -- "Threat Intelligence Settings." Are we talking about the same thing and if so, which should it be? Please fix globally. --> threat intelligence settings.
- Rule processing.
- Tasks you can perform with Firewall Manager.

## What are Azure Firewall policy rules?

The following table describes the Azure Firewall policy rule collections and settings.

| Rule collection or setting   | Description    |
| ---------------------------- | ------------------------------------------------------------ |
| Threat Intelligence Settings | Enables Azure Firewall policy filtering based on threat intelligence. This will alert you to potentially malicious traffic. It also allows you to deny traffic from and to IP addresses and domains that are known to be malicious. |
| NAT rule collection          | Enables you to configure Azure Firewall Destination Network Address Translation (DNAT) rules. These rules translate and filter inbound internet traffic to your Azure subnets. |
| Network rule collection      | Manages non-HTTP/S traffic flowing through the firewall.     |
| Application rule collection  | Manages HTTP/S traffic flowing through the firewall.         |

First you must decide which rules you need to manage your traffic. Then you use Firewall Manager to create and configure Azure Firewall policies containing these rules, as the following graphic depicts.

:::image type="content" source="../media/threat-intelligence.png" alt-text="Screenshot of the Threat Intelligence blade in the Azure portal within a Firewall Policy called ContosoFirewallPolicy.":::

### How rules are processed

In reality, a NAT rule is a routing rule that directs traffic from public to private IP addresses in your Azure resources. When a firewall processes a policy's defined rules, it's the network and application rules that determine whether the traffic is allowed . The following process describes how these rules are processed against traffic:

1. Threat intelligence rules are processed before NAT, network, or application rules. When you establish these rules, you can configure one of two behaviors:

   - Alert when rule is triggered (default mode).
   - Alert and deny when rule is triggered.

2. Network rules are applied next. If a network rule matches the traffic, that rule is applied. No other rules are checked.
3. <!-- ID/SME: Please note, I changed the verbiage for these steps to remove the "If/then" construction. MS style doesn't like "If/then" anymore. --> If no network rules match and the traffic is HTTP/S, application rules are applied.
4. If no application rule matches, traffic is compared with the infrastructure rule collection.
5. If there's still no match for the traffic, the traffic is implicitly denied.

> [!NOTE]
> Infrastructure rule collections define <!-- ID/SME: Please ensure this is spelled out either here or upon it's first appearance in an earlier module. We do indeed have to spell out this one! --> FQDNs that are allowed by default. These FQDNs are specific to Azure.

## Use Firewall Manager

Firewall Manager enables you to:

- Define rules for traffic filtering across multiple Azure Firewall instances in secured virtual hubs and hub virtual networks.
- Associate an Azure Firewall policy with new or existing virtual networks. This enforces consistent firewall policies across multiple hub virtual networks.
- Associate an Azure Firewall policy or a Security Partner Provider with new or existing virtual hubs. This enforces consistent security and routing policies across multiple hubs.

In the following graphic, an administrator is deploying a firewall with a firewall policy for an existing virtual network.

:::image type="content" source="../media/deploy-firewall.png" alt-text="Screenshot of the Virtual networks blade in Firewall Manager. The administrator has selected an existing virtual network.":::
