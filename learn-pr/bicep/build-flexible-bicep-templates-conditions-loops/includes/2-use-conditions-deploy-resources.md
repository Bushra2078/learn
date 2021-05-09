Conditions can be used in Bicep code to only deploy resources in certain cases.

In your toy company, you need to deploy resources to different environments. When deploying to your production environment, you need to make sure that auditing is enabled for your SQL servers. But when you deploy to your development environments, you don't want to enable auditing. You want to use single template to deploy all of your environments.

In this unit, you'll learn how to conditionally deploy resources.

## Use simple conditions

When you deploy a resource in Bicep, you can provide the `if` keyword followed by a condition. The condition should resolve to a Boolean (true or false) value. If the value is true then the resource is deployed, and if the value is false then the resource is not deployed.

It's common to create conditions based on the values of parameters that you provide. The following example deploys a storage account only when the `deployStorageAccount` parameter is set to `true`:

::: code language="plaintext" source="code/2-simple-condition.bicep" highlight="3" :::

Notice that the `if` keyword is on the same line as the resource definition.

## Use expressions as conditions

The example above was quite simple. The `deployStorageAccount` parameter was of type `bool`, so it was clear whether it had a value of true or false.

In Bicep you are also able to use expressions as condition evaluation. The following example only deploys a SQL auditing resource when the `environmentName` parameter value is equal to `Production`:

::: code language="plaintext" source="code/2-expression-condition.bicep" range="1-5, 19-23, 27-28" highlight="7" :::

## Depend on conditionally deployed resources

When resources are deployed conditionally, you sometimes need to be aware of how Bicep evaluates dependencies between resources.

Let's continue writing our Bicep code to deploy SQL auditing settings. The Bicep file also need to declare a storage account resource:

::: code language="plaintext" source="code/2-expression-condition.bicep" range="1-23, 27-28" highlight="11-18" :::

Notice that the storage account has a condition too. This means it won't be deployed for non-production environments either. The SQL server auditing settings resource can now refer to the storage account's details:

::: code language="plaintext" source="code/2-expression-condition.bicep" range="20-28" highlight="6-7" :::

Notice that this Bicep code uses the `?` operator within the `storageEndpoint` and `storageAccountAccessKey` properties. When the Bicep code is deployed to a production environment, the expressions will be evaluated to the details from the storage account. When it's deployed to a non-production environment, the expressions evaluate to an empty string (``).

You might wonder why this is necessary, since `auditingSettings` and `auditStorageAccount` both have the same condition and so we'll never need to deploy a SQL auditing settings resource without a storage account. While this is true, Resource Manager evaluates the property expressions before conditionals, so the Bicep code doesn't have this expression, the deployment will fail with a `ResourceNotFound` error.
