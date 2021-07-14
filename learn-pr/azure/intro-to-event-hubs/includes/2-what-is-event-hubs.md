Event Hubs is one of three types of message broker available on Azure. Message brokers act as intermediaries between event producers, such as mobile phone apps, and event consumers, like dashboards or data processing pipelines. Event Hubs acts as a large buffer for incoming information (rather than commands) sent by producers that are safe to be processed asynchronously. Consumers can then pull from that queue and process the data on their own schedule.

For example, in our security company scenario, Event Hubs might receive event information from home sensors, and store them in memory. The processing server pulls this information from Event Hubs and processes it on a best-effort basis, allowing near real-time information on customer’s monitoring webpages, and detection of events designed to trigger a security response.

## Why would I want a message broker?

Message brokers logically and temporally decouple event producers from event consumers. The major benefit of this is a more modular pipeline that is more easily scaled and typically more reliable than a tightly coupled system.

### Temporal Decoupling

The temporal decoupling provided by message brokers means that the event producer and event consumers don’t need to run concurrently. In other words, the producer can send a message (data) without the consumer being available, and the consumer can process information without the producer being available. This can provide stronger guarantees of messages being received and means that producers aren't blocked while consumers are processing data.

### Load Balancing and Load Leveling

Because of their limited responsibility, Event Hubs is better able to handle sudden influxes of traffic than a directly coupled consumer that needs to spend time processing each message. As consumers pull data at their own rate, they avoid being overloaded at any given moment and can process any backlog during moments of lower traffic. What's more, Event Hubs supports multiple concurrent consumers, potentially making load balancing simpler to achieve than with a directly coupled model. In addition, if a consumer fails, the message persists on Event Hubs, and so can be processed either by another consumer or when the original consumer comes back online.

![Diagram showing how event hubs splits up consumers of events.](../media/2-event-hubs-consumers.png)

## Event Hubs is a versatile service

Event Hubs is a fully managed platform-as-a-service. It simplifies the creation and maintenance of reliable, scalable data pipelines. Data can be compiled and organized from multiple sources, before it’s stored or sent to an event consumer. You’re provided with a single platform for your systems to ingest, buffer, store, and process data, at scale, while multiple clients with multiple purposes can receive and process the same message.

Event Hubs is compatible with a wide variety of languages and tools. **Data can be read and processed using languages such as Python and Go**, and it’s compatible with common protocols, Apache Kafka applications, the Spring Framework for Java, and more. Further, Event Hubs emits exhaustive metrics that provide the state of your resources to Azure Monitor. They also let you assess the overall health of the Event Hubs service not only at the namespace level but also at the entity level.

## When is Event Hubs a suitable solution?

Event Hubs is specifically suited for ingesting high volumes of messages quickly and reliably. This means that it’s suitable for receiving data from thousands, or more, event publishers simultaneously and ensuring this data is stored in a non-volatile state. It supports connection mechanisms like *Advanced Message Queuing Protocol* (AMQP) and *WebSockets* to support low-bandwidth and low-latency message delivery. For example, this might allow monitoring of firewall activity or processing of live website use to rapidly update product recommendations.

There are scenarios where other message brokers are more suitable than Event Hubs. Event Hubs can enable near real-time responses to messages. However, due to its asynchronous nature, Event Hubs is not always the best choice if the event creators are critically dependent on specific actions taking place in a specific window of time.

Event Hubs is also not the best choice when delivery of all information is absolutely business critical. Event Hubs can guarantee at least once delivery to its singular Capture consumer, but if your application has multiple groups that consume the same messages, then your client application is responsible for connecting to and consuming the events while they're still in the cache. The cache lifetime is configurable, and defaults to 24 hours, but if some downtime prevents your consumer applications from running, you may miss those events.

If Event Hubs isn't the perfect fit for your problem, Azure provides other messaging services. These include:

* **Azure Service Bus**, which uses a pull model, similarly to Event Hubs, but is designed for the delivery of mission-critical commands for which a delivery guarantee is required.
* **Azure Event Grid**, which uses a push rather than pull model. This follows a publisher-subscriber pattern, whereby a source (such as a mobile app) triggers an event that is pushed to all subscribers or discarded if no subscribers exist.