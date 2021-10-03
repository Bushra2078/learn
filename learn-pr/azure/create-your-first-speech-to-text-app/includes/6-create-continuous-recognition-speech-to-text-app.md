In the previous exercise, you learned how to create an application that used single-shot recognition to transcribe shorter audio files. This worked well for the audio memos that your medical clients have provided, but your company needs an application that you can use to transcribe the longer dictation files from your clients.

With that in mind, in the next exercise, you'll modify your existing application to use continuous recognition, which will work for both the short memos and longer dictations. Continuous recognition gives you greater control over the speech recognition process, but it requires more code to implement in your application.

## Creating an application using continuous recognition to transcribe audio files

To create an application that will convert speech to text using Azure Cognitive Services' continuous recognition, your application will have to accomplish all of the following tasks.

- Add the `Microsoft.CognitiveServices.Speech` package to your application.

- Create a `SpeechConfig` class using the API key from your Azure Cognitive Services account.

- Create a `AudioConfig` class using a WAVE file as the source.

- Create a `SpeechRecognizer` class using the `SpeechConfig` and `AudioConfig` classes.

- Subscribe to the following events of the `SpeechRecognizer` class:

    - The `Recognized` event detects whether text has been recognized.
    - The `Canceled` event detects whether the recognition has been cancelled, which might be due to error.
    - The `SessionStopped` event detects when recognition has stopped.

- Create a `StreamWriter` class to write the converted text to a file.

- Invoke the `StartContinuousRecognitionAsync()` method of the `SpeechRecognizer` class to start recognition, and the `StopContinuousRecognitionAsync()` method to stop recognition.

In the next exercise, we'll look at all of those steps in detail.
