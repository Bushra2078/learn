In this unit, we look at Azure scaling concepts.

## Why care about scaling

A primary advantage of the cloud is elastic scaling - scale **out** by adding application instances based on increased demand. You can use as much capacity as you need, scaling out as load increases, and scaling **in** when the extra capacity isn't needed.

A classic example of the need for elasticity occurs when an organization's web site experiences unusually high loads. If the site can't scale to meet demand, requests take longer to process because they're queued waiting for processor time. To the customer, the site seems slow and unresponsive. In extreme cases, the site might even appear to be down.

Some loads are unpredictable. For example, the Covid-19 lowdowns triggered a massive surge in many companies e-commerce traffic. IT teams where still managing their infrastructure manually, and the scale-outs were time consuming. Now, with scale automation, teams can achieve that same degree of expansion automatically. Other loads are also as unpredictable. They may occur because a tweet went viral or our favorite team won the World Cup, or because other factors that an organization can't expect.

### Manual vs Automatic scale

You can configure scale settings for an application with either two modes manual or automatic. Manual is as you would expect, you set the absolute count of instances. Automatic (autoscale) however allows you to set rules that govern how and by how much you should scale.

Autoscale allows you to have the right amount of resources running to handle the load on your application. Autoscaling eases management overhead by reducing the need for system operators to constantly make decisions about adding or removing resources or checking the system's performance. Having a minimum makes sure your application is always running even under no load. Having a maximum limits your total possible hourly cost. You automatically scale between these two extremes using rules you create.

:::image type="content" source="../media/computesaving.jpg" alt-text="save on compute" lightbox="../media/computesaving.jpg":::

## "Out" vs "Up"

There are two main ways that an application can scale:

- Vertical scaling, also called scaling **up** and **down**, means changing the capacity of a resource. For example, you could move an application to a larger compute size. Vertical scaling often requires making the system temporarily unavailable while it's being redeployed. So, it's less common to automate vertical scaling.

- Horizontal scaling, also called scaling **out** and **in**, means adding or removing instances of a resource. The application continues running without interruption as new resources are provisioned. When the provisioning process is complete, the solution is deployed on these extra resources. If demand drops, the extra resources can be shut down cleanly and de-allocated.

Autoscale only scales "**out**" (horizontally), which is an increase ("**out**") or decrease ("**in**") in the number of application instances.

:::image type="content" source="../media/outvsup.png" alt-text="scaleup vs scale out difference" lightbox="../media/outvsup.png":::

## Autoscale in Azure Spring Cloud

Autoscaling in Azure Spring Cloud monitors the resource metrics of a Spring application as it runs. It detects situations where extra resources are required to handle an increasing workload, and ensures those resources are available before the system becomes overloaded. Autoscale is a built-in feature of Azure Spring Cloud that helps microservice applications do their best when demand changes.

## Real-world example

Raley’s grocery stores needed to modernize the code and infrastructure for their Java-powered e-commerce sites hosted on Azure. The company also needed to optimize and automate its network allocation. Everything had to be robust, always-on, and—most importantly—easy to manage.

Raley’s chose Azure Spring Cloud. Azure Spring Cloud is a managed service for Spring Boot, which provides the power of Kubernetes, coupled with real-time monitoring and autoscaling. It also enabled Raley’s to adopt a true platform as a service (PaaS) architecture, seizing the benefits of the cloud more fully.

The service manages the infrastructure of Spring Boot microservice applications behind the scenes, so developers can focus on their code. When Java libraries or code is deployed, Spring Cloud automatically wires the apps with the Spring service runtime.

After they’re deployed, Spring Cloud apps are fully integrated with Azure Monitor tools, like Application Insights and Log Analytics, allowing easy, fully configurable monitoring of performance and errors. These same monitoring services can also drive autoscaling, helping to ensure that resources are appropriately sized for current loads.

:::image type="content" source="../media/autoscaleconcept.png" alt-text="autoscale up scaling" lightbox="../media/autoscaleconcept.png":::
