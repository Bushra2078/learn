Your web app and API are both running locally. Now it's time to publish your web app and API to Azure Static Web Apps.

## Push your changes to GitHub

You've made changes to your API in the previous exercise. Commit those changes to the **api** branch and push them to GitHub by following these steps:

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Git: Commit All**
1. Enter a commit message such as **api changes**
1. Open the command palette by pressing **F1**
1. Type and select **Git: Push**
1. If you are prompted with the message **The branch 'api' has no upstream branch. Would you like to publish this branch?** press the \*_OK_ button

## Create a Pull Request

You pushed your **api** branch to GitHub. Now you want the GitHub Action to publish your web app and API in a preview URL. So your next step is to create a pull request against the **master** branch.

1. Open a browser
1. Navigate to your repository

   <https://github.com/YOUR_GITHUB_USERNAME/my-first-static-web-app>

1. Click on the **Pull requests** menu
1. Click the **New pull request** button
1. Select the **master** branch fro the **base** dropdown
1. Select the **api** branch from the **compare** dropdown
1. Click the **Create pull request** button

Your GitHub Action has now been triggered.

## Watch the GitHub Action build and publish

You can stay in your browser on your repository and watch the GitHub Action's progress. Follow these steps to view the progress:

1. Click on the **Actions** menu
1. Under the Workflows menu, click on the **Azure Static Web Apps CI/CD** workflow item
1. Select the latest (top) link in the action runs to the right

You can see the progress of your GitHub Action as it builds and publishes your web app and API.

## Browse to the preview URL

Once the GitHub Action has completed successfully, you can view your running app in the browser.

1. Click on the **Pull requests** menu
1. Select your pull request
1. Click on the link following the message **Azure Pages: Your stage site is ready! Visit it here**

Notice that the preview URL contains a hyphen followed by a number. The number matches the pull request number for the pull request you created. For every pull request you create, you'll get a unique and repeatable preview URL.

::: zone pivot="angular"

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Your angular web app":::

::: zone-end

::: zone pivot="react"

:::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="Your react web app":::

::: zone-end

::: zone pivot="svelte"

:::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="Your svelte web app":::

::: zone-end

::: zone pivot="vue"

:::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="Your vue web app":::

::: zone-end

## Next steps

Congratulations, you've created your first Azure Static Web Apps instance with a web app and API!
