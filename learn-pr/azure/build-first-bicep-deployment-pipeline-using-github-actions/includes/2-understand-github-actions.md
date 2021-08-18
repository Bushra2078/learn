You can automate the steps in your deployment process by using a *workflow*. Each time you make a change to your code and commit the change to your Git repository, the workflow runs your predefined process. A workflow can verify whether your Bicep code meets your quality standards, and then it automates the actions to deploy your resources to Azure. The process is defined in a *workflow definition* that you create.

GitHub Actions is a feature of GitHub. GitHub also hosts the Git repositories you use to store and share your code with your collaborators. When you store your Bicep code on GitHub, GitHub Actions can access your code to automate your deployment processes. In this unit, you'll learn about GitHub Actions.

## What is a workflow?

A workflow is the repeatable process that you use to test and deploy your code defined in a configuration file. A workflow includes all the steps you want to execute and in what order.

When you work with GitHub Actions, you define your workflow in a YAML file. This YAML file needs to be stored in your repository in a folder named `.github/workflows`. A YAML file is a structured text file, similar to how Bicep is a structured text file. You can create and edit YAML files by using any text editor. In this module, you'll use Visual Studio Code. The GitHub web interface also provides some tools that you can use to view and edit your workflow YAML files.

Because a workflow YAML file is a code file, the file is stored with your Bicep code in your Git repository. You use Git features to collaborate on your workflow definition. You can manage different versions of your workflow file by using commits and branches. 

## Runners

Until now, you've deployed your Bicep files from your local computer. After you write a Bicep template, you deploy it to Azure by using the Azure CLI or Azure PowerShell. These tools use your computer's resources to submit the template to Azure. They use your personal identity to authenticate you to Azure and to verify that you have the permissions to deploy the resources.

A workflow also needs access to a computer, so it can execute the deployment actions. GitHub Actions uses a machine called a *runner*. An runner is a computer that's configured to run deployment steps for a workflow. Each runner already has the Bicep and Azure tooling you used in earlier modules, so it can do the same things you do from your own computer. Instead of a human executing commands, the GitHub Actions service instructs the runner to run the steps that you've defined in a YAML file.

GitHub Actions provides multiple types of runners for different operating systems, like Ubuntu or Windows, and different sets of tools. GitHub runs these runners, so you don't have to maintain any compute infrastructure for the runners. The runners sometimes are called *GitHub-hosted runners* or *hosted runners* because they're hosted on your behalf. When your workflow runs, a hosted runner is automatically created. When your workflow is finished running, the hosted runner is automatically deleted. You can't access hosted runners directly, so it's important that your workflow contains all the steps necessary to deploy your solution.

:::image type="content" source="../media/2-runner.png" alt-text="Diagram that shows a workflow that runs on an runner." border="false":::

> [!NOTE]
> You have the option to create a custom runner that's called a *self-hosted runner*. You might create a self-hosted runner if you have specific software that you need to run as part of your workflow or if you need to control precisely how the runner is configured. We don't discuss self-hosted runners in this module, but we provide a link to more information in the summary.

## Triggers

To instruct GitHub Actions *when* to run your workflow, you create a *trigger*. You can choose from multiple types of triggers. For now, you'll use a *manual trigger*. You'll manually tell GitHub Actions when to start running your workflow. Later in this module, you'll learn more about other types of triggers.

:::image type="content" source="../media/2-trigger.png" alt-text="Diagram that shows a trigger initiating a workflow." border="false":::

## Steps

A *step* represents a single operation that the workflow performs. A step is similar to an individual command that you run in Bash or PowerShell. For most deployments, you execute several steps in a sequence. You define the sequence and all the details of each step in your workflow YAML file.

GitHub Actions offers two types of steps:

- **Run steps**. Use a run step to run a single command or a sequence of commands in Bash, PowerShell, or the Windows command shell.
- **Action steps**. An action step is a convenient way to access many different capabilities without writing script statements. For example, there is a built-in task to deploy Bicep files to Azure. Anyone can write an action and share it with other users. A large set of commercial and open-source tasks are available.

Some people prefer to use script statements instead of actions because they offer more control over what's executed. Other people prefer to use actions so that they don't have to write and manage scripts. In this module, we use a mixture of both approaches.

## Jobs

In GitHub Actions, a *job* represents an ordered set of steps. You always have at least one job in a workflow, and when you create complex deployments, it's common to have more than one job.

> [!NOTE]
> You can set each job to run on a different runner. Running jobs on different runners is useful when you build and deploy solutions that need to use different operating systems in different parts of the job workflow.
>
> For example, suppose you're building an iOS app and the app's back-end service. You might have one job that runs on a macOS runner to build the iOS app and another job that runs on an Ubuntu or Windows runner to build the back end. You might even tell the workflow to run the two jobs simultaneously, which speeds up your workflow's execution.

:::image type="content" source="../media/2-steps.png" alt-text="Diagram that shows a workflow with two steps, both within one job." border="false":::

## Basic workflow example

Now that you know the basic concepts in GitHub Actions, let's look at a simple workflow definition in YAML:

:::code language="yaml" source="code/2-simple.yml" :::

Let's look at each part of the file in detail:

- `name` is the name of your workflow. The name is shown on the GitHub web interface.
- `on` tells your workflow when to execute. In this case, `on: [workflow_dispatch]` tells GitHub Actions that you want to manually trigger the workflow.
- `jobs` groups together all the jobs in your workflow.
- `say-hello` is the name of your first and only job in this workflow. 
- `runs-on` instructs the workflow which runner to use when it runs the job. In this example, the workflow runs on a runner running the Ubuntu operating system, which comes from a pool of GitHub-hosted runners.
- `steps` lists the sequence of steps to run in the job. The example YAML includes two steps. Both steps run a simple script to echo some text. Each step has a `name` value, which is a human-readable name for the step. You'll see the display name when you look at the workflow logs. To create a multi-line script step, use the pipe character (`|`) as shown in the example. After your step executes, you'll see the outputs in the workflow log.

> [!IMPORTANT]
> In YAML files, indentation is important. Take a look at the example YAML. Some lines in the YAML are indented by two or four spaces. The number of spaces you use is important. If you don't indent your file correctly, GitHub Actions can't interpret it. Visual Studio Code helps you find and fix errors in your YAML file indentation.
