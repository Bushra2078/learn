When working on a project requiring port forwarding, you may want to modify the port that's forwarded, or you may want a configuration different than the default. In this exercise, you'll explore and make some changes to your current port forwarding setup.

## Open the Remote Explorer

1. Press <kbd>F1</kbd> to open the Command Palette
1. Type "remote explorer" and select "View: Show Remote Explorer"
1. Ensure you have "Containers" selected from the top dropdown menu
1. Observe port 5000 is forwarded

:::image type="content" source="../media/Remote-explorer-containers.png" alt-text="Screenshot of Remote Explorer with containers view in Visual Studio Code":::

## Launch the forwarded port

1. Select the globe icon next to 5000 -> 127.0.0.1:5000 to open your app in a browser
1. Your app will launch at http://127.0.0.1:5000/

## Stop forwarding a port

1. Stop forwarding port 5000 (right-click -> Stop Forwarding Port, or select the X next to the globe)
1. You'll notice port 5000 is still being used by the container but no longer being forwarded
1. Try navigating to http://127.0.0.1:5000/ - the page won't load since the container's port 5000 is no longer being properly forwarded

:::image type="content" source="../media/Port-5000-not-forwarded.png" alt-text="Screenshot of Port 5000 not forwarded in Forwarded Ports section of Remote Explorer in Visual Studio Code":::

## Forward to a new port

In case you no longer want to use localhost port 5000, let's forward to a new port. 

1. Select the + next to port 5000 (or right-click -> Forward Port)
1. Notice it automatically maps to port 5000. If you'd like to map to a different port, right-click, select "Change Local Port," and type a new port of your choosing, i.e. 5001
1. Navigate to http://127.0.0.1:5001/ and notice your web app loads

## Stop web app

1. Stop the execution of your web app with <kbd>Ctrl</kbd> + <kbd>c</kbd> in the integrated terminal
1. Select the globe icon next to 5000 -> 127.0.0.1:5000 again
1. Notice your app no longer loads

## Remove forwarded port

1. Stop forwarding port 5000
1. Notice the port disappears and the view is replaced with "Forward a Port...". Since the app isn't running, it isn't using port 5000, so it doesn't list port 5000 as an available but "Not Forwarded" port as it did earlier
1. Enter the following command in the terminal to start the project...

        python app.py

1. Notice VS Code automatically takes care of port forwarding again!

Great work! We've now explored port forwarding with a dev container in VS Code. 

Rather than using the Remote Explorer or **Forward a Port** command from the Command Palette, you could also specify a list of ports you always want to forward when attaching or opening a folder in container through the `forwardPorts` property in `devcontainer.json`. We'll explore customizing our container's setup through properties like this in `devcontainer.json` in the next section.