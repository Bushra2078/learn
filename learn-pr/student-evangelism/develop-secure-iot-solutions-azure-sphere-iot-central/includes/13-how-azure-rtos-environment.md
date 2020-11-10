In this unit you will learn about running Real-time applications on an Azure Sphere.

------

## Azure Sphere Architecture

The Azure Sphere microcontroller unit (MCU) has three developer-accessible cores, a Cortex-A7 which runs a Linux kernel, and two Cortex-M4 cores that can run bare-metal code, or a Real-time operating system such as Azure RTOS or FreeRTOS.

High-level applications running on the Cortex-A7 Linux kernel are used for less timing-sensitive tasks such as establishing network connections, negotiating security, updating device state, communicating with Real-time core applications, and sending telemetry messages to cloud gateways such as IoT Hub.

![Azure Sphere architecture](../media/azure-sphere-architecture.png)

------

## What is an RTOS (Real-Time Operating System)

A system is said to be Real-time if the total correctness of an operation depends not only upon its logical correctness, but also upon the time in which it is performed [Link to Wikipedia Article](https://en.wikipedia.org/wiki/Real-time_computing?azure-portal=true)

A Real-Time Operating System is system software that provides services and manages processor resources for applications. These resources include processor cycles, memory, peripherals, and interrupts. The main purpose of a Real-Time Operating System is to allocate processing time among various duties the embedded software must perform.

This typically involves a division of the software into pieces, commonly called “tasks” or “threads,” and creating a run-time environment that provides each thread with its own virtual microprocessor (“Multithreading”). Basically, a virtual microprocessor consists of a virtual set of microprocessor resources, e.g., register set, program counter, stack memory area, and a stack pointer. Only while executing does a thread use the physical microprocessor resources, but each thread retains its own copy of the contents of these resources as if they were its own private resources (the thread”s “context”).

------

## Introducing Azure RTOS

Azure RTOS is a Real-time Operating System available from Microsoft. Azure RTOS is an embedded development suite including a small but powerful operating system called ThreadX that provides reliable, ultra-fast performance for resource-constrained devices. The [Azure RTOS](https://azure.microsoft.com/en-us/services/rtos?azure-portal=true) suite includes other components such as GUI design tools and libraries. In this unit we will be using Azure RTOS ThreadX.

Azure RTOS ThreadX is an advanced real-time operating system (RTOS) designed specifically for deeply embedded applications. Among the multiple benefits it provides are real-time multithreading, inter-thread communication and synchronisation, and memory management. Azure RTOS ThreadX has many advanced features, including picokernel architecture, preemption threshold, event chaining and a rich set of system services.

------

## Why build and deploy Real-time applications

The reasons to run code on the Cortex M4 Real-time cores include:

1. You are migrating existing Cortex M4 code to an Azure Sphere.
1. Your application requires precise or deterministic timing that cannot be guaranteed on the Cortex-A7 Linux kernel core where it would have to complete with other services.
1. Your application may benefit from running across multiple cores to take advantage of all the memory and processing resources on the Azure Sphere.

To learn more, review the [Real-Time Operating System - What it is and why you might want to use one](https://azure.microsoft.com/en-au/resources/real-time-operating-system?azure-portal=true) guide.

------

## Inter-core communications

For security reasons, applications running on the Real-time cores cannot access any network resources. However, applications can communicate with applications running on other cores through a secure mailbox mechanism. There also needs to be a shared understanding or contract that describes the shape of the data being passed between the cores. Where possible describe the shape of the data messages using basic types like C ints, floats, enums, and characters. For more complex needs, such as passing an array of objects, then you will need to implement a serialization scheme.

The following structure declares the inter-core contract used in this unit. You can find this contact in the **IntercoreContract** directory.

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

## Solution architecture

![Inter-core communications architecture](../media/intercore-coms.png)

The following describes the solution architecture:

1. The Azure RTOS Real-time environment sensor thread runs every 2 seconds. The thread stores in memory the latest environment temperature, humidity, and pressure data.
2. The High-level telemetry streaming app requests from the Real-time core the latest environment data.
3. The Azure RTOS Real-time environment service thread responses with the latest environment data.
4. The High-level application serializes the environment data as JSON and sends the telemetry message to IoT Hub
5. Azure IoT Central subscribes to telemetry messages sent to IoT Hub by the device and displays the data to the user.
6. The IoT Central user can also set the desired temperature for the room by setting a property. The property is set on the device via an IoT Hub device twin message.
7. The Azure Sphere then sets the HVAC operating mode to meet the desired temperature.

------

## Real-time core security and communications

Like High-level applications, Real-time applications are secure by default and you must declare all resources the application requires. This includes access to peripherals and what applications the Real-time core can communicate with. To communicate, applications running across cores must be configured with corresponding Component IDs.

### Real-Time inter-core capabilities

To communicate, applications running across cores must be configured with corresponding Component IDs.

The Component ID for the High-level application can be found in its **app_manifest.json** file.

```json
{
  "SchemaVersion": 1,
  "Name": "AzureSphereIoTCentral",
  "ComponentId": "25025d2c-66da-4448-bae1-ac26fcdd3627",
  ...
}
```

The **AllowedApplicationConnections** property in the Real-time **app_manifest.json** file is set to the Component ID of the Azure Sphere High-level application.

```json
{
    ...
    "AllowedApplicationConnections": [ "25025d2c-66da-4448-bae1-ac26fcdd3627" ]
    ...
}
```
