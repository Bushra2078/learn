In this module, you'll learn how to control an Azure Sphere application by using Azure IoT Central properties and commands. This module will cover Azure IoT direct methods.

## Azure IoT direct methods

The following steps outline how an Azure IoT Central command uses Azure IoT Hub direct methods for cloud-to-device control.

1. A user invokes an Azure IoT Central command. Azure IoT Hub sends a direct method message to the device. For example, reset the device. This message includes the method name and an optional payload.
2. The device receives the direct method message and calls the associated handler function.
3. The device implements the direct method; in this case, reset the device.
4. The device responds with an HTTP status code, and optionally a response message.

### The direct method pattern

![The illustration shows a direct method pattern.](../media/azure-direct-method-pattern.png)

## Direct method bindings

Direct method bindings map a direct method with a handler function that implements an action.

### Cloud-to-device commands

In **main.c**, the variable named **resetDevice** of type **DirectMethodBinding** is declared. This variable maps the Azure IoT Central **ResetMethod** command property with a handler function named **ResetDirectMethod**.

```
static LP_DIRECT_METHOD_BINDING resetDevice = { 
	.methodName = "ResetMethod", 
	.handler = ResetDirectMethodHandler 
};
```

## Azure IoT Central commands

Azure IoT Central commands are defined in device templates.

![The illustration shows a device template interface.](../media/iot-central-device-template-interface-fan1.png)

1. From Azure IoT Central, navigate to **Device template**, and select the **Azure Sphere** template.
2. Click on **Interface** to list the interface capabilities.
3. Scroll down and expand the **ResetMethod** capability.
4. Review the definition of **ResetMethod**. The capability type is **Command**.
5. The schema type is **Object**. Click on the **view** button to display the object definition. The object definition describes the shape of the JSON payload sent with the command. In this example, the shape of the JSON payload will be the same as this example: *{"reset_timer":5}*.

## Direct method handler function

1. From Azure IoT Central, a user invokes the **Reset Azure Sphere** command.

   A direct method named **ResetMethod**, along with a JSON payload, is sent to the device. The JSON payload *{"reset_timer":5}* specifies how many seconds to wait before resetting the device.

2. The **ResetDirectMethod** function handler is called.

   When the device receives a direct method message, the **DirectMethodBindings** set is checked for a matching **DirectMethodBinding** *methodName* name. When a match is found, the associated **DirectMethodBinding** handler function is called.

3. The current UTC time is reported to Azure IoT using a device twin binding property named **DeviceResetUTC**.

4. The direct method responds with an HTTP status code and a response message.

5. The device is reset.

6. Azure IoT Central queries and displays the device twin's reported property **DeviceResetUTC**.

![The illustration shows how a direct method works.](../media/azure-sphere-method-and-twin.png)

```
/// <summary>
/// Start Device Power Restart Direct Method 'ResetMethod' {"reset_timer":5}
/// </summary>
static LP_DIRECT_METHOD_RESPONSE_CODE ResetDirectMethodHandler(JSON_Object* json, LP_DIRECT_METHOD_BINDING* directMethodBinding, char** responseMsg)
{
	const char propertyName[] = "reset_timer";
	const size_t responseLen = 60; // Allocate and initialize a response message buffer. The calling function is responsible for the freeing memory
	static struct timespec period;

	*responseMsg = (char*)malloc(responseLen);
	memset(*responseMsg, 0, responseLen);

	if (!json_object_has_value_of_type(json, propertyName, JSONNumber))
	{
		return LP_METHOD_FAILED;
	}
	int seconds = (int)json_object_get_number(json, propertyName);

	// leave enough time for the device twin deviceResetUtc to update before restarting the device
	if (seconds > 2 && seconds < 10)
	{
		// Report Device Reset UTC
		lp_deviceTwinReportState(&deviceResetUtc, lp_getCurrentUtc(msgBuffer, sizeof(msgBuffer))); // LP_TYPE_STRING

		// Create Direct Method Response
		snprintf(*responseMsg, responseLen, "%s called. Reset in %d seconds", directMethodBinding->methodName, seconds);

		// Set One Shot LP_TIMER
		period = (struct timespec){ .tv_sec = seconds, .tv_nsec = 0 };
		lp_setOneShotTimer(&resetDeviceOneShotTimer, &period);

		return LP_METHOD_SUCCEEDED;
	}
	else
	{
		snprintf(*responseMsg, responseLen, "%s called. Reset Failed. Seconds out of range: %d", directMethodBinding->methodName, seconds);
		return LP_METHOD_FAILED;
	}
}
```

## Working with direct method binding

Direct method bindings must be added to **directMethodBindingSet**. When a direct method message is received from Azure, this set is checked for a matching *methodName* name. When a match is found, the corresponding handler function is called.

```
LP_DIRECT_METHOD_BINDING* directMethodBindingSet[] = { &resetDevice };
```

### Opening

Sets are initialized in the **InitPeripheralsAndHandlers** function found in **main.c**.

```
lp_openDirectMethodSet(directMethodBindingSet, NELEMS(directMethodBindingSet));
```

### Dispatching

When a direct method message is received, the set is checked for a matching *methodName* name. When a match is found, the corresponding handler function is called.

### Closing

Sets are closed in the **ClosePeripheralsAndHandlers** function found in **main.c**.

```
lp_closeDirectMethodSet();
```
