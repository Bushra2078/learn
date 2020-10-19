We talked about all the concepts behind the pipeline, CI, and Docker. Now it's time to put these concepts into practice.

Let's recap our designed pipeline.

:::image type="content" source="../media/3-pipeline-5-deploy.png" alt-text="The designed pipeline":::

You'll build this pipeline using GitHub Actions workflow.

## Build the Action workflow

1. To start building your pipeline, go to the fork of the sample repository in the GitHub website and select the **Actions** tab.

    :::image type="content" source="../media/6-1-actions-tab.png" alt-text="Open the actions tab in the GitHub website":::

1. Select the "set up a workflow yourself" link just below the header. A new editor with a file in it should be opened

    :::image type="content" source="../media/6-2-example-editor.png" alt-text="Example file being edited":::

    As you can see, the pipeline is just a file within the `.github/workflows` directory in your repository.

    GitHub provides you with the prebuilt components you need to build most of the pipelines. You'll have an example file like this:

    ```yml
    # This is a basic workflow to help you get started with Actions

    name: CI

    # Controls when the action will run. Triggers the workflow on push or pull request
    # events but only for the main branch
    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]

    # A workflow run is made up of one or more jobs that can run sequentially or in parallel
    jobs:
      # This workflow contains a single job called "build"
      build:
        # The type of runner that the job will run on
        runs-on: ubuntu-latest

        # Steps represent a sequence of tasks that will be executed as part of the job
        steps:
          # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
          - uses: actions/checkout@v2

          # Runs a single command using the runners shell
          - name: Run a one-line script
            run: echo Hello, world!

          # Runs a set of commands using the runners shell
          - name: Run a multi-line script
            run: |
              echo Add other actions to build,
              echo test, and deploy your project.
    ```

1. Rename the file from `main.yml` to `build-latest.yml` by typing on the top input panel

1. Change the `name` key to _"Build and push the latest build to staging"_, your file will look like this example:

    ```yml
    # This is a basic workflow to help you get started with Actions

    name: Build and push the latest build to staging
    ```

### Create the trigger

1. Next, change the default triggers in the `on` key.

    The default file comes with two triggers:

    1. Any push to the `main` branch

    1. Any pull request on the `main` branch

    Remove the second part and leave just the `push` tags. The keys should be like this afterwards:

    ```yml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]
    ```

    This closes the second trigger in the designed diagram.

### Build and push the image

1. Now, let's work on the jobs you're going to run.

    In this part, you'll address both the build and deploy steps from the diagram.

    GitHub workflows are divided into jobs, and these jobs are divided into steps. Each step can have multiple commands and use multiple actions to be executed.

    The `jobs` key is already set to run on `ubuntu-latest`, which is the environment you want this workflow to run.

1. Rename the `build` key to `build_push_image`.

1. Jump into the `steps` key. Delete the last two commands, those are only examples from the template. Your file will be like the following.

    ```yml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2
    ```

    See that you already have a step using the `checkout` action. This action is responsible for cloning the repository into the job environment.

    This is the equivalent to the first action in the "Build steps" in the diagram, so this is taken care of.

    Add another action to build your Docker image.

1. In the right panel, search for "Build and push docker images". Select the first result published by **Docker**.

    :::image type="content" source="../media/6-3-docker-action.png" alt-text="Select the action":::

    In the opened panel, select the **copy icon** to copy the usage YAML.

    :::image type="content" source="../media/6-4-docker-copy.png" alt-text="Copy the YAML":::

1. Paste the copied yaml below the `- uses: actions/checkout@v2` key. Your YAML file should be like the following

    ```yml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Build and push Docker images
            # You may pin to the exact commit or the version.
            # uses: docker/build-push-action@ab83648e2e224cfeeab899e23b639660765c3a89
            uses: docker/build-push-action@v1.1.1
            with:
              # Username used to log in to a Docker registry. If not set then no login will occur
              username: # optional
              # Password or personal access token used to log in to a Docker registry. If not set then no login will occur
              password: # optional
              # Server address of Docker registry. If not set then will default to Docker Hub
              registry: # optional
              # Docker repository to tag the image with
              repository:
              # Comma-delimited list of tags. These will be added to the registry/repository to form the image's tags
              tags: # optional
              # Automatically tags the built image with the git reference as per the readme
              tag_with_ref: # optional
              # Automatically tags the built image with the git short SHA as per the readme
              tag_with_sha: # optional
              # Path to the build context
              path: # optional, default is .
              # Path to the Dockerfile (Default is '{path}/Dockerfile')
              dockerfile: # optional
              # Sets the target stage to build
              target: # optional
              # Always attempt to pull a newer version of the image
              always_pull: # optional
              # Comma-delimited list of build-time variables
              build_args: # optional
              # Comma-delimited list of images to consider as cache sources
              cache_froms: # optional
              # Comma-delimited list of labels to add to the built image
              labels: # optional
              # Adds labels with git repository information to the built image
              add_git_labels: # optional
              # Whether to push the image
              push: # optional, default is true
    ```

    > [!IMPORTANT]
    > Be mindful of the indentation when using YAML. The `name` key should be aligned with the previous `uses` key.

    This action gives us several options to tweak the usage. You can learn more about each one of them in the [documentation page](https://github.com/docker/build-push-action/tree/releases/v1).

1. In the `name` key, rename the value to "Build and push staging image"

1. You'll only use a handful of the parameters given by this action. Set them and delete the others.

    Add the values according to the table below.

    |Key name     |Value                                           |
    |-------------|------------------------------------------------|
    |username     |`${{ secrets.ACR_LOGIN }}`                      |
    |password     |`${{ secrets.ACR_PASSWORD }}`                   |
    |registry     |`${{ secrets.ACR_NAME }}`                       |
    |repository   |contoso-website                                 |
    |tags         |latest                                          |

    You can delete all the other keys since they'll not be used. Your file should be like the following example:

    ```yml
    name: Build and push the latest build to staging

    on:
      push:
        branches: [ main ]

    jobs:
      build_push_image:
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v2

          - name: Build and push staging image
            uses: docker/build-push-action@v1.1.1
            with:
              username: ${{ secrets.ACR_LOGIN }}
              password: ${{ secrets.ACR_PASSWORD }}
              registry: ${{ secrets.ACR_NAME }}
              repository: contoso-website
              tags: latest
    ```

1. Commit the changes by clicking the green button on the top right. Give the commit a message and click the **Commit new file** button

    :::image type="content" source="../media/6-5-commit-staging.png" alt-text="Commit the workflow to the repo":::

You'll notice that, right after you commit the file, a new build will start on the **Actions** tab. This build will fail, because you haven't set the secrets yet!

:::image type="content" source="../media/6-6-first-build.png" alt-text="First failed build":::

### Set the secrets

1. Go to the **Settings** tab in the repository. Scroll down until you find a left menu called **Secrets**. Click on it.

1. Click the **New secret** button on the top right

1. Create `ACR_NAME` secret

    1. Put `ACR_NAME` in the **Name** field.
    1. Run the following command in the Azure Cloud Shell to obtain the login server of the ACR you created earlier.

    ```azurecli-interactive
    az acr list --query "[?contains(resourceGroup, 'mslearn-gh-pipelines')].loginServer" -o table
    ```

    1. Put the value in the **Value** field of the secret

1. Create `ACR_LOGIN` secret

    1. Put `ACR_LOGIN` in the **Name** field.

    1. If you saved the values presented to you in the end of the set-up script, copy the **ACR Login Username** value. If not, run the following command in the Azure Cloud Shell to obtain the login of the ACR you created earlier.

    ```azurecli-interactive
    az acr credential show --name <ACR_NAME> --query "username" -o table
    ```

    1. Put the value in the **Value** field of the secret

1. Create `ACR_PASSWORD` secret

    1. Put `ACR_PASSWORD` in the **Name** field.

    1. If you saved the values presented to you in the end of the set-up script, copy the **ACR Login Password** value. If not, run the following command in the Azure Cloud Shell to obtain the login of the ACR you created earlier.

    ```azurecli-interactive
    az acr credential show --name <ACR_NAME> --query "passwords[0].value" -o table
    ```

    1. Put the value in the **Value** field of the secret

### Push the image

1. Go back to the **Actions** tab

1. Click the only execution in the list

1. Click on the **Rerun jobs** in the right-hand side of the screen and then "Rerun all jobs"

    :::image type="content" source="../media/6-7-rerun-jobs.png" alt-text="Rerun all jobs":::

1. Run `az acr repository list --name <ACR_NAME> -o table` in the Azure Cloud Shell to confirm there's a repository named `contoso-website` listed in the results
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)
