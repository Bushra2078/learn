Your company needed to build an application that runs as a background process to generate a report that lists the users who have an upcoming monthly payment. You built a Python daemon app that represents a confidential client app that calls Microsoft Graph as itself to read users' data from a protected web API.

The Microsoft identity platform lets you register a Python daemon app to perform identity and access management (IAM). The Azure portal displays the app registration's **Overview** pane. You see, the **Application (client) ID**, also called the client ID, uniquely identifies your application within the Microsoft identity platform.

The Microsoft Authentication Library (MSAL) for Python was used to create a client-confidential application instance. Finally, an access token was acquired and Microsoft Graph was called by the application.

The amount of work it would take to build a client-confidential application from scratch is substantial. You’d have to write code to create your own identity provider, develop a rest API service, and create a secure library to interact with your identity provider. Once all the code is ready, you'd need a server to host the code.

The Microsoft identity platform and the Microsoft Authentication Library (MSAL) make it much more manageable to build a daemon app. Building a Python daemon app through taking this module meant that no servers needed to be set up and user data can be read from a protected web API.
