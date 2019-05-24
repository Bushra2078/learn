This module shows you how to make sure you're writing code that's secure by scanning it for potential vulnerabilities. You'll also learn some techniques that can ensure that the code you write is of high quality and is easily maintainable.

Are you certain that the code you're writing is secure? Have you ever inadvertently added a vulnerability that could be exploited? As a developer, you need to be sure that you're not deploying code that could compromise the integrity of your software. You can detect potential code security issues by _shifting left_, which means scanning your code for potential issues early in the development process.

In this module, you'll learn about tools and procedures that you can use to give your team and your stakeholders peace of mind when it comes to understanding the possible vulnerabilities in your codebase. You'll also examine the codebase to find *code smells*, or maintainability issues, that will likely add time to the maintenance of your code. This maintenance time is called *technical debt*.

In this module, you'll:

* Learn what resources are available to scan your code for security vulnerabilities, bugs, and code smells
* Use SonarCloud to scan your code locally and as part of your build pipeline
* Limit your scanning to pull requests only by using conditions

## Prerequisites

The prerequisites are the same as the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

You'll also need an account on [SonarCloud](https://sonarcloud.io?azure-portal=true). Sign in using your GitHub or Azure DevOps account.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process using Azure DevOps.
