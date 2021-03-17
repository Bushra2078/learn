A Remote Rendering service resource must be created in Azure to get access to the service. The Remote Rendering service resource will later be used to render a model in the app. Here, you'll learn how to create a Remote Rendering resource and locate the account ID, account domain, and Primary key.

## Create a Remote Rendering service resource

1. After the sandbox at the top of this page has completed activation, sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. On the Azure portal menu or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource.
1. The portal takes you to the **Marketplace** page. In the **Search the Marketplace** box, type **remote rendering** and press the Enter key.
1. Select **Remote Rendering** from the results.

    :::image type="content" source="../media/marketplace-results.png" alt-text="A screenshot of the Azure Marketplace results. There's a red box around the Remote Rendering service.":::

1. On the page for the Remote Rendering service resource, select **Create**.
1. Fill out the wizard with the following values:

    |Field  |Value  |Details  |
    |---------|---------|---------|
    |**Resource Name**     |    Enter a unique name     |   Choose a globally unique name for the resource. For example, you might name the resource *remote-rendering-xxx*, where the x's are replaced with your initials. If the name isn't globally unique, you can try any other combination. Valid characters are a-z, 0-9, and -.      |
    |**Subscription**    |   *Concierge Subscription*      |    The resource you're creating must belong to a resource group. Here, *Concierge Subscription* is the name of the subscription to which you have access in the Azure Sandbox.     |
    |**Resource group**     |   *<rgn>[Sandbox resource group name]</rgn>*      |    The resource group to which the Remote Rendering service will belong. All Azure resources must belong to a resource group. The resource group specified here has been created for you by the Azure Sandbox.     |
    |**Location**     |    Geographical location near you     |   The geographical location where your app will be used.      |

   :::image type="content" source="../media/create-remote-rendering-resource.png" alt-text="A screenshot of the values provided for the Remote Rendering Account wizard.":::

1. Select **Create**.

> [!NOTE]
> It can take a few seconds to get your Remote Rendering service resource created and ready for use.

A notification will appear after deployment is complete. Your new Remote Rendering service resource and API keys will then be available for use.

## View the subscription keys and endpoint

1. On the Azure portal menu or from the **Home** page, select **All resources**.
1. Select the Remote Rendering service resource from the list.

    :::image type="content" source="../media/all-resources.png" alt-text="A screenshot of the list of all resources. There's a red box around the remote dash rendering dash demo resource." lightbox="../media/all-resources.png":::

1. In the **Overview** tab, note the **Account Domain**.

    :::image type="content" source="../media/account-domain.png" alt-text="A screenshot of the remote rendering service resource page. There's a red box around the account domain." lightbox="../media/account-domain.png":::

1. In the **Overview** tab, note the **Account ID**.

    :::image type="content" source="../media/account-id.png" alt-text="A screenshot of the remote rendering service resource page. There's a red box around the account ID." lightbox="../media/account-id.png":::

1. In the **Settings** section, select **Access Keys**. In the next exercise, you'll need the value for **Primary key** to render the model in the app.

    :::image type="content" source="../media/access-keys.png" alt-text="A screenshot of the remote rendering service resource page. There's a red box around access keys within the settings section. There's also a red box around the primary key." lightbox="../media/access-keys.png":::
