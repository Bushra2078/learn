Fabrikam, Inc. has recently launched a drone delivery service, to compliment their existing shipping business. The company manages and operates a fleet of drone aircraft. Businesses register with the service, and users can request a drone to pick up goods for delivery. When a customer schedules a pickup, a backend system assigns a drone and notifies the user with an estimated delivery time. While the delivery is in progress, the customer can track the location of the drone, with a continuously updated ETA.

To support this new line of business, they have integrated new capabilities into the current system they use to manage their shipping business line, which is based on a monolithic architecture. Their drone business has become popular, and is straining the performance and development of the system. Fabrikam wants to continue to iterate on their system to quickly add new functionality and capabilities, and adjust to their customer's demands. This is driving Fabrikam to evolve their application from a monolithic architecture to a microservices architecture.

Microservices have become a popular architectural style for building cloud applications that are resilient, highly scalable, independently deployable, and able to evolve quickly. In this module, we'll explore the microservices architecture, and demonstrate how to decompose a monolithic application into a microservices architecture.

<!-- This scenario involves a fairly complicated domain. Some of the business concerns include scheduling drones, tracking packages, managing user accounts, and storing and analyzing historical data. Moreover, Fabrikam wants to get to market quickly and then iterate quickly, adding new functionality and capabilities. The application needs to operate at cloud scale, with a high service level objective (SLO). Fabrikam also expects that different parts of the system will have very different requirements for data storage and querying. All of these considerations lead Fabrikam to choose a microservices architecture for the Drone Delivery application. -->

## Learning objectives

- In this module, you will:Identify the properties and benefits of a microservices application
- Decompose a monolithic application into a microservices architecture

## Prerequisites

- Basic understanding of application and system architecture
- Basic knowledge of C#