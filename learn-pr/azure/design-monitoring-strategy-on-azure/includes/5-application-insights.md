The last time issues arose on your organization's application, customers couldn't access their accounts. Also, the issues with the application weren't resolved on time so customer satisfaction was affected. Your organization wants to avoid a repeat of these issues when they move to Azure.

You'll detail how to integrate Azure Application Insights with your applications. You'll explore how to use it to continuously check the health of applications, and resolve issues faster. And you'll cover how to continuously monitor release pipelines to improve the development lifecycle of your applications.

## Criteria for assessing Application Insights

You use Application Insights if:

- You want to analyze and address issues and problems affecting your application's health.
- You want to improve your application's development lifecycle.
- You want to analyze users' activities to help understand them better.

## How to integrate Application Insights with your applications

To integrate Application Insights with your applications, you set up an Application Insights resource in the Azure portal. You'll also install an instrumentation package in your application. The package will monitor your application and send log data to the Log Analytics workspace.

For example, in your JavaScript web applications, you'll use a Node.js SDK as the instrumentation package. You'll need the Application Insights resource's Instrumentation Key that you can get from the Azure portal. You're going to use the key in your application's code.

 ![Instrumentation key](../media/5-instrumentation-key.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/nodejs/instrumentation-key-001.png -->

You'll then need to add the Node.JS library via the package.json as a dependency, using npm.

``` bash
npm install applicationinsights --save
```

Your code needs to load the library.  You load it before everything else, including other `require` statements. You'll need to add the following code to your top-level .js file:

```javascript
const appInsights = require("applicationinsights");
appInsights.setup("<your-instrumentation_key>");
appInsights.start();
```

You also use the environment variable *APPINSIGHTS_INSTRUMENTATIONKEY* to hold your key. The environment variable helps keep the key invisible in commits when you're using version control.

The SDK automatically gathers data about your Node.JS runtime as you use your application. When the data has been generated, you can view it in the Application Insights dashboard, in the Azure portal. From there you can, for example, get a list of all failures that have been collected and drill down into each one.

![Failures](../media/5-failures.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-runtime-exceptions/failed-requests-blade.png -->

The SDK will also analyze your application for a typology. You'll see this typology through the **Application map** option. View more details of each component in the map by selecting it. You can, among other things, view the top slowest requests for an instance and investigate performance further. These detailed analytics help you understand the application better and respond to its needs.

![Application map](../media/5-application-map.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/nodejs/application-map-002.png -->

## How to continuously monitor your applications

Application Insights can send alerts for various issues, such as failures, or your application becoming unavailable. You can create availability tests to continuously monitor the health of your applications. Availability tests allow you to check the health of your application from different geographic locations around the world.

![Availability test results](../media/5-availability-results.png)

<!-- TODO: please feel free to update to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-alert/add-test-001.png -->

You can create an availability test in the Azure portal. Among other things, you'll need to specify the frequency, the URL of your application, and locations from which to test it.

![Create availability test](../media/5-create-availability-test.png)

<!-- TODO: please feel free to update to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-alert/create-test-001.png -->

In the above example, you see a test being configured that will send a request to an application every five minutes. The test is done from five geographic locations. If you enable **Near-realtime** for the alert type, you're telling Application Insights to send alerts in near-realtime. When you enable this alert type, you'll need to configure an alert rule for it.

![Configuring an alert rule](../media/5-alert-rule.png)

<!-- TODO: please feel free to update to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-alert/save-alert-001.png -->

You specify under which conditions this alert should be triggered, for example, if a certain number of locations are unavailable. And you specify who should be notified. Send notifications through email or text message, or use runbooks, and webhooks to respond to alerts in an automated fashion.

![Locations](../media/5-availability-in-locations.png)

<!-- TODO: please feel free to update to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-alert/test-details-001.png -->

When your availability test has been created, you'll see how your application is doing across different locations. Each dot in the example above represents a test that's been run. A red dot means there's a failed test. You can find more information about a failed test when you select a dot.

![Detailed test](../media/5-detailed-test.png)

<!-- TODO: please feel free to update to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/learn/media/tutorial-alert/test-result-001.png  -->

You'll then see a detailed breakdown of the failed test, including information on what might have caused it. Use the information to respond appropriately.

## How to continuously monitor your release pipelines

Application Insights works with Azure Pipelines. Use them together to improve your development lifecycle. When an Azure Pipelines release pipeline receives an alert from Application Insights that something went wrong, it can stop the deployment. It then rolls back the deployment until the issue that caused the alert is resolved. This way, you respond much earlier and more effectively to issues as they arise in the development lifecycle.

When you create a new release pipeline in Azure Pipelines, you'll need to use the **Azure App Service deployment with continuous monitoring** template and apply it to your pipeline.

![Pipeline](../media/5-pipeline-template.png)

<!-- TODO: please feel free to update to Learn standards.  Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/continuous-monitoring/001.png -->

It will automatically create a pipeline stage. View the stage tasks in your stage to configure the connection between your pipeline and Application Insights.

![Stage](../media/5-pipeline-stage.png)

You'll need to provide details about your application and the Application Insights resource, then save your configuration.

![Link to Application Insights](../media/5-new-link-insights-app-service.png)

The **Azure App Service deployment with continuous monitoring** template provides alert rules for server exceptions, failed requests, server response times, and availability. You can also modify alert rules and customize them for your specific needs.

![Deployment conditions](../media/5-predeployment-conditions.png)

<!-- original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/continuous-monitoring/004.png -->

Add a continuous monitoring gate to your release pipeline. Use the gate to stop deployment when an issue has been identified, and continue deployment automatically when the issue is resolved. First, you'll need to enable gates in the pre-deployment conditions configuration, then add the gate you want. You can, for example, add a gate that will listen for active alerts, as shown below.

![Deployment gate](../media/5-deployment-gate.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/continuous-monitoring/005.png  -->

Analyze your release by viewing the logs in the release summary. You'll see all of your release steps, and whether each has succeeded or failed. You'll also see details of what caused a failure.

![Release logs](../media/5-release-logs.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/app/media/continuous-monitoring/006.png -->