In this module, you: 

* Examined an existing ASP.NET Core microservices running in AKS.
* Implemented a new ASP.NET Core microservice and containerized it.
* Published the Docker image to ACR.
* Deployed the Docker container to the existing app in AKS.

## Remove Azure resources

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

To de-provision all of the resources created in this module, run the following command:

```azurecli
az group delete --name eshop-learn-rg --yes
```

The preceding command deletes the resource group containing the AKS and ACR resources. Another resource group containing infrastructure resources (such as IP addresses) was previously created on behalf of the AKS resource. This group and all resources contained within are also deleted when the AKS resource is deleted.

## Remove Azure service principal

The initial setup script created an Azure service principal, which allows Azure resources to authenticate to each other.

To remove the service principal, run the following script:

```bash
./deploy/k8s/cleanup-service-principal.sh
```

The preceding script:

* Uses the following Azure CLI command to return a list of service principal identifiers from AAD. The identifiers are filtered to those:
  * Owned by the current user.
  * Containing the string `eShop-Learn-AKS` in the display name.

    ```azurecli
    az ad sp list --show-mine --query "[?contains(displayName,'eShop-Learn-AKS')].appId" --output tsv
    ```

* Uses the `az ad sp delete` Azure CLI command to remove each matching service principal.

> [!NOTE]
> More than one service principal is expected if the setup script has been run more than once. Each time the setup script is run, it creates a new service principal.

## Revert .NET Core SDK changes

The setup script installs a newer version of the .NET Core SDK alongside Cloud Shell's default SDK version. You may choose to keep this configuration. To revert to your prior configuration, execute the following commands:

```bash
cp ~/.bashrc.bak.microservices-aspnet-core ~/.bashrc
```

The preceding command restores your prior *:::no-loc text=".bashrc":::* profile startup file from a backup saved by the setup script.

[!INCLUDE[download files](../../includes/summary-download-clouddrive.md)]

## Reset Azure Cloud Shell

The scripts used in this module make temporary changes to your Cloud Shell preferences. You don't need to reset your configuration if the scripts ran as intended. If you want to reset your Cloud Shell to its default configuration, see the [documentation on deleting personal data](/azure/cloud-shell/troubleshooting#delete).

## Learn more about microservices

* Free e-book: [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices/)
* [Full eShopOnContainers reference app on GitHub](https://github.com/dotnet-architecture/eShopOnContainers)
* Video: [Implement microservices patterns with .NET Core and Docker containers](https://aka.ms/microservices-video)
  * Note: The above video doesn't reflect current .NET Core tooling. However, the architectural concepts and design patterns remain valid.

## Learn more about .NET

* [.NET Core 101](https://channel9.msdn.com/Series/NET-Core-101/?WT.mc_id=Educationaldotnet-c9-scottha&azure-portal=true)
* [ASP.NET Core 101](https://channel9.msdn.com/Series/ASPNET-Core-101/?WT.mc_id=Educationaspnet-c9-niner&azure-portal=true)
