Here we'll discuss how Azure Communication Services works behind the scenes. You'll learn about the pieces of Azure Communication Services and how they work together to solve your communication problems. 

We'll be covering:

* Azure Resources.
* Azure Communication Services SDKs for Client-based tasks.
* Azure Communication Services SDKs for Server-based tasks.

## Azure resources

The first element is making Azure Communication Services work is an Azure resource, which is created within the Azure Portal by you. Once a resource is created from the Azure Portal, it becomes the central hub for managing many Azure Communication Services tasks and administration.

The Azure resource within the portal is where you can:

* Manage and view the billing charges for your Azure Communication Services usage.
* Purchase and manage Phone Numbers.
* Manage security keys.
* Create event handlers for Azure Communication Services events.

With a properly configured resource within the Azure Portal, you and your team can continue building and creating Azure Communication Services solutions for your customers.

## Server SDKs

With an Azure resource setup, another component is some form of server-side management. This is created with our server focused SDKs.

Server-side programming is performed by downloading these SDKs, and writing small amounts of code which interact with Azure Communication Services. There's a couple of features and parts of Azure Communication Services that needs this:

* For voice/video calling and chat, you need to link an Azure Communication Services identity to your applications identity systems. This link is needed so that when your users make calls, or chat with each other you can link them back to your application's identity platform.
* For event handling of incoming calls or Short Messaging Service (SMS) messages.
* For processing of chat messages.
* For receiving and routing incoming calls.

Not all parts of Azure Communications Services will need it, but it's good to be aware of so you know what to expect.

We have Server SDKs available for:

* JavaScript
* .NET
* Java Server Edition(SE)
* Python

You can get these from our [SDK Documentation page](/azure/communication-services/concepts/sdk-options).

## Client SDKs

The last component of how Azure Communication Services works is also the most important as it provides the gateway for your customers to use Azure Communication Services products.

Our Client SDKs are downloaded and then integrated into your existing applications and products. When a customer makes a video call or talks using chat, it's the Client SDKs that connect you to the call and receive/transmit the audio and video.

We have Client SDKs available for:

* JavaScript
* .NET (C#)
* iOS (Swift)
* Android

You can get these from our [SDK Documentation page](azure/communication-services/concepts/sdk-options).

## Tying it all together

With the Azure resource, server and client parts of Azure Communication Services working together you have everything you need to piece together a communication solution for your product or service.
