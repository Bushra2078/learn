Nice job! Your pipeline is really taking shape. You and the Tailspin team have moved from a basic proof of concept to a realistic release pipeline. You can use this pipeline to build an artifact and test it before making it available to your users. 

In this module, you learned about some of the ways to control how changes move from from one stage of a pipeline to the next. Let's review the pipeline you built in this module. This image shows your pipeline's overall shape:

![A whiteboard showing the Build, Dev, Test, and Staging stages](../media/2-add-staging-stage-approval.png)

The _Dev_, _Test_, and _Staging_ stages each deploy the build artifact to its own Azure App Service environment.

* When a change is pushed to GitHub, a _CI trigger_ causes the _Build_ stage to run. The _Build_ stage produces a build artifact as its output.
* The _Dev_ stage runs only when the change happens in the _release_ branch. You use a _condition_ to specify this requirement.
* The _Test_ stage runs at 3 A.M. each morning. This stage runs only when the _release_ branch contains changes since the last run. You use a _scheduled trigger_ to specify when the _Test_ stage runs.
* The _Staging_ stage runs only after you approve the changes in the _Test_ stage. You add a _release approval_ to the **staging** environment to pause the pipeline until you approve or reject the change.

Keep in mind that this pipeline satisfies the Tailspin team's requirements. The shape of your pipeline as well as how changes flow through your pipeline depend on the needs of your own team and the needs of the apps and services your team builds.

Although the team is making steps towards improving their release cadence, there's room for additional improvements. For example, Amita from QA must manually test and approve builds before the team can present new features to management. In the next module, you'll work with the Tailspin team as they automate some tests so that changes can move through the pipeline even faster.

## Learn more

In this module, you worked with conditions, triggers, and approvals. Here are some additional resources you can use to learn more.

* [Conditions](https://docs.microsoft.com/azure/devops/pipelines/process/conditions?view=azure-devops&tabs=yaml&azure-portal=true)
* [Build pipeline triggers](https://docs.microsoft.com/azure/devops/pipelines/build/triggers?view=azure-devops&tabs=yaml&azure-portal=true)
* [Approvals and other checks](https://docs.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops&azure-portal=true)