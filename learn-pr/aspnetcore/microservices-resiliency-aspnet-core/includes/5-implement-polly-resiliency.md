In this exercise, you'll implement a resiliency handler with Polly. The initial *:::no-loc text="eShopOnContainers":::* deployment includes a failure simulation feature when validating a coupon from the checkout basket. This feature allows you to configure how many times a request for a specific discount coupon code should fail.

In this unit, you will:

- Update the app's code to implement failure handling using Polly.
- Create an ACR instance and deploy the updated app to AKS.
- Explore the system response under failure after implementing resiliency.

## Add failure handling code using Polly

In this section, you'll modify the app to automatically retry a failing operation until it succeeds. If the operation continues to fail after several attempts, the UI will display an exception.

When validating a discount coupon, the HTTP request is sent to the web shopping aggregator. The web shopping aggregator is responsible for routing the request to the coupon service. This is an implementation of the [Backends For Frontends pattern](https://samnewman.io/patterns/architectural/bff) (BFF). The BFF implementation:

- Sends another HTTP request to the coupon service to get the required information.
- Handles resiliency using [IHttpClientFactory](/aspnet/core/fundamentals/http-requests) and [Polly](http://www.thepollyproject.org).

To make the coupon service resilient, you'll implement a Retry and a Circuit Breaker policy to handle failure within the web shopping aggregator. Using Polly with `IHttpClientFactory` to add resiliency to web apps is one of the archetypical failure handling solutions. The `IHttpClientFactory` is responsible for creating instances of `HttpClient`.

The following sequence diagram depicts the flow of events from an `HttpClient` instance to Polly's Retry and Circuit Breaker policies:

:::image type="content" source="../media/5-implement-polly-resiliency/policy-http-message-handlers.png" alt-text="An HttpClient call through multiple PolicyHttpMessageHandlers" border="true" lightbox="../media/5-implement-polly-resiliency/policy-http-message-handlers.png":::

Complete the following steps to implement failure handling for the coupon service as described above:

1. Set your current location to the HTTP aggregator project directory by running the following command:

    ```bash
    pushd src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/
    ```

    Your current location is *:::no-loc text="~/clouddrive/aspnet-learn/src/src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::*.

1. Run the following command:

    ```dotnetcli
    dotnet add package Microsoft.Extensions.Http.Polly
    ```

    The preceding command installs a NuGet package in the *:::no-loc text="Web.Shopping.HttpAggregator":::* project. The package integrates `IHttpClientFactory` with Polly and installs the actual `Polly` package as a dependency. The package is necessary to configure Polly policies to handle conditions representing transient faults when making HTTP requests. Such conditions are handled by invoking the package's `HttpPolicyExtensions.HandleTransientHttpError` method. The conditions include:

    - Network failures, as indicated by exceptions of type `HttpRequestException`
    - Server errors, as indicated by HTTP 5xx status codes
    - Request timeouts, as indicated by the HTTP 408 status code

1. Apply the following changes in the *:::no-loc text="src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Extensions/ServiceCollectionExtensions.cs":::* file:
    1. Replace the comment `// Add the GetRetryPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy()
        {
            return HttpPolicyExtensions.HandleTransientHttpError()
                .WaitAndRetryAsync(5,
                    retryAttempt => TimeSpan.FromMilliseconds(Math.Pow(1.5, retryAttempt) * 1000),
                    (_, waitingTime) =>
                    {
                        Log.Logger.Information(
                            "----- Retrying in {WaitingTime}s", $"{ waitingTime.TotalSeconds:n1}");
                    });
        }
        ```

        The preceding method creates a Retry policy that retries up to five times with an exponentially increasing delay in between each attempt. The delay:

        - Increases as a power of 1.5 seconds after each attempt.
        - Is a power of 2 seconds by default. To decrease wait times for this exercise, 1.5 seconds is used instead.

        This policy's premise is that faults are transient and may self-correct after a short delay.

    1. Replace the comment `// Add the GetCircuitBreakerPolicy method` with the following method:

        ```csharp
        public static IAsyncPolicy<HttpResponseMessage> GetCircuitBreakerPolicy() =>
            HttpPolicyExtensions.HandleTransientHttpError()
                .CircuitBreakerAsync(15, TimeSpan.FromSeconds(15));
        ```

        The preceding method creates a Circuit Breaker policy. After 15 consecutive failures, the policy enforces a 15-second pause. This policy's premise is that protecting the service from overload can help it recover.

    1. In the `AddApplicationServices` method, call the `AddPolicyHandler` extension method twice. Chain the method calls to the `AddHttpMessageHandler` method call for the coupon service:

        :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/extensions/5-servicecollectionextensions.cs" highlight="7-8":::

        With the preceding changes, the `HttpClient` instance used by the coupon service has been configured to apply a Retry and a Circuit Breaker policy. This particular `HttpClient` instance is provided to the `CouponService` class via constructor injection:

        :::code language="csharp" source="../code/src/apigateways/services/5-couponservice.cs" highlight="8":::

        The `AddApplicationServices` extension method is invoked from the `ConfigureServices` method in the project's *:::no-loc text="Startup.cs":::* file:

        :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/5-startup.cs" highlight="7":::

    1. Replace the comment `// Add the using statements` with the following `using` directives:

        ```csharp
        using Polly;
        using Polly.Extensions.Http;
        using System.Net.Http;
        ```

        Importing the preceding namespaces resolves member references in the `GetRetryPolicy` and `GetCircuitBreakerPolicy` methods.

1. Save the *:::no-loc text="ServiceCollectionExtensions.cs":::* file.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. Return to your previous location by running the following command:

    ```bash
    popd
    ```

## Deploy the updated microservice

Complete the following steps to deploy the changes that you've implemented:

1. Run the following script to publish the updated Docker image to ACR:

    ```bash
    ./deploy/k8s/build-to-acr.sh --services webshoppingagg
    ```

    The preceding script builds and publishes the updated image to the ACR instance. An [ACR quick task](/azure/container-registry/container-registry-tasks-overview#quick-task) is used to build and publish the `webshoppingagg` image to the ACR instance. You'll see a variation of the following output:

    ```console
    Building images to ACR
    ======================
    ~/clouddrive/aspnet-learn/src/deploy/k8s ~/clouddrive/aspnet-learn/src

    Building and publishing docker images to eshoplearn20200729161705092.azurecr.io
    ~/clouddrive/aspnet-learn/src ~/clouddrive/aspnet-learn/src/deploy/k8s ~/clouddrive/aspnet-learn/src

    Building image "webshoppingagg" for service "webshoppingagg" with "src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr"...

     > az acr build -r eshoplearn20200729161705092 -t eshoplearn20200729161705092.azurecr.io/webshoppingagg:linux-latest -f src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Dockerfile.acr .

    Packing source code into tar to upload...
    Excluding '.gitignore' based on default ignore rules
    Uploading archived source code from '/tmp/build_archive_1a826ecd8db64f8c846d796af13d6318.tar.gz'...
    Sending context (7.838 MiB) to registry: eshoplearn20200729161705092...
    Queued a build with ID: cf2
    Waiting for an agent...
    2020/07/29 17:03:19 Downloading source code...
    2020/07/29 17:03:21 Finished downloading source code
    2020/07/29 17:03:22 Using acb_vol_faae1c90-bbea-4ea6-89e9-daa0ab059f5a as the home volume
    2020/07/29 17:03:22 Setting up Docker configuration...
    2020/07/29 17:03:23 Successfully set up Docker configuration
    2020/07/29 17:03:23 Logging in to registry: eshoplearn20200729161705092.azurecr.io
    2020/07/29 17:03:24 Successfully logged into eshoplearn20200729161705092.azurecr.io
    2020/07/29 17:03:24 Executing step ID: build. Timeout(sec): 28800, Working directory: '', Network: ''
    2020/07/29 17:03:24 Scanning for dependencies...
    2020/07/29 17:03:25 Successfully scanned dependencies
    2020/07/29 17:03:25 Launching container with name: build
    ```

    And this particular line once the image has been published to ACR:

    ```console
    2020/07/29 17:04:57 Successfully pushed image: eshoplearn20200729161705092.azurecr.io/webshoppingagg:linux-latest
    ```

1. Run the following command to verify the URL of your ACR instance:

    ```bash
    echo $ESHOP_REGISTRY
    ```

    You'll see a variation of the following output:

    ```console
    eshoplearn2020072900000000.azurecr.io
    ```

    > [!IMPORTANT]
    > If the output is blank, it's because the `ESHOP_REGISTRY` variable isn't defined. Run the following command to set the variable using output from the setup script and then run the `echo` command again to verify:
    >
    > ```bash
    > eval $(cat ~/clouddrive/aspnet-learn/create-acr-exports.txt)
    > ```

1. Run the following script to deploy the updated image in ACR to AKS:

    ```bash
    ./deploy/k8s/deploy-application.sh --registry $ESHOP_REGISTRY --charts webshoppingagg
    ```

    The preceding script uninstalls the old `webshoppingagg` Helm chart and installs it again. The AKS cluster uses the new image from the ACR instance. You'll see a variation of the following output:

    ```console
    ~/clouddrive/aspnet-learn ~/clouddrive/aspnet-learn/src/deploy/k8s
    ~/clouddrive/aspnet-learn/src/deploy/k8s

    Uninstalling chart webshoppingagg...
    release "eshoplearn-webshoppingagg" uninstalled

    Deploying Helm charts from registry "eshoplearn20200731194920286.azurecr.io" to "http://13.87.153.177"...
    ---------------------

    Installing chart "webshoppingagg"...
    NAME: eshoplearn-webshoppingagg
    LAST DEPLOYED: Fri Jul 31 20:38:05 2020
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None

    Helm charts deployed!
    ```

## Test the app again

### Retry policy

Place an item in the shopping bag and begin the checkout procedure. Repeat the earlier steps to configure multiple failures from the coupon service. Complete the following steps to test the retry policy:

1. Enter the discount code *:::no-loc text="FAIL 2 DISC-10":::* and select **:::no-loc text="APPLY":::**.

    You'll receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 2 failure(s) configured for code \"DISC-10\"!!":::**.
1. Replace the existing discount code with *:::no-loc text="DISC-10":::* and select **:::no-loc text="APPLY":::**.

    The operation appears to be successful on the first try after a brief wait. The resilient BFF handles retries transparently from the user's perspective.
1. Run the following command to view the logging page URL. Select the **:::no-loc text="Centralized logging":::** link.

    ```bash
    cat ../deployment-urls.txt
    ```

1. Check the log traces. You'll see a variation of the following output:

    :::image type="content" source="../media/5-implement-polly-resiliency/configure-and-retry-logs.png" alt-text="log traces" border="true" lightbox="../media/5-implement-polly-resiliency/configure-and-retry-logs.png":::

    In the preceding image, you can see:

    - The log traces when configuring the simulated failures, labeled as ":::no-loc text="1":::".
    - Three retries until the aggregator could finally get the value, labeled as ":::no-loc text="2":::".
1. Complete the checkout procedure and select **:::no-loc text="CONTINUE SHOPPING":::**.

### Circuit Breaker policy

To test the Circuit Breaker policy, you'll configure the code for 20 failures. Accordingly, you'll use the discount code *:::no-loc text="FAIL 20 DISC-10":::*:

:::image type="content" source="../media/5-implement-polly-resiliency/configure-severe-failure.png" alt-text="configure a severe failure" border="true" lightbox="../media/5-implement-polly-resiliency/configure-severe-failure.png":::

Place an item in the shopping bag and begin the checkout procedure. Repeat the earlier steps to configure multiple failures from the coupon service, this time for 20 consecutive failures. Complete the following steps:

1. Enter the discount code *:::no-loc text="FAIL 20 DISC-10":::* and select **:::no-loc text="APPLY":::**.

    You'll receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 20 failure(s) configured for code \"DISC-10\"!!":::**.
1. Enter the discount code *:::no-loc text="DISC-10":::* again and select **:::no-loc text="APPLY":::**.
1. Wait about 20 seconds. You'll receive an HTTP 500 error message.
1. Select **:::no-loc text="APPLY":::** again. The error message is received again in about 20 seconds.
1. Select **:::no-loc text="APPLY":::** again. The HTTP 500 error message came in much faster because of the Circuit Breaker policy.
1. Select **:::no-loc text="APPLY":::** again.

    The error message is received immediately. You can see this error clearly in the log traces:

    :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-logs.png" alt-text="severe failures in log traces" border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-logs.png":::

    In the preceding image, notice that:

    - After waiting for 7.6 seconds, labeled as ":::no-loc text="1":::", you received the HTTP 500 error message with the retry policy, labeled as ":::no-loc text="2":::".
    - On the next try, you validate the code. You receive the HTTP 500 error message after waiting only 3.4 seconds, labeled as ":::no-loc text="3":::". You don't see the ":::no-loc text="Get coupon...":::" trace, meaning it failed without going to the server.
    - If you check the details on this last trace, you should see a variation of the following output:

        :::image type="content" source="../media/5-implement-polly-resiliency/severe-failure-log-detail.png" alt-text="severe failure log detail" border="true" lightbox="../media/5-implement-polly-resiliency/severe-failure-log-detail.png":::

        Notice that the last trace has the ":::no-loc text="The circuit is now open...":::" message.

In this unit, you added code-based resiliency with Polly. Next, you'll implement infrastructure-based resiliency with Linkerd.
