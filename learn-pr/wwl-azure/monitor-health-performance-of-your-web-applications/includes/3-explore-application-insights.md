Application Insights, a feature of Azure Monitor, is an extensible Application Performance Management (APM) service for developers and DevOps professionals. Use it to monitor your live applications. It will automatically detect performance anomalies, and includes powerful analytics tools to help you diagnose issues and to understand what users actually do with your app. It's designed to help you continuously improve performance and usability.

## How Application Insights works

You install a small instrumentation package (SDK) in your application or enable Application Insights using the Application Insights Agent when supported. The instrumentation monitors your app and directs the telemetry data to an Azure Application Insights Resource using a unique GUID that we refer to as an Instrumentation Key.

You can instrument not only the web service application, but also any background components, and the JavaScript in the web pages themselves. The application and its components can run anywhere, it doesn't have to be hosted in Azure.

In addition, you can pull in telemetry from the host environments such as performance counters, Azure diagnostics, or Docker logs. You can also set up web tests that periodically send synthetic requests to your web service.

All these telemetry streams are integrated into Azure Monitor. In the Azure portal, you can apply powerful analytic and search tools to the raw data. The impact on your app's performance is small. Tracking calls are non-blocking, and are batched and sent in a separate thread.

## What Application Insights monitors

Application Insights is aimed at the development team, to help you understand how your app is performing and how it's being used. It monitors:

* Request rates, response times, and failure rates: Find out which pages are most popular, at what times of day, and where your users are. See which pages perform best. If your response times and failure rates go high when there are more requests, then perhaps you have a resourcing problem.
* Dependency rates, response times, and failure rates: Find out whether external services are slowing you down.
* Exceptions: Analyze the aggregated statistics, or pick specific instances and drill into the stack trace and related requests. Both server and browser exceptions are reported.
* Page views and load performance: Reported by your users' browsers.
* AJAX calls from web pages: Rates, response times, and failure rates.
* User and session counts.
* Performance counters from your Windows or Linux server machines, such as CPU, memory, and network usage.
* Host diagnostics from Docker or Azure.
* Diagnostic trace logs from your app - so that you can correlate trace events with requests.
* Custom events and metrics that you write yourself in the client or server code, to track business events such as items sold or games won.
