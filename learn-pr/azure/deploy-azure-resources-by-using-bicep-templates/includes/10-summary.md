Your company needs to launch new toys regularly to stay competitive. The shorter the time to market, the better. 

You've created a template that will deploy a website and storage resources. This template is reusable for future product launches, which means you've significantly cut the time it takes to launch a new product.

You created a Bicep template to deploy a basic storage account, an Azure App Service plan, and an application. You parameterized the template to make it generalizable for future products. You then refactored it into modules to make the template more reusable, as well as easier to understand and work with. Finally, you added an output to send information from a template deployment back to the person or tool that's executing the deployment.

Imagine how much work it would be to deploy these resources for each new product launch. You'd have to manually provision the resources and remember to configure them correctly each time.

Bicep makes it easy to describe your Azure resources and create reusable templates. You can parameterize the templates, and use modules to separate your templates into different components that you can reuse and work on individually. 

Now, when you want to prepare your resources for the next product launch, you can use the Bicep template that you created with parameter values that are unique to the product launch. Your company can quickly and easily provision its Azure resources.

## References

- [Template reference for each Azure resource type](/azure/templates/)
- [Template functions](/azure/azure-resource-manager/templates/template-functions)
