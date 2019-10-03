In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you built a basic release pipeline. That pipeline has a _Build_ stage that builds the artifact and a _Deploy_ stage that installs the web app on Azure App Service. Mara and Andy built this pipeline as a proof of concept that they showed to the rest of the team.

Of course, an actual release pipeline has more stages, each with its own set of tasks, that can potentially take an artifact all the way to production.

In this module, you'll join the Tailspin web team as they design a realistic release pipeline that contains multiple stages. You'll also learn different ways to control how an artifact gets promoted from one stage to the next.

A good release management workflow enables you to release more frequently and more consistently. In practice, you'll want to define a process that maps to your team's needs. Here, you'll create a basic workflow. That means first designing the environments, which define the runtimes of each stage in the pipeline.  You'll then deploy the _Space Game_ web application to these stages: _Dev_, _Test_ and _Staging_. Each stage deploys the application to its own App Service instance.

## Learning objectives

In this module, you will:

- Identify the stages, or major divisions of the pipeline, that you need to implement a multi-stage pipeline.
- Understand when to use conditions, triggers, and approvals to promote changes from one stage to the next.
- Promote a build through these stages: _Build_ _Dev_, _Test_, and _Staging_.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)

We also recommend you start at the beginning of this learning path, [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 2.1](https://www.microsoft.com/net/download?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure and Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process that uses Azure DevOps.