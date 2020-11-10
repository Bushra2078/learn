In this unit, you will learn how to partner a High-level application with a Real-time core application.

------

## Solution architecture

In this unit we will learn how to partner a high level application with an Azure RTOS Real-time environment monitor application running on one of the Azure Sphere Cortex-M4 cores.

![Inter-core communications architecture](../media/intercore-coms.png)

To recap the solution architecture introduced in the Azure RTOS lab.

1. The Azure RTOS Real-time environment sensor thread runs every 2 seconds. The thread stores in memory the latest environment temperature, humidity, and pressure data.
2. The High-level telemetry streaming app requests from the Real-time core the latest environment data.
3. The Azure RTOS Real-time environment service thread responses with the latest environment data.
4. The High-level application serializes the environment data as JSON and sends as a telemetry message to IoT Hub
5. Azure IoT Central subscribes to telemetry messages sent to IoT Hub by the device and displays the data to the user.
6. The IoT Central user can also set the desired temperature for the room by setting a property. The property is set on the device via an IoT Hub device twin message.
7. The Azure Sphere then sets the HVAC operating mode to meet the desired temperature.

------

## Inter-core message contract

There needs to be a contract that describes the shape of the data being passed between the cores. The following structure declares the inter-core contract used in this unit. You can find this contact in the **IntercoreContract** directory.

```c
typedef enum
{
  LP_IC_UNKNOWN,
  LP_IC_HEARTBEAT,
  LP_IC_ENVIRONMENT_SENSOR,
} LP_INTER_CORE_CMD;

typedef struct
{
  LP_INTER_CORE_CMD cmd;
  float temperature;
  float pressure;
  float humidity;
} LP_INTER_CORE_BLOCK;
```

------

## Inter-core security

To communicate, applications running across cores must be configured with corresponding Component IDs.

The Component ID for the Real-time application can be found in its **app_manifest.json** file.

```json
{
  "SchemaVersion": 1,
  "Name": "AzureSphereIoTCentral",
  "ComponentId": "25025d2c-66da-4448-bae1-ac26fcdd3627",
  ...
}
```

### High-Level inter-core capabilities

The **AllowedApplicationConnections** property in the High-Level **app_manifest.json** file is set to the Component ID of the Azure RTOS Real-time application.

```json
{
    ...
    "AllowedApplicationConnections": [ "6583cf17-d321-4d72-8283-0b7c5b56442b" ]
    ...
}
```

------

## Initializing inter-core communications

In the **InitPeripheralAndHandlers** a call is made to **lp_interCoreCommunicationsEnable**, passing in the Component ID of the Real-time and the inter-core callback function.

The inter-core callback function will be called when a message is received from the Real-time core.

```c
lp_interCoreCommunicationsEnable(lp_config.rtComponentId, InterCoreHandler);
```

------

## Sending a request to the Real-time core application

To request the environment data from the Real-time core then:

1. Set the inter-core control block command to LP_IC_ENVIRONMENT_SENSOR.
2. Send the request message by calling lp_interCoreSendMessage and passing the inter-core control block.

```c
/// <summary>
/// Read sensor and send to Azure IoT
/// </summary>
static void MeasureSensorHandler(EventLoopTimer* eventLoopTimer)
{
    if (ConsumeEventLoopTimerEvent(eventLoopTimer) != 0)
    {
        lp_terminate(ExitCode_ConsumeEventLoopTimeEvent);
    }
    else {
        // send request to Real-Time core app to read temperature, pressure, and humidity
        ic_control_block.cmd = LP_IC_ENVIRONMENT_SENSOR;
        lp_interCoreSendMessage(&ic_control_block, sizeof(ic_control_block));
    }
}
```

------

## Receiving inter-core messages

When the High-level application receives a message the inter-core callback function is called passing a reference to the inter-core control block containing the environment data. The application serializes the data as JSON, sends the telemetry message to IoT Hub, and the HVAC status LED is updated. Azure IoT Central subscribes to telemetry messages sent to IoT Hub by the device and displays the data to the user.

```c
/// <summary>
/// Callback handler for Inter-Core Messaging - Does Device Twin Update, and Event Message
/// </summary>
static void InterCoreHandler(LP_INTER_CORE_BLOCK* ic_message_block)
{
    static int msgId = 0;

    switch (ic_message_block->cmd)
    {
    case LP_IC_ENVIRONMENT_SENSOR:
        if (snprintf(msgBuffer, JSON_MESSAGE_BYTES, msgTemplate, ic_message_block->temperature,
            ic_message_block->humidity, ic_message_block->pressure, msgId++) > 0) {

            Log_Debug("%s\n", msgBuffer);
            lp_azureMsgSendWithProperties(msgBuffer, telemetryMessageProperties, NELEMS(telemetryMessageProperties));

            SetHvacStatusColour((int)ic_message_block->temperature);

            // If the previous temperature not equal to the new temperature then update ReportedTemperature device twin
            if (previous_temperature != (int)ic_message_block->temperature) {
                lp_deviceTwinReportState(&dt_reportedTemperature, &ic_message_block->temperature);
            }
            previous_temperature = (int)ic_message_block->temperature;
        }
        break;
    default:
        break;
    }
}
```
