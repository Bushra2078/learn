<!--
Provide a scenario of a real-world job-task that shows how the technology is used in practice:

TODO WRITE SCENARIO https://review.docs.microsoft.com/en-us/help/learn/id-guidance-scenarios?branch=master
-->

Many organizations are investing in IoT to increase operational efficiency, deliver better customer experiences, increase levels of security, enhance workplace safety, and reduce costs. Azure SQL Database provides a price-performant backend, including templates that simplify deploying and configuring for any scenario.

Suppose you work for a distributor and your role is to manage the logistics of shipping goods between the main warehouses. These goods are shipped via trucks. Due to the distance between the warehouses, sometimes a truck can drive 2-3 days without stopping at a warehouse. It is your responsibility to make sure the trucks show up on time. One key consideration is the maintenance of the trucks. At the main warehouses, there is a dedicated team for addressing any issues or maintenance with the truck. If a truck breaks down or needs unexpected maintenance when it is either scheduled to be driven or is not at a main warehouse, big delays and expenses are incurred. You want to implement a system that uses IoT devices to monitor the health of your fleet. Due to the size of the fleet, you need a system that can ingest thousands of entries per second, have unlimited storage, and help you perform preventative maintenance to prevent delays and extra expenses.

In this module, you will deploy a baseline IoT solution that leverages Azure SQL Database Hyperscale as the backend database. First, you'll analyze the solution architecture and how it can be used for IoT solutions. Next, you'll deploy the solution template and configure the device simulator. Finally, you'll implement, monitor, and react to a workload, using tools like Azure Functions, Azure IoT Hub, and dashboards.

By the end of the module, you'll be able to use the template provided to create scalable IoT solutions and apply it to a variety of IoT use cases.
