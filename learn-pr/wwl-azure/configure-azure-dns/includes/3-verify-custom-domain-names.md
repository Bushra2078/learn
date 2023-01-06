When an administrator adds a custom domain name to an Azure Active Directory instance, the custom domain name is initially in an _unverified_ state. Azure AD won't allow any directory resources to use a custom domain name that's unverified.

Before you can use a custom domain name for your Azure AD instance, your custom domain name must be _verified_.

### How custom domain names are verified

After you add a custom domain name for your Azure AD instance in the Azure portal, you must verify ownership of your custom domain name.

You initiate the verification process by adding a DNS record for your custom domain name. The DNS record type can be `MX` or `TXT`, as shown in the following image:

:::image type="content" source="../media/verify-custom-domain-2a02fdb3.png" alt-text="Screenshot that shows how to add a DNS record in the Azure portal to enable verification of a new custom domain name.":::

After you add a DNS record to your custom domain name, Azure queries the DNS domain for the presence of the DNS record.

> [!Note]
> The Azure verification process can take several minutes or hours.

After Azure verifies the presence of the DNS record for your custom domain name, Azure adds your new custom domain name to your subscription for the Azure AD instance.