## Virtual machine offers in the commercial marketplace

When you publish your virtual machine (VM) based application to the Microsoft commercial marketplace, it’s called a VM offer. Customers will be able to find your Windows or Linux application in Azure Marketplace—both the online store at https://azuremarketplace.microsoft.com and the marketplace experience in the Azure portal. From Azure Marketplace, customers can purchase your VM offer and deploy it to their Azure subscription in a matter of minutes.

:::image type="content" source="../media/1-vm-azure-marketplace.png" alt-text="Screenshot of the customer Azure Marketplace online store. Apps are filtered to show virtual machine images.":::

### Publishing options for your VM offer

Before you publish your VM offer, you’ll need to decide how you want to use Azure Marketplace to engage with customers and sell your application. When you create your VM offer in Partner Center, you'll be asked to choose a software license model. Your choice has significant implications for you and your customers' marketplace experience, which we'll explain throughout the rest of this unit.

:::image type="content" source="../media/3-vm-licensing-partner-center.png" alt-text="Screenshot of the license model options in Partner Center. This screen appears in the 'pricing and availability' step of the publishing process.":::

You have two software licensing options:

- **Bring your own license (BYOL)**: Customers use an existing subscription to your software to deploy your application to their Azure subscription. When you choose the BYOL model, customers have to purchase a subscription to your software outside of Azure Marketplace. They'll enter a valid subscription key when they configure the VM for deployment in the Azure portal. You’ll be responsible for validating customer subscriptions, facilitating payments, managing active subscriptions, and invoicing  over the life of the subscription.

- **Usage-based monthly billed plan**: Also known as the pay-as-you-go (PAYG) license model, customers purchase a license to your software through Microsoft. When you choose pay-as-you-go, Microsoft processes payments from customers on your behalf. Customers pay using the same payment method that they use to pay for their Azure subscriptions.

>[!NOTE]
>When you choose the usage-based license model, you’ll also have the option to enable free trials for Azure Marketplace customers so they can evaluate your application. You'll get to choose between one, three, or 6-month trial periods when you configure your offer's pricing and availability in Partner Center.

As we mentioned at the beginning of this unit, deciding between the BYOL and usage-based license models is an important decision. It has a significant impact on the following:

- **Customer experience**: Selling your software through Microsoft using the usage-based license model provides the most streamlined purchasing experience for your customers. They don’t have to leave Azure Marketplace to buy a license from you—they just configure the VM and deploy your offer from the Azure portal to start using your application. Customers manage their subscriptions from the Azure portal and receive a consolidated invoice that includes all their purchases from Azure Marketplace. Customers pay for your software using the same payment method they use for Azure, which makes it easier for them to work through their procurement process.

- **Additional benefits for publishers**: When you license your software through Microsoft, you’re eligible for other commercial marketplace benefits for publishers, including the following:

  - Cost savings and operational efficiencies as Microsoft takes on billing, collections, currency conversions, and taxation for purchases from the commercial marketplace.
  
  - More valuable [Marketplace Rewards](/azure/marketplace/gtm-your-marketplace-benefits) program benefits when your offer reaches revenue milestones through marketplace.
  
  - The ability to take advantage of customers’ [Azure consumption commitment benefit](/azure/marketplace/azure-consumption-commitment-benefit). This benefit lets customers purchase qualified offers from the commercial marketplace and get credit against their Microsoft Azure Consumption Commitment (MACC). This streamlines purchasing and budgeting for customers with existing enterprise agreements (EA) or Microsoft Customer Agreements (MCA).

## Summary

Now that you understand where customers can find your VM offer and the different ways that you can license it through Microsoft, we’ll turn our attention to some of the other business considerations you should take before you publish. We’ll discuss some important VM offer concepts that will help you determine how you want to use Azure Marketplace to sell your application.
