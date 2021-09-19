You've set up a dev container for one of your agency's projects. It will now "just work" for anyone who has Docker and the Remote - Containers extension. Almost. They'll still have to install dependences. They might also need some Visual Studio Code extensions that they don't know about. 

Fortunately, you can fully customize and automate all the project setup by using the devcontainer.json file.

## A closer look at devcontainer.json

Let's look at the main options in the .devcontainer/devcontainer.json file from the Products Dashboard project. It's a bit long to look at all at once, so let's look at it in sections.

### Build configuration

The `build` section defines how the container will be created. You'll recognize the Dockerfile as being the other file in the .devcontainer folder. 

```json
"build": {
    "dockerfile": "Dockerfile",
    ...
},
```

### Settings

The `settings` option copies machine-specific settings into the container.

```json
"settings": {
    "terminal.integrated.shell.linux": "/bin/bash",
    "python.pythonPath": "/usr/local/bin/python",
    "python.linting.enabled": true,
    ...
},
```

You might have these settings in your own Visual Studio Code setup. In this Python container, some of these settings are setting the terminal shell. Some are setting Python editing options in Visual Studio Code. These options will give the user an opinionated Python editing experience.

### Project settings

The last section of the file deals directly with project configuration.

```json
// Add the IDs of extensions you want installed when the container is created.
"extensions": [
    "ms-python.python"
],

// Use 'postCreateCommand' to run commands after the container is created.
// "postCreateCommand": "pip3 install --user -r requirements.txt",

// Comment out connect as root instead. More info: https://aka.ms/vscode-remote/containers/non-root.
"remoteUser": "vscode"
```

- You can use the `extensions` array to specify which Visual Studio Code extensions should be installed in Visual Studio Code when it connects to the container. Your normal Visual Studio Code setup and all the extensions that you already have won't be present when you're using Remote - Containers. Extensions are specified here with their ID. 

- The `postCreateCommand` option lets you run any commands that you want after the container is created. If you remember from the first exercise, you had to run the `pip3` command to install dependencies. But how would you know to do that? You might not. You can configure it here so that it will happen automatically and others won't have to worry about it.

In the next exercise, you'll modify the devcontainer.json file to automate several aspects of the project that will set up other developers for immediate success.
