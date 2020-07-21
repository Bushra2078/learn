This exercise steps through the process of preparing a submission for the key phrase extraction service, using either C# or Python. You will require an active Azure subscription and a Cognitive Service for this exercise.  Your Cognitive Service may be a multi-service resource (Cognitive Services resource), or it may be a **Text Analytics** resource.

## Setting up your environment (Optional if these requirements are already met)

1. To complete the exercises, you will require an Azure subscription and a Cognitive Services resource.
1. Sign in to the [Azure portal](https://portal.azure.com) using your Azure subscription credentials.  If you do not have an Azure subscription yet, [create the subscription](https://azure.microsoft.com/free) before proceeding.
1. Select the + Create a resource option in the left nav pane or on the Home page of the Azure portal.
1. In the text entry to search the Azure Marketplace, enter **Cognitive Services** for a multi-service resource, and press **Enter**.
1. Select **Cognitive Services** from the list presented.
1. Select the **Create** button.
1. Enter a unique name for the service, such as **myMultiCogService**.
1. Select your Azure subscription from the **Subscription** drop-down list.
1. Choose a **Location** that is closest to you.
1. For the **Pricing Tier**, select F0 if available, otherwise select S0.
1. Select an existing resource group or create a new one, if you do not already have an appropriate resource group.
1. Select the check box to confirm you understand the notice on the page.
1. Select **Create**.
1. Once the deployment succeeds, go to the newly created Cognitive Service resource.
1. Open the **Keys and Endpoint** page by selecting that option from left nav pane of the service.  You will need the key and endpoint for the exercises.

## Create Visual Studio Codespace environment

1. Start by opening a browser tab or window and navigating to [Visual Studio Codespaces](https://visualstudio.microsoft.com/services/visual-studio-codespaces/).

    An Azure subscription is required to create an environment for Visual Studio Codespaces.
    > [!NOTE]
    > At this time, Safari is not a supported browser for the preview of Visual Studio Codespaces.

    
1. Select the **Get started** button.
1. Sign in using the Microsoft Account that is linked to your Azure subscription.
1. The first time you use Visual Studio Codespaces, you need to create a new plan, which should be selected in the drop-down at the top of the page.
1. Select **Create Codespace**.
1. Select your Subscription in the **Select Billing** pane and choose a location for the service.
1. Select **Create**.
1. Once your plan is created, you can then create your first environment.  
1. If the **Create Codespace** panel does not open automatically, select **Create Codespace**.
1. Select the programming language of choice and continue with the exercise.

## Call the Key Phrase Extraction service

:::zone pivot="csharp"

1. Enter an environment name of your choosing, example **KeyPhraseExtractCS**.
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Cognitive Service in the Azure portal and copy one of your keys.
1. Once the environment indicates that it is available, select the hamburger menu in the upper left corner and choose **Terminal, New Terminal**.
1. Once the new terminal opens, verify your prompt is **vsonline:~/workspace$**.
1. Type in the command ``` dotnet new console ```.
1. A skeleton .NET Core application is created.
1. Select the **Program.cs** file in the file panel to open it in the editor.
1. To get a larger space in which to work, close the **Welcome** and **Creation Log** tabs.
1. You may be prompted to install the C# extension.  Select **Install** when prompted, then select **Reload Required** to apply the extension to the environment.
1. The next prompt asks you to install required assets.  Select **Yes** to install these assets.
1. You can now start to enter some code for the application.
1. You will require several libraries for the Text Analytics functionality so paste these **using** statements into your **Program.cs** file.

   ```csharp
   using System.Collections.Generic;
   using System.Net.Http;
   using System.Threading;
   using System.Threading.Tasks;
   using Microsoft.Azure.CognitiveServices.Language.TextAnalytics;
   using Microsoft.Rest;
   ```

1. Create a method called ExtractKeyPhrases() by pasting in the code below the existing Main() method in Program.cs.

   ```csharp
   public static async Task ExtractKeyPhrases(string endpoint, string key)
           {
               var credentials = new ApiKeyServiceClientCredentials(key);
               var client = new TextAnalyticsClient(credentials)
               {
                   Endpoint = endpoint
               };

               // Create a strongly-typed list to store the sentences that will be passed to the service
               List<String> phraseList = new List<string>();

               // Add two sentences to the list
               phraseList.Add("Microsoft was founded by Bill Gates and Paul Allen on April 4, 1975, to develop and sell BASIC interpreters for the Altair 8800.");
               phraseList.Add("La sede principal de Microsoft se encuentra en la ciudad de Redmond, a 21 kilómetros de Seattle.");

               // loop through the list and pass in each sentence to key phrase extraction service
               foreach (string doc in phraseList)
               {
                   var response = await client.KeyPhrasesAsync(doc);

                   // iterate over the returned key phrases and output them to the console
                   foreach (string keyphrase in response.KeyPhrases)
                   {
                       Console.WriteLine($"\t{keyphrase}");
                   }
                   Console.WriteLine();
               }
           }
   ```

1. In the code listing, we are not using well-formed JSON.  In this case we are simply exercising the ability of the service to extract key phrases from simple sentences.  This is to show the flexibility of the service.
1. Now that we have the method that will perform the bulk of the work you will require a client class to handle the authentication to your Cognitive Service.  Create that client class in the same namespace as Program.cs but as a separate class.

   ```csharp
   // <clientClass>
       class ApiKeyServiceClientCredentials : ServiceClientCredentials
       {
           private readonly string apiKey;
   
           public ApiKeyServiceClientCredentials(string apiKey)
           {
               this.apiKey = apiKey;
           }
   
           public override Task ProcessHttpRequestAsync(HttpRequestMessage request, CancellationToken cancellationToken)
           {
               if (request == null)
               {
                   throw new ArgumentNullException("request");
               }
               request.Headers.Add("Ocp-Apim-Subscription-Key", this.apiKey);
               return base.ProcessHttpRequestAsync(request, cancellationToken);
           }
       }
   // </clientClass>
   ```

1. Next, modify Main() to work asynchronously and to pass in the key and endpoint, then call the ExtractKeyPhrases() method.

   ```csharp
   static async Task Main(string[] args)
   {
       string key = "YourCognitiveKey";
       string endpoint = "YourCognitiveEndpoint";
   
       await ExtractKeyPhrases(endpoint, key);
   }
   ```

1. Paste your key and endpoint into the placeholders in the Main() method.
1. Before you run the code, you will need to add the TextAnalytics package to the application.  Enter the following command to add the package, ``` dotnet add package Microsoft.Azure.CognitiveServices.Language.TextAnalytics ```, and press Enter.
1. Once the package is added, in the Terminal, enter the command ``` dotnet run ```.
1. If there are no errors in the code and your key is accurate, key phrases from each sentence will be output to the terminal window.

   >[!NOTE]
   >This sample code did not append additional URL information to the endpoint URL nor did it use well-formed JSON for the input.  This demonstrates another method to call the service if you don't want to deal with JSON formatting.  Also note that the service was able to automatically detect the language of each sentence that was passed in.

:::zone-end

:::zone pivot="python"

1. Enter an environment name of your choosing, example **KeyPhraseExtractPy**.
1. Leave the rest of the settings at their default and select **Create**.
1. It will take a few minutes for the environment to be created so while you wait, go to your Cognitive Service in the Azure portal and copy one of your keys.
1. Once the environment is created, close the **Welcome** and **Creation Log** tabs.
1. Create a new file and call it **keyPhrases.py**.
1. Visual Studio Codespace will prompt you to install the Python extension, choose **Install**.
1. Select the **Reload Required** button in the **Extensions** pane.
1. Choose **Do not show again** when prompted for PyLint.
1. If the **Terminal** window is not open at the bottom of the editor, select the hamburger menu and choose **Terminal, New Terminal**.
1. In the Terminal window, install the **Text Analytics** library with the command, ```sudo pip install --upgrade azure-cognitiveservices-language-textanalytics```.
1. In your Python file, add the following code at the top.

   ```python
   import os
   from azure.cognitiveservices.language.textanalytics import TextAnalyticsClient
   from msrest.authentication import CognitiveServicesCredentials
   ```

1. Next, you will add variables to store your endpoint and key.

   ```python
   # variables to store subscription key and root URL for the Cognitive Service resource
   subscription_key = "YourCognitiveKey"
   endpoint = "YourCognitiveEndpoint"
   ```

1. In your Python code, create a function to authenticate to your Cognitive Service. This function will use the key and the URL endpoint for your service.

   ```python
   def authenticateClient():
       credentials = CognitiveServicesCredentials(key)
       text_analytics_client = TextAnalyticsClient(
           endpoint=endpoint, credentials=credentials)
    return text_analytics_client
    ```

1. To call the service, you will need a properly formatted document.  You can create that inside your Python code easily.  Create a ```documents``` variable and store a properly formatted documents array, in JSON format, using the following code.

    ```python

    def key_phrases():

        client = authenticateClient()

        try:
            documents = [
                {"id": "1", "language": "ja", "text": "猫は幸せ"},
                {"id": "2", "language": "de",
                    "text": "Fahrt nach Stuttgart und dann zum Hotel zu Fu."},
                {"id": "3", "language": "en",
                    "text": "My cat might need to see a veterinarian."},
                {"id": "4", "language": "es", "text": "A mi me encanta el fútbol!"}
            ]
    
            for document in documents:
                print(
                    "Asking key-phrases on '{}' (id: {})".format(document['text'], document['id']))
    
            response = client.key_phrases(documents=documents)
    
            for document in response.documents:
                print("Document Id: ", document.id)
                print("\tKey Phrases:")
                for phrase in document.key_phrases:
                    print("\t\t", phrase)
    
        except Exception as err:
            print("Encountered exception. {}".format(err))
    ```

1. This function will also take each document in the JSON file, denoted by the ID, output a phrase indicating it is seeking key phrases on the sentence, and outputting the actual text of the passed in sentence (document).
1. The code then calls the service, passing in the JSON file, and storing the returned key phrases in the response variable.
1. Finally, it prints out the key phrases detected in each sentence.
1. Now that have your text document, key and URL configured, it is time to call the service and output the results.

    ```python
    key_phrases()
    ```

1. Paste your key and endpoint URL into the placeholders in the code.
1. Select the **Run Python File in Terminal** or right-click anywhere in the code editor and select **Run Python File in Terminal**.
1. If your code contains no errors, the resulting key phrase output should be sent to the output window and is displayed here.

    ```
    Document Id:  1
            Key Phrases:
                     幸せ
    Document Id:  2
            Key Phrases:
                     Stuttgart
                     Hotel
                     Fahrt
                     Fu
    Document Id:  3
            Key Phrases:
                     cat
                     veterinarian
    Document Id:  4
            Key Phrases:
                     fútbol
    ```

:::zone-end
