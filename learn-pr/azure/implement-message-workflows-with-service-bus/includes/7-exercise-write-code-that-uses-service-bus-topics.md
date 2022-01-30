You have decided to use an Azure Service Bus topic to distribute sales performance messages in your salesforce application. Sales personnel will use the app on their mobile devices to send messages that summarize sales figures for each area and time period. Those messages will be distributed to web services located in the company's operational regions, including the Americas and Europe.

You have already implemented the necessary infrastructure in your Azure subscriptions for the topic. Now, you want to write the code that sends messages to the topic and retrieves messages from a subscription.

Make sure you are working in the correct directory by running the following commands in the Azure Cloud Shell:

```bash
cd ~/mslearn-connect-services-together/implement-message-workflows-with-service-bus/src/start
code .
```

## Write code that sends a message to the topic

To complete the component that sends messages about sales performance, follow these steps:

1. In the Azure Cloud Shell editor, open *performancemessagesender/Program.cs* and locate the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved in the previous exercise between the quotation marks.

1. Locate the `SendPerformanceMessageAsync()` method. (*Hint*: It's located at or near line 26.)

1. Within that method, locate the following line of code:

    ```csharp
    // Create a Service Bus client here
    ```

1. Replace that line of code with the following code:

    ```csharp
    // By leveraging "await using", the DisposeAsync method will be called automatically once the client variable goes out of scope.
    // In more realistic scenarios, you would want to store off a class reference to the client (rather than a local variable) so that it can be used throughout your program.
    await using var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. Within that method, locate the following line of code:

    ```csharp
    // Create a sender here
    ```

1. Replace that line of code with the following code:

    ```csharp
    await using ServiceBusSender sender = client.CreateSender(TopicName);
    ```

1. Within the `try...catch` block, locate the following line of code:

    ```csharp
    // Create and send a message here
    ```

1. Replace that line of code with the following code:

    ```csharp
    string messageBody = "Total sales for Brazil in August: $13m.";
    var message = new ServiceBusMessage(messageBody);
    ```

1. To display the message in the console, insert the following code on the next line:

    ```csharp
    Console.WriteLine($"Sending message: {messageBody}");
    ```

1. To send the message to the topic, insert the following code on the next line:

    ```csharp
    await sender.SendMessageAsync(message);
    ```

1. Your final code should resemble the following example:

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace performancemessagesender
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://example.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=AbCdEfGhIjKlMnOpQrStUvWxYz==";
            const string TopicName = "salesperformancemessages";
    
            static void Main(string[] args)
            {
                Console.WriteLine("Sending a message to the Sales Performance topic...");
                SendPerformanceMessageAsync().GetAwaiter().GetResult();
                Console.WriteLine("Message was sent successfully.");
            }
    
            static async Task SendPerformanceMessageAsync()
            {
                // By leveraging "await using", the DisposeAsync method will be called automatically once the client variable goes out of scope.
                // In more realistic scenarios, you would want to store off a class reference to the client (rather than a local variable) so that it can be used throughout your program.
                await using var client = new ServiceBusClient(ServiceBusConnectionString);

                await using ServiceBusSender sender = client.CreateSender(TopicName);
    
                try
                {
                    string messageBody = "Total sales for Brazil in August: $13m.";
                    var message = new ServiceBusMessage(messageBody);
                    Console.WriteLine($"Sending message: {messageBody}");
                    await sender.SendMessageAsync(message);
                }
                catch (Exception exception)
                {
                    Console.WriteLine($"{DateTime.Now} :: Exception: {exception.Message}");
                }
            }
        }
    }
    ```

1. Save the file using the editor's **&#9776;** menu, or the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Send a message to the topic

1. To run the component that sends a message about a sale, run the following command in the Azure Cloud Shell:

    ```bash
    dotnet run -p performancemessagesender
    ```

1. As the program executes, watch for notifications in the Cloud Shell that indicate a message is being sent. Each time you run the app, another message is added to the topic, and a copy becomes available for each subscription.
  
    ```command
    Sending a message to the Sales Performance topic...
    Sending message: Total sales for Brazil in August: $13m.
    Message was sent successfully.
    ```

### Check the message count before you retrieve messages for a subscription

When you see **Message was sent successfully**, run the following command to see how many messages are in the `Americas` subscription. Remember to replace \<namespace-name\> with your Service Bus namespace.

```azurecli
az servicebus topic subscription show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --namespace-name <namespace-name> \
    --topic-name salesperformancemessages \
    --name Americas \
    --query messageCount
```

If you replace `Americas` with `EuropeAndAsia` and run the command again, you'll see that both subscriptions have the same number of messages.

## Write code that retrieves a topic message for a subscription

To create the component that retrieves messages about sales performance, follow these steps:

1. Run `code .` to launch the editor.

1. In the editor, open *performancemessagereceiver/Program.cs* and locate the following line of code:

    ```csharp
    const string ServiceBusConnectionString = "";
    ```

    Paste the connection string that you saved in the previous exercise between the quotation marks.

1. Locate the `MainAsync()` method.

1. Within that method, locate the following line of code:

    ```csharp
    // Create a Service Bus client that will authenticate using a connection string
    ```

1. To create a Service Bus client, replace that line with the following code:

    ```csharp
    var client = new ServiceBusClient(ServiceBusConnectionString);
    ```

1. Locate the following line of code:

    ```csharp
    // Create the options to use for configuring the processor
    ```

1. To configure message handling options, replace that line with the following code:

    ```csharp
    var processorOptions = new ServiceBusProcessorOptions
    {
        MaxConcurrentCalls = 1,
        AutoCompleteMessages = false
    };
    ```

1. Locate the following line of code:

    ```csharp
    // Create a processor that we can use to process the messages
    ```

1. To create a processor, replace that line with the following code:

    ```csharp
    ServiceBusProcessor processor = client.CreateProcessor(TopicName, SubscriptionName, processorOptions);
    ```

1. Locate the following line of code:

    ```csharp
    // Configure the message and error handler to use
    ```

1. To configure the handler, replace that line with the following code:

    ```csharp
    processor.ProcessMessageAsync += MessageHandler;
    processor.ProcessErrorAsync += ErrorHandler;
    ```

1. Locate the following line of code:

    ```csharp
    // Start processing
    ```

1. To start processing, replace that line with the following code:

    ```csharp
    await processor.StartProcessingAsync();
    ```

1. Look for the following line of code. 

    ```csharp
    // Since we didn't use the "await using" syntax here, we need to explicitly dispose the processor and client    
    ```

1. Replace the line with the following code:

    ```csharp
    await processor.DisposeAsync();
    await client.DisposeAsync();    
    ```

1. Locate the `MessageHandler()` method. You have registered this method to handle incoming messages.

1. To display incoming messages in the console, replace all the code within that method with the following code:

    ```csharp
    Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
    ```

1. To remove the received message from the subscription, on the next line, add the following code:

    ```csharp
    await args.CompleteMessageAsync(args.Message);
    ```

1. Your final code should resemble the following example:

    ```csharp
    using System;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Azure.Messaging.ServiceBus;
    
    namespace performancemessagereceiver
    {
        class Program
        {
            const string ServiceBusConnectionString = "Endpoint=sb://alexgeddyneil.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=LIWIyxs8baqQ0bRf5zJLef6OTfrv0kBEDxFM/ML37Zs=";
            const string TopicName = "salesperformancemessages";
            const string SubscriptionName = "Americas";
    
            static void Main(string[] args)
            {
                MainAsync().GetAwaiter().GetResult();
            }
    
            static async Task MainAsync()
            {
                var client = new ServiceBusClient(ServiceBusConnectionString);
    
                Console.WriteLine("======================================================");
                Console.WriteLine("Press ENTER key to exit after receiving all the messages.");
                Console.WriteLine("======================================================");
    
                var processorOptions = new ServiceBusProcessorOptions
                {
                    MaxConcurrentCalls = 1,
                    AutoCompleteMessages = false
                };

                ServiceBusProcessor processor = client.CreateProcessor(TopicName, SubscriptionName, processorOptions);

                processor.ProcessMessageAsync += MessageHandler;
                processor.ProcessErrorAsync += ErrorHandler;

                await processor.StartProcessingAsync();
                
                Console.Read();

                await processor.DisposeAsync();
                await client.DisposeAsync();
            }
    
            static async Task MessageHandler(ProcessMessageEventArgs args)
            {
                Console.WriteLine($"Received message: SequenceNumber:{args.Message.SequenceNumber} Body:{args.Message.Body}");
                await args.CompleteMessageAsync(args.Message);
            }

            static Task ErrorHandler(ProcessErrorEventArgs args)
            {
                Console.WriteLine($"Message handler encountered an exception {args.Exception}.");
                Console.WriteLine("Exception context for troubleshooting:");
                Console.WriteLine($"- Endpoint: {args.FullyQualifiedNamespace}");
                Console.WriteLine($"- Entity Path: {args.EntityPath}");
                Console.WriteLine($"- Executing Action: {args.ErrorSource}");
                return Task.CompletedTask;
            }
        }
    }
    ```

1. Save the file using either the **&#9776;** menu or use the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

## Run code to retrieve a topic message for a subscription

1. To run the component that retrieves a message about sales performance for a subscription, run the following command:

    ```bash
    dotnet run -p performancemessagereceiver
    ```

    You'll see output similar to the following example:

    ```command
    Received message: SequenceNumber:31806672368304129 Body:Total sales for Brazil in August: $13m.
    ```

1. When the program has returned notifications that it is receiving messages, press <kbd>Enter</kbd> to stop the app.

### Check the message count after you retrieve messages for a subscription

Run the following command to confirm that there are 0 remaining messages in the `Americas` subscription. Be sure to replace \<namespace-name\> with your Service Bus namespace.

```azurecli
az servicebus topic subscription show \
     --resource-group <rgn>[sandbox resource group name]</rgn> \
     --namespace-name <namespace-name> \
     --topic-name salesperformancemessages \
     --name Americas \
     --query messageCount
```

If you replace `Americas` with `EuropeAndAsia` in this code to see the current message count for the `EuropeAndAsia` subscription, you'll see that the message count is 1. In the preceding code, only `Americas` was set to retrieve topic messages, so that message is still waiting for `EuropeAndAsia` to retrieve it.
