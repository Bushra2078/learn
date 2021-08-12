Now that you have a web app running on your machine through a dev container, let's understand how you can access that app through port forwarding.

## What is port forwarding?

Containers are isolated environments. Which means that if you start an application that serves up a web page, that service is isolated to that container and not accessible from your local machine. Port forwarding is what the Remote - Containers extension does so that you can access the Python Products dashboard from your browser.

## How port forwarding works

In the last exercise, Visual Studio Code forwarded the port for your container automatically. Your web app was running at port 5000 in the dev container and was sent to port 5000 of your host machine.

Although both the remote and local ports matched here (port 5000), that might not always be the case. For example, a remote server listening on port 3000 might be mapped to port 4123 on localhost if 3000 was already in use on localhost. You can then connect to this remote server by using http://localhost:4123. Accessing http://localhost:4123 will feel just like you're accessing a local server, which is the power of port forwarding!

## View or modify forwarded ports

You can forward a new port for the duration of the session by running the **Forward a Port** command from the Command Palette (<kbd>F1</kbd>) or clicking **Add Port** in the ports tab of the terminal.

You can also right-click and modify your port or open it in a browser, as shown in the following screenshot.

:::image type="content" source="../media/port-forwarded.png" alt-text="Screenshot of the Forwarded Ports section of the internal terminal in Visual Studio Code.":::

In the next section, you'll take a closer look at your forwarded ports and make some changes to understand forwarding even better.

:::image type="content" source="../media/port-right-click.png" alt-text="Screenshot of right-clicking on the forwarded port in the internal terminal in Visual Studio Code.":::