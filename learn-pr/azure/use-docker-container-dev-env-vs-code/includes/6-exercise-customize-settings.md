The devcontainer.json file helps you configure a variety of settings in your containerized Visual Studio Code setup. So far, you've configured a dev container for a Python project. However, there are still some rough edges and setup tasks that you can further automate. 

In this exercise, you'll use the devcontainer.json file to smooth these edges and make the project work with no setup steps from the developer.

## Reopen the project locally

Before you change the container configuration, you need to reopen the project locally.

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **locally** and select **Remote-Containers: Reopen Folder Locally**.
1. Notice that the remote indicator changes back to your local environment.

    :::image type="content" source="../media/remote-indicator-local.jpg" alt-text="Remote indicator showing a local connection":::

    > [!Note]
    > If you are using WSL and the Remote WSL extension, your indicator may show a connection to WSL when you re-open locally

1. Open the devcontainer.json file in the .devcontainer folder if it's not open already.

## Install Visual Studio Code extensions

The container comes with the Microsoft Python extension. The Python extension enables snippets, linting, and IntelliSense in Python files. But the index.html file in the templates folder is a Jinja template, and a different extension needs to be installed to get syntax highlighting in that file.

1.  Press <kbd>F1</kbd> to open the Command Palette.
1.  Type **extension** and select **Extensions: Install Extensions**.
1.  In the extension explorer on the right, search for **jinja**.
1.  Right-click the **Jinja** extension from **wholroyd** and select **Add to devcontainer.json**.
1.  Notice that the extension ID has been added to the `extensions` option.

    ```json
    // Add the IDs of extensions you want installed when the container is created.
    "extensions": [
        "ms-python.python",
        "wholroyd.jinja"
    ],
    ```

## Automate dependency installation

Right now, a developer who's setting up the project for the first time has to know to run `pip3 install --user -r requirements.txt` to install dependencies. Without these dependencies, the project won't run, and other developers might not know why.

Uncomment the `postCreateCommand` option.

```json
"postCreateCommand": "pip3 install --user -r requirements.txt"
```

This will cause the container to automatically install depedencies whenever a container is created.

## Rebuild the new container

1. Open the Command Palette.
1. Type **rebuild** and select **Remote-Containers: Rebuild and Reopen in Container**.

The container will be rebuilt with the changes you've specified in the devcontainer.json file. 

> [!NOTE]
> Whenever a container is rebuilt, the container is removed and completely recreated. 

## Examine syntax highlighting provided by the Jinja extension

1. Open the template/index.html file.
1. Scroll down to line 33 and notice that syntax highlighting is on the `for` loop. This syntax highlighting is enabled by the Jinja extension

   :::image type="content" source="../media/for-loop.jpg" alt-text="Screenshot of a Jinja template, emphasizing a for loop with syntax highlighting.":::

## Run the app

1.  Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the Visual Studio Code integrated terminal.
1.  Run the app by using the following command:

    ```bash
    python app.py
    ```

1.  Notice that you didn't have to install any dependencies. The application simply runs.

The container is now customized and automated for your agency. Any developer who opens this project by using Remote - Containers can immediately run it and get to work writing code.

In the next unit, you'll learn how to install software in the dev container.
