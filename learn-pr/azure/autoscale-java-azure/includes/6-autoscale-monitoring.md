In this unit, we'll look at autoscale monitoring.

## Monitoring

Similar to other Azure resources, Azure Spring cloud autoscale actions create logs.
There are two categories of logs it can create:

- Autoscale Evaluations - The autoscale engine records log entries for every single condition evaluation every time it does a check. The entry includes details on the observed values of the metrics, the rules evaluated, and if the evaluation resulted in a scale action or not.

- Autoscale Scale Actions - The engine records scale action events initiated by autoscale service and the results of those scales actions (success, failure, and how much scaling occurred as seen by the autoscale service).

## Understanding autoscale events

In the autoscale setting screen, you can go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. In addition, to find more details about all autoscale actions including operations such as update/delete autoscale settings, you can view the activity log and filter by autoscale operations.

Autoscale will post to the Activity Log if any of the following conditions occur:

- Autoscale issues a scale operation.
- Autoscale service successfully completes a scale action.
- Autoscale service fails to take a scale action.
- Autoscale detects flapping and aborts the scale attempt. You will see a log type of `Flapping` in this situation. If you see this, consider whether your thresholds are too narrow.
- Autoscale detects flapping but is still able to successfully scale. You will see a log type of `FlappingOccurred` in this situation. If you see this, the autoscale engine has attempted to scale (for example, from four instances to 2), but has determined that this would cause flapping. Instead, the autoscale engine has scaled to a different number of instances (for example, using three instances instead of 2), which no longer causes flapping, so it has scaled to this number of instances.

## Monitor the Application's autoscale with Log Analytics

As with any Azure Monitor supported service, you can use Diagnostic Settings to route these logs:

- to your Log Analytics workspace for detailed analytics
- to Event Hubs and then to non-Azure tools
- to your Azure storage account for archival

You can validate the evaluations and scale actions better using Log Analytics. In your sample application, we've routed your autoscale logs to Azure Monitor Logs (Log Analytics) through a workspace when you created the autoscale setting. In the next exercise, you'll use log analytics to find out more about the autoscale events.
