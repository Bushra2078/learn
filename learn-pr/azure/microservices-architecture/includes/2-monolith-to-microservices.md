Fabrikam has integrated their new drone service into their existing application, but they realize that this isn't a good plan for their application moving forward. The existing system is a monolithic architecture, but what exactly does that mean?

## What is a monolithic architecture?

A monolithic architecture is an architecture where all components for an application are co-located within a single unit. This unit is typically constrained within a single runtime instance of the application. Traditional applications often consist of a web interface, a services layer, and a data layer. In a monolithic architecture, these are combined on an instance of the application.

![Logical diagram of a monolithic architecture](../media/2-monolith.png)

Monolithic architecture are often suitable solutions for small applications, but can become unwieldy as the application grows. What was originally a small application, can quickly become a giant ball of mud that is difficult to scale, difficult to deploy to, and difficult to innovate on.

Because the all services are contained within a single unit, it brings challenges especially as their business, and subsequent system load, grows. Some of these challenges are:

- Difficult to scale services independently
- Complex to develop and manage deployments as the codebase grows, slowing releases and new feature implementation
- Tied to a single technology stack, limiting innovation in new platforms and SDK's
- Data schema updates can be increasingly difficult

These challenges can be addressed by looking at alternative architectures, such as a microservices architecture.

## What is a microservices architecture?

A microservices architecture consists of services that are small, independent, and loosely coupled. Each service can be deployed and scaled independently.

![Logical diagram of a microservices architecture](../media/2-microservices-logical.svg)

A microservice is small enough that a single small team of developers can write and maintain it. Because services can be deployed independently, a team can update an existing service without rebuilding and redeploying the entire application.

Each service is typically responsible for it's own data. It's data structure is isolated, so that upgrades or changes to schema aren't dependant on other services. Requests for data typically is handled through API's, and provide a well-defined and consistent access model, hiding internal implementation details from service consumers.

Because each service is independent, they can leverage different technology stacks, frameworks, and SDK's. It's common to see services rely on REST calls for service-to-service communication using well-defined APIs instead of RPC or other custom communication methods.

Microservice architectures are technology agnostic, but you will often see containers or serverless technologies used for their implementation. Continuous deployment and continuous integration (CI/CD) is frequently used to increase the speed and quality of development activities.

### Benefits of a microservices architecture

Why would you choose a microservices architecture? There are several primary benefits to a microservices architecture.

#### Agility

Because microservices are deployed independently, it's easier to manage bug fixes and feature releases. You can update a service without redeploying the entire application, and roll back an update if something goes wrong. In many traditional applications, if a bug is found in one part of the application, it can block the entire release process; as a result, new features may be held up waiting for a bug fix to be integrated, tested, and published.

#### Small code, small teams

A microservice should be small enough that a single feature team can build, test, and deploy it. Small code bases are easier to understand. In a large monolithic application, there is a tendency over time for code dependencies to become tangled, so that adding a new feature requires touching code in a lot of places. By not sharing code or data stores, a microservices architecture minimizes dependencies, and that makes it easier to add new features. Small team sizes also promote greater agility. The "two-pizza rule" says that a team should be small enough that two pizzas can feed the team. Obviously that's not an exact metric and depends on team appetites! But the point is that large groups tend be less productive, because communication is slower, management overhead goes up, and agility diminishes.

#### Mix of technologies

Teams can pick the technology that best fits their service, using a mix of technology stacks as appropriate. This allows each team to evolve the technologies that support their service independently. Services can use different development languages, cloud services, SDK's, and more, because of this independent. This allows teams to pick the best options for their service, while minimizing any external impact to consumers of the service.

#### Resiliency

If an individual microservice becomes unavailable, it won't disrupt the entire application, as long as any upstream microservices are designed to handle faults correctly (for example, by implementing circuit breaking). This benefits your end users or service consumers, by creating an always-on experience for your application.

#### Scalability

A microservices architecture allows each microservice to be scaled independently of the others. That lets you scale out subsystems that require more resources, without scaling out the entire application. This not only improves the overall performance of your application, but can also help to minimize costs bye only adding more resources to services that need it, instead of scaling up your entire application.

#### Data isolation

It improves the ability to perform data schema updates, because only a single microservice is affected. In a monolithic application, schema updates can become very challenging, because different parts of the application may all touch the same data, making any alterations to the schema risky. You can update a schema, but keep your API surface intact so that service consumers have the same experience, regardless of the underlying data architecture.

### Potential challenges of a microservices architecture

While there are numerous benefits, a microservices architecture is not a fix-all, and does bring its own set of challenges.

#### Complexity

A microservices application has more moving parts than the equivalent monolithic application. Each service is simpler, but the entire system as a whole is more complex. With service discovery, orchestration, and automation tools, there can be more pieces to manage in the overall application.

#### Development and testing

Writing a small service that relies on other dependent services requires a different approach than a writing a traditional monolithic or layered application. Existing tools are not always designed to work with service dependencies. Refactoring across service boundaries can be difficult. It is also challenging to test service dependencies, especially when the application is evolving quickly.

#### Lack of governance

The decentralized approach to building microservices has advantages, but it can also lead to problems. You may end up with so many different languages and frameworks that the application becomes hard to maintain. It may be useful to put some project-wide standards in place, without overly restricting teams' flexibility. This especially applies to cross-cutting functionality such as logging and metrics.

#### Network congestion and latency

The use of many small, granular services can result in more inter-service communication. If the chain of service dependencies gets too long (service A calls B, which calls C...), the additional latency of these network calls can become a problem. You will need to design APIs carefully. Avoid overly chatty APIs, think about serialization formats, and look for places to use asynchronous communication patterns.

#### Data integrity

With each microservice responsible for its own data persistence. As a result, data consistency can be a challenge. Embrace eventual consistency where possible. You can also end up with duplicated data and a sprawling data architecture. This can increase raw storage costs as well as data platform service costs with service and data duplication.

#### Management

To be successful with microservices requires a mature DevOps culture. Correlated logging across services can be challenging. Typically, logging must correlate multiple service calls for a single user operation.

#### Versioning

Updates to a service must not break services that depend on it. Multiple services could be updated at any given time, so without careful design, you might have problems with backward or forward compatibility. Services that lag on adopting new API versions can increase the resources and maintenance required for older API's.

#### Skill set

Microservices are highly distributed systems. These distributed systems often require a different skill set to properly develop, manage, and maintain. Carefully evaluate whether the team has the skills and experience to be successful, and allow for the time and planning your teams will need to evolve their abilities.

## When should you choose a microservices architecture?

So with all this background information, in what situations is a microservices architecture best suited for?

- Large applications that require a high release velocity.
- Complex applications that need to be highly scalable.
- Applications with rich domains or many subdomains.
- An organization that consists of small development teams.
