Bicep conditions and loops enable you to make your Bicep code more flexible. Conditions enable you to deploy resources only when specific conditions are met. Loops enable you to deploy multiple resources that all have similar properties.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company is designing a new smart teddy bear toy. Some of the teddy bear's features are based on backend server components and SQL databases hosted in Azure. For security reasons, within your production environments, you need to make sure that you ave enabled auditing on your Azure SQL servers.

You expect the toy will be very popular, and your company plans to launch into new countries regularly. Every country you launch the smart teddy bear into will need to have a separate database server. These servers need to be physically located in specific places to follow the laws of each country. You've been asked to deploy each country's database servers while making it easy to add new servers as the toy is launched into new countries.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating a resource group containing multiple instances of SQL Server in different countries." border="false":::

## What will we be doing?

In this module, you'll extend Bicep template with conditions and loops. You'll:

- Use **conditions** to deploy Azure resources only when they're required.
- Use **loops** to deploy multiple instances of Azure resources.
- Learn how you can control loop parallelism.
- Learn about how to create nested loops.
- Use loops with variables and outputs.

## What is the main goal?

By the end of this module you'll be able to create advanced Bicep templates by using conditions and loops. You'll be able to write Bicep code that configures how loops are executed, and you'll be able to create variable loops and output loops to make your templates even more flexible, and to control how your Azure resources are deployed.
