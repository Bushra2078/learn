After reviewing your template with your colleague, you decide to refactor the file to make it easier for them to work with. In this exercise, you apply the best practices you learned in the preceding units.

## Your task

Look at the Bicep template that you saved earlier. Think about the advice you've seen for how to structure your templates. Try to update your template to make it easier for your colleague to understand.

In the sections below, there are some pointers to specific parts of the template and some hints for things you might want to change. A suggested solution is provided, but your template might look different - that's OK!

> [!TIP]
> As you work through the refactoring process, it's good to ensure that your Bicep file is valid and that you haven't accidentally introduced any errors. The Bicep extension for Visual Studio Code helps with this. Watch out for any red or yellow squiggly lines below your code, since these lines indicate an error or a warning. You can also view a list of the problems in your file by selecting **View** > **Problems**.

## Update the parameters

1. There are some parameters in your template that aren't clear. For example, consider these parameters:

   ::: code language="bicep" source="code/2-template.bicep" range="3-20" :::

   What are they used for?

   > [!TIP]
   > If you have a parameter that you're trying to understand, Visual Studio Code can help. Select and hold (or right-click) the name of a parameter anywhere in your file and select **Find All References**.

   Does the template need to specify the list of allowed values for the `skuName` parameter? What resources are affected by choosing different values for these parameters? Are there better names that you can give the parameters?

   > [!TIP]
   > When you rename identifiers, you need to make sure you rename them consistently in all parts of your template. This is especially important for parameters, variables, and resources that you refer to throughout your template.
   >
   > Visual Studio Code offers a convenient way to rename symbols: select the identifier you want to rename, press <kbd>F2</kbd>, enter a new name, and press <kbd>Enter</kbd>:
   >
   > :::image type="content" source="../media/6-rename-symbol.png" alt-text="Screenshot from Visual Studio Code showing how to rename a symbol." border="true":::
   >
   > This renames the identifier and automatically updates all of the references to it as well.

1. The `managedIdentityName` parameter doesn't have a default value. Could you fix that, or better yet, create the name automatically within the template?

1. Look at the `roleDefinitionId` parameter definition:

   ::: code language="bicep" source="code/2-template.bicep" range="27" :::

   Why is there a default value of `b24988ac-6180-42a0-ab88-20f7382dd24c`? What does that long identifier mean? How would someone else know whether to use the default value or override it? What could you do to improve this? Does it even make sense to have this as a parameter?

   > [!TIP]
   > That identifier is the _Contributor_ role definition ID for Azure. How can you use that information to improve the template?

1. When someone deploys the template, how will they know what each parameter is for? Can you add some descriptions to help your template's users?

## Add a configuration set

1. You speak to your colleagues and decide to use different SKUs for each resource depending on the environment being deployed. You decide on these SKUs for each of your resources:

   | Resource | SKU for production | SKU for non-production |
   |-|-|-|
   | App Service plan | S1, two instances | F1, one instance |
   | Storage account | GRS | LRS |
   | SQL database | S1 | Basic |

1. Can you provide a configuration set to simplify the parameters?

## Update the symbolic names

Take a look at the symbolic names for the resources in the template. What could you do to improve them?

1. Your Bicep template contains resources with several different capitalization styles for their symbolic names, such as:

   - `storageAccount` and `webSite`, which use camel case.
   - `roleassignment` and `sqlserver`, which use flat case.
   - `sqlserverName_databaseName` and `AppInsights_webSiteName`, which use snake case.
   
   Can you fix these to use one style consistently?

1. Look at this role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="145-153" :::

   Is the symbolic name descriptive enough to help someone else work with this template?

   > [!TIP]
   > The reason the identity needs a role assignment is that the web app uses its managed identity to connect to the database server. Does that help you to clarify this in the template?

1. There are a few resources with symbolic names that don't reflect the current names of Azure resources:

   ::: code language="bicep" source="code/2-template.bicep" range="94,101, 103,127, 140,143" :::

   Managed identities used to be called _MSIs_, App Service plans used to be called _hosting plans_, and App Service apps used to be called _websites_.

   Can you update these to the latest names, to avoid confusion in the future?

## Simplify the blob container definitions

1. Look at how the blob containers are defined:

   ::: code language="bicep" source="code/2-template.bicep" range="52-56, 91-93" :::

   One of them uses the `parent` property, and the other doesn't. Can you fix these to be consistent?

1. The names of the blob containers won't change between environments. Do you think the names need to be specified using parameters?

1. There are two blob containers. Could they be deployed using a loop?

## Update the resource names

1. There are some parameters that explicitly set resource names:

   ::: code language="bicep" source="code/2-template.bicep" range="26-30" :::

   Is there another way you could do this?

   > [!CAUTION]
   > Remember that resources can't be renamed. When you modify templates that are already in use, be careful when you change the way the template creates resource names. If the template is redeployed and the resource has a new name, Azure will create another resource - and it might even delete the old resource if you deploy in _Complete_ mode.
   >
   > You don't need to worry about this here, since this is just an example.

1. Your SQL logical server's resource name is set using a variable, even though it needs a globally unique name:

   ::: code language="bicep" source="code/2-template.bicep" range="33" :::

   How could you improve this?

## Update dependencies and child resources

1. Here's one of your resources, which includes a `dependsOn` property - does it really need it?

   ::: code language="bicep" source="code/2-template.bicep" range="80-89" highlight="7-9" :::

1. Notice how these child resources are declared in your template:

   ::: code language="bicep" source="code/2-template.bicep" range="68-89" highlight="2, 14" :::

   How could you modify how these resources are declared? Are there any other resources in the template that should be updated too?

## Update property values

1. Take a look at the properties of the SQL database resource:

   ::: code language="bicep" source="code/2-template.bicep" range="68-78" highlight="5, 8-9" :::

   Does it make sense to hard-code the SKU's `name` property value? And what are those weird-looking values for the `collation` and `maxSizeBytes` properties?

   > [!TIP]
   > The `collation` and `maxSizeBytes` properties are set to the default values. If you don't specify the values yourself, the default values will be used. Does that help you to decide what to do with them?

1. Can you change the way the storage connection string is set so that the complex expression isn't defined in-line with the resource?

   ::: code language="bicep" source="code/2-template.bicep" range="103-127" highlight="14" :::

## Order of elements

1. Are you happy with the order of the elements in the file? How could you improve the readability of the file by moving the elements around?

1. Take a look at the `databaseName` variable - does that belong where it is now?

   ::: code language="bicep" source="code/2-template.bicep" range="67-78" highlight="1" :::

1. Did you notice the commented-out resource, `webSiteConnectionStrings`? Do you think that needs to be in the file?

## Add comments, tags, and other metadata

Think about anything in the template that might not be obvious, or that needs some extra explanation. Can you add comments to make it clearer for someone else who opens the file in the future?

1. Take a look at the `webSite` resource's `identity` property:

   ::: code language="bicep" source="code/2-template.bicep" range="103-127" highlight="22" :::

   That syntax is strange, isn't it? Do you think this needs a comment to help explain it?

1. Look at the role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="145-153" highlight="2" :::

   The name of the resource uses the `guid()` function. Would it help to explain why?

1. Can you add a description to the role assignment?

1. Can you add a set of tags to each resource?

## Suggested solution

Here's an example of how you might refactor the template. Your template might not look exactly like this, since you may have a different style.

::: code language="bicep" source="code/6-template.bicep" :::

> [!TIP]
> If you're working with your colleague using GitHub or Azure Repos, this would be a great time to submit a _pull request_ to integrate your changes into the main branch. It's a good idea to submit pull requests after you do a piece of refactoring work.