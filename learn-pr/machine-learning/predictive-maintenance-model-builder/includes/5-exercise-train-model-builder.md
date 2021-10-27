You've collected sensor data from your company's manufacturing devices that are healthy as well as those that have failed. You'd now like to use Model Builder to train a machine learning model that predicts whether a machine has failed or not. By using machine learning to automate the monitoring of these devices, you can significantly save your company money by providing more timely and reliable maintenance.

## Add a new Machine Learning Model (ML.NET) item

To start the training process, you need add a new Machine Learning Model (ML.NET) item to a new or existing .NET application.

### Create a C# class library

Since you're starting from scratch, create a new C# class library project to add a machine learning model to.

1. Start Visual Studio.
1. On the Start Window, choose **Create a new project**.
1. In the Create a new project dialog, type "class library" into the search bar.
1. Select **Class Library** from the list of options. Make sure that the language is C# and select **Next**.

    :::image type="content" source="../media/create-class-library-project.png" alt-text="Create class library project" lightbox="../media/create-class-library-project.png":::

1. In the Project name text box, type "PredictiveMaintenance". Leave the defaults for all other fields and select **Next**
1. Select **.NET 6.0 (Preview)** from the Framework dropdown and select **Create** to scaffold your C# class library.

### Add machine learning to your project

Once your class library project opens in Visual Studio, it's time to add machine learning to it.

1. In Visual Studio's solution explorer, right-click your project.
1. Select **Add > Machine Learning Model...**.

    :::image type="content" source="../media/add-machine-learning-model.png" alt-text="Add machine learning model to project" lightbox="../media/add-machine-learning-model.png":::

1. From the list of new items in the Add New Item dialog, select **Machine Learning Model (ML.NET)**.
1. In the Name text box, use the name "PredictiveMaintenanceModel.mbconfig" for your model and select **Add**.

    :::image type="content" source="../media/add-new-mbconfig-item.png" alt-text="Create new MBConfig item" lightbox="../media/add-new-mbconfig-item.png":::

After a few seconds, a file called *PredictiveMaintenanceModel.mbconfig* is added to your project.

## Choose your scenario

In addition to adding *PredictiveMaintenanceModel.mbconfig*, the first time you add a machine learning model to a project, the Model Builder screen opens. 

Now it's time to select your scenario.

For your use case, you're trying to determine whether a machine is broken or not. Since there are only two options and you want to determine which state a machine is in, the data classification scenario is the most appropriate.

In the Scenario step of the Model Builder screen, select the **Data classification** scenario. Once you've selected this scenario, you're immediately advanced to the Environment screen.

:::image type="content" source="../media/choose-scenario.png" alt-text="Choose data classification scenario" lightbox="../media/choose-scenario.png":::

## Choose your environment

For data classification scenarios, only local environments that use your CPU are supported.

1. In the Environment step of the Model Builder screen, **Local (CPU)** is selected by default. Leave the default environment selected.
1. Select **Next step**.

:::image type="content" source="../media/choose-environment.png" alt-text="Choose local compute training environment" lightbox="../media/choose-environment.png":::

## Load and prepare your data

Now that you've selected your scenario and training environment, it's time to load and prepare the data you've collected using Model Builder.

### Download the data

[Download the dataset](https://archive.ics.uci.edu/ml/machine-learning-databases/00601/?azure-portal=true) and save it anywhere on your computer.

After some time, a file with the name *ai4i2020.csv* should appear in the location you specified.

### Prepare your data

1. Open the *ai4i2020.csv* file in the text editor of your choice.
1. The original column names contain special bracket characters. To prevent issues parsing the data, remove the special characters from the column names.

    **Original header**

    UDI,Product ID,Type,Air temperature [K],Process temperature [K],Rotational speed [rpm],Torque [Nm],Tool wear [min],Machine failure,TWF,HDF,PWF,OSF,RNF

    **Updated header**

    UDI,Product ID,Type,Air temperature,Process temperature,Rotational speed,Torque,Tool wear,Machine failure,TWF,HDF,PWF,OSF,RNF

1. Save the *ai4i2020.csv* file with your changes.

### Choose your data source type

The predictive maintenance dataset is a CSV file.

In the Data step of the Model Builder screen, select **File (csv, tsv, txt)** for Data source type.

### Provide the location of your data

Select the **Browse** button and use the file explorer to provide the location of your *ai4i2020.csv* dataset.

### Choose your label column

Choose **Machine failure** from the Column to predict (Label) dropdown

:::image type="content" source="../media/load-training-data.png" alt-text="Load predictive maintenance csv file dataset" lightbox="../media/load-training-data.png":::

### Advanced data options

By default, all columns that are not the label are used as features. As previously mentioned though, some columns contain redundant information while others don't inform the prediction. Therefore, you want to ignore those columns. To do so, use the advanced data options.

1. Select **Advanced data options...**.
1. In the Advanced data options dialog, select the **Column settings** tab.

    :::image type="content" source="../media/configure-advanced-data-options.png" alt-text="Configure advanced data options for predictive maintenance dataset" lightbox="../media/configure-advanced-data-options.png":::

1. Configure the column settings as follows:

    | Columns             | Purpose | Data type | Categorical |
    | ---                 | ---     | ---       | ---         |
    | UDI                 | Ignore  | Single    |             |
    | Product ID          | Feature | String    |             |
    | Type                | Feature | String    | X           |
    | Air temperature     | Feature | Single    |             |
    | Process temperature | Feature | Single    |             |
    | Rotational speed    | Feature | Single    |             |
    | Torque              | Feature | Single    |             |
    | Tool wear           | Feature | Single    |             |
    | Machine failure     | Label   | Single    | X           |
    | TWF                 | Ignore  | Single    | X           |
    | HDF                 | Ignore  | Single    | X           |
    | PWF                 | Ignore  | Single    | X           |
    | OSF                 | Ignore  | Single    | X           |
    | RNF                 | Ignore  | Single    | X           |

1. Select **Save**.
1. In the Data step of the Model Builder screen, select **Next step**.

## Train your model

Use Model Builder and AutoML to train your model.

### Set your training time

Model Builder automatically sets how long you should train for based on the size of your file. In this case, to help Model Builder explore more models, provide a higher number for the Train time.

1. In the Train step of the Model Builder screen, set the Time to train (seconds) to 30.
1. Select **Train**

### Track the training process

:::image type="content" source="../media/train-machine-learning-model.png" alt-text="Train predictive maintenance classification model" lightbox="../media/train-machine-learning-model.png":::

Once the training process kicks off, Model Builder explores various models. Your training process is tracked in the Training results and in the Visual Studio output window. The training results provide information about the best model that's been found throughout the training process and the output window provides detailed information like the name of the algorithm used, how long it took to train, and the performance metrics for that model. You may see the same algorithm name appear multiple times. This happens because in addition to trying different algorithms, Model Builder is also trying different hyperparameter configurations for those algorithms. Therefore it's normal to see the same algorithm appear multiple times.

## Evaluate your model

Use evaluation metrics and data to test how well your model performs.

### Inspect your model

The Evaluate step in the Model Builder screen allows you to inspect the evaluation metrics and algorithm chosen for the best model. Remember that it's okay if your results are different from those mentioned in this module since the algorithm and hyperparameters chosen may be different.

### Test your model

In the test your model section of the evaluate step, you can provide new data and evaluate the results of your prediction.

:::image type="content" source="../media/evaluate-machine-learning-model.png" alt-text="Make predictions with your trained model" lightbox="../media/evaluate-machine-learning-model.png":::

The sample data section is where you provide input data for your model to make predictions. Each field corresponds to the columns used to train your model. This is a convenient way to verify that the model behaves as expected. By default, Model Builder pre-populates with the first row from your dataset.

Let's test out your model to see whether it produces the expected results.

1. In the sample data section, enter the following data:

    The data below comes from the row in your dataset with UID 161.

    | Column              | Value  |
    | ---                 | ---    |
    | Product ID          | L47340 |
    | Type                | L      |
    | Air temperature     | 298.4  |
    | Process temperature | 308.2  |
    | Rotational speed    | 1282   |
    | Torque              | 60.7   |
    | Tool wear           | 216    |

1. Select **Predict**

### Evaluate prediction results

The results section displays the prediction made by your model and how confident it is in its prediction.

If you look at the Machine failure column of UID 161 in your dataset, you'll notice that the value is 1. This is the same as the predicted value with the highest confidence in the results section.

If you'd like, you can continue trying out your model with different input values and evaluating the predictions made.

Congratulations! You've trained a model to predict machine failures. In the next unit, you'll learn about model consumption.
