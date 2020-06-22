In this module, you'll run Cognitive Services on an edge device with Azure IoT Edge. You will combine the advantages of Azure IoT Edge (ability to run offline if needed) with the characteristics of docker containers that enable you to run Cognitive Service APIs on the edge.

In this module, you'll focus on language detection working with the Text Analytics API. You'll deploy a Language Detection container to the edge device that uses Text Analytics API. This API enables you to detect which language the input text is written in.

The steps you'll follow:

1. Create an IoT Hub

2. Create an IoT Edge device

3. Create an Azure resource for Text Analytics

4. Configure your Language Detection container with the Cognitive Services keys

5. Set Language Detection container on to the edge device

6. Test your Cognitive Service

By the end of the module, you'll deploy a module to an edge device, which uses Cognitive Services in a container. It will analyze text and detect the language of the text on the edge. You'll test your Text Analytics API in the browser.
Consider the scenario outlined previously. In this scenario, for a disaster zone, you were tasked with managing donated medical supplies from a variety of countries. Using cognitive API capabilities like language detection on an edge device, you can rapidly sort out the source of the medicine even when connectivity is non-existent.