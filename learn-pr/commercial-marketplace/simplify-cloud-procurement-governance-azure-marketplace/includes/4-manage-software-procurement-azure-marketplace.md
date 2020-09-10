When you started your cloud migration, your manager asked you to ensure costs remained within the company’s budget. This is a challenge because your IT employees are spread across multiple lines of business, each of which needs autonomy to buy the solutions they need to get their part of the job done. You need a centralized and scalable way to manage spending for each group without having to micro-manage their budgets.

Azure and Azure Marketplace have several tools available to help you get a better understanding of cloud spend and how to effectively manage costs.

## Manage Azure Marketplace purchases

Microsoft gives you the ability to manage purchases by your users through your billing profile as the Azure subscription administrator. You can choose three options to manage software acquisitions by users from Azure Marketplace:

- **Free + Paid**: lets users acquire all Azure Marketplace software applications

- **Free**: users will only be able to deploy free software from Azure Marketplace

- **No**: users won’t be able to deploy software from Azure Marketplace

![Screenshot of Azure Marketplace on/off/free toggle in the Azure Portal](../media/15-onoff-big.png)

These settings apply to all users with access to your Azure subscription, which gives you the capability to control software procurement through the Azure portal.

## Manage procurement using Azure policy

Your organization might have policies that place guidelines on purchasing Azure services such as virtual machines. For example, you might need to ensure that virtual machines deployed in your subscription meet certain kinds of criteria, including:

- **Vendor specific**: only letting virtual machines from certain software vendors be deployed on the subscription

- **Operating system**: only letting either Windows or Linux resources be deployed on the subscription

- **Version**: only allowing specific versions of resources be deployed on the subscription

- **Size**: only letting users deploy virtual machines up to a certain size on the subscription

- **Location**: only letting resources be deployed from specific global regions

You can use Azure policy to [manage virtual machine deployment](https://docs.microsoft.com/azure/virtual-machines/windows/policy#images-for-virtual-machines) so only approved virtual machine images from the Azure Marketplace are deployed
into your Azure environment.

## Cost management

As you purchase products from Azure Marketplace, you want to get insights that will help you manage costs. Azure Cost Management is a free tool that you can use can be used to view information on the products you've purchased. You can use Cost Management to see details of what services you're spending money on over time and how those costs track against the budgets that you’ve set. In addition to setting budgets on your subscription, you can schedule reports and analyze subscription costs. You can learn more about Azure Cost Management by completing the Microsoft Learn module on [Analyze costs and create budgets with Azure Cost Management.](https://docs.microsoft.com/learn/modules/analyze-costs-create-budgets-azure-cost-management/)

You can view your Azure Marketplace charges and invoices on the cost analysis tool under Azure Cost Management.

![Screenshot of Azure Cost Management with Azure Marketplace invoice from the Azure Portal](../media/16-cost-management-big.png)

## Private Azure Marketplace

Managing procurement in any organization, regardless of size, can be complex. For example, your organization might have rules in place that restrict purchasing to only approved vendors. To adhere to these policies, you need a simple, scalable way to govern what your users can purchase and which vendors they can purchase from.

Private Azure Marketplace makes it easier for IT administrators to empower users while controlling costs and ensuring purchasing complies with your organizations’ governance and procurement policies.

### Create a Private Azure Marketplace

With Private Azure Marketplace, you can create a catalog of products from approved software vendors that can be purchased by users in your tenant. As a Marketplace Admin (assigned role), you can create a Private Azure Marketplace in the Azure Portal.

Click on the Private Marketplace link in Azure Marketplace inside the Azure Portal to begin the configuration process. The Private Azure Marketplace admin must be assigned the Marketplace Admin role by the tenant global admin.

![Screenshot of the Private Azure Marketplace homepage in the Azure Portal](../media/22-azure-private-marketplace-home.png)

To add approved products to the Private Azure Marketplace, browse the product catalog by using the product filters at the top or use the search field to find the product you want to add to your approved catalog. To add a product, simply check the box on the top right corner of the product tile. When finished, click ‘done’.

![Screenshot of the Private Azure Marketplace product selection in the Azure Portal](../media/17-private-marketplace-build.png)

### Managing purchases for specific product plans

Products in Azure Marketplace might contain multiple plans. Each plan can have specific technical and pricing characteristics to meet different customer requirements.

You can use Azure Private Marketplace to manage what plans under each product can be purchased by users. This might be useful to align purchases to your organization’s budget, allowing only plans within a specific price range to be acquired by users.

As you add products to your catalog, you can select the allowed plans under each product:

- **Select all current and future plans:** allow users to purchase existing plans and give them the option to purchase new plans if the software provider adds them to that product.

- **Select all current plans:** restrict purchases to plans that the software vendor has currently made available for that product. If the software vendor makes new plans available, users will not be able to purchase them.

- **Select specific plans:** choose the specific plan or subset of plans you want users to purchase.

![Detailed screenshot of Azure Private Marketplace selection process in the Azure portal](../media/18-private-marketplace-build.png)

### Purchasing allowed products

When accessing your Private Azure Marketplace, users will be alerted that a Private Azure Marketplace has been enabled by their Marketplace Admin (assigned role). This will ensure purchases by users in your organization align to your company’s procurement and governance guidelines.

Once you have selected the set of products from your company’s approved software vendors, all users browsing in the Private Marketplace experience will see whether a product is allowed for purchase by identifying the product through the ‘allowed’ badge on the product tile card. Microsoft products will always be allowed for purchase.

![Screenshot of allowed products and services in the Azure Marketplace experience in the Azure Portal](../media/19-private-marketplace-allowed-big.png)

The administrator of your Private Azure Marketplace will have the flexibility to select the products and associated plans that users can purchase. When a user tries to purchase an allowed product they'll see the plans the administrator has made available when viewing the plans and pricing for the product.

![Screenshot of allowed product plans on the plans and pricing page of a product in the Azure Marketplace experience in the Azure Portal](../media/20-not-allowed.png)

Users won't be able to purchase a plan that has not been allowed by their Private Azure Marketplace administrator.

## Summary

With your newfound knowledge about the ways Azure Marketplace can help your organization manage software procurement, you're almost ready to finish your research and summarize what you learned for your manager. You're able to demonstrate how Azure features like role-based access control (RBAC) and Policy, as well as Private Azure Marketplace can be used to control software purchasing for your organization. You've already started thinking about ways that you can use these features to adhere to company policies.

You're confident that Azure Marketplace is what you need to manage the complexities of finding, trying, and buying cloud software and services--you just need to convince your boss so you can move forward.
