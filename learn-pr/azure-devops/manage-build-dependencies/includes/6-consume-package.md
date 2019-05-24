In this part, you'll get the new Tailspin.SpaceGame.Web code that has the model classes removed. Instead of referencing the models directly, the code will reference them from the package you created in the previous unit. 

Here is a list of the steps:

> [!div class="checklist"]
> * Get the new code from a branch of the original **Tailspin.SpaceGame.Web** repository.
> * Reference the new Models package, version 1.0.0.
> * Change the build pipeline to look for this package in your Azure Artifacts feed.
> * Watch the pipeline successfully build the application.

## Fetch the branch from GitHub

Here you'll fetch the `models-package` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules, but the **Models** directory has been removed.

1. From a new instance of Visual Studio Code, open the integrated terminal.

1. Run the following `git` commands to fetch a branch named `models-package` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream models-package
    git checkout models-package
    ```

    As you did in previous modules, the format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.
1. As an optional step, verify that the **Models** directory no longer exists in the file explorer.

    Instead, you see **Controllers**, **Views**, and other directories.

## Reference the Models package

1. Open the **Tailspin.SpaceGame.Web.csproj** file, add the following `PackageReference`, and save the file.

    ```xml
    <PackageReference Include="Tailspin.SpaceGame.Web.Models" Version="1.0.0" />
    ```

    This references the **Tailspin.SpaceGame.Web.Models** package that you created in Azure Artifacts. Notice the version number, 1.0.0. This matches the initial version that you published to Azure Artifacts in the previous part.

> [!NOTE]
> When you save the file, Visual Studio Code may ask you to restore dependencies. We're not going to run this locally, so there is no need to restore the dependencies. Accessing your Azure Artifacts feed locally requires you to add a package source to set up authentication. We'll skip that here for brevity.

## Add the pipeline configuration

The `models-package` branch does not contain an initial **azure-pipelines.yml** file. Here's your chance to create it.

1. From Visual Studio Code, select **File > New File**. Then select **File > Save** to save the blank file as **azure-pipelines.yml** in your project's root directory, such as **~/mslearn-tailspin-spacegame-web**.

1. Copy the following YAML code into **azure-pipelines.yml**:

    [!code-yml[](code/6-azure-pipelines-yaml.yml?highlight=36-42)]

    The highlighted code shows where the pipeline restores dependencies and looks in your Azure Artifacts feed for the dependencies that might be there.

1. Stage, commit, and push your changes to GitHub.

    ```bash
    git add .
    git commit -m "Add reference to Models package"
    git push origin models-package
    ```

1. Navigate to Azure Pipelines and watch the build run. The build picks up your Models package from Azure Artifacts and builds the project successfully.