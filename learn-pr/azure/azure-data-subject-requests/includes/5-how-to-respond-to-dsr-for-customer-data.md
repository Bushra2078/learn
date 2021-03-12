When a data controller receives a DSR, they typically need to provide a response as soon as possible. The GDPR requires responses within one calendar month. CCPA requires a response no later than 45 days. Companies who don't comply with this could incur monetary penalties.

To respond efficiently to a DSR for customer data, organizations can use the tools and in-app features available in both Microsoft 36 and Office 365.

## Scenarios for DSR in Azure and Office 365 for customer data

DSR request scenarios usually start with performing discovery and locating the requested personal information. The DSR requested action will determine the second step. The following table breaks out the technical process and tools you can use for the DSR based on the personal information's location and the data type.

|Request type|Step 1|Step 2|
|------|------|------|
|Right to access data|Discover|Access|
|Right to rectify data|Discover|Rectify|
|Right to restrict data|Discover|Restrict|
|Right to be forgotten|Discover|Delete|
|Right of portability|Discover|Export/Receive|

Some DSRs might be more complex than others. There might even be multiple requests from the same person. Data controllers have the right to validate the data subject's identity before fulfilling their DSR. However, the data subject doesn't have to specify the reason for the DSR.

### Example 1: DSR against customer data in Azure

A Contoso customer residing in France has called the DSR toll-free number to enact their right to be forgotten, also known as *right to erasure*. You need to remove all their personal information from Azure. To do this, you can use the following steps:

#### Task 1: Discover

1. Sign into the Azure portal.
2. Navigate to Azure AD, and then select **Users**.
3. Locate the user account in the **All users** blade.
4. Select **Profile** to review the personal data and confirm that this is the DSR data subject.

#### Task 2: Delete

1. In Azure AD, select **Users**.
2. In the **All users** blade, select the check box for the data subject's user account.
3. Select **Delete user**, and then select **Yes** to confirm.
4. In the **Deleted users** blade, select the check box for the data subject's user account.
5. Select **Delete permanently**, and then select **Yes** to confirm.

> [!NOTE]
> Deleting this data also means deleting the user from the tenant. However, users are initially soft-deleted, which means that within 30 days of being marked for soft-delete, a tenant admin can recover the account. After 30 days, the account is automatically and permanently deleted from the tenant. You can also speed up the process by manually deleting the user from the recycle bin.

### Example 2: DSR against customer data in Office 365

A Contoso customer residing in California has submitted a DSR form through the company's website. They want access to their personal information that they provided to Contoso via emails and documents. You need to search for their personal information, then give the customer access to that information. If that's not possible, you may need to provide an explanation of why the information can't be provided. To accomplish this, you can use the following steps:

#### Task one: Discover

1. Search all content locations with the **Content Search** tool by using identifiers such as:

    - Email address or alias (examples: datasubject@contoso.com or datasubject)
    - Phone number
    - Mailing address
    - Social security number

2. Narrow down results by using conditions such as:

    - File type: for example, **docx**, **pdf**, or **xlsx**
    - Message type: for example, **\*email** or **\*contacts**
    - Compliance tag: for example, *compliancetag="personal data"*

3. Search for data in SharePoint Online and OneDrive for Business with queries such as:

    - datasubject@contoso.com AND filetype="docx"
    - (11-18-1990) AND (kind="email")

4. Save the content search for future queries.

#### Task 2: Provide access

1. Provide access to data subject by retrieving a copy of the document or item that contains responsive data. To do this, you can preview and download items:

    1. In the Compliance Center, open **Content Search**.
    1. Select **Preview results**.
    1. Select an item, and then select **Download original file**.

2. Determine which of the following item (or items) to provide:

    - The actual document
    - An appropriately redacted version
    - A screenshot of portions deemed appropriate to share

> [!NOTE]
> When providing a copy to the data subject, you might need to remove or redact personal information about other data subjects and any other confidential information.

## Tools for fulfilling DSRs for customer data

The following table lists tool that you can use to fulfill DSRs for customer data in Microsoft cloud products.

|Tool name|Description|
|------|------|
|Azure Portal|Use this tool to respond to DSRs within Azure.|
|Content Search eDiscovery tool|This tool is in both the Office 365 Security & Compliance Center, and the Microsoft 365 compliance center. You can use it to help fulfill DSRs against Office 365 / Microsoft 365 applications.|
|DSR case tool|This tool is in the Office 365 Security & Compliance Center. You can use this tool help with investigations for a data subject.|
|In-app functionality|For applications that don’t support the Content Search tool, you can use the application itself for responding to DSRs.|

## In-scope applications

Office 365 includes many applications that can store user data. Knowing which applications the data subject uses helps you narrow down what’s in scope for the DSR response. Depending on the application, you might be able to use the Content Search tool to respond. In some cases, however, you'll have to use the in-app functionality to get to the data.

One of the fastest ways to determine the in-scope applications is to review the Microsoft 365 for Business subscription. The subscription's details will show the applications that are included. You can also use the Microsoft 365 admin center to help locate the user's account. From there, in the user account's properties, you can review their product licensing.

## Compliance boundaries

*Compliance boundaries* are logical search boundaries. These boundaries control the locations that the people involved in the DSR fulfillment can access. You can use the Compliance Center to create compliance boundaries. Some common use cases for compliance boundaries include:

- Geographical boundaries
- Governmental organizations and agencies
- Organizational units or departments