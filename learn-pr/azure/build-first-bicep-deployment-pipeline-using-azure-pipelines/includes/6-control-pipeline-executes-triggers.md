You now have a working pipeline that deploys your Bicep file to your Azure environment. However, you still need to manually run your pipeline. In this unit, you'll learn how to trigger your pipeline automatically when your Bicep code changes.

## What are pipeline triggers?

Pipeline triggers automatically run your pipeline based on rules you specify. You can configure them to run your pipeline at scheduled intervals. You can also configure triggers to run your pipeline every time the files in your repository changes. You do this because it's a good idea to run all of your tests and deployment steps every time your code changes.

If you don't use an automatic trigger, someone might make a change to a Bicep file, and even commit it and push it to the repository. If they forget to run the pipeline, then you have a difference between the resource definitions in your Bicep file and the resources that are actually deployed to your Azure environment. Suppose this happens for a couple of subsequent commits and pushes. If someone now introduces an error or misconfiguration in the Bicep file during one of these changes, it's hard to track back to where the error was introduced, since you have several commits to work through. After a while, you won't trust that your Bicep code truly represents your infrastructure, and its value is eroded.

When you configure your pipeline to run every time you update your files, the moment your changes are pushed, your pipeline will start running. This gives you instant feedback on the validity of your change and ensures that everything is always up to date.

## Branch triggers

A common trigger is a _branch trigger_, which sometimes called a _continuous integration trigger_ or _CI trigger_. When you use this trigger, every time you make a change to a specified branch, the pipeline is run. If you commit and push a change to a different branch, the pipeline ignores it. It's common to use this trigger against your **main**  branch, like this:

```yaml
trigger: 
- main
```

### Trigger when multiple branches change

You can customize the branches that cause your pipeline to trigger. For example, suppose you create _release branches_ that contain the code you'll deploy for a specific release of your project. You use branch names like **release/v1**, **release/v2**, and so forth. You want to run your pipeline any time code changes on a branch that begins with the name **release/**. You can use the `include` property in conjunction with a `*` wildcard to express this:

```yaml
trigger:
  branches:
    include:
    - main
    - release/*
```

You can also exclude specific branches, too. Suppose you're collaborating with team members on your project. Your colleagues create _feature branches_ to try out their ideas in Bicep files. All of these feature branches are given names like **feature/add-database**, **feature/improve-performance**, and so forth. You don't want to run the pipeline automatically when changes are made to these branches. By using the `exclude` property, you ensure the pipeline isn't automatically triggered for changes to feature branches:

```yaml
trigger:
  branches:
    include:
    - main
    - release/*
    exclude:
    - feature/*
```

### Path filters

Sometimes, you have files in your repository that don't relate to your deployment. For example, in your repository you might have a _deploy_ folder that contains your Bicep code, and a separate _docs_ folder that contains your documentation files. You want to trigger your pipeline when anyone makes a change to any of the Bicep files in the _deploy_ folder, but you don't want to trigger the pipeline if someone only changes a documentation file. To configure this, you can use a _path filter_:

```YAML
trigger:
  branches:
    include:
    - main
  paths:
    exclude:
    - docs
    include:
    - deploy
```

If someone commits a change that only updates a documentation file, the pipeline won't run. But if they change a Bicep file, or even if they change a Bicep file in addition to a documentation file, then the trigger will run the pipeline.

## Schedule your pipeline to run automatically

You can also run your pipeline on a schedule. For example, you might run a nightly release of your Bicep code, or automatically deploy a test environment every morning. Use the `schedule` keyword instead of `trigger`, and specify the frequency by using a cron expression:

```yaml
schedules:
- cron: "0 0 * * *"
  displayName: Daily environment restore
  branches:
    include:
    - main
```

> [!NOTE]
> A _cron expression_ is a specially formatted sequence of characters that specify how often something should happen. In this example, `0 0 * * *` means _run every day at midnight UTC_.

You can also specify the branch of your repository that should be used when the schedule starts. When the pipeline begins, it will use the most recent version of the code from that branch.

## Combine triggers

You can combine triggers, like in this example:

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

When you specify a branch trigger and a scheduled trigger in the same pipeline, then the pipeline will run every time a file changes on the specified branch, _and_ on the schedule you specify.

> [!TIP]
> It's a good practice to specify the triggers for each pipeline. If you don't, then by default your pipeline will automatically run whenever any files change on any branch, which isn't often what you want.
