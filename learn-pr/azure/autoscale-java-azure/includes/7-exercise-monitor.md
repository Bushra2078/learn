In this exercise, with zero configuration, you'll effortlessly monitor autoscaling for your sample application.

## Monitor the Application's autoscale with Log Analytics

You can validate the evaluations and scale actions better using Log Analytics. In your sample application, we've routed your autoscale logs to Azure Monitor Logs (Log Analytics) through a Log Analytics workspace you created with your sample application setup.

## Use Log Analytics

1. In the Azure portal, go to your Azure Log Analytics instance.
1. To open the Log Search pane, select Logs.
1. In the Tables search box
1. To get started, try this query to view the most recent autoscale evaluation logs:

```Kusto
AutoscaleEvaluationsLog
| limit 50
```

Or try the following query to view the most recent scale action logs:

```Kusto
AutoscaleScaleActionsLog
| limit 50
```

Use the following sections to  these questions.

## A scale action occurred that I didn’t expect

First execute the query for scale action to find the scale action you are interested in. If it is the latest scale action, use the following query:

```Kusto
AutoscaleScaleActionsLog
| take 1
```

Select the CorrelationId field from the scale actions log. Use the CorrelationId to find the right Evaluation log. Executing the below query will display all the rules and conditions evaluated leading to that scale action.

```Kusto
AutoscaleEvaluationsLog
| where CorrelationId = "<correliationId>"
```

## What profile caused a scale action?

A scaled action occurred, but you have overlapping rules and profiles and need to track down which caused the action.

Find the correlationId of the scale action (as explained in example 1) and then execute the query on evaluation logs to learn more about the profile.

```Kusto
AutoscaleEvaluationsLog
| where CorrelationId = "<correliationId_Guid>"
| where ProfileSelected == true
| project ProfileEvaluationTime, Profile, ProfileSelected, EvaluationResult
```

The whole profile evaluation can also be understood better using the following query

```Kusto
AutoscaleEvaluationsLog
| where TimeGenerated > ago(2h)
| where OperationName contains == "profileEvaluation"
| project OperationName, Profile, ProfileEvaluationTime, ProfileSelected, EvaluationResult
```

## A scale action did not occur

If you expected a scale action, and it did not occur, there might have been no scale action events.

Review the autoscale metrics if you are using a metric-based scale rule. It's possible that the **Observed metric value** or **Observed Capacity** are not what you expected them to be and therefore the scale rule did not fire. You would still see evaluations, but not a scale-out rule. It's also possible that the cool-down time kept a scale action from occurring.

Review the autoscale evaluation logs during the time period you expected the scale action to occur. Review all the evaluations it did and why it decided to not trigger a scale action.

```Kusto
AutoscaleEvaluationsLog
| where TimeGenerated > ago(2h)
| where OperationName == "MetricEvaluation" or OperationName == "ScaleRuleEvaluation"
| project OperationName, MetricData, ObservedValue, Threshold, EstimateScaleResult
```

## Scale action failed

There may be a case where autoscale service took the scale action but the system decided not to scale or failed to complete the scale action. Use this query to find the failed scale actions.

```Kusto
AutoscaleScaleActionsLog
| where ResultType == "Failed"
| project ResultDescription
```
