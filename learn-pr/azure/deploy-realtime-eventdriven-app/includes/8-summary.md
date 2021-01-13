Congratulations! You've completed a full event-driven scenario!

Your application is sending event based telemetric data in real time to Cosmos DB using Azure Functions and Event Hub. You followed these steps:

1. Create an Azure Function to simulate telemetry data.

2. Send the telemetry data towards an event hub.

3. Consuming the events with a function, process them and store them in a database.

4. Add monitoring.

5. Verify the timings set to ensure your workload gets handled in real time.

You're now confident that you can handle real-time workloads on Azure.

## Enable diagnostic logging

Learn how Azure provides [built-in diagnostics to help with debugging](https://docs.microsoft.com/azure/app-service/troubleshoot-diagnostic-logs/).

## Clean up resources

In this module, you created Azure resources in a resource group. If you won't need these resources later, delete the resource group from the portal. Or run the following command in Azure Cloud Shell.

```bash
az group delete --name <your resource group name> --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources

[Tutorial: Create a function in Java with an Event Hub trigger and an Azure Cosmos DB output binding](https://docs.microsoft.com/azure/azure-functions/functions-event-hub-cosmos-db?WT.mc_id=java-9741-sakriema)

[An introduction to Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/introduction?WT.mc_id=java-9741-sakriema)

[Best practices for Azure Functions](https://docs.microsoft.com/azure/azure-functions/storage-considerations?WT.mc_id=java-9741-sakriema)
