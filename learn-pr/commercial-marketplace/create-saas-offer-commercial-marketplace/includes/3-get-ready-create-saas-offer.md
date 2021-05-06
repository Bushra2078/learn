Deciding whether you want to sell your SaaS offer through Microsoft is the most important decision you’ll need to make before publishing to the commercial marketplace. This decision will play a big role in determining the amount of time and resources you and your team will need to invest in your company's presence in the commercial marketplace.

## SaaS offer considerations for all publishing options

Regardless of whether you sell through Microsoft, you’ll need to provide the following basic information to publish your offer:

- Customer Relationship Management (CRM) connection to receive [customer leads](https://docs.microsoft.com/azure/marketplace/partner-center-portal/commercial-marketplace-get-customer-leads).

- Offer categories & industries that describe your application and help customers find your product in the marketplace.

- Legal terms and conditions that dictate the terms of use for your application.

- Details and descriptions of your offer and the value it provides for customers.

> [!TIP]
> To help you provide the information listed above, we’ve created a separate learning module that shares information and best practices that will help you make the most of your company’s presence in the Microsoft commercial marketplace. To learn more, you can complete **["Go to market through the Microsoft commercial marketplace."](https://aka.ms/GTMlearnmarketplace)**

We’ll spend the rest of our time in this unit discussing considerations for publishers that sell their SaaS offers through Microsoft.

## Providing information to sell through Microsoft

Selling through Microsoft makes it possible for customers to acquire your solution directly from Azure Marketplace or Microsoft AppSource, without having to get in touch with anyone at your organization. This means you’ll need to provide all the information customers need to make a purchasing decision.
Let’s spend some time reviewing concepts that will help you decide how you want to package your SaaS offer for commercial marketplace customers.

### SaaS offer plans and pricing

SaaS offers that are sold through Microsoft must have at least one plan. You can create a variety of different plans with different pricing and availability for the same offer to give your customers choices to purchase your application. Plans can differ in price, billing terms, and levels of functionality. For more detailed information on offer plans and available SaaS pricing models, you can check out our [documentation on planning a SaaS offer](https://docs.microsoft.com/azure/marketplace/plan-saas-offer).

:::image type="content" source="../media/4-plans-pricing-setup.png" alt-text="Screenshot of the pricing and availability configuration page in Partner Center.":::

#### SaaS offer pricing

When you publish a SaaS offer that's sold through Microsoft, you’ll need to give us pricing details for each of your offer's plans. With SaaS, customers are never billed directly for Azure infrastructure costs associated with their use of the application because the application runs on your cloud infrastructure. That means cloud infrastructure costs are billed to you. Because of this, your SaaS offer’s price to customers should include software licensing fees, associated infrastructure costs, and related support. You can use different SaaS pricing models, billing terms, and the marketplace metering service to tell us how you want to charge your customers.

#### Selecting a pricing model

When you create your SaaS offer in Partner Center, you’ll be able to choose between the following pricing models:

- **Flat rate**: Customers are charged a certain amount to use your software across their entire organization

- **Per user**: Customers are charged a certain amount for each unique user that has access to log in and use your solution

#### Selecting billing terms

After choosing a pricing model, you’ll also be able to choose the billing term, which dictates the duration of customer subscription periods. You’ll be able to select monthly or annual billing terms and set the associated price per period.

#### Using marketplace metering service dimensions for consumption-based pricing

When you choose the flat rate pricing model, you can also use the marketplace metering service to add a consumption-based pricing component to your offer. Consumption-based pricing allows you to define a unit of customer usage, measure customer usages using the metering service, and bill customers for their level of usage.

:::image type="content" source="../media/6-metering-service-dimensions.png" alt-text="Screenshot of the metering service configuration details in Partner Center.":::

Let’s look at an example to help illustrate this concept:

> Let’s say you sell a SaaS application that helps customers send and share files that are too big to be sent via email. You chose a flat rate pricing model that includes 20 TB of file transfers per year for your customers. In addition to the flat monthly rate you charge customers to use your software, you also want to charge them for any data transfers that exceed the 20 TB included in the annual subscription. You can use the marketplace metering service to charge customers per additional GB of data transferred using your application each month.

> [!TIP]
> You can also use the marketplace metering service to create a fully consumption-based pricing model for your SaaS offer. To do this, set the flat rate price to $0 and use the metering service to dictate an associated price per unit of measure.

For more detailed information about using the marketplace metering service, check out our [documentation on metered billing for SaaS](https://docs.microsoft.com/azure/marketplace/partner-center-portal/saas-metered-billing).

#### Enabling SaaS offer free trials

When you sell through Microsoft, you can also choose to allow a one-month free trial for customers. If you choose this option, Microsoft will automatically forego billing for the first month of a customer’s subscription. At the end of the 1-month trial period, Microsoft automatically converts the customer to a paid subscription.

Adding a free trial to your transact offer is as easy as checking a box when configuring your offer in Partner Center. The option appears on the pricing and availability page of the process, and free trials can be added for each offer plan.

> [!Note]
> This free trial period for a transact offer is different from a free trial listing, which redirects customers to your website to activate a trial. With free trials for transact offers, customers subscribe through Microsoft and they're automatically converted to a paid subscription at the end of the trial period.

#### Selecting plan visibility

When you set up your SaaS offer plans in Partner Center, you’ll be able to dictate whether each plan is public or private. Public plans are made available to all customers, while private plans will only be made available to specific customers that you choose. Private plans can be used to negotiate custom terms and pricing with specific customers.

:::image type="content" source="../media/5-plan-visibility.png" alt-text="Screenshot of plan visibility configuration for private plans in Partner Center.":::

> [!NOTE]
> To publish a private plan, you’ll need to know the Azure tenant IDs of the customer that wants to use your software. Private plans are only possible for SaaS offers sold through Azure Marketplace.

For more information on private offers, reference our [documentation on private offers in the commercial marketplace](https://docs.microsoft.com/azure/marketplace/private-offers).
