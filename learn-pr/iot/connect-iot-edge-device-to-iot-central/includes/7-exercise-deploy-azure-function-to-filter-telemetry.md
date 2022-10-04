Filter the telemetry sent by the device.

To reduce the amount of telemetry sent to your IoT Central application, you want to filter the data on the IoT Edge device.

In this unit, you'll use Azure Functions running on the IoT Edge device to implement a filter. The filter ensures that the device only sends telemetry when the ambient temperature is above 21&deg;C.

## Configure a container registry

Your IoT Edge device will need to download and install the custom Azure Functions module that implements the filter. IoT Edge modules are packaged as Docker-compatible images that you can store in a container repository. You decide to use the Azure Container Registry (ACR) to store your new module. You'll also use ACR to build the container from a source project.

Run the following commands to add a container registry to your resource group in Azure:

```azurecli
REGISTRY_NAME="edgecentral$RANDOM"
az acr create -n $REGISTRY_NAME -g <rgn>[sandbox resource group name]</rgn> --sku Standard --admin-enabled true
az acr credential show -n $REGISTRY_NAME
echo "Your registry name is: $REGISTRY_NAME"
```

Make a note of the registry name and `password` values, you use them later in this unit.

## Create an Azure Functions project

You're using C# to implement the function. Run the following commands to install the project template and then generate a skeleton project:

```azurecli
dotnet new -i Microsoft.Azure.IoT.Edge.Function
dotnet new aziotedgefunction -n FilterFunction -r $REGISTRY_NAME.azurecr.io/filterfunction
cd FilterFunction
ls
```

Run the following command to replace the existing _FilterFunction.cs_ with an implementation that filters the machine temperature telemetry:

```azurecli
curl -O https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/edge-vm-deploy/FilterFunction.cs
```

Now build the image and upload it to your container registry. Expect this command to take a couple of minutes to run:

```azurecli
az acr build --registry $REGISTRY_NAME --image filterfunction:v1 -f Dockerfile.amd64 .
```

You can list the images in your registry with the following command:

```azurecli
az acr repository list --name $REGISTRY_NAME
```

## Update the deployment manifest

To use the new filter module on your IoT Edge device, update the deployment manifest with the new version.

Download the new deployment manifest and interface definition to your local machine by right-clicking on the following links and choosing **Save as**:

- [EnvironmentalSensorManifestFilter.json](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/edge-vm-deploy/EnvironmentalSensorManifestFilter.json)
- [TelemetryInterfaceFilter.json](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/edge-vm-deploy/TelemetryInterfaceFilter.json)

Open the _EnvironmentalSensorManifestFilter.json_ in a text editor and update it to use the filter module from your container registry:

1. Replace the three instances of `<YOUR CONTAINER REGISTRY NAME>` with the name of your container registry. The name looks like `edgecentral27912`.
1. Replace `<YOUR CONTAINER REGISTRY PASSWORD>` with the password you made a note of previously in this unit.
1. Save the changes.

This version of the deployment manifest:

- Adds the module with the Azure function you created:

    ```json
    "filterfunction": {
        "settings": {
            "image": "{your container registry}.azurecr.io/filterfunction:v1",
            "createOptions": ""
        },
        "type": "docker",
        "status": "running",
        "restartPolicy": "always",
        "version": "1.0"
    }
    ```

- Routes the output from the **SimulatedTemperatureSensor** module to the **filterfunction** module before sending the filtered telemetry to your IoT Central application:

    ```json
    "routes": {
        "FilterFunctionToIoTCentral": "FROM /messages/modules/filterfunction/outputs/* INTO $upstream",
        "sensorToFilterFunction": "FROM /messages/modules/SimulatedTemperatureSensor/outputs/temperatureOutput INTO BrokeredEndpoint(\"/modules/filterfunction/inputs/input1\")"
    },
    ```

To upload the new deployment manifest:

1. In your IoT Central application, navigate to **Edge manifests** and select the **Environmental Sensor** manifest.

1. On the **Customize** page, upload the new *EnvironmentalSensorManifestFilter.json* file. Select **Next**.

1. The **Review and finish** page shows the new **filterfunction** module. Select **Save**.

1. Navigate to the **store-001** device from the **Devices** page and select **Modules**.

1. On the **Modules** page, select **Manage manifest > Assign edge manifest**. Select the **Environmental Sensor** manifest.

1. The list of modules now includes the running **filterfunction** module:

:::image type="content" source="../media/7-filterfunction-running.png" alt-text="Screenshot that shows the FilterFunction module running on the IoT Edge device.":::


## Update the device template to use the new module

The IoT Edge device is now sending the telemetry through the **filterfunction** interface instead of the **Telemetry** interface. Therefore, you need to update the device template and views:

1. Navigate to the **Environmental Sensor Edge Device** on the **Device templates page**.

1. Select **Modules**, and then select **Import modules from manifest**.

1. In the **Import modules** dialog, select **Environmental Sensor**, and then select **Import**.

:::image type="content" source="../media/7-module-filterfunction.png" alt-text="Screenshot that shows the FilterFunction module added to the device template.":::

The new module now sends the telemetry to IoT Central. Next, add an interface to the new filter module that specifies the telemetry and update the chart:

1. Select **Module FilterFunction**, then **+ Add inherited interface**.
1. Choose the **Import interface** tile. Select the **TelemetryInterfaceFilter.json** file you downloaded previously.
1. Select **Save** to save your changes.

You can remove the original **Telemetry** interface because the **SimulatedTemperatureModule** no longer sends telemetry directly to IoT Central. The output from this module is routed to the **FilterFunction** module by the IoT Edge runtime:

1. Select the **Telemetry** interface in the **SimulatedTemperatureSensor** module.
1. Select **Delete** and then confirm the operation.

Modify the **View IoT Edge device telemetry** view to display the telemetry sent by the **FilterFunction** module:

1. In the device template, select the **View IoT Edge device telemetry** view, and then select the **Edit** option on the chart tile.
1. Add the **ambient/temperature**, **humidity**, **machine/temperature**, and **pressure** telemetry values.
1. Select **Update** and then **Save** to save your changes.
1. Select **Publish** to publish the new version of the device template.

## View the filtered data

To view the filtered telemetry from your IoT Edge device:

1. Navigate to the **store-001** device on the **Devices** page.
1. Select the **View IoT Edge device telemetry** view.
1. You can see the filtered telemetry on the chart. There are no values shown with an average ambient temperature of less than 21.0 degrees.

    :::image type="content" source="../media/7-telemetry-view.png" alt-text="Screenshot that shows telemetry plot with no average ambient temperature values less than 21.":::

If the device appears to stop sending telemetry, it's likely to be because the **SimulatedTemperatureSensor** module stops sending telemetry after sending 500 messages. If you restart the VM, the count resets and you see telemetry start to flow again:

```azurecli
az vm restart --resource-group <rgn>[sandbox resource group name]</rgn> \
  --name $(az vm list --resource-group <rgn>[sandbox resource group name]</rgn> --query [0].name -o tsv)
```
