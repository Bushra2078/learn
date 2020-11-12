:::image type="content" source="../media/adt-solutions.png" alt-text="Diagram of an Azure Digital Twins solution steps" lightbox="../media/adt-solutions.png":::

In a solution context, Azure Digital Twins is the platform that allows you to model any environment, connect sensors, and business systems to the model to control the present, track the past, and predict the future.

To enable this promise, a typical customer would need to model their environment using the Digital Twin Definition Language (DTDL), and keep this model of their environment live with the data coming from their operational systems (i.e. IoT data) as well as the data coming from their business systems such as CRM, ERP, HR, Finance, etc. The insights that are generated in the digital twin would then need to be plugged into business systems to drive action, and close the digital feedback loop.

:::image type="content" source="../media/adt-overview.png" alt-text="Diagram of the sources, and uses of Azure Digital Twins" lightbox="../media/adt-overview.png":::

:::image type="content" source="../media/adt-dataflow.png" alt-text="Diagram of the data flow in digital twins solutions" lightbox="../media/adt-dataflow.png":::

## Open Modelling Language (DTDL)

Real world environments in Azure Digital Twins are modeled as a topology graph. The entities that make up the graph are called twins, and each type of twin is described as a collection of Properties, Telemetry, Commands, Relationships, and Components. Twin definitions are expressed in Digital Twins Definition Language (DTDL), a simple language based on JSON-LD.

## Live Execution Environment

Azure Digital Twins (ADT) is a live execution environment to bring your digital twins to life in a live graph representation.

Once you have defined your custom business vocabulary in ADT, you can create a graph of twins. Typically, customers do this programmatically, driving the topology with data already available in other databases, for example Building Information Management systems.

In ADT, all data changes generate events. Incoming telemetry, property changes to the graph, creation, or deletion of twins all result in events that custom business logic can react to. Developers can define event handlers for processing events within the graph, and propagate data through the graph.

ADT also provides a powerful query system to extract insight from your modeled environment.

## Input from IoT & Business Systems

Input from IoT, and business systems can be fed into Azure Digital Twins to connect assets, including IoT devices using Azure IoT Hub, Azure Logic Apps, and REST APIs.

You can use IoT Hub to connect to IoT, and IoT Edge devices to keep the live execution environment up to date with operational data.

IoT data is not a mandatory component for your digital twin solutions. You can also drive Azure Digital Twins from other data sources using REST APIs or creating Azure Logic Apps connectors based on the system you want to collect data from. A combination of different data sources, either IoT or not, can be the feeding mechanism for your digital twin.

## Output to Time Series Insights, storage, and analytics

Azure Digital Twins provides means to output insights to external services such as Time Series Insights, storage, and analytics using event routes to downstream services including Azure Synapse Analytics.

Developers can define event routes that send selected data out to downstream services. Supported endpoints include EventHub, Event Grid or Service Bus.

Examples include cold storage, for example Azure Data Lake, machine learning or other analytics with Azure Synapse or workflow integration with Logic Apps.

Integration with Time Series Insight can be used to track data over time and apply historian analytics.

## What a Digital Twin Solution Architecture looks like

:::image type="content" source="../media/adt-architecture.png" alt-text="Graphical representation of a Digital Twin solution architecture" lightbox="../media/adt-architecture.png":::
