A busy website is rarely considered finished. Instead, code is updated regularly to fix issues and add new features. You can deploy new versions by using Visual Studio Code and manage them by using deployment slots.

Suppose you're making updates to your launch countdown website that promotes your new video game. You want to deploy these changes to Azure and test them. Then, if the new code passes the tests, you want to move it into the production website.

In this unit, you learn how to deploy new versions and roll back a version if there are failures.

## Push updates with Visual Studio Code

To deploy a new version of your code to an existing webapp in Azure App service, right-click on it in the Code Azure explorer window and then select **Deploy to Web App**. This operation overwrites the previous version of the app:

:::image type="content" source="../media/6-update-web-app.png" alt-text="Deploy updated code from Visual Studio Code.":::

In the Azure explorer, you can also see a list of deployments for your webapp under the **Deployments** node. For each log you can view the deployment log, which shows all the steps that Code took to deploy and run your webapp:

:::image type="content" source="../media/6-vs-code-azure-deployments.png" alt-text="View a deployment in Azure from Visual Studio Code.":::