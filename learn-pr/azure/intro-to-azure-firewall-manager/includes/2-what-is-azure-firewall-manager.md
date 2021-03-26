Let's start with a definition and overview about core features of Firewall Manager. This should help you decide when to use Firewall Manager and whether it's a good fit for your organizational requirements.

## What is centralized firewall management?

Centralized firewall management means managing multiple firewalls simultaneously. It can be challenging to maintain multiple firewalls individually. As your security needs change, you might need to reconfigure all your firewalls to ensure their settings are in sync. Similarly, if your security needs expand, you might need to update all of your firewalls. Using Firewall Manager simplifies  firewall management.

## Firewall Manager definition

Azure Firewall is a cloud-based network security service that's fully managed. By implementing Azure Firewall, you can help protect your Azure resources.

Your security team must configure and maintain network and application-level rules for traffic filtering. If your organization has multiple Azure Firewall instances, you'll benefit from centralizing these configurations. Firewall Manager enables you to:

- Span multiple Azure subscriptions.
- Span different Azure regions.
- Implement hub and spoke architectures to provide for traffic governance and protection.

### Firewall policy

Firewall policy is the fundamental building block of Firewall Manager. A firewall policy can consist of:

- NAT settings.
- Network rule collections.
- Application rule collections.
- Threat Intelligence settings. <!-- ID/SME: Elsewhere, we have "Threat Intelligence" lowercase, including in the graphic in introduction.md. We need to be consistent. Please fix globally. -->

You apply firewall policies to firewalls. After you create policies, you can associate them with one or more virtual networks or virtual hubs.

> [!TIP]
> You can create and manage Azure Firewall policies by using the Azure Portal, REST API, templates, Azure PowerShell, and <!-- ID/SME: I added "Azure" in front of CLI for clarity. Can you confirm that's OK? -->Azure CLI.

## How to centrally manage your firewalls

To centrally manage your firewalls, implement Firewall Manager. It provides the following features:

- <!-- ID/SME: Again, why are we bolding these? Please fix globally in all files. I won't comment on this again, so you don't have to keep clearing the same comment. --> **Centralized deployment and configuration**. This allows you to configure multiple Azure Firewall instances. These multiple instances potentially can span Azure subscriptions and regions.
- **Centralized route management**. This bypasses the requirement to manually create user-defined routes on spoke virtual networks.

   > [!IMPORTANT]
   > Centralized route management is only available on secured virtual hub architecture.

- **Hierarchical policies**. These enable central management of Azure Firewall policies across multiple secured virtual hubs. Your IT security team then can create global firewall policies and apply them across your organization.

   > [!IMPORTANT]
   > Hierarchical policies are only available on secured virtual hub architecture.

- **Third-party integration**. This supports integration of third-party security as a service provider.  

- **Cross-region availability**. This allows you to create Azure Firewall policies in one region and apply them in other regions.

You can implement Firewall Manager in one of two architectures, which the following table describes.

| Architecture type   | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| Hub virtual network | A standard Azure virtual network that you create and manage. When you associate firewall policies with this type of hub, you're creating a *hub virtual network*. This architecture's underlying resource is a virtual network. |
| Secured virtual hub | A Microsoft-managed resource that enables you to easily create hub and spoke architectures. When you associate policies, you're using a *secured virtual hub*. The underlying resource is a virtual WAN hub. |

The following diagram depicts each of these architecture types. A global admin has overarching policy control over an organization's security policies. A local admin has some control over policies associated with a hub virtual network.

:::image type="content" source="../media/firewall-manager-architecture.png" alt-text="Architecture of Firewall Manager depicting two scenarios: secured virtual hub and hub virtual network.":::
