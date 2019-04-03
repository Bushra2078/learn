<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u02_data_centers\_u02_m04_programming_the_cloud\x-oli-workbook_page\_u02_m04_7_economics.xml -->

CSPs are taking great pains to attract users from their traditional deployments. Public IaaS cloud prices have been steadily and steeply falling ever since the launch of their services. On average, for most major CSPs, prices have fallen by 20-30% per year since 2013. 

![Figure 2.37: Average cost reduction of CSP Services](../media/cost_reductions.png)

_Figure 2.37: Average cost reduction of CSP Services_

However, despite these decreasing prices, cloud adoption still must be done with care. To truly gain the cost benefits of the cloud, it is important to understand, budget, plan, monitor and carefully analyze your usage. Also, it is difficult to choose between CSPs for individual use cases, since there is no standard way for CSPs to package resources, nor do they always follow the same pricing models. 

##  Pricing Models

Cloud providers generally charge for resources based on one of the following 3 types of parameters: 
1. **Time Based**: Resources are charged based on the amount of time they are provisioned to the user. For example, you pay a certain amount per hour/day/month/year to have a virtual machine running on an IaaS cloud. The granularity of the charging period varies from cloud provider to cloud provider. Amazon, for example charges users per hour on a non-prorated basis.
1. **Capacity Based**: Users are charged based on the amount of a particular resource that is utilized or consumed. This is a popular charging model for cloud storage systems. For example, users are charged a certain amount for storing a gigabyte on cloud object storage systems such as S3 and Azure Blobs.
1. **Performance Based**: In many cloud providers, users can select a higher performance level for resources by paying a higher rate. For virtual machines, larger, more powerful machines with more CPU, Memory and Disk capacity can be provisioned at a higher hourly rate.

Based on these charging parameters, CSPs, such as AWS, use one of the following common pricing models: 
1. **On-demand / pay-as-you-go pricing**: This is generally the most expensive pricing model for long-term usage. Payments are made for a very short period of usage (generally metered in minutes or hours). The advantages are that there is no need for a long-term contract, making it very flexible to scale in and out based on the current need. Although not common, it is possible for CSPs to increase costs during high demand and decrease it during low demand. This is a great model for service providers, as well as for cloud users who are just beginning to use the cloud.
1. **Reserved instances / Subscription-based pricing**: Instead of paying an hourly or per-minute rate, a user can choose to pre-pay and reserve a resource for a fairly long period of time (weeks or months). This often leads to significantly high markdowns (20-50%) but requires a long-term commitment. Within reserved pricing models, the payment schemes can vary from prepaid to contractually obliged periodic payments.
1. **Spot pricing**: Spot pricing is a way for CSPs to deal with excess unutilized capacity by offering it for sale at significantly lower prices than on-demand resources. For example,AWS often offers markdowns of 80-90% on spot EC2 resources. The prices are determined by a user auction, where users bid the maximum amount that they are willing to pay for a resource. The biggest downside is that the resources can often be terminated at any time if the spot price increases beyond the actual bid price. Spot resources are ideal for short-running, non-critical jobs that can be executed speculatively.



Generally reserved instances should be used to meet the base requirements of the system. If an application needs 2 instances 80% of the time, 3 instances 15% of the time and 4 instances 5% of the time, you would generally reserve 2 instances for the lifetime of the application and scale out either using on-demand or spot instances. As mentioned, on-demand instances should only be chosen while scaling out if the application is business critical or if the differential between the on-demand price and the current spot price is offset by the risk of sudden termination. This is often a business-case specific decision. 

##  How to Optimize Cost Utilization

To use the cloud in a cost-effective manner, enterprises must develop a mature process for choosing the resources to deploy, monitor and visualize usage, as well as a clear mechanism to identify waste and optimize utilization. 

![Figure 2.38: Cost Optimization Process](../media/cost_reductions2.png)

_Figure 2.38: Cost Optimization Process_

Before considering cost requirements, an organization must plan the amount of work that it is capable of completing in a given period based on fixed resources like the amount of staff, while dealing with physical constraints like inventory management, overhead due to transportation, material handling, etc. The provisioning of IT resources must be designed to meet or exceed the physical capacity of the organization. This is extremely important, because the elasticity provided by the cloud tempts development teams to simply add resources as needed, without considering the cost implications of their decisions. 

The first step when attempting to reduce expenditure on the cloud is to match resource types with the actual requirement for the application. This may mean selecting between EC2 VMs with different memory configurations, or number of cores. There is no simple way to do this, apart from testing and benchmarking the application across different resource types. 

Even if an application performs better on a more expensive resource class, it is important to verify if the performance improvement is proportional to the cost increase. For example, if there is a 1.2x improvement in an application using a VM that is 7.5x more expensive than the base, it might make more sense to horizontally scale out the base resource to improve the performance. 

It is important to build a monitoring and visualization system to monitor the various resources being used. The monitoring system must be designed to trigger scaling events in response to observed patterns of overload or idleness. Often, infrastructure teams choose to scale up or out aggressively, while they scale down or in more conservatively. Though this approach is more expensive in terms of resource provisioning, it theoretically provides a higher Quality of Service than operating near peak capacity all of the time. 

That being said, organizations often underestimate the need to scale down and terminate rarely used resources. When planning to run different components of an application, it is important to categorize the utilization into different bins, based on the approximate duration for which it will be used. For instance, any jobs that are run for a short time on a nightly or weekly basis should not use resources 24/7. Idle resources should also be flagged and terminated (based on certain rules) by the monitoring system. 

An important technique that ties into cost optimization is that of tagging resources. Tagging is the process of assigning labels to resources that allow them to be identified by monitoring and analytics tools. Tagging also enables custom rules to be defined per-tag, including access control lists to resources, billing alerts and specific scaling policies. Commonly used tags specify the owner (user or group) of a particular resource, the environment to which it belongs (e.g. production, backup, staging, testing), the cost center in charge of paying the bill, etc. When analyzing expenditure, this enables the generation of grouped views based on particular applications, as well as on specific development or testing teams. 

##  Case Study: Netflix's Ice System

As one of the largest AWS customers in the world, it is crucial for Netflix to have clear visibility about their expenditure. To support this requirement, they use an internally designed tool known as Ice. Ice relies on tags and resource metadata to build a dynamic dashboard that allows resources to be grouped by user, team, region, type, pricing model or any custom tag. It also supports the amortization of one time costs such as reserved instances over the lifetime of the resource. All of the data is periodically generated using AWS Billing APIs. 

![Figure 2.39: Netflix Ice](../media/netflix.png)

_Figure 2.39: Netflix Ice_

This tool has been released as a part of their Open Source initiative. Many companies (as well as CMU’s cloud computing course staff) use Ice or variants to gain insights into AWS usage and expenditure. It helps influence whether future resources should be reserved for the long-term (at cheaper prices), and identifies users or teams who overspend. All large cloud deployments should follow a similar process of planning & budgeting, monitoring & visualization, and forecasting & optimization. 