You've started to use Bicep templates for some recent product launches, and they have been very successful. Since you've declared your resources in a template file, you can quickly deploy the resources for new toy launches without needing to manually configure resources in the Azure portal.

The IT manager can see that your Bicep code is becoming more complex and has more and more resources defined, so they've asked if you can make them more _modularized_. You can create individual Bicep files, called modules, for different parts of your deployment. The main Bicep template references these modules, and behind the scenes the modules are transpiled into a single JSON template for deployment. Modules are also a way to make Bicep code even more reusable. You can have a single Bicep module that is used by lots of Bicep templates.

You also will often need to emit _outputs_ from the Bicep modules and templates. Outputs are a way for your Bicep code to send data back to whoever or whatever has initiated the deployment. Let's look at outputs first.

## Outputs

Bicep templates can be deployed manually by a human, or by some sort of automated release process. Either way, it's common to have some data from the template that you need to provide back to whoever or whatever is executing the template deployment. Here are some example scenarios where you might need to get information from the template deployment:

- You create a Bicep template that deploys a virtual machine, and you need to get the public IP address so that you can SSH into the machine.
- You create a Bicep template that accepts a set of parameters, like an environment name and an application name. The template uses an expression to create the name of an App Service app that it deploys. You need to output the name of the app the template has deployed so that it can be used within a deployment pipeline to publish the application binaries.

You can use _outputs_ for these scenarios. To define an output in a Bicep template, use the `output` keyword like this:

```bicep
output appServiceAppName string = appServiceAppName
```

The output definition includes a few key parts:

- The `output` keyword tells Bicep that you're defining an output.
- `appServiceAppName` is the name of the output. When someone executes the template successfully, the output values will include the name you specified so they can access the values they're expecting.
- `string` is the type of the output. Bicep outputs support the same types as parameters.
- A value must be specified for each output. Unlike parameters, outputs always need to have values. Output values can be expressions, references to parameters or variables, or properties of resources that are deployed within the file.

> [!TIP]
> Outputs can use the same names as variables and parameters. This can be helpful if you construct a complex expression within a variable to use within your template's resources, and then also need to expose the variable's value as an output.

Here's another example of an output - this one will have its value set to the fully qualified domain name (FQDN) of a public IP address resource:

```bicep
output ipFqdn string = publicIPAddress.properties.dnsSettings.fqdn
```

> [!TIP]
> Try to use resource properties as outputs, rather than making assumptions about how resources will behave. For example, if you need to have an output for the URL to an App Service app, use the `defaultHostname` property of the app instead of creating a string for the URL yourself. Sometimes these assumptions aren't correct in different environments, or the resources change the way they work, so it's safer to have the resource tell you its own properties. 

> [!CAUTION]
> Don't create outputs for secret values like connection strings or keys. Outputs from templates can be read by anyone with access to your resource group. There are other approaches you can use to get access to secret resource properties, which we'll cover in a later module.

## Define a module

Bicep modules enable you to organize and reuse your Bicep code by creating smaller units that can be composed together into a template. Any Bicep template can be used as a module by another template. Throughout this learning module, you've been creating Bicep templates. That means you have already created files that can be used as Bicep modules!

Imagine you have a Bicep template that deploys application, database, and networking resources for *solution A*. You could split this up into three modules, each of which is focused on its own individual set of resources. As a bonus, you can now reuse the modules in other templates for other solutions too - so when you develop a template for *solution B*, which has very similar networking requirements to *solution A*, you can reuse the networking module.

:::image type="content" source="../media/7-templates-modules.png" alt-text="Diagram showing a template for solution A referencing three modules - application, database, and networking. The networking module is then reused in another template for solution B." border="false":::

When you want the template to include a reference to a module file, use the `module` keyword. A module definition looks similar to a resource declaration, but instead of including a resource type and API version, you instead use the module filename:

```bicep
module myModule 'modules/my-module.bicep' = {
  name: 'MyModule'
  params: {
    location: location
  }
}
```

Let's look closely at some key parts of this module definition.

* The `module` keyword tells Bicep that you're about to use another Bicep file as a module.
* Just like with resources, modules need a _symbolic name_. You use the symbolic name when you refer to the module's outputs in other parts of the template.
* `modules/my-module.bicep` is the path to the module file, relative to the template file. Remember, this is just a regular Bicep file.
* Just like with resources, the _name_ property is mandatory. The name of the module is used by Azure because it creates a separate deployment for each module within the template file, and those deployments have names that you can use to identify them.
* You can specify any _parameters_ of the module using the `params` keyword. When you set the values of each parameter within the template, you can use expressions, template parameters, variables, properties of resources deployed within the template, and outputs from other modules. Bicep will automatically understand the dependency between the resources.

## Modules and outputs

Just like templates, Bicep modules can define outputs. It's common to chain modules together within a template - the output from one module can be a parameter for another module. By using modules and outputs together, you can create powerful and reusable Bicep files.

## Design your modules

A good Bicep module follows a few key principles.

> [!div class="checklist"]
>
> * **A module should have a clear purpose.** For example, you might use a module to define all of the resources that are related to a specific part of your solution. For example, you might create a module that contains all of the resources that are used to monitor your application. You might also use a module to define a set of resources that belong together, like all of your database servers and databases.
> * **Don't put every resource into its own module.** You shouldn't create a separate module for every resource you deploy. If you have a resource that has lots of complex properties then it might make sense to put it into its own module, but in general, it's better for modules to combine multiple resources together.
> * **A module should have clear parameters and outputs that make sense.** Consider the purpose of the module. Think about whether the module should be manipulating parameter values, or whether the parent template should handle that and then pass a single value through to the module. Similarly, think about the outputs that a module should return, and make sure they are useful to the templates that will include the module.
> * **A module should be as self-contained as possible.** If a module needs to use a variable to define a part of a module, the variable should generally be included in the module file rather than in the parent template.
> * **A module should not output secrets.** Just like with templates, don't create module outputs for secret values like connection strings or keys.
