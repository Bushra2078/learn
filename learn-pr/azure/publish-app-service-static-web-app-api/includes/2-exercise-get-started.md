Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you'll build a web application using your preferred front-end framework from a GitHub repository.

## Create a repository

This tutorial makes it easy for you to create a new repository by using a GitHub template repository. A series of templates is available where each contains a starter app built with a different front-end framework.

1. Navigate to the [create from template page](https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate?azure-portal=true) for the template repository.
   - If you get a 404 Page Not Found error, sign in to GitHub and try again.
1. If prompted for **Owner**, choose one of your GitHub accounts
1. Name your repository **my-static-web-app**
1. Click the **Create repository from template** button

## Run your app

You just created a GitHub repository named **my-static-web-app** in your GitHub account. Next, you'll clone the repo and run the code locally on your computer.

1. Open a terminal on your computer.
1. Start by cloning the GitHub repository to your computer.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app
   ```

1. Go to the folder for your source code.

   ```bash
   cd my-static-web-app
   ```

1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Now install the application dependencies.

   ```bash
   npm install
   ```

1. Finally, run the front-end client application.

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

## Browse to your app

It's time to see your application running locally. Each front-end application runs on a different port.

Click the link to browse to your application.

::: zone pivot="angular"

Browse to <http://localhost:4200>.

::: zone-end

::: zone pivot="react"

Browse to <http://localhost:3000>.

::: zone-end

::: zone pivot="svelte"

Browse to <http://localhost:5000>.

::: zone-end

::: zone pivot="vue"

Browse to <http://localhost:8080>.

::: zone-end

:::image type="content" source="../media/my-shopping-list-app.png" alt-text="Browsing to your web app":::

> [!NOTE]
> In this module's exercises, you will deploy an app without an API. See the Next Steps section in the final unit for information about the next tutorial, where you'll deploy an API alongside your app.

Now stop your running app by pressing <kbd>Ctrl-C</kbd> in the terminal.

## Next steps

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.
