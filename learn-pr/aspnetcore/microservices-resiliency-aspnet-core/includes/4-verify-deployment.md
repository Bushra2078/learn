Soon after launching the setup script, the [Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor) opens the starter solution. The editor opens to the *:::no-loc text="~/clouddrive/aspnet-learn/src/":::* directory. You can investigate the solution while the script continues to deploy the Docker containers to Azure Kubernetes Service (AKS). While doing so, the script will continue to run.

> [!NOTE]
> If your Cloud Shell session disconnects due to inactivity, reconnect and run the following command to return to this directory and open the Cloud Shell editor:
>
> ```bash
> cd ~/clouddrive/aspnet-learn/src/ && \
>   code .
> ```

## Review code

The following *:::no-loc text="src":::* subdirectories contain .NET Core projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *:::no-loc text="Aggregators/":::* | Services to aggregate across multiple microservices for certain cross-service operations. An HTTP aggregator is implemented in the *:::no-loc text="ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::* project. |
| *:::no-loc text="BuildingBlocks/":::* | Services that provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *:::no-loc text="Services/":::* | These projects implement the business logic of the app. Each microservice is autonomous, with its own data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain-Driven Design (DDD), and Command and Query Responsibility Segregation (CQRS). The new *:::no-loc text="Coupon.API":::* project has been provided, but it's not resilient. |
| *:::no-loc text="Web/":::* | ASP.NET Core apps that implement user interfaces. *:::no-loc text="WebSPA":::* is a storefront UI built with Angular. *:::no-loc text="WebStatus":::* is the health checks dashboard for monitoring the operational status of each service. |

## Verify deployment to AKS

After the app has deployed to AKS, you'll see a variation of the following message in the command shell:

```console
The eShop-Learn application has been deployed.

You can begin exploring these services (when available):
- Centralized logging       : http://13.83.97.100/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://13.83.97.100/webstatus/ (See overall service status)
- Web SPA application       : http://13.83.97.100/
```

> [!TIP]
> To display these URLs again, run the following command:
>
> ```bash
> cat ~/clouddrive/aspnet-learn/deployment-urls.txt
> ```

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **General application status** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/4-verify-deployment/health-checks-status-page.png" alt-text="health checks status dashboard" border="true" lightbox="../media/4-verify-deployment/health-checks-status-page.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **Centralized logging** URL, are available before the other endpoints.

1. After all the services are healthy, select the **Web SPA application** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../media/4-verify-deployment/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../media/4-verify-deployment/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **LOGIN** link in the upper right to sign into the app. The credentials are provided on the page.
    1. Add the **.NET BLUE HOODIE** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**, and then select **PLACE ORDER** to complete the purchase.

    :::image type="content" source="../media/4-verify-deployment/eshop-spa-shopping-bag.png" alt-text="shopping cart with .NET Blue Hoodie" border="true" lightbox="../media/4-verify-deployment/eshop-spa-shopping-bag.png":::

## Explore the response of a non-resilient app

Complete the following steps to see how the app responds without a resiliency solution in place.

### Purchase some merchandise

To configure a simulated failure, you need at least one item in the basket. Complete the following steps:

1. Select the **CONTINUE SHOPPING** button.
1. Log in to *eShopOnContainers*.
1. Select the **.NET FOUNDATION PIN**.
1. Select the basket icon at the top right of the page.
1. Select **CHECKOUT**.

### Configure simulated failure

1. In the **HAVE A DISCOUNT CODE?** text box at the bottom of the page, enter the code *:::no-loc text="FAIL 2 DISC-10":::*.

    This code causes the coupon service raise an exception twice, when validating the *:::no-loc text="DISC-10":::* discount code.
1. Select the **APPLY** button.

    You'll receive the following confirmation message with the number of failures configured for the code: **CONFIG: 2 failure(s) configured for code "DISC-10"!**.

    :::image type="content" source="../media/4-verify-deployment/configure-coupon-failures.png" alt-text="configure coupon failures" border="true" lightbox="../media/4-verify-deployment/configure-coupon-failures.png" :::

This configuration causes the next two requests for the *:::no-loc text="DISC-10":::* code to throw an exception.

### Apply the failing discount coupon

1. In the **HAVE A DISCOUNT CODE?** text box, remove the coupon code *:::no-loc text="FAIL 2":::*, leaving only *:::no-loc text="DISC-10":::*.
1. Select the **APPLY** button. You'll receive the message **ERROR: 500 - Internal Server Error!**.
1. Select the **APPLY** button again. You'll receive the same message once more.
1. Select the **APPLY** button for a third time. This time, the code validation succeeds and the discount is applied to the order.

In the two failed attempts to apply the *:::no-loc text="DISC-10":::* code, notice that you received the error message immediately. Check the log traces. You'll see something like the following output:

:::image type="content" source="../media/4-verify-deployment/non-resilient-failures.png" alt-text="non-resilient failures" border="true" lightbox="../media/4-verify-deployment/non-resilient-failures.png":::

In the preceding image, you can see that:

- The first two requests, labeled as "1" and "2", fail when getting the values.
- The third request, labeled as "3", succeeds and returns the expected value, labeled as "4".

In this unit, you've seen the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. You'll add code-based resiliency with Polly to the coupon service in the next unit.
