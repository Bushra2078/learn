Most Azure resources are deployed into resource groups. Virtual machines, SQL servers and databases, storage accounts, virtual networks, and the majority of other resource types need to be placed in a resource group. However, there are a few resources that can, or must, be deployed in a different way. Typically these resources are used to control the behavior of Azure itself. In this unit, you'll review the hierarchy of Azure resource organization, and look at how certain resources might be deployed at different scopes.

## Azure's resource hierarchy

Azure has a hierarchical resource structure with multiple levels of management.

:::image type="content" source="../media/2-hierarchy.png" alt-text="Diagram that shows an Azure tenant, three management groups, three subscriptions, and four resource groups." border="false":::

:::image type="icon" source="../media/callout-01.png"::: Your **tenant** corresponds to your Azure Active Directory instance. Typically an organization only has one Azure AD instance. This acts as the root of the resource hierarchy.
:::image type="icon" source="../media/callout-02.png"::: **Management groups** provide a way to organize your Azure subscriptions. Every tenant has a single root management group, and then you can establish your own hierarchy of management groups. You might create different management groups for different parts of your organization, or for subscriptions that need to have different types of management. You can apply Azure Policies and access control restrictions to management groups, and these are inherited by all subscriptions within that management group's hierarchy.
:::image type="icon" source="../media/callout-03.png"::: **Subscriptions** act as a billing account, and contain resource groups and resources.
:::image type="icon" source="../media/callout-04.png"::: **Resource groups** logically group resources together, and let you manage and control them as a single unit.

By understanding these levels of the hierarchy, you can start to apply flexible controls on how your Azure environment is used and managed. Bicep enables you to manage these controls with all the benefits of infrastructure as code. Let's look at some examples where you might deploy resources to each of these levels.

> [!NOTE]
> *Extension resources* are resources that are deployed to the scope of another Azure resource. For example, a resource lock is deployed onto a resource like a storage account. There is a learning module that discusses extension resources.

<!-- TODO can we link to the module? Check with Tom -->

You're already familiar with deploying resources into resource groups, so let's look at the other scopes for deployment.

## Subscription-scoped resources

You might deploy to a subscription for these kinds of use cases:

- You need to create a new resource group. A resource group is just a subscription-scoped resource itself.
- You're using Azure Policy, and you want to define or apply a policy to all resources within the subscription. For example, your toy company's R&D department has asked you to deploy a policy that will restrict the list of virtual machine SKUs that can be created.
- You need to grant access to all of the resources within a subscription. For example, if your HR department has an Azure subscription that contains all of their Azure resources, you might create role assignments to allow everybody in your HR department to read the contents of the subscription.

## Management group-scoped resources

You might deploy to a management group for these kinds of use cases:

- You need to grant access to all of the resources within any subscriptions that are within the management group hierarchy. For example, your cloud operations team might need to have access to every subscription in your organization. You can create a role assignment at your root management group, which grants your cloud operations team access to everything in your environment.

  > [!CAUTION]
  > Be extremely careful when you grant access to resources using management groups, and especially the root management group. Remember that every resource underneath the management group in the hierarchy will inherit the role assignment. Make sure your organization follows best practices regarding identity management and authentication, and don't grant access that isn't required.

- You need to apply policies across your entire organization. For example, your organization might have a policy that resources cannot be created in certain geographic regions, under any circumstances. You might apply a policy to your root management group that will block creation of resources in that region.

> [!NOTE]
> Before you use management groups for the first time, [you need to set them up for your Azure environment](/azure/governance/management-groups/overview#initial-setup-of-management-groups).

## Tenant-scoped resources

You might deploy to your tenant for these kinds of use cases:

- You need to create Azure subscriptions. Even though subscriptions might be put into management groups, the creation of a subscription requires a tenant-scoped deployment.

  > [!NOTE]
  > Not all Azure customers can create subscriptions using infrastructure as code. [Depending on your billing relationship with Microsoft, this might not be possible.](/azure/cost-management-billing/manage/programmatically-create-subscription)

- You're creating management groups. A single root management group is created by Azure when you enable management groups for your tenant, but you can create multiple levels of management groups underneath it. You can use Bicep to define your whole management group hierarchy. You can also assign subscriptions to management groups.

Tenant-scoped deployments [require you have special permission](/azure/azure-resource-manager/templates/deploy-to-tenant#required-access).

> [!TIP]
> You can't create policies or role assignments at the tenant scope. However, if you need to grant access or apply policies across your whole organization, you can deploy these resources to the root management group.

## Resource IDs

Subscription-scoped resources have IDs that look quite familiar. For example. here's a resource ID that represents a resource group, which is a subscription-scope resource:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment
```

Here's a visual representation of the same information:

:::image type="content" source="../media/2-subscription-resource-id.png" alt-text="Resource ID for a resource group." border="false":::

When you're working with resources at a management group or tenant scope, resource IDs can look a bit different to normal. They mostly follow the standard pattern of interleaving the resource type with the information about your specific resources. However, the specific format depends on the resource you're working with. Here are some examples:

| Resource type | Deployed at scope | Example resource ID |
|-|-|-|
| Role definition | Management group | `Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca` |
| Role definition | Subscription | `/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/providers/Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca` |
| Subscription | Tenant | `/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c` |
| Management group | Tenant | `/providers/Microsoft.Management/managementGroups/ProductionMG` |

In the next unit, you'll learn how to create Bicep files that target each of these scopes.
