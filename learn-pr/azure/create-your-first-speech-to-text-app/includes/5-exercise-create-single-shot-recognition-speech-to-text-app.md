In this exercise, you'll create an application that uses single-shot recognition to transcribe a sample audio file that you'll download.

## Create your speech-to-text application

1. In the Cloud Shell on the right, create a directory for your application, then switch folders to your new folder.

    ```bash
    mkdir speech-to-text
    cd speech-to-text
    ```

1. Create a new .NET Core application.

    ```dotnetcli
    dotnet new console
    ```

    This command should take a few seconds to complete.

1. When your .NET Core application has been created, add the Cognitive Services package to your application.

    ```dotnetcli
    dotnet add package Microsoft.CognitiveServices.Speech
    ```

    This command should take a few seconds to complete.

## Download a WAVE file for recognition

In the Cloud Shell on the right, run the following command to download a sample WAVE file that contains a series of quotes from William Shakespeare's play "As you like it."

```bash
curl -L https://aka.ms/ShakespeareWAV -o Shakespeare.wav
```

You'll use this WAVE file for the application in this exercise, and the application in the next exercise.

## Add the code for your text-to-speech application

1. In the Cloud Shell on the right, open the *Program.cs* file in Visual Studio Code.

    ```dotnetcli
    code Program.cs
    ```

1. Replace the existing `using` statements with the following statements, which will enable the Azure Cognitive Services Speech APIs for your application.

    ```csharp
    using System;
    using System.IO;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    ```

1. Replace the existing `Main()` function with the following code, which will use Azure Cognitive Services Speech APIs to convert the contents of the text file that you created earlier to create a WAVE file with the synthesized voice.

    ```csharp
    static async Task Main(string[] args)
    {
        string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
        string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
        string textFile = "Shakespeare.txt";
        string waveFile = "Shakespeare.wav";

        try
        {
            FileInfo fileInfo = new FileInfo(waveFile);
            if (fileInfo.Exists)
            {
                var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
                using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
                using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
                var result = await speechRecognizer.RecognizeOnceAsync();
                
                FileStream fileStream = File.OpenWrite(Path.Combine(fileInfo.DirectoryName, textFile));
                StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
                streamWriter.WriteLine(result.Text);
                streamWriter.Close();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
    ```

    This code uses your key and location to initialize a connection to Azure Cognitive Services, then it reads the contents of the WAVE file that you downloaded, then it uses the `RecognizeOnceAsync()` method of the `SpeechRecognizer` to convert the audio to text, and then it uses a stream writer to save the results to a text file.

1. When you have finished adding all of the code, your file should resemble the following example.

    ```csharp

    using System;
    using System.IO;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Audio;
    
    namespace speech_to_text
    {
        class Program
        {
            static async Task Main(string[] args)
            {
                string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
                string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
                string textFile = "Shakespeare.txt";
                string waveFile = "Shakespeare.wav";
    
                try
                {
                    FileInfo fileInfo = new FileInfo(waveFile);
                    if (fileInfo.Exists)
                    {
                        var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
                        using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
                        using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
                        var result = await speechRecognizer.RecognizeOnceAsync();
                        
                        FileStream fileStream = File.OpenWrite(Path.Combine(fileInfo.DirectoryName, textFile));
                        StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
                        streamWriter.WriteLine(result.Text);
                        streamWriter.Close();
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
    ```

    Make sure that you update the values for the `azureKey` and `azureLocation` variables with your key and location from the previous exercise.

1. To save your changes, press <kbd>Ctrl-S</kbd> to save the file, and then press <kbd>Ctrl-Q</kbd> to exit the editor.

## Run your application

1. To run your application, use the following command in the Cloud Shell on the right.

    ```dotnetcli
    dotnet run
    ```

1. If you don't see any errors, your application has run successfully. To verify, run the following command to get a list of files in the directory.

    ```bash
    ls -l
    ```

    You should see a response like the following example, and you should see the _Shakespeare.txt_ in the list of files.

    ```bash
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 bin
    drwxr-xr-x 3 user   user     4096 Oct  1 11:11 obj
    -rw-r--r-- 1 user   user     1476 Oct  1 11:11 Program.cs
    -rw-r--r-- 1 user   user       98 Oct  1 11:11 Shakespeare.txt
    -rwxr-xr-x 1 user   user   978242 Oct  1 11:11 Shakespeare.wav
    -rw-r--r-- 1 user   user      348 Oct  1 11:11 speech-to-text.csproj
    ```

    You'll notice that the size of the text file is small; in this example, it is only 98 bytes.

1. To view the contents of the _Shakespeare.txt_ file, use the following command.

    ```bash
    cat Shakespeare.txt
    ```

    You should see a response like the following example.

    ```text
    The following quotes are from Act 2, scene seven of William Shakespeare's play as you like it.
    ```

    If you listened to the sample WAVE file, you would notice that this text is only the first few seconds of the audio. Because we used the `RecognizeOnceAsync()` method of the `SpeechRecognizer`, the speech-to-text recognition stopped when the speaker paused.

In the next exercise, you'll learn how to continue the speech-to-text recognition for the entire audio file.
