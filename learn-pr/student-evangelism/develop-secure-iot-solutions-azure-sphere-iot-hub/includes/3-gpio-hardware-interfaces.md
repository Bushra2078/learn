In this unit, you'll learn about GPIO hardware interfaces.

The terms you'll tackle:

- **Hardware:** Most IoT solutions are designed to interface with hardware and interact with the real world. The most common interfaces on a device are GPIO, PWM, I2C, SPI, ADC, and UART.

- **GPIO(General Purpose Input Output):** Any GPIO pin can be designated (in software) as an input or output pin and can be used for a wide range of purposes. These labs use single pin GPIO peripherals for input and output, so the following is an introduction to GPIO pins.

- **GPIO Output:** If a GPIO pin is designated as an *output* pin, then the software running on the Azure Sphere can set a pin to be either on or off. This equates to 3.3 volts for a pin that has been turned on, and zero volts when turned off. It is important to check that a peripheral connected to the pin is 3.3 volts tolerant. Otherwise you may destroy the peripheral. Lots of peripherals use single pins such as LEDs, relays, reed switches.

- **GPIO Input:** If a GPIO pin is designated as an *input* pin, then the software running on the Azure Sphere can read a pin to determine if the voltage has been set to 3.3 volts, or zero volts/ground. It is essential to check that a peripheral will not set a voltage on a pin to anything higher than 3.3 volts **before** you connect it. Be warned, if you set a pin to a voltage higher than 3.3 volts you'll destroy the Azure Sphere. An example of a GPIO peripheral that uses a single pin is a push button.

- **Other Peripheral Interface Types:** The following is a list of other common peripheral interfaces found on devices, including the Azure Sphere. To learn more about each interface type, right mouse click and open the link in a new browser window.
  - [PWM - Pulse width modulation](https://en.wikipedia.org/wiki/Pulse-width_modulation)
  - [I2C - Inter-Integrated Circuit](https://en.wikipedia.org/wiki/I²C)
  - [SPI - Serial Peripheral Interface](https://en.wikipedia.org/wiki/Serial_Peripheral_Interface)
  - [ADC - Analog-to-digital converter](https://en.wikipedia.org/wiki/Analog-to-digital_converter)
  - [UART - Universal asynchronous receiver-transmitter](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter)

- **ISU:** You'll see references to **ISU** in the Azure Sphere and Mediatec documentation. An ISU is a Serial interface block and is an acronym for "**I**2C, **S**PI, **U**ART.". For more information, see the [MT3620 Support Status](https://docs.microsoft.com/azure-sphere/hardware/mt3620-product-status?WT.mc_id=github-blog-dglover) page.

## Azure Sphere Developer Board Peripheral Interfaces

You can find detailed peripheral interface information for each board by clicking on the board image.

| Azure Sphere MT3620 Starter Kit Hardware User Guide          | Seeed Studio Azure Sphere MT3620 Development Kit             | Seeed Studio Azure Sphere MT3620 Mini Dev Board              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [![img](../media/avnet-pinout.jpg)](https://www.avnet.com/opasdata/d120001/medias/docus/196/Azure Sphere Starter Kit User Guide (v1.3).pdf) | [![img](../media/seeed-studio-rdb-pinmap.png)](http://wiki.seeedstudio.com/Azure_Sphere_MT3620_Development_Kit/) | [![img](../media/seeed-studio-mini-pinmap.jpg)](http://wiki.seeedstudio.com/MT3620_Mini_Dev_Board/) |

## Introduction to the Azure Sphere Learning Path Labs

For this module, you'll clone the [Azure Sphere Developer Learning Path repository](https://github.com/MicrosoftDocs/Azure-Sphere-Developer-Learning-Path).

There are a number of Learning Path libraries that support these labs. These Learning Path C functions are prefixed with **lp_**, typedefs and enums are prefixed with **LP_**.

The Learning Path libraries are open source and contributions are welcome.

The Learning Path libraries are built from the [Azure Sphere Samples](https://github.com/Azure/azure-sphere-samples) and aim to demonstrate best practices.

The Learning Path libraries are **not** part of the official Azure Sphere libraries or samples.

## Input and Output Peripherals

In the Azure Sphere Learning Path labs there are several Peripheral variables declared, including LEDs, buttons, and a relay. Variables of type **LP_PERIPHERAL_GPIO** declare a GPIO model for **input** and **output** of single pin peripherals, such as LEDs, buttons, reed switches, and relays.

A GPIO Peripheral variable holds the GPIO pin number, the initial state of the pin when the program starts, whether the pin logic needs to be inverted, and the function called to open the peripheral.

The following example declares an LED **output** peripheral.

```
static LP_PERIPHERAL_GPIO led1 = {
	.pin = LED1, // The GPIO pin number
	.direction = LP_OUTPUT, // for OUTPUT
	.initialState = GPIO_Value_Low, // Set the initial state on the pin when opened
	.invertPin = true, // Should the switching logic be reverse for on/off, high/low
	.initialise = lp_openPeripheral, // The function to be called to open the GPIO Pin
	.name = "led1" // An arbitrary name for the peripheral
};
```

The following example declares a button **input** peripheral.

```
static LP_PERIPHERAL_GPIO buttonA = {
	.pin = BUTTON_A,
	.direction = LP_INPUT, 	// for INPUT
	.initialise = lp_openPeripheral,
	.name = "buttonA"
};
```
