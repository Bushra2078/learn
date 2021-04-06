At this point in the data science lifecycle, you have data that best represents the truth about what you're researching. So, it's time to model machine learning to start uncovering knowledge. 

*Modeling* is the process of choosing what data features most likely will indicate reliable knowledge. These data features can vary. For example, they might be columns in a table, secondary information like the difference between two columns, or something more nuanced like the color of an image.

### Modeling

For your lettuce garden, some aspects of the environment are likely to be more important than others. For example, soil moisture is more relevant than noise level. But for other features, it can be difficult to assess whether a feature has a stronger correlation than another feature with the outcome you want. For example, is soil moisture more of an indicator of growth over time than temperature? *Featurization* is a technique that uses the machine learning model to help you understand which features correlate more tightly with a predicted outcome.

For a rocket launch, you don't have access to some possibly highly correlated data like the shape, size, and classification of clouds. However, you'll have three main pieces of data that are likely to be highly correlated: temperature, precipitation, and humidity. In this learning path, the goal is to use past launch data, past weather data, and predicted weather data to predict whether a launch is likely to be successful.

### The machine learning algorithm cheat sheet

A helpful resource for determining what kind of machine learning algorithm will be useful for your particular analysis is the [machine learning algorithm cheat sheet](https://docs.microsoft.com/azure/machine-learning/algorithm-cheat-sheet?azure-portal=true).

:::image type="content" source="../media/algorithm-cheat-sheet.png" alt-text="Flowchart style diagram of the Algorithm cheat sheet." lightbox="../media/algorithm-cheat-sheet.png" loc-scope="Azure" border="false":::

## Choose the right machine learning algorithm

Here again is your central question: *Will weather conditions on a specific day support a successful rocket launch?*

The question is answered with *yes* or *no*. It's a problem in which a *two-class classification algorithm* might be helpful. If you look in that category in the algorithm cheat sheet, you'll see that you can choose from many algorithms. In this case, you'll use a decision tree classifier. This type of algorithm takes observations about an event, like the weather conditions for a particular day, and draws conclusions about the target value. Its result is *yes* or *no* to the question of whether a rocket would successfully launch that day given the predicted weather.

## Train and test machine learning models

In the next unit, we consider an example that describes how humans might be trained to learn new information. Machine learning models are similar to the berry identification experiment that's described next. You give the model data that has both input and output to train it. However, you don't give it *all* the data because otherwise the model will overfit. It would know only how to identify *those* berries. It wouldn't be able to generalize to a new berry farm on which all the berries are larger, for example. So, you keep some of the data for testing the model. To test the model, you provide it only with the input data. You use the true output to "grade" or "score" the model.

Luckily, the machine learning algorithms you need are already written. The tools required to split your data, train your model, and test your model also are available. You can access and use these tools as a service, so you don't have to install them on your computer.

## Deploy your model

Finally, when your model is trained and tested, you can deploy your model. When your model is deployed, it's available to be used with any other piece of software. For example, you can create a website where someone enters a picture of a berry and the site identifies the type of berry.