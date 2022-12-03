<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
To help move your app through the development, test, and production lifecycle, you will need an Azure Active Directory (Azure AD) test environment. You can use your Azure AD test environment during the early stages of app development and long-term as a permanent test environment.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
Recall that in the sales team dashboard example, managers use an internal web app to manage their direct reports and help them meet their targets.  Managers sign in to the web app and can view confidential information for themselves and the employees that report to them, internal sales goals, and upcoming product release dates.  To better secure access to the sales team dashboard, administrators recently enabled Azure AD Multi-Factor Authentication to prompt users for additional verification information during sign-in. Testing your application in your production Azure AD tenant would be simpler and easier, but can you safely constrain the test application in the production environment?  Will the administrators approve the creation of test users and test data in production environment?  How can your tests use automated sign-ins for integration testing when user interaction is required (through multi-factor authentication)?

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
This exercise takes you through the process of evaluating whether you need a dedicated tenant for your application's Azure AD test environment or if you can use your existing production tenant.

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
<!-- TODO: add a visual element -->

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## Dedicated test tenant or production Azure AD tenant?

Your task is to decide between using an Azure AD tenant dedicated to testing or your production tenant as your test environment.

Using a production tenant can make some aspects of application testing easier, but it requires the right level of isolation between test and production resources. Isolation is especially important for high-privilege scenarios.

Don't use your production Azure AD tenant if:

- Your application uses settings that require tenant-wide uniqueness. For example, your app might need to access tenant resources as itself, not on behalf of a user, by using app-only permissions. App-only access requires admin consent which applies to the entire tenant. Such permissions are hard to scope down safely within a tenant boundary.
- You have low tolerance of risk for potential unauthorized access of test resources by tenant members.
- Configuration changes could negatively impact the critical operation of your production environment.
- You're unable to create users or other test data in your production tenant.
- Policies are enabled in your production tenant that require user interaction during authentication. For example, if multi-factor authentication is required for all users, you can't use automated sign-ins for integration testing.
- Adding non-production resources and/or workload to your production tenant would exceed service or throttling limits for the tenant.

If any of these restrictions apply, set up a test environment in a separate tenant.

If none of these restrictions apply, you can set up a test environment in your production tenant. Be aware that global administrators in your production tenant can access its resources and change its configuration at any time. To prevent access to any test resources or configuration, put that data in a separate tenant.

## Deciding to use a dedicated test tenant

After consulting with key stakeholders and reviewing the web app requirements, your team considered these key factors:

- You want to set up a CI/CD pipeline that automates building, testing, and deploying the web app.  Creating test users and test app registrations in the tenant require in the production tenant are high-privilege operations, since they require admin permissions.
- The administrators reviewed your request for allowing the creation of test users and test data in the production tenant and did not approve.
- Multi-factor authentication is required for all users in the production tenant.  Automating sign-ins for integration testing will not be possible.
- After some investigation, your team decided that the integration tests need to use a non-interactive flow, called Resource Owner Password Credential Grant (ROPC), to automatically sign in users for testing. Microsoft recommends that you *do not* use the ROPC flow in a production environment.

Taking all of these factors into account, your team decides to use a dedicated test tenant for testing the sales team dashboard.
