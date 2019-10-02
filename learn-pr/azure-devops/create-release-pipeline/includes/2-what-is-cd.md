In this part, you follow the Tailspin team as they discuss how a continuous delivery (CD) pipeline can help them with their upcoming release.

The Tailspin team is starting to feel better about their build process. They've got an automated process running on Azure Pipelines, which means the build environment is stable. Amita knows immediately when there's an artifact for her to test. She's finding fewer bugs because Andy and Mara have started to add unit tests and code quality tests. Life is looking good. Let's check in with the team.

## Morning meeting

Everyone on the team is in the meeting room waiting for Irwin, the product manager, who says he wants to talk to them. They're looking forward to telling him about the progress they've made. But when Irwin walks in, he doesn't look happy. He starts talking right away.

**Irwin:** I had a meeting this morning with the management team. They want to know why we're taking so long to release our games and websites. Our closest competitors get new features and new games out there much faster than we do. We need to speed things up. I'm not just saying this to you. I'm saying it to all the teams. What can we do to help your team deploy faster?

Irwin looks around. Andy clears his throat.

**Andy:** This is a little sudden but we're a bit ahead of you. We've been automating how we build our websites. Maybe now it's time to extend our automation to our release process.

**Irwin:** How would you do that?

**Mara:** We created an automated build pipeline with Azure Pipelines. It builds an artifact that Amita can test. We could also build a continuous delivery, or CD, pipeline.

**Irwin:** Which is what?

Mara beings to explain things, but is interrupted when Irwin's cell phone beeps. Irwin reads a text message and mutters under his breath.

**Irwin:** I'm really sorry but this is urgent. I have to go. Why don't you all figure out this CD business and get back to me, soon?

Andy looks around at his team.

**Andy:** Coffee?

Andy and the rest of the team head to the coffee shop to create a plan.

## How will the team deploy faster?

The team is having a meeting over coffee. Irwin, the product manager, has told them they need to start releasing new versions of the web site faster and he's left it up to them to figure out how to do it.

**Andy:** So, as I told Irwin just before he ran off, I think it's time to build a CD pipeline. Automation is the only way to release faster.

Mara nods. Amita and Tim look unhappy.

**Tim:** I don't really know what CD is, but if it means losing control of my production environment, I won't do it.

**Amita:** If it means all the tests are automated, what am I supposed to do? It's not only about my job. I don't think we should sacrifice the user experience just to meet some arbitrary deadline.

Amita starts crumbling her scone into little pieces.

**Andy:** Tim, you won't lose control over your production environment. And Amita, you're correct, we should never sacrifice the user experience. Let's talk a bit about what CD is so we all understand each other. Mara, want to try?

**Mara:** Sure.

## What is continuous delivery?

**Mara:** To me, CD and DevOps are inseparable. Remember that we defined DevOps as the union of people, process, and products to enable continuous delivery of value to our end users.

CD by itself is a set of processes, tools and techniques that makes rapid, reliable and continuous delivery of software possible. So CD isn't only about setting up a pipeline, although that part is important. CD is about setting up a working environment, where:

* We have a reliable and repeatable process for releasing and deploying software.
* We automate as much as possible.
* We don't put off doing something that's difficult or painful. Instead, we do it more often so that we figure out how to make it routine.
* We keep everything in source control.
* We all agree that "done" means "released."
* We build quality into the process. Quality is never an afterthought.
* We all are responsible for the release process. We no longer work in silos.
* We always try to improve.

We've already put many of these ideas into place and we all agree they've improved how we work. CD is an extension of what we've already started.

## Why do I need continuous delivery?

CD helps software teams deliver reliable software updates to their customers on a rapid cadence. CD helps ensure that both customers and stakeholders have the latest features and fixes quickly.

Let's continue to listen in on the team as they talk this out.

**Andy:** Thanks, Mara. We need CD because, as we all know, the world has changed. Releases with new features are happening faster. Updates and bug fixes need to be available right away. It isn't just our management that wants to speed up our releases. They're simply reacting to the demands of our customers. If customers can't get what they want from us, they'll go somewhere else.

The old way of doing things, where we all worked in our separate silos and didn't talk to each other is too slow and, honestly, it's frustrating for all of us.

We need to work together if we're going to succeed. All of us have seen how automation gives us a reliable, repeatable, and faster process for building artifacts. CD will bring those benefits to an entire release pipeline.

Amita, I think your life has gotten better since we added tests to the build pipeline. You aren't getting regression bugs. You're also getting automatic updates that tell you when builds are ready.

Tim, I'm going to ask you to be patient. I know you haven't seen a lot of benefit yet, but I promise you, you will. When you're home on the weekends instead of here because we keep crashing your production environment, you'll be happier. Can I ask you both to give CD a chance?

Amita and Tim look at each other and nod.

**Tim:** Let's get started.

**Andy:** Thanks, everyone. I'm going to propose that Mara and I put together a simple proof of concept (POC) that we can show you. I think everything will be a lot easier to understand if you can see a CD pipeline in action.

Tim laughs.

**Tim:** Don't let me stop you from doing all the work!

**Amita:** Good luck, you two.

The team leaves Andy and Mara to work out the details.

## How does continuous delivery compare to "right-click publishing"?

Many development tools provide ways to publish your application directly to some target environment, such as IIS or Azure App Service. For example, you can [Publish an ASP.NET Core app to Azure with Visual Studio](https://docs.microsoft.com/aspnet/core/tutorials/publish-to-azure-webapp-using-vs?azure-portal=true). This process of sometimes called "right-click publishing".

Right-click publishing is a great way to quickly build a prototype. For example, you might right-click publish your application to Azure so that you can share a new idea with your team. However, right-click publishing has its limits.

Continuous delivery provides a consistent way for you and your team to continuously test, deploy, and monitor your application each time you check in your code. When you right-click publish your application, there's no guarantee whether the code has undergone the proper testing or will perform as expected against real-world usage.

In this short video, Abel Wang, Cloud Advocate at Microsoft, explains more.

**Ask Abel**

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/Why-should-or-shouldnt-I-just-right-click-and-publish-my-apps-to-Azure--One-Dev-Question/player?format=ny]

## How does continuous delivery compare to continuous deployment?

In the DevOps community, you might hear the terms _continuous delivery_ and _continuous deployment_. Do these terms mean the same thing? In this short video, Abel explains the difference.

**Ask Abel**

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/What-is-the-difference-between-Continuous-Delivery-and-Continuous-Deployment--One-Dev-Question/player?format=ny]

## What continuous delivery tools can I use?

After the meeting ends, Andy and Mara plan next steps. They use Azure Pipelines to build their software. They want to look at their options to see what tools, including Azure Pipelines, are available to help them with their release process.

**Mara:** Where do you want to start?

**Andy:** First, we need to agree on our release management tool. Let's make sure the tool we choose:

* Supports our version control system.
* Can deploy to multiple environments so we can test and validate our work.
* Makes it easy to define the deployment tasks we need to perform.
* Is easy to extend.

**Mara:** Azure DevOps integrates with several other CI/CD solutions. There are a lot of options out there and we don't already have an investment in any of them. If we did, it would make sense to simply use that one. Popular CI/CD systems include Jenkins, Circle CI, GitLab, Travis CI, and Azure Pipelines.

These tools have their similarities but each also has its particular strengths. Some of these tools are open source, some are free, and some you have to pay for. They each also provide built-in integrations with other software tools.

For example, Jenkins is open source. It has a lot of plug-ins and many companies use it. You can run Circle CI in the cloud or on premises. I think we would need to customize it. GitLab is a single application for the entire software development lifecycle. It might be bigger than we want right now. Of course, we can keep using Azure Pipelines.

My point is there are many possibilities. Here's a short video where Abel talks about using DevOps best practices to deploy code to Azure.

**Ask Abel**

> [!VIDEO https://channel9.msdn.com/Blogs/One-Dev-Minute/Can-I-use-DevOps-best-practices-to-get-my-code-deployed-in-Azure--One-Dev-Question/player?format=ny]

**Mara:** My vote is to stay with Azure Pipelines.

**Andy:** I agree. Azure Pipelines has worked great for us so far and we don't have to learn another new technology.

**Mara:** Great. Let's get started on the pipeline details.

Andy and Mara move to a conference room to plan their CD pipeline.