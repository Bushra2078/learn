In this unit, you'll learn how to create your Azure Service Bus Premium namespace.

## Introduction to Azure Service Bus

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics. Service Bus is used to decouple applications and services from each other, and it provides the following benefits:

* Load balances work across competing workers
* Safely routs and transfers data and controls across service and application boundaries
* Coordinates transactional work that requires a high degree of reliability

## Messaging scenarios

Some common messaging scenarios are:

* **Messaging**: Transfer business data, such as sales or purchase orders, journals, or inventory movements.
* **Decouple applications**: Improve reliability and scalability of applications and services. Producer and consumer don't have to be online or readily available at the same time. The load is leveled such that traffic spikes don't overtax a service.
* **Load balancing**: Allow for multiple competing consumers to read from a queue at the same time, each safely obtaining exclusive ownership to specific messages.
* **Topics and subscriptions**. Enable 1:n relationships between publishers and subscribers, which allows subscribers to select particular messages from a published message stream.
* **Transactions**: Do several operations, all in the scope of an atomic transaction.
* **Message sessions**: Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.

If you're familiar with other message brokers like Apache ActiveMQ, Rabbit MQ, TIBCO EMS, and IBM MQ, Service Bus concepts are similar to what you know.

## Create your Service Bus Premium namespace by using the Azure CLI

You can use the Azure CLI to create and manage Azure resources. The CLI allows administrators and developers to run commands by using a terminal or command-line prompt (or script) instead of a web browser.

To use the Azure CLI to create a Service Bus Premium namespace, use the following commands.

### Set up the Azure CLI

You'll need the Azure CLI to create your Service Bus Premium namespace. You can check the version of your current Azure CLI installation by running the following command:

```bash
az --version
```

Ensure that the Azure CLI installation is signed in to your Azure subscription.

```bash
az login
az account show --output table
```

Ensure that your default subscription is the one you want to use for this lab. If not, set the subscription by using the following command:

```bash
az account set --subscription SUBSCRIPTION_ID
```

Congratulations, the Azure CLI is now ready to create your first Service Bus Premium namespace.

### Create a Service Bus namespace

In this section, you'll create a Service Bus namespace by using the Azure CLI. It's possible to do exactly the same configuration by using the Azure portal. For this configuration, you'll need to set up the following three environment variables:

* Create a resource group. To limit typing, set the variable `AZ_RESOURCE_GROUP` to the name of the resource group that you want to create.
* Set the variable `AZ_LOCATION` to the name of the Azure region that you want to use. The default location is eastus, but you can choose a region closer to you for better performance. Use az account list-locations to list all available regions.
* Choose a name for your Service Bus Premium namespace in the `AZ_SB_PREMIUM_NAMESPACE` variable.

> [!NOTE]
> Be sure to substitute your own values for `AZ_RESOURCE_GROUP`, `AZ_LOCATION`, and `AZ_SB_PREMIUM_NAMESPACE` in the following example configuration.
>

```bash
AZ_RESOURCE_GROUP=<xxxxxxx>
AZ_LOCATION=eastus
AZ_SB_PREMIUM_NAMESPACE=<xxxxxxx>
```

With these variables set, you can now create your Service Bus Premium namespace.

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION

az servicebus namespace create \
    --resource-group $AZ_RESOURCE_GROUP \
    --namespace-name $AZ_SB_PREMIUM_NAMESPACE \
    --sku Premium \
    --capacity 1
```

This command takes a few minutes to finish. You can continue to the next unit while it finishes.

> [!NOTE]
> Make sure to delete your Service Bus Premium namespace when you're finished with it to avoid an ongoing charge to your Azure subscription. Even if you don't finish the module, follow the cleanup steps in the final Summary unit to remove the namespace and stop billing. For more information about pricing, see [Service Bus pricing](https://azure.microsoft.com/pricing/details/service-bus/).
