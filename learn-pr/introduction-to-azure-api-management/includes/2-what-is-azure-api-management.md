<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start with a quick overview of Azure API Management and its core features. This overview should help you decide whether Azure API Management might be a suitable solution for reducing your company's API complexity.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is <concept>?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<concept> is..." (ensure this is a definition, do not give use cases like "<concept> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

## What is API lifecycle management?

*API lifecycle management* is the process of administering an API through its entire lifespan&mdash;from its design and creation to its obsolescence and retirement. For the purposes of this module<!-- Should this be "course?" -->, we'll pick up after your APIs have already been designed, coded, and deployed. This way, we can concentrate on the rest of the API lifecycle management tasks, which include:

- Providing API documentation, testing, and code samples.
- Onboarding and off-boarding users.
- Managing API subscriptions and the distribution of subscription keys.
- Implementing API revisions in a controlled and safe way.
- Managing multiple versions of an API.
- Implementing API access controls, such as authentication and call rate limits.
- API reporting for usage, errors, and so on.<!-- For consistency with the rest of the bulleted list, can we start this bulleted sentence and the next with a verb ending with a gerund (ing)? For example, providing, onboarding, managing, etc. -->
- Analytics for both your company and for the developers who use the APIs.

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## <product> definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<product> is..." (ensure this is a definition, do not give use cases like "<product> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

## Azure API Management definition

*Azure API Management* is a cloud service that gives you a platform for publishing, securing, maintaining, and analyzing all your company's APIs. Azure API Management accomplishes these tasks by offering three main components:

- Gateway
- Administration interface
- Developer portal

:::image type="content" source="../media/2-what-is-azure-api-management-overview.png" alt-text="The main components of Azure API Management, include the administration interface, gateway, and developer portal.":::<!-- Can we also say something about it being the go-between between the items on the left and the servers on the right? -->

> [!IMPORTANT]
> Azure API Management does *not* host your actual APIs; your APIs remain where they were originally deployed. Instead, Azure API Management acts as a kind of façade or "front door" for your APIs. In this way, Azure API Management is said to *decouple* your APIs by letting you set API policies and other management options in Azure, while leaving your deployed backend APIs untouched.
<!-- Could we  put the following sections in the same order as the graphic? -->
## Gateway

The *Azure API Management gateway* is an Azure endpoint that accepts all calls from all your APIs. The gateway:

- Verifies API subscription keys and other credentials.
- Enforces your usage quotas and rate limits.
- Transforms the API as needed for backend compatibility.
- Routes each call to its appropriate backend server.
- Caches backend responses.
- Collects call metadata for analytics workloads.

## Administration interface

The *Azure API Management administration interface* is a set of Azure portal pages that enables you to administer your APIs. API administration includes the following activities:

- Defining or importing API specifications
- Implementing usage policies such as quotas and rate limits
- Setting security policies
- Managing users
- Packaging APIs into products
- Defining API transformations
- Managing API revisions and versions
- Running analytics on your API metadata

## Developer portal

The *Azure API Management developer portal* is a web interface that enables developers to interact with your APIs through:

- Reviewing the documentation for each API.
- Trying an API by using the interactive console.
- Reviewing code samples in different programming languages.
- Subscribing to an API and getting the API subscription key.
- Running analytics on the developer's usage.

## Azure API Management tiers

Azure API Management provides several service tiers, each of which offers a distinct set of features, capacities, and pricing. The following table lists the tiers in order from lowest to highest price.

| | | | | | |
| --- | --- | --- | --- | --- | --- |
|**Criteria**  |**Consumption**  |**Developer**  |**Basic**  |**Standard**  |**Premium**  |
|**Designed for**    | Lightweight usage        | Evaluation, testing, and other non-production usage        | Entry-level production usage        | Medium-volume production usage        | High-volume or enterprise production usage        |
|**Cache**     | External only        | 10 megabytes (MB)         | 50 MB        | 1 gigabyte (GB)        | 5 GB        |
|**Service-level agreement (SLA)**     | 99.95%        | None        | 99.95%        | 99.95%        | 99.99%        |
|**Developer portal**     | No         | Yes        | Yes        | Yes        | Yes        |
|**Built-in analytics**     | No        | Yes        | Yes        | Yes        | Yes        |
|**Throughput (estimated requests/sec)**     | N/A        | 500        | 1,000        | 2,500        | 4,000        |
|   |   |   |   |   |   |

> [!NOTE]
> The pricing for the Consumption tier is per API call, where the first million calls are free, and the remainder then billed a fixed rate per million calls. The pricing for all the other tiers is per hour.

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the <product> solves one of the customer tasks in your <scenario>.
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to <solve scenario>"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the <product> solved the <scenario>.
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->

## How to apply policies to API requests and responses

One of the biggest problems with having multiple published APIs is that each API requires a separate set of policies. Here, a *policy* is a setting or action that controls the behavior of the API. For example, if you want to enforce a *rate limit* (the maximum number of API calls allowed from a single source in a given time period) you'd include that limit as part of the policies for an API. This is just one example, but there are numerous policies you can apply. Multiply that by several different APIs and you have a management nightmare.

Azure API Management solves the API policy problem by enabling you to set policies for all your APIs in a single place, which is the Azure API Management administration interface. With Azure API Management, you can set policies in the following categories:

- Access restriction. These policies determine where an API is allowed through the gateway. For example, there are policies that enforce rate limits and usage quotas, filter caller IPs, and check for a valid JSON Web Token (JWT).
- Authentication. These policies authenticate API calls. For example, you can authenticate an API call using Basic authentication, a client certificate, or a managed identity.
- Caching*. These policies enable you to improve API performance by storing and retrieving responses in the cache.
- Transformation. These policies enable you to perform operations on API requests and responses. For example, you can convert an API from XML to JavaScript Object Notation (JSON) or vice versa, set a different backend service, and modify a query string parameter.
- **Validation**. These policies are used to validate API calls by comparing certain parameters to what's in your API specification. For example, you can validate the request or response body, the request header parameters, and the response headers.
- **Advanced**. These policies enable you to perform operations on the API requests and responses. For example, you can apply policies based on conditional expressions, set variables, and modify the HTTP status code of a response.

*Azure API Management policy definitions* are XML documents that consist of a series of statements, each of which represents a policy and its parameters. The XML document is divided into the following sections:

- **inbound**: The policies in this section are applied to each incoming API request.
- **backend**: The policies in this section are applied before each incoming API request is routed to its backend service.
- **outbound**: The policies in this section are applied to each outgoing API response.
- **on-error**: The policies in this section are applied when an API request or response generates an error.

:::image type="content" source="../media/2-what-is-azure-api-management-policies.png" alt-text="A consumer's API request enters the Azure API Management gateway where it passes through inbound and backend policies before being sent to the backend server. The API response then passes though the gateway's outbound policies before being sent to the originating API consumer.":::

<!-- 5. Additional content (optional, as needed) ------------------------------------------------

    Goal:
        The section is a catch-all for any information not covered in the sections above.
        Repeat the pattern here as many times as needed.

    Possible topics:
        - Key feature(s).
        - Example use case in addition to the scenario.
        - High-level of how practitioners use the product (e.g. there's an API and a web UI to support multiple use cases).
        - Business value (e.g. it lets you do something that would be difficult to achieve without <product>).

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote (image preferred).

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
