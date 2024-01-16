Cloud-based services such as Azure often host multiple tenants. If a data subject's personal information is in a cloud-based multi-tenancy, it’s helpful to understand the scope or boundaries of a DSR response. Having a multi-tenancy response process in place helps create a timely response to a DSR.

<a name='dsr-response-scopes-for-azure-ad-and-microsoft-service-accounts'></a>

## DSR response scopes for Microsoft Entra ID and Microsoft service accounts

The following image illustrates three scenarios in which a Microsoft customer might receive a DSR:

:::image type="content" source="../media/4-dsr-scope.png" alt-text="Diagram of three scenarios depicting the scope of Microsoft DSR fulfillment. 1. An enterprise customer receives a DSR. 2. A Microsoft service account with a Microsoft Entra tenant receives a DSR. 3. A Microsoft service account outside a Microsoft Entra tenant receives a DSR." border="false":::

### Scenario 1

If an enterprise customer receives a DSR, the DSR response occurs only in that customer's Microsoft Entra tenant. It won’t affect other tenants.

> [!NOTE]
> It's possible that a user submitting a DSR participates in multiple tenants. If this happens, the DSR is only fulfilled in the tenant that receives the DSR.

### Scenario 2

If a Microsoft service account creates an Azure subscription, the subscription will be handled as if it were a Microsoft Entra tenant. Consequently, DSRs are scoped within the tenant as described above.

### Scenario 3

If a Microsoft service account receives a DSR and the account is outside of the Microsoft Entra tenant, the DSR response occurs in the consumer privacy dashboard.

## DSR response overview for Azure

There’s a two-part process for DSR responses in Azure. However, the high-level response tasks will differ based on data type.

### Part one: Customer data

For customer data, the high-level response tasks are:

1. Discover
2. Access
3. Rectify
4. Restrict
5. Delete
6. Export

### Part two: System-generated logs

For system-generated logs, the high-level response tasks are:

1. Access
2. Delete
3. Export
