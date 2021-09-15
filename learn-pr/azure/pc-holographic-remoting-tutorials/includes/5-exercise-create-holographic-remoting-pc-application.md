In this tutorial, you'll learn how to create a PC app for Holographic Remoting. That lets you connect to HoloLens 2 at any time, providing a way to visualize 3D content in Mixed Reality.

## Configure the capabilities

In the Project Settings window, expand the **Publishing Settings**, then scroll down to the Capabilities section and then select the following:

* Internet Clint server
* Private Network Client Server

:::image type="content" source="../media/player-setting.png" alt-text="Screenshot of Player settings" lightbox="../media/player-setting.png":::

[!INCLUDE[](includes/switch-platform.md)]

## Build your application to pc

[!INCLUDE[](includes/build-your-application-to-pc.md)]

## Test holographic remoting remote application

To connect your PC application to your HoloLens 2, do the following:

### 1. Install the remoting player application on holoLens 2 device

* On your HoloLens 2, visit the Store app and search for **"Remoting Player."**
* Select the **Remoting Player** app.
* Tap **Install** to download and install the app.

### 2. Connect the holographic remoting pc app to the remoting player

* Start the **Remoting Player** on your HoloLens.
* Take note of the HoloLens **IP address**. It will be displayed as a hologram by the **Remoting Player** as soon as it launches.
* Open the Holographic Remoting PC application on your PC.
* Once the application is launched, enter the **IP address** and click the **Connect** button to connect.
