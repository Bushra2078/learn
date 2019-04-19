Azure Pipelines is a cloud service that you can use to automatically build and test your code project and make it available to other users. It works with just about any language or project type.

Mara is excited about replicating the team's build process on Azure Pipelines. Amita, the tester, finally has some free time and she wants to catch up. Mara decides that now is a great time to tell her about her plan: setting up an automated build pipeline for the _Space Game_ web site using Azure Pipelines.

When she hears Mara's plan, Amita is a bit hesitant. But since Mara's plan is to replicate the build process but not replace it, she's also curious. She knows the build process could use some improvements.

**Amita**: It sounds like an interesting exercise, but you must want to prove a DevOps point!

**Mara**: You already know me so well!

**Amita**: What improvements do you expect to see, especially since you're going to do what we already do?

**Mara**: I think that just moving to Azure Pipelines will bring a lot of benefits. Remember, Azure Pipelines is a cloud service that you can use to automatically build and test code and make it available to others. It works with just about any language or project type.

Our build server has problems. Even keeping it up to date is hard. Since Azure Pipelines provides build servers that Microsoft hosts and maintains, it's always got the latest patches and security updates. We won't have to worry about maintaining build servers.

Also, we have all kinds of scripts written by different people. We don't even understand how some of them work. Azure Pipelines comes with a catalog of tasks. A _task_ is a packaged script or procedure that has been abstracted with a set of inputs. I'm going to try and map what the scripts do to those tasks. At least we can standardize how things get done and increase the level of automation.

Finally, Azure Pipelines works with many different languages and application types. If we want to expand in those directions, we won't have to retool.

**Amita**: I know it's selfish but why do I care? One of my big problems is that I never know when a build is ready to test. Sometimes someone remembers to update the spreadsheet but a lot of times they forget. It seems like I'm the last person to know.

**Mara**: Right, that's something we can easily fix. We can set up the pipeline to notify you automatically, either through email or some other kind of notification, when a build is ready. You'll never have to wait for someone to remember you again.

**Amita**: Okay, so your goal right now is to build the app and let me know when it's ready?

**Mara**: Right! Of course, I've got bigger plans. I know you're all going to love this first step so I want to build on it to give us true continuous integration.

**Amita**: Give me the 5 minute rundown on continuous integration (CI).

**Mara**: Let me draw you a picture.

Mara moves to the whiteboard and draws the pipeline.

![A hand-drawn illustration of a CI pipeline](../media/2-whiteboard-pipeline-with-callouts.png)

This is my CI pipeline. Continuous Integration (CI) is the process of automating the build and testing of code every time a team member commits changes to version control. I know we don't do automated testing yet but give it time.

A _pipeline_ defines the continuous integration process for the app. It's made up of steps called _tasks_ ![Callout 1](../../shared/media-draft/callout-01.png). It can be thought of as a script that defines how your build, test, and deployment steps are run. I'm going to try and map our scripts to tasks.

The pipeline runs when you submit code changes ![Callout 2](../../shared/media-draft/callout-02.png). You can configure the pipeline to run automatically or you can run it manually. You connect your pipeline to a source repository such as GitHub, Bitbucket, or Subversion. We're using GitHub.

A _build agent_ ![Callout 3](../../shared/media-draft/callout-03.png) builds or deploys the code. When your build or deployment runs, the system begins one or more jobs. An agent is installable software that runs one build or deployment job at a time. Because we're using Azure Pipelines, we can use a Microsoft-hosted agent. With Microsoft-hosted agents, maintenance and upgrades are taken care of for you. Each time you run a pipeline, you get a fresh virtual machine. There are six virtual machine images to choose from, including Ubuntu 16.04, which is what we use.

The final product of the pipeline is a _build artifact_ ![Callout 4](../../shared/media-draft/callout-04.png). Think of an artifact as the smallest compiled unit that your team needs to test or deploy your app. For example, an artifact can be:

* A Java or .NET application packaged into a .jar or .zip file
* A C++ or JavaScript library
* A virtual machine, cloud, or Docker image

And that's it. I know we can do this.

**Amita**: It sounds great. Let's see what you have to do to get it to work and how long it takes you. You can give us all a demo.

**Mara**: Will do!