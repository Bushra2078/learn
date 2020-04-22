## 3 - Exercise - Create an Azure Static Web App

## Activate the Azure sandbox

1. Start by **activating the Azure sandbox above**.
1. Once it's activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

## Flow

- Motivation - You want to publish your app to Azure. Let's go!
- Setup the concierge sandbox
- Navigate to https://aka.ms/tryjamstack [TODO: this will change]
- Set the subscription
- Create a resource group
- Set the Azure static web app name
- Select the region
- Click sign-in with GitHub
- Authorize Azure-Static-Web-Apps access to your GitHub account
- When you are prompted for password enter it
- Select your GitHub organization, repository, and branch
- Click the next: Build button
- Enter the app location
- Enter the api location
- Enter the artifact location
- Click the Review:Create button
- Browse to it? Takes about a minute

## Build

Next, add configuration details specific to your preferred front-end framework.

::: zone pivot="angular"

### [Angular](#tab/angular)

- Enter **src** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="react"

### [React](#tab/react)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **build** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="svelte"

### [Svelte](#tab/svelte)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Clear the default value from _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="vue"

### [Vue](#tab/vue)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

## Create the app

Now that the repo is created, you can create a static app from the Azure portal.

- Navigate to the [Azure portal](https://portal.azure.com)
- In the top bar, search for **Static Web Apps**
- Click **Static Web Apps**

### Basics

Begin by configuring your new app and linking it to a GitHub repository.

- Select your _Azure subscription_
- Select or create a new _Resource Group_
- Name the app **my-first-static-app**.
  - Valid characters are `a-z` (case insensitive), `0-9`, and `_`.
- Select _Region_ closest to you
- Select the **Free** _SKU_
- Click the **Sign-in with GitHub** button and authenticate with GitHub
- Select your preferred _Organization_
- Select **my-first-static-app** from the _Repository_ drop-down
- Select **master** from the _Branch_ drop-down
- Click the **Next: Build >** button to edit the build configuration

### Review + create

After the build validates, you can continue to create the application.

- Click the **Create** button
- Once the deployment is complete, click the **Go to resource** button

## View website

There are two automated aspects to deploying a static app. The first provisions the underlying Azure resources that make up your app. The second is a GitHub Actions workflow that builds and publishes your application.

> [!NOTE]
> You can ensure that the GitHub Actions workflow is complete by checking the status of your commits available at `https://github.com/<YOUR_GITHUB_USERNAME>/my-first-static-app/actions`.

Once the provisioning and deployment is complete, you can click on the _URL_ link in the Azure portal to launch your app in the browser.

## Clean up resources

If you're not going to continue to use this application, you can delete the static app through the following steps:

1. Open the [Azure portal](https://portal.azure.com)
1. Search for **my-first-static-app** from the top search bar
1. Click on the app name
1. Click on the **Delete** button
1. Click **Yes** to confirm the delete action
