Azure IoT Central is a fully managed Internet of Things (IoT) solution that makes it easy to connect, monitor, and manage your global IoT assets.

Here, you'll follow the scenario in which a remote coffee machine is connected to Azure IoT Central for monitoring and management of issues. You can monitor telemetry such as water temperature and humidity, observe the state of your machine, set optimal temperature, receive warranty status, and send commands. If the warranty is expired when the water temperature is outside the expected range, an email from IoT Central is sent to the client's maintenance department for further action.

You'll begin by a creating a device in Azure IoT Central that defines the data and commands that can be exchanged with the IoT device.

In this module, you will:

- Create an Azure IoT Central custom application
- Create and define your device template
- Connect a coffee machine simulator to your application in Azure IoT Central
- Validate your connection and data flow
- Configure rules for maintenance notifications

## Prerequisites

An active Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

## Create the Coffee Maker application

In this unit, you sign in to IoT Central and create a new custom application. An application created using a standard pricing plan.

1. Navigate to the Azure IoT Central [Build > New application](https://apps.azureiotcentral.com/build/new/custom) page.

1. On the sign-in page, enter the email address and password that you use to access your Microsoft account.

1. On the **New application** page:

    - Enter a friendly application name, such as **Coffee Maker 01-A**.
    - Optionally edit the URL - this is required if the name you selected is already in use.
    - Select **Custom application** as the application template.
    - Select one of the standard pricing plans. Select your **Directory**, **Azure subscription**, and **Location**. To learn about creating IoT Central applications, see [Create an IoT Central application](/azure/iot-central/core/howto-create-iot-central-application). To learn about pricing, see [Azure IoT Central pricing](https://azure.microsoft.com/pricing/details/iot-central/).
    - Choose **Create**.
