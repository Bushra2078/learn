Farmers around the world must carefully watch the weather to guarantee optimal growth or even the survival of their crops. Many farmers need to ensure a sufficient food supply not only for their community, but also for themselves. 

In 2015, it was estimated that 2 billion people who live in the rural areas of developing nations were involved in subsistence farming, growing what they need to eat and trade for daily essentials. The failure of their crops can literally mean having nothing to eat.

In the developed world, widespread access to the internet via computers and smartphones can provide detailed weather reports that help farmers plan how to best water or protect their crops. This data can be combined with sensors to track temperature, rainfall, and soil moisture. And it can be combined with complex AI models to make predictions or to provide guidance. 

In remote locations around the world, access to such technology is limited, although mobile phones with text messaging are common.

In this module, you'll create an application that lets farmers use text messaging to set up temperature alerts for specific locations. These alerts help farmers know when to plant, when to water, or when to protect their crops.

:::image type="content" source="../media/text-message.png" alt-text="Screenshot of text messages sent to and received by the application.":::

The temperature and location services that this app uses come from Azure Maps. Azure Maps is a collection of geospatial services that use fresh mapping data to provide geographic context to web and mobile applications. These services include APIs for maps, vehicle routing, weather, and geofencing.

In your app, you'll use the third-party communications service Twilio to manage sending and receiving text messages. 

You'll coordinate app functionality by using Azure Functions.

## Learning objectives

In this module, you will:

- Learn about using the Azure Maps APIs to get a location's weather forecast.
- Create and configure a Twilio account with a programmable phone number to send and receive text messages.
- Deploy an existing application to a function app by using Twilio and Azure Maps to manage and send temperature alerts for specific locations.

## Prerequisites

- Basic familiarity with Azure Functions, similar to what's covered in [Create serverless logic with Azure Functions](/learn/modules/create-serverless-logic-with-azure-functions/?azure-portal=true).