Azure DNS enables you to host your DNS domains in Azure and access name resolution for your domains by using Microsoft Azure infrastructure. You can configure and manage your custom domains with Azure DNS in the Azure portal. By accessing your domains in Azure, you can use your same credentials, support agreements, and billing preferences as for your other Azure services.

Before you begin using Azure DNS to host DNS records for your domains, there a few important concepts to review.

### Things to know about domain names in Azure

Let's examine the basic characteristics for how Azure assigns and resolves your domain names. Two terms that are frequently discussed when working with domains are the _initial domain name_ and _custom domain names_.

- When you create an Azure subscription, Azure automatically creates an Azure Active Directory (Azure AD) domain for your subscription.

   > [!Note]
   > You must be a global administrator to perform domain management tasks. The global administrator is the user who created the subscription.

- Azure applies an **initial domain name** to your initial domain instance.

   The initial domain name follows the form `<Your Domain Name>` followed by `.onmicrosoft.com`. For example, `yourdomainname.onmicrosoft.com`.

- The purpose of a **custom domain** name is to provide a simplified form of your domain name to support specific users or tasks.

   Organizations commonly implement custom domain names to enable users to access their domain by using credentials they're familiar with. 
   
   Consider an example website for Azure Administrator Incorporated. Azure creates the initial domain name as `azureadminincorg.onmicrosoft.com`. A custom domain name for this site could be `azureadmininc.org`.

   :::image type="content" source="../media/custom-domain-names-8dae9b45.png" alt-text="Screenshot that shows how to create a custom domain name for a directory in the Azure portal." border="false":::
 
- The initial domain name is intended to be used until your custom domain name is verified.

- The initial domain name can't be changed or deleted, but you can add a routable custom domain name that you control.

- In Azure AD, **domain names must be globally unique**. When one Azure AD directory has verified a specific domain name, other Azure AD directories can't use that same domain name.
 
- Before a custom domain name can be used by Azure AD, the custom domain name must be added to your directory and verified.