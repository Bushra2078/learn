This module is about how to add automated tests to your build pipeline.

As you add a feature to your app, how do you _know_ whether those features work correctly, given all possible inputs? How do you know that the feature works well with &mdash; and doesn't break &mdash; other features? How do you know that your code is maintainable and can be easily understood by others?

You _could_ run the app locally and try a few inputs. But that takes time and doesn't cover all cases. Plus, repeatedly testing existing features gets tedious and time consuming as you add new features.

In this module, you'll learn how to set up automated testing to help ensure that your latest feature will work, and to help make sure you didn't break anything along the way.

In this module, you will:

* Learn the benefits of automated testing and the kinds of testing you can use
* Run unit tests locally and then in Azure Pipelines
* Add dashboard widgets to visualize test runs over time
* Perform code coverage testing to see how much of your code is covered by unit tests
* See a test fail in the pipeline and then fix the failure

## Prerequisites

The prerequisites are the same as the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline-azure-pipelines?azure-portal=true) module.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project on GitHub handy.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-row.md)]

[!include[](../../shared/includes/meet-amita-short-row.md)]

[!include[](../../shared/includes/meet-tim-short-row.md)]

[!include[](../../shared/includes/meet-mara-short-row.md)]

:::row-end:::

Mara's prior experience is helping bring DevOps to the team.