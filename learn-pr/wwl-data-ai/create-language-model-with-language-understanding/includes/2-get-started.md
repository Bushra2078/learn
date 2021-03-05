Creating a language understanding application with Language Understanding consists of two main tasks. First you must define entities, intents, and utterances with which to train the language model - referred to as *authoring* the model. Then you must publish the model so that client applications can use it for intent and entity *prediction* based on user input.

## Azure resources for Language Understanding

For each of the authoring and prediction tasks, you need a resource in your Azure subscription. You can use the following types of resource:

- **Language Understanding**: A dedicated resource for Language Understanding, which can be either an *authoring* or a *prediction* resource.
- **Cognitive Services**: A general cognitive services resource that includes Language Understanding along with many other cognitive services. You can only use this type of resource for *prediction*.

The separation of authoring and prediction resources is useful when you want to track resource utilization for language model training separately from client applications using the model to generate predictions.

If you choose to create a Language Understanding resource, you will be prompted to choose *authoring*, *prediction*, or *both* - and it's important to note that if you choose "both", then ***two*** resources are created - one for authoring and one for prediction.

Alternatively, you can use a dedicated Language Understanding resource for authoring, but deploy your model to a generic Cognitive Services resource for prediction. When your client application uses other cognitive services in addition to Language Understanding, this approach enables you to manage access to all of the cognitive services being used, including the Language Understanding prediction service, through a single endpoint and key.

## Authoring

After you've created an authoring resource, you can use it to author and train a Language Understanding application by defining the entities and intents that your application will predict as well as utterances for each intent that can be used to train the predictive model.

Language Understanding provides a comprehensive collection of prebuilt *domains* that include pre-defined intents and entities for common scenarios; which you can use as a starting point for your model. You can also create your own entities and intents.

When you create entities and intents, you can do so in any order. You can create an intent, and select words in the sample utterances you define for it to create entities for them; or you can create the entities ahead of time and then map them to words in utterances as you're creating the intents.

You can write code to define the elements of your model, but in most cases it's easiest to author your model using the Language Understanding portal - a web-based interface for creating and managing Language Understanding applications.

>[!Tip]
>Best practice is to use the Language Understanding portal for authoring and to use the SDK for runtime predictions.  

### Creating intents

Define intents based on actions a user would want to perform with your application. For each intent, you should include a variety of utterances that provide examples of how a user might express the intent.

If an intent can be applied to multiple entities, be sure to include sample utterances for each potential entity; and ensure that each entity is identified in the utterance.

### Creating entities

There are four types of entities:

- **Machine-Learned**: Entities that are learned by your model during training from context in the sample utterances you provide.
- **List**: Entities that are defined as a hierarchy of lists and sublists. For example, a **device** list might include sublists for **light** and **fan**. For each list entry, you can specify synonyms, such as **lamp** for **light**.
- **RegEx**: Entities that are defined as a *regular expression* that describes a pattern - for example, you might define a pattern like **[0-9]{3}-[0-9]{3}-[0-9]{4}** for telephone numbers of the form ***555-123-4567***.
- **Pattern.any**: Entities that are used with *patterns* to define complex entities that may be hard to extract from sample utterances.

### Training the model

After you have defined the intents and entities in your model, and included a suitable set of sample utterances; the next step is to train the model. Training is the process of using your sample utterances to teach your model to match natural language expressions that a user might say to probable intents and entities.

After training the model, you can test it by submitting text and reviewing the predicted intents. Training and testing is an iterative process. After you train your model, you test it with sample utterances to see if the intents and entities are recognized correctly. If they're not, make updates, retrain, and test again.

## Predicting

When you are satisfied with the results from the training and testing, you can publish your Language Understanding application to a prediction resource for consumption.

Client applications can use the model by connecting to the endpoint for the prediction resource, specifying the appropriate authentication key; and submit user input to get predicted intents and entities. The predictions are returned to the client application, which can then take appropriate action based on the predicted intent.