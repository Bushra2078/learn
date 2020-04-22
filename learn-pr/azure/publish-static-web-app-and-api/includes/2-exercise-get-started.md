## 2- Exercise - Get started

Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you build a web application using your preferred front-end framework from a GitHub repository.

## Create a repository

This article uses a GitHub template repository to make it easy for you to create a new repository. The templates features starter apps built with different front-end frameworks.

# [Angular](#tab/angular)

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

# [React](#tab/react)

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

# [No Framework](#tab/svelte)

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

# [Vue](#tab/vue)

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

---

## Create a static app

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

### Build

Next, add configuration details specific to your preferred front-end framework.

# [Angular](#tab/angular)

- Enter **src** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

# [React](#tab/react)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **build** in the _App artifact location_ box
- Click the **Review + create** button

# [Vue](#tab/vue)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

# [No Framework](#tab/vanilla-javascript)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Clear the default value from _App artifact location_ box
- Click the **Review + create** button

---

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






## Flow

Generalized content for all JavaScript frameworks. Always shown.

- Generalized content for all JavaScript frameworks. Always shown.
- Generate your repo https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name it
- Clone it
- npm install
- npm start
- See your app locally

::: zone pivot="angular"

## Angular section

Content specific for Angular. Only shown when "Angular" is selected.

```typescript
const name = 'john';
```

::: zone-end

::: zone pivot="react"

## React section

Content specific for React. Only shown when "React" is selected.

```javascript
const name = 'john';
```

::: zone-end

::: zone pivot="svelte"

## Svelte section

Content specific for Svelte. Only shown when "Svelte" is selected.

```javascript
const name = 'john';
```

::: zone-end

::: zone pivot="vue"

## Vue section

Content specific for Vue. Only shown when "Vue" is selected.

```javascript
const name = 'john';
```

::: zone-end





