Azure Pipelines can automatically build and validate every pull request and commit to your Azure Repos Git repository.

Azure Pipelines can be used with Azure DevOps public projects and Azure DevOps private projects.

In future sections of this training, we'll also learn how to use Azure Repos with external code repositories such as GitHub.

Let's start by creating a hello world YAML Pipeline.

## Hello world

Start slowly and create a pipeline that echoes "Hello world!" to the console. No technical course is complete without a hello world example.

```YAML
name: 1.0$(Rev:.r)

# simplified trigger (implied branch)
trigger:

- main

# equivalents trigger
# trigger:
#  branches:
#    include:
#    - main

variables:
  name: martin

pool:
  vmImage: ubuntu-latest

jobs:

- job: helloworld
  steps:

    - script: echo "Hello, $(name)"

```

Most pipelines will have these components:

 -  Name – though often it's skipped (if it's skipped, a date-based name is generated automatically).
 -  Trigger – more on triggers later, but without an explicit trigger. There's an implicit "trigger on every commit to any path from any branch in this repo."
 -  Variables – "Inline" variables (more on other types of variables later).
 -  Job – every pipeline must have at least one job.
 -  Pool – you configure which pool (queue) the job must run on.
 -  Checkout – the "checkout: self" tells the job which repository (or repositories if there are multiple checkouts) to check out for this job.
 -  Steps – the actual tasks that need to be executed: in this case, a "script" task (the script is an alias) that can run inline scripts.

## Name

The variable name is a bit misleading since the name is the build number format. If you don't explicitly set a name format, you'll get an integer number. It's a monotonically increasing number for run triggered off this pipeline, starting at 1. This number is stored in Azure DevOps. You can make use of this number by referencing $(Rev).

To make a date-based number, you can use the format $(Date:yyyy-mm-dd-HH-mm) to get a build number like 2020-01-16-19-22. To get a semantic number like 1.0.x, you can use something like 1.0$(Rev:.r)

## Triggers

If there's no explicit triggers section, then it's implied that any commit to any path in any branch will trigger this pipeline to run.

You can be more precise, though, using filters such as branches or paths.

Let's consider this trigger:

```YAML
trigger:
  branches:
    include:

    - main

```

This trigger is configured to queue the pipeline only when there's a commit to the main branch. What about triggering for any branch except main? You guessed it: use exclude instead of include:

```YAML
trigger:
  branches:
    exclude:

    - main

```

> [!TIP]
> You can get the name of the branch from the variables Build.SourceBranch (for the full name like `refs/heads/main`) or Build.SourceBranchName (for the short name like main).

What about a trigger for any branch with a name that starts with topic/ and only if the change is in the webapp folder?

```
trigger:
  branches:
    include:

    - feature/*
  paths:
    include:

    - webapp/**

```

You can mix includes and excludes if you need to. You can also filter on tags.

> [!TIP]
> Don't forget one overlooked trigger: none. If you never want your pipeline to trigger automatically, then you can use none. It's useful if you're going to create a pipeline that is only manually triggered.

There are other triggers for other events such as:

 -  Pull Requests (PRs), which can also filter on branches and paths.
 -  Schedules, which allow you to specify cron expressions for scheduling pipeline runs.
 -  Pipelines, which will enable you to trigger pipelines when other pipelines complete, allowing pipeline chaining.

You can find all the documentation on triggers [here](/azure/devops/pipelines/build/triggers).

## Jobs

A job is a set of steps executed by an agent in a queue (or pool). Jobs are atomic – that is, they're executed wholly on a single agent. You can configure the same job to run on multiple agents simultaneously, but even in this case, the entire set of steps in the job are run on every agent. If you need some steps to run on one agent and some on another, you'll need two jobs.

A job has the following attributes besides its name:

1.  displayName – a friendly name.
2.  dependsOn - a way to specify dependencies and ordering of multiple jobs.
3.  condition – a binary expression: if it evaluates to true, the job runs; if false, the job is skipped.
4.  strategy - used to control how jobs are parallelized.
5.  continueOnError - to specify if the rest of the pipeline should continue or not if this job fails.
6.  pool – the name of the pool (queue) to run this job on.
7.  workspace - managing the source workspace.
8.  container - for specifying a container image to execute the job in - more later.
9.  variables – variables scoped to this job.
10. steps – the set of steps to execute.
11. timeoutInMinutes and cancelTimeoutInMinutes for controlling timeouts.
12. services - sidecar services that you can spin up.

## Dependencies

You can define dependencies between jobs using the `dependensOn` property. It lets you specify sequences and fan-out and fan-in scenarios.

If you don't explicitly define a dependency, a sequential dependency is implied.

If you want jobs to run in parallel, you need to specify `dependsOn: none`.

Let's look at a few examples. Consider this pipeline:

```YAML
jobs:

- job: A
  steps:
  # steps omitted for brevity


- job: B
  steps:
  # steps omitted for brevity

```

Because no dependsOn was specified, the jobs will run sequentially: first A and then B.

To have both jobs run in parallel, we add dependsOn: none to job B:

```YAML
jobs:

- job: A
  steps:
  # steps omitted for brevity


- job: B
  dependsOn: none
  steps:
  # steps omitted for brevity

```

If we want to fan out and fan in, we can do that too:

```YAML
jobs:

- job: A
  steps:

  - script: echo' job A.'


- job: B
  dependsOn: A
  steps:

  - script: echo' job B.'


- job: C
  dependsOn: A
  steps:

  - script: echo' job C.'


- job: D
  dependsOn:

  - B
  - C
  steps:

  - script: echo' job D.'


- job: E
  dependsOn:

  - B
  - D
  steps:

  - script: echo' job E.'

```

:::image type="content" source="../media/jobs-dependency-chart-7231b7f2.png" alt-text="Dependency Chart.":::


## Checkout

Classic builds implicitly checkout any repository artifacts, but pipelines require you to be more explicit using the checkout keyword:

 -  Jobs check out the repo they're contained in automatically unless you specify `checkout: none`.
 -  Deployment jobs don't automatically check out the repo, so you'll need to specify checkout: self for deployment jobs if you want to get access to files in the YAML file's repo.

## Download

Downloading artifacts requires you to use the download keyword. Downloads also work the opposite way for jobs and deployment jobs:

 -  Jobs don't download anything unless you explicitly define a download.
 -  Deployment jobs implicitly do a download: current, which downloads any pipeline artifacts that have been created in the current pipeline. To prevent it, you must specify `download: none`.

## Resources

What if your job requires source code in another repository? You'll need to use resources. Resources let you reference:

1.  other repositories
2.  pipelines
3.  builds (classic builds)
4.  containers (for container jobs)
5.  packages

To reference code in another repo, specify that repo in the resources section and then reference it via its alias in the checkout step:

```YAML
resources:
  repositories:

  - repository: appcode
    type: git
    name: otherRepo

steps:

- checkout: appcode

```

## Steps are Tasks

Steps are the actual "things" that execute in the order specified in the job.

Each step is a task: there are out-of-the-box (OOB) tasks that come with Azure DevOps. Many of which have aliases, and tasks that get installed to your Azure DevOps organization via the marketplace.

Creating custom tasks is beyond the scope of this chapter, but you can see how to create your custom tasks [here](/azure/devops/extend/develop/add-build-task).

## Variables

It would be tough to achieve any sophistication in your pipelines without variables. Though this classification is partly mine, there are several types of variables, and pipelines don't distinguish between these types. However, I've found it helpful to categorize pipeline variables to help teams understand some of the nuances when dealing with them.

Every variable is a key: value pair. The key is the name of the variable, and it has a value.

To dereference a variable, wrap the key in $(). Let's consider this example:

```YAML
variables:
  name: martin
steps:

- script: echo "Hello, $(name)!"

```

It will write Hello, martin! To the log.
