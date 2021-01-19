In this unit, you download the DTDL Validator sample. This is a command line sample application that parses and validates a DTDL hierarchy of models, given a root folder. You'll also deliberately add errors to a copy of a model file to demonstrate the benefits of using the validation sample application.

## Download the DTDL Validator sample application

1. Download the [DTDL Validator](https://docs.microsoft.com/en-us/samples/azure-samples/dtdl-validator/dtdl-validator/).

1. Extract the zip file to an appropriate location. The default location will be in your **Downloads** folder.

1. Make sure you have the [C# Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) and [.NET Core 3.1](https://dotnet.microsoft.com/download) installed.

1. In Visual Studio Code, open the project folder by navigating to "File" > "Open Folder..." (`CTRL`+`K` `CTRL`+`O`) and selecting the folder where you extracted the DTDL Validator sample application.

    > [!NOTE]
    > You can disregard these messages about unresolved dependencies and missing assets:
    > :::image type="content" source="../media/adt-visual-studio-code-messages.png" alt-text="Screenshot showing the messages that can be disregarded with the DTDL Validator sample open in Visual Studio Code":::

1. Open the terminal (if it's not already open) by navigating to "View" > "Terminal".

1. From the "DTDL_Validator" root directory of the project, navigate to the application by entering the following command in the terminal:

    ```powershell
    cd .\DTDLValidator-Sample\DTDLValidator\
    ```

1. Leave Visual Studio Code and its terminal open.

## Run the validation app on the chocolate factory models

First, check that the models you've been given are valid.

1. Navigate to the folder containing your production line models and copy the full path for a later step in this section. For example: "C:\\Users\\{username}\\Documents\\factory-models".

1. To use the DTDL Validator sample application, run the following command in the Visual Studio Code terminal with the full path to your models folder:

    ```powershell
    dotnet run -d <your folder>
    ```

1. You should get the message that your models are valid:

    ```powershell
    **********************************************
    ** Validated all files - Your DTDL is valid **
    **********************************************
    ```

If your models are invalid, you'll need to edit them. The next section examines what might go wrong.

## Run the validation app on a faulty model

In this section, you'll deliberately add errors to a DTDL model to test the validator app.

1. In your models folder, create a copy of the **ProductionStepGrinding.json** file. Leave the name as **ProductionStepGrinding - Copy.json**.

1. Open the **ProductionStepGrinding - Copy.json** file. Double check you've opened the copy, and not the original!

1. Edit the file by making the following changes:
    - Locate the field <b>@type</b> on line 4, and change it to <b>@type</b>.
    - Locate the field **name** on line 30, and delete the line.
    - Locate the field **schema** on line 19, and add a line before it:

        ```json
        "glitch" : "nonsense",
        ```

1. Save the edited **ProductionStepGrinding - Copy.json**, but leave it open in your text editor.

1. Back in the Visual Studio Code terminal, use the up arrow to locate the `dotnet run -d <your folder>` entry, and hit return.

1. You should notice that you get an error that there are multiple definitions of a model. You'll also notice that you only get one error message before the app exits.

1. Correct the duplicate error by changing the ID. Change "grinding" to "crunching", on line 3.

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. In the command window, use the up arrow to run the app again.

1. You'll get one red error message in the output. Correct the `missing required @type` error in file by changing "typo" back to "type" on line 4.

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. Repeat this process, until all the errors in the copied version of the model file are corrected. Refer back to the hacks you made in the file on step 3 of this section, if necessary.

1. To clean up your models folder, delete the **ProductionStepGrinding - Copy.json** file as there's no further use for it.

1. Close Visual Studio Code.

Next, you'll look at how your models make up a digital twin graph.
