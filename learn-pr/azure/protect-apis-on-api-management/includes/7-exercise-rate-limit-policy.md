In API Management, you use policies to implement throttling.

Recall that your government agency would like to prevent the abuse of their APIs, such as large volumes of requests.

In this unit, you learn how to set limits on the frequency that your census API can be called. You also learn how these limits can be applied globally to all of your census endpoints or granularly to each client.

## Apply a rate limit policy

To apply a **throttling** policy within API Management, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **All Resources**, and then select your API gateway.

1. In the left menu pane, Under **APIs**, select **APIs**, and in the middle pane, select **Census Data**.

1. In the top menu bar, select the **Design** tab, and then select **All operations**.

1. In the **Inbound processing** section, select the **</>** icon.

   :::image type="content" source="../media/7-apply-throttling-policy.png" alt-text="Screenshot of the Design tab with the Policies icon highlighted in the Inbound processing section.":::

1. Replace the entire `<inbound>` element with the following code:

    ```XML
    <inbound>
        <rate-limit calls="3" renewal-period="15" />
        <base />
    </inbound>
    ```

1. Select **Save**.

Your policy file should contain all three policies, similar to this code:

```XML
<policies>
    <inbound>
        <rate-limit calls="3" renewal-period="15" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <set-header name="x-powered-by" exists-action="delete" />
        <redirect-content-urls />
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
```

> [!NOTE]
> The order of the policies within each section is not important for this example.

## Test the policy

Now let's see if the throttling policy is working:

1. Select **Census Data** again, and in the top menu bar, select the **Test** tab.

1. Select the **GetLatestCensus** operation, and then select **Send** three times in a row.

1. Upon sending the request the third time, you should get a **429 error (too many requests)** response:

   :::image type="content" source="../media/7-too-many-requests.png" alt-text="Screenshot of an HTTP response showing a 429 Too Many Requests error.":::
