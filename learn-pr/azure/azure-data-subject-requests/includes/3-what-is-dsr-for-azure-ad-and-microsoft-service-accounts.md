Cloud-based services such as Azure often host multiple tenants. If a data subject's personal information is in a cloud-based multi-tenancy, it’s helpful to understand the scope or boundaries of a DSR response. Having a multi-tenancy response process in place helps create a timely response to a DSR.

## Scope of DSR for Azure AD and Microsoft service accounts

The following image details three scenarios in which a Microsoft customer might receive a DSR.

:::image type="content" source="../media/4-dsr-scope.png" alt-text="Three scenarios depicting the scope of Microsoft DSR fulfillment. 1. An enterprise customer receives a DSR. 2. A Microsoft service account with an Azure AD tenant receives a DSR. 3. A Microsoft service account outside an Azure AD tenant receives a DSR." border="false":::

### Scenario 1

If an enterprise customer receives a DSR, then the DSR fulfillment is performed only in that customer's Azure AD tenant; it won’t affect any other tenants.

### Scenario 2

If a Microsoft service account receives a DSR and that Microsoft service account has created an Azure AD tenant, then the scope of the DSR fulfillment is also the Azure AD tenant.

### Scenario 3

If a Microsoft service account receives a DSR and the account is outside of an Azure AD tenant, then the DSR fulfillment will occur in the consumer privacy dashboard.

> [!NOTE]
> It's possible that a user submitting a DSR participates in multiple tenants. If this happens, the DSR is only fulfilled in the tenant that receives the DSR.

## DSR response processes for Azure

The process for fulfilling a DSR in Azure consists of two parts. However, the high-level fulfillment tasks will differ based on the data type.

### Part one: Customer data

For customer data, the high-level fulfillment tasks are:

1. Discover
2. Access
3. Rectify
4. Restrict
5. Delete
6. Export

### Part two: System-generated logs

For system-generated logs, the high-level fulfillment tasks are:

1. Access
2. Delete
3. Export
