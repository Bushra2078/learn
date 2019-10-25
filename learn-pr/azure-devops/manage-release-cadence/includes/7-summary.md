In this module, you defined a _deployment pattern_ as an automated way to smoothly roll out new application features to your users. A good deployment pattern can help you minimize downtime. It can also enable you to roll out new features progressively to your users.

There are several deployment patterns to choose from. Choosing a deployment pattern depends on your reasons for the deployment as well as your infrastructure. Do you have canary testers in place, or will you choose testers that don't know they are testers with dark launching? If you have a set of testers that progress from a small trusted set, to a larger set, then you may use progressive exposure deployment. Perhaps you want to test if one version performs better than another version with A/B testing.

The team chose to implement the *blue-green deployment* pattern. Azure App Service provides *deployment slots*, which are are live apps with their own host names. You can swap between two deployment slots, which enables you to promote changes to production instantly. Although the team is not yet ready to release their website to the public, they've proven that they can get new features to their users without incurring downtime.

As a bonus, you also learned how to roll forward an unintended change by reverting a Git commit and then pushing the reverted change through the pipeline.

## How is the team measuring up?

In the _Assess your existing software development process_ module, Mara performed a [value stream mapping exercise](/learn/modules/assess-your-development-process/4-assess-process-efficiency?azure-portal=true) to help the team analyze their current release cycle process.

Recall that the *activity ratio*, or efficiency, is process time divided by total lead time.

$${Activity\ ratio\ =\ }{\dfrac{Process\ time}{Total\ lead\ time}}$$

The Tailspin web team initially determined they were 23% efficient against this metric.

The team has already reduced some inefficiencies when they implemented continuous integration (CI). With continuous delivery (CD) in place, they have reduced it even further.

In previous learning paths, the team has reduced:

* The time it takes to set up source control for new features from **three days** to **zero days**.

    They did so by moving from centralized source control to Git, a form of distributed source control. With distributed source control, there's no need to wait for files to be unlocked.
* The time it takes to hand off code to Amita, the tester, from **two days** to **zero days**.

    They did this by moving their build process to Azure Pipelines. Azure Pipelines automatically notifies Amita when a build is available, so the developers no longer need to update Amita's spreadsheet.
* The time it takes Amita to test new features from **three days** to **one day**.

    They did this by unit testing their code. By running unit tests each time a change moves through the build pipeline, fewer bugs and regressions reach Amita, which enables her to complete each manual test pass much faster.

The deployment pipeline that you and the team built in this learning path reduced:

* The time it takes to get the build into the _Test_ environment from **three days** to **one day**

    They did so by using a scheduled trigger to deploy to _Test_ every day at 3:00 AM.
* The time is takes to get the tested build into _Staging_ from **two days** to **zero days**.

    They did so by adding Selenium UI tests, a form of functional testing, to the _Test_ stage. These tests quickly perform tests Amita needed to perform manually.
* The time it takes to get the approved build from _Staging_ to _Production_ from **one day** to **less than one day**.

    They did this by adding manual approval checks to the pipeline. When management signs off, Tim can release the changes from _Staging_ to  _Production_.

These changes reduce the total lead time from 22 days to 10 days. Substitute these numbers into the equation and we get:

$${Activity\ ratio\ =\ }{\dfrac{5\ days}{10\ days}}{ = .50}$$

Multiply the result by 100% and you get **50%**.

Although there's always room for improvement, this is a very positive change for the team. Not only do customers receive value more quickly, the Tailspin team now spends less time waiting and more time doing what they enjoy most &mdash; delivering features they know their customers will love.

## Learning path summary

Congratulations. You've completed the final module in the _Deploy applications with Azure DevOps_ learning path. The main focus of this learning path is on deploying applications with Azure Pipelines.

In this learning path, you accomplished a lot, including:

* Building a basic release pipeline that deploys a web application to App Service.
* Expanding your basic release pipeline to a multi-stage pipeline that deploys to various development, test, and staging environments.
* Running both functional and non-functional tests in the pipeline.
* Implementing a blue-green deployment that updates the application with minimal downtime.

You can apply what you've learned to the applications and services that you work on. You can also find more self-paced, hands-on learning around Azure DevOps at [Azure DevOps Labs](https://www.azuredevopslabs.com?azure-portal=true).

## Learn more

Here are some additional resources you can use to learn more about App Service, deployment slots, and rolling back changes:

* [App Service Documentation](https://docs.microsoft.com/azure/app-service?azure-portal=true)
* [Deploy a website to Azure with Azure App Service](https://docs.microsoft.com/learn/paths/deploy-a-website-with-azure-app-service?azure-portal=true)
* [Stage a web app deployment for testing and rollback by using App Service deployment slots](https://docs.microsoft.com/learn/modules/stage-deploy-app-service-deployment-slots?azure-portal=true)
* [Set up staging environments in Azure App Service](https://docs.microsoft.com/azure/app-service/deploy-staging-slots?azure-portal=true)