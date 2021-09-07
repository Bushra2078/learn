You now have a working pipeline that deploys your Bicep file to your Azure environment. However, whenever you change your file, you must manually run your pipeline. In this unit, you'll learn how to trigger your pipeline to run automatically whenever your Bicep code changes.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## What is a pipeline trigger?

A pipeline trigger is a condition that, when met, automatically runs your pipeline based on rules you create. You can set triggers to run your pipeline at scheduled intervals. You can also set triggers to run your pipeline every time a file in your repository changes. You might choose the second option because it's a good idea to run all your tests and deployment steps every time sometime changes your code.

If you don't use an automatic trigger, someone might make a change to a Bicep file, and even commit it and push it to the repository. But if they forget to run the pipeline, there will be a difference between the resource definitions in your Bicep file and the resources that are deployed to your Azure environment. Suppose a couple more commits and pushes are made but not deployed. If someone introduces an error or misconfiguration in the Bicep file in one of these changes, it might be hard to track down the error among the multiple commits that are later deployed at once. After a while, you won't trust that your Bicep code truly represents your infrastructure, and its value is eroded.

When you set up your pipeline to run every time you update your files, the moment your changes are pushed, your pipeline starts running. You get instant feedback on the validity of your change, and can be sure that your production environment is always up to date.

## Branch triggers

A common type of trigger is a *branch trigger*, also called a *continuous integration trigger* or *CI trigger*. When you use a branch trigger, every time you make a change to a specific branch, the pipeline runs. If you commit and push a change to a different branch, the pipeline is not triggered and it doesn't run. It's common to use this type of trigger against your default or *main*  branch, with this code:

```yaml
trigger: 
- main
```

### Trigger when multiple branches change

You can set up triggers to run your pipeline on a specific branch or on sets of branches. For example, suppose you create *release branches* that contain the code you'll deploy for a specific release of your project. You can use branch names like *release/v1*, *release/v2*, and so on. You want to run your pipeline anytime your code changes on a branch that begins with the name *release/*. You can use the `include` property with a `*` wildcard:

:::code language="yaml" source="code/7-branch-filter-include.yml" highlight="3-5":::

You can exclude specific branches, too. Suppose you're collaborating with team members on your project. Your colleagues create *feature branches* to try out their ideas in Bicep files. All feature branches have names like *feature/add-database*, *feature/improve-performance*, and so on. You want to run your pipeline automatically on all branches except for the feature branches that your colleagues create. By using the `exclude` property, you ensure that the pipeline isn't automatically triggered for changes to feature branches:

:::code language="yaml" source="code/7-branch-filter-exclude.yml" highlight="5-6":::

> [!TIP]
> Notice the quotation marks around the wildcard in the `include` filter. The YAML file format requires that you enclose a single `*` character in quotation marks when you use it as a wildcard.

### Path filters

Sometimes you have files in your repository that aren't related to your deployment. For example, you might have a *deploy* folder in your repository that contains your Bicep code and a separate *docs* folder that contains your documentation files. You want to trigger your pipeline when anyone makes a change to any of the Bicep files in the *deploy* folder, but you don't want to trigger the pipeline if someone changes only a documentation file. To set up a trigger to respond to changes in a specific folder in your repository, you can use a *path filter*:

:::code language="yaml" source="code/7-path-filter.yml" highlight="5-9":::

If someone commits a change that updates only a documentation file, the pipeline doesn't run. But if someone changes a Bicep file, or even if they change a Bicep file in addition to a documentation file, the trigger runs the pipeline.

## Schedule your pipeline to run automatically

You can run your pipeline on a set schedule, and not in response to a file change. For example, you might run a nightly release of your Bicep code or automatically deploy a test environment every morning. Use the `schedules` keyword instead of `trigger`, and set the frequency by using a cron expression:

:::code language="yaml" source="code/7-schedule.yml" highlight="2":::

> [!NOTE]
> A *cron expression* is a specially formatted sequence of characters that sets how often an event will happen. In this example, `0 0 * * *` means *run every day at midnight UTC*.

You can also set the branch of your repository to use in the scheduled event. When the pipeline starts, it uses the most recent version of the code from the branch you set in the schedule.

## Use multiple triggers

You can combine triggers and schedules, like in this example:

```yaml
trigger: 
- main

schedules:
- cron: "0 0 * * *"
  displayName: Deploy test environment
  branches:
    include:
    - main
```

When you create a branch trigger *and* a scheduled trigger in the same pipeline, the pipeline runs every time a file changes on the branch that's set in the trigger *and* on the schedule you set. In this example, the pipeline runs every day at midnight UTC and also whenever a change is pushed to the *main* branch.

> [!TIP]
> It's a good practice to set triggers for each pipeline. If you don't set triggers, by default, your pipeline automatically runs whenever any file changes on any branch, which often isn't what you want.
