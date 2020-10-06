In this unit, you'll modify the catalog service to enable Application Insights telemetry. Application Insights has already been enabled for the other three microservices; however, configuration changes are required.

You will:

- Create Application Insights resources for the app.
- Enable logging to Application Insights.
- Deploy the updated and reconfigured microservices.

## Create the Application Insights resources

1. Add the Application Insights extension to Azure CLI by running this command:

    ```azurecli
    az extension add --name application-insights
    ```

1. Run the following commands to create the Application Insights resources:

    ```azurecli
    az configure --defaults group=eshop-learn-rg location=centralus && \
        az monitor app-insights component create --app catalog \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app coupon \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app ordering \
            --query '{Name:name, Key:instrumentationKey}' && \
        az monitor app-insights component create --app webshoppingagg \
            --query '{Name:name, Key:instrumentationKey}'
    ```

    The preceding commands create four Application Insights resources, in the resource group you created for this module. A variation of the following output appears:

    ```console
    {
      "Key": "037fb7a1-2eb5-45e8-9193-806becc426f9",
      "Name": "catalog"
    }
    {
      "Key": "726d19a4-2493-4c03-bdc5-817f2a7a3ffa",
      "Name": "coupon"
    }
    {
      "Key": "0ac4010c-9ac4-47ae-80b3-16c4d1a7889b",
      "Name": "ordering"
    }
    {
      "Key": "c0cde760-d563-4534-9b4f-0eac68763d40",
      "Name": "webshoppingagg"
    }
    ```

    In the preceding output, there are four key-value pairs, where:

    - The `Name` property represents the service name.
    - The `Key` property represents the Application Insights instrumentation key.

1. Using the Cloud Shell editor, uncomment the `APPINSIGHTS_INSTRUMENTATIONKEY` environment variable in each of the following files in the *deploy/k8s/helm-simple* directory. Replace the `<key>` placeholder with the appropriate Application Insights instrumentation key. Save your changes.
    - *catalog/templates/configmap.yaml*
    - *coupon/templates/configmap.yaml*
    - *ordering/templates/configmap.yaml*
    - *webshoppingagg/templates/configmap.yaml*

    For example, update the catalog service's Helm chart template as follows:

    :::code language="yaml" source="../code/deploy/k8s/helm-simple/catalog/templates/configmap.yaml" highlight="9":::

    > [!IMPORTANT]
    > Each microservice requires a different instrumentation key.

    The environment variables defined within the `data` element are accessible by the service at runtime.

## Enable logging to Application Insights

Logging to Application Insights has been enabled in the ordering and coupon services, but not the catalog service. Complete the following steps to implement Application Insights in the catalog service.

1. Install the supporting Application Insights NuGet packages:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API/ && \
        dotnet add package Microsoft.ApplicationInsights.AspNetCore --version 2.12.1 && \
        dotnet add package Microsoft.ApplicationInsights.Kubernetes --version 1.1.1 && \
        dotnet add package Serilog.Sinks.ApplicationInsights --version 3.1.0 && \
        popd
    ```

1. Apply the following changes in the *src/Services/Catalog/Catalog.API* directory:
    1. In *Extensions/ServiceCollectionExtensions.cs*, replace the comment `// Add AddAppInsights extension method` with the following extension method. Save your changes.

        :::code language="csharp" source="../code/src/services/catalog/catalog.api/extensions/servicecollectionextensions.cs":::

        In the preceding code:

        - The `AddApplicationInsightsTelemetry` extension method is provided by the `Microsoft.ApplicationInsights.AspNetCore` NuGet package.
        - The `AddApplicationInsightsKubernetesEnricher` extension method is provided by the `Microsoft.ApplicationInsights.Kubernetes` NuGet package.

    1. In the *Startup.cs* file's `ConfigureServices` method, invoke the `AddAppInsights` extension method. Save your changes.

        :::code language="csharp" source="../code/src/services/catalog/catalog.api/startup.cs" highlight="3":::

        The preceding code registers the telemetry services in the dependency injection container.

    1. In *Program.cs*, add the highlighted code to the `CreateSerilogLogger` method:

        :::code language="csharp" source="../code/src/services/catalog/catalog.api/program.cs" highlight="5,12":::

        The preceding changes add the Application Insights sink for Serilog to include log traces. Note the following details:

        - The `Serilog.Sinks.ApplicationInsights` NuGet package provides the `ApplicationInsights` extension method.
        - The `APPINSIGHTS_INSTRUMENTATIONKEY` environment variable defined in the catalog service's Helm chart template is accessed with the .NET Core Configuration API.

        > [!NOTE]
        > Startup logging with Application Insights [isn't supported](/aspnet/core/fundamentals/logging/#log-during-host-construction), so it must be accomplished using another logger. This example uses Serilog with the Application Insights sink, passing the instrumentation key. Although this is the simplest way to enable logging to Application Insights during startup, it can lead to losing correlation between metrics and log traces.

1. Run the following commands to build the catalog service:

    ```dotnetcli
    pushd src/Services/Catalog/Catalog.API && \
        dotnet build && \
        popd
    ```

    The build succeeds with no warnings. If the build fails, check the output for troubleshooting information.

## Build and deploy modified container images

In the previous section, you modified the catalog service to enable Application Insights telemetry. The HTTP aggregator code has already been similarly instrumented. To update the production service deployments, the container images will be built and hosted on ACR.

1. Run this script to build the catalog and HTTP aggregator images:

    ```bash
    deploy/k8s/build-to-acr.sh --services catalog-api,webshoppingagg
    ```

    The script starts [ACR quick tasks](/azure/container-registry/container-registry-tasks-overview#quick-task) for each service. Each service's container image is built independently. Variations of the following lines confirm that the catalog and HTTP aggregator Docker images were pushed to ACR:

    ```console
    2020/09/30 20:51:57 Successfully pushed image: eshoplearn20200929194132362.azurecr.io/catalog.api:linux-latest
    ```

    ```console
    2020/09/30 20:54:15 Successfully pushed image: eshoplearn20200929194132362.azurecr.io/webshoppingagg:linux-latest
    ```

1. Deploy the updated catalog service and HTTP aggregator from ACR by running the following script:

    ```bash
    deploy/k8s/deploy-application.sh --charts catalog,webshoppingagg
    ```

    The preceding script deploys the container images from ACR to AKS.

1. Redeploy the coupon and ordering services configured with their new `APPINSIGHTS_INSTRUMENTATIONKEY` environment variables:

    ```bash
    deploy/k8s/deploy-application.sh --registry eshopdev --charts coupon,ordering
    ```

    The coupon and ordering services deployed by the setup script are already instrumented for telemetry. Since there were no code changes, the containers only need redeployment with the new configuration settings. The `--registry` parameter instructs the script to use the Docker Hub registry that hosts the unmodified images.

## Verify deployment to AKS

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

    A variation of the following output appears:

    ```console
    The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

    You can begin exploring these services (when ready):
    - Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
    - General application status: http://203.0.113.55/webstatus/ (See overall service status)
    - Web SPA application       : http://203.0.113.55/
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. A green checkmark icon denotes a healthy service. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/4-implement-app-insights/health-check.png" alt-text="health checks status dashboard" border="true" lightbox="../media/4-implement-app-insights/health-check.png":::

    > [!NOTE]
    > While the app is starting, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

You've successfully verified that the app was deployed to AKS and is working properly.

In the next unit, you'll examine the telemetry in Application Insights.
