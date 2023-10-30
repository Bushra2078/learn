In the last unit, you identified the types of sites and zones you'll need for your car manufacturing organization. This unit considers the types of sensor management methods you need. Specifically, the type of cloud-connected sensor that best fits your organizational needs.
<!-- 
    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

## Cloud-connected sensors

A cloud-connection has on-premises sensors connected to Defender for IoT via Azure. Sensor detected data is displayed in the sensor console and delivered to Azure for analysis and sharing. Microsoft threat intelligence packages can be pushed automatically to cloud-connected sensors.

### Connection types

 Consider what type of connection methods to use for your cloud-connected sensors. Possible types include:

- Proxy connections with an Azure proxy
- Proxy connections with proxy chaining
- Direct connections
- Multicloud connections

Use the following questions to help you choose the right connection for your manufacturing organization.

#### Proxy connections with an Azure proxy

- Do you need private connectivity between your sensor and Azure?
- Is your site connected to Azure via ExpressRoute, or over a VPN?

If your answers to these questions are *Yes*, use a proxy connection with an Azure proxy.

In the following image sensors are connected to the Defender for IoT portal in Azure through a proxy in the Azure virtual network to ensure communication confidentiality.

:::image type="content" source="../media/4-proxy.png" alt-text="Diagram of a proxy connection using an Azure proxy." border="false":::

#### Proxy connections with proxy chaining

- Does your sensor need a proxy to reach the cloud from the OT network?
- Do you want multiple sensors to connect to Azure through a single point?

If your answers to these questions are *Yes*, use a proxy connection with proxy chaining.

In the following image, sensors connect to the Defender for IoT portal in Azure through multiple proxies.

:::image type="content" source="../media/4-proxy-chaining.png" alt-text="Diagram of a proxy connection using proxy chaining." border="false":::

#### Direct connection

- Do you want to connect your sensor to Azure directly?

If so, you don't need a proxy at all. The following image shows an example of how you can connect your sensors to the Defender for IoT portal in Azure directly over the internet.

:::image type="content" source="../media/4-direct.png" alt-text="Diagram of a direct cloud connection." border="false":::

#### Multicloud connections

- Do you have sensors hosted in multiple public clouds?

If so, consider which connectivity method to use:

- **Public IP addresses over the internet**- use if you *don't* need to exchange data using private IP addresses.
- **Site-to-site VPN over the internet**- use if you *don't* need:

  - Predictable throughput
  - SLA
  - High data volume transfers
  - to avoid connections over the public internet
- **ExpressRoute** - use if you *do* need:
  - Predictable throughput
  - SLA
  - High data volume transfers
  - To avoid connections over the public internet

If you choose ExpressRoute, use with:

- Customer-managed routing if you *do* want to own and manage the routers making the connection.
- A cloud exchange provider if you *don't* need to own and manage the routers making the connection.

<!-- Pattern for complex chunks (repeat as needed) -->
<!-- ## Air-gapped locally connected sensors

An air-gapped on-premises sensor connection isn't connected to the cloud. This is for when you want to isolate your network from the cloud or other networks for security reasons. For instance, an automotive manufacturing organization that produces only military or autonomous vehicles might choose this option.

With Air-gapped connections:

- Specific sensor data must be viewed from the sensor console.
- The on-premises management console can be used to manage air-gapped sensors and to view aggregated data and configure settings.
- You must manually upload any threat intelligence packages to locally managed sensors.
- Sensor names are updated in the sensor console.

## Hybrid connection

A hybrid sensor connection includes sensors connected to the cloud as well as locally managed sensors. For instance, in an automotive manufacturing organization which has networks which require isolation in addition to networks which can take advantage of the cloud connection. -->

## Sensor management

All data collection, processing, analysis, and alerting takes place directly on the sensor. Only telemetry and insights are transferred on for management to the Azure portal.

## Knowledge check
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->