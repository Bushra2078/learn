Policy is the backbone of Azure implementation and compliance. Compliance is an evolving scenario that you will always need to assess and adjust according to the needs of the moment. You also need to carefully plan your policies so as not to interrupt other units that require a more flexible policy than the one you have defined. Through Azure Policy, you can control the types of resources that can be provisioned. Or, you can restrict the locations where resources can be provisioned. Unlike RBAC, the policy is a standard system of explicit permission and denial.

:::image type="content" source="../media/1-azure-policy.png" alt-text="Screen with the Azure Policy overview example." lightbox="../media/1-azure-policy.png":::

## Example scenario

Due a new cost optimization initiative in your company, you should be able to have a more granular control over the resources deployed in your Azure environment. Also you should avoid deploying resources in regions where the costs are higher.

The cloud administration team brings to you the following definitions:

* For the production subscription, only the regions Central US and East US2 will be used for new deployments
* For the dev/test subscription, only three specific types of virtual machines SKUs will be allowed

This is a use case scenario where you can use the Azure Policy to meet those requirements: 

* Create a new assignment using a built-in policy called **Allowed locations** associated with the production subscription then specify the regions Central US and East US2
* Create another assignment using a built-in policy called **Allowed virtual machine SKUs** associated with the dev/test subscription and select properly with the three SKUs of virtual machines allowed

## What will we be doing?

In this module, we'll be learning about what Azure Policy is, and how you can use it to meet compliance requirements in your environment.

## What is the main goal?

By the end of this session, you'll be able to create policies and initiatives, validate the compliance status of your environment and understand why you should use Azure Policy.
