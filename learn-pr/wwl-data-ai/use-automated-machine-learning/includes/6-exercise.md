
In this exercise, you will use a dataset of historical bicycle rental details to train a model that predicts the number of bicycle rentals that should be expected on a given day, based on seasonal and meteorological features.

## Create an Azure Machine Learning workspace  

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using your Microsoft credentials.
2. Select **Create a resource**, search for *Machine Learning*, and create a new **Azure Machine Learning** resource with an *Azure Machine Learning* plan. Use the following settings:
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *Create or select a resource group*
    - **Workspace name**: *Enter a unique name for your workspace*
    - **Region**: *Select the closest geographical region*
    - **Storage account**: *Note the default new storage account that will be created for your workspace*
    - **Key vault**: *Note the default new key vault that will be created for your workspace*
    - **Application insights**: *Note the default new application insights resource that will be created for your workspace*
    - **Container registry**: None (*one will be created automatically the first time you deploy a model to a container*)
3. Select **Review + create**, then select **Create**. Wait for your workspace to be created (it can take a few minutes). 
4. Launch Azure Machine Learning studio (or open a new browser tab and navigate to [https://ml.azure.com](https://ml.azure.com?azure-portal=true), and sign into Azure Machine Learning studio using your Microsoft account.
5. In Azure Machine Learning studio, in the menu on the left, select **Workspaces**. Select the workspace you created to open an instance of your workspace in a new window. 

> [!NOTE]
> This module is one of many that make use of an Azure Machine Learning workspace, including the other modules in the [Microsoft Azure AI Fundamentals: Explore visual tools for machine learning](/learn/paths/create-no-code-predictive-models-azure-machine-learning/) learning path. If you are using your own Azure subscription, you may consider creating the workspace once and reusing it in other modules. Your Azure subscription will be charged a small amount for data storage as long as the Azure Machine Learning workspace exists in your subscription, so we recommend you delete the Azure Machine Learning workspace when it is no longer required.

## Create compute 

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), select the three lines at the top left to view the various pages in the interface. You can use these pages in the left hand pane to manage the resources in your workspace. Select the **Compute** page. 

2. On the **Compute** page, select the **Compute Clusters** tab, and add a new compute cluster with the following settings. You'll use this to train a machine learning model:
    - **Location**: *Select the same as your workspace. If that location is not listed, choose the one closest to you*
    - **Virtual Machine tier**: Dedicated
    - **Virtual Machine type**: CPU
    - **Virtual Machine size**: 
        - Choose **Select from all options** 
        - Search for and select **Standard_DS11_v2**
    - Select **Next**
    - **Compute name**: *enter a unique name*
    - **Minimum number of nodes**: 0
    - **Maximum number of nodes**: 2
    - **Idle seconds before scale down**: 120
    - **Enable SSH access**: Unselected
    - Select **Create** 

> [!NOTE]
> Compute instances and clusters are based on standard Azure virtual machine images. For this module, the *Standard_DS11_v2* image is recommended to achieve the optimal balance of cost and performance. If your subscription has a quota that does not include this image, choose an alternative image; but bear in mind that a larger image may incur higher cost and a smaller image may not be sufficient to complete the tasks. Alternatively, ask your Azure administrator to extend your quota.

The compute cluster will take some time to be created. You can move onto the next step while you wait.

## Create a dataset

1. View the comma-separated data at [https://aka.ms/bike-rentals](https://aka.ms/bike-rentals?azure-portal=true) in your web browser. 

2. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), expand the left pane by selecting the three lines at the top left of the screen. View the **Data** page (under **Assets**). The Data page contains specific data files or tables that you plan to work with in Azure ML. You can create datasets from this page as well.

3. Create a new dataset **from web files**, using the following settings:
    * **Basic Info**:
        * **Web URL**: [https://aka.ms/bike-rentals](https://aka.ms/bike-rentals?azure-portal=true)
        * **Name**: bike-rentals
        * **Dataset type**: Tabular
        * **Description**: Bicycle rental data
        * **Skip data validation**: _do not select_
    * **Settings and preview**:
        * **File format**: Delimited
        * **Delimiter**: Comma
        * **Encoding**: UTF-8
        * **Column headers**: Only first file has headers 
        * **Skip rows**: None
        * **Dataset contains multi-line data**: _do not select_ 
    * **Schema**:
        * Include all columns other than **Path**
        * Review the automatically detected types
    * **Confirm details**:
        * Do not profile the dataset after creation

4. After the dataset has been created, open it and view the **Explore** page to see a sample of the data. This data contains historical features and labels for bike rentals.

> **Citation**: *This data is derived from [Capital Bikeshare](https://www.capitalbikeshare.com/system-data) and is used in accordance with the published data [license agreement](https://www.capitalbikeshare.com/data-license-agreement).*

## Run an automated machine learning experiment 

Follow the next steps to run an experiment that uses automated machine learning to train a regression model that predicts bicycle rentals.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Automated ML** page (under **Author**).

2. Create an Automated ML run with the following settings:
    - **Select data asset**:
        - **Dataset**: bike-rentals
    - **Configure job**:
        - **New experiment name**: mslearn-bike-rental
        - **Target column**: rentals (*this is the label that the model is trained to predict)*
        - **Select compute cluster**: *the compute cluster that you created previously*
    - **Select task and settings**: 
        - **Task type**: Regression *(the model predicts a numeric value)* 

    ![Screenshot of a selection pane with boxes around the Regression task type and additional configuration settings.](../media/new-automated-ml-run-4.png)

    Notice under task type there are settings _View additional configuration settings_ and _View Featurization settings_. Now configure these settings.

    - **Additional configuration settings:**
        - **Primary metric**: Select **Normalized root mean squared error** 
        - **Explain best model**: Selected — *this option causes automated machine learning to calculate feature importance for the best model which makes it possible to determine the influence of each feature on the predicted label.*
        - **Use all supported models**: <u>Un</u>selected. *You'll restrict the experiment to try only a few specific algorithms.*
        - **Allowed models**: *Select only **RandomForest** and **LightGBM** — normally you'd want to try as many as possible, but each model added increases the time it takes to run the experiment.*

        ![Screenshot of additional configurations with a box around the allowed models.](../media/allowed-models.png)            
        - **Exit criterion**:
            - **Training job time (hours)**: 0.5 — *ends the experiment after a maximum of 30 minutes.*
            - **Metric score threshold**: 0.085 — *if a model achieves a normalized root mean squared error metric score of 0.085 or less, the experiment ends.*
        - **Concurrency**: *do not change*
    - **Featurization settings:**
        - **Enable featurization**: Selected — *automatically preprocess the features before training.*

    Click **Next** to go to the next selection pane. 

    - **[Optional] Select the validation and test type**
        - **Validation type**: Auto 
        - **Test dataset (preview)**: No test dataset required 

3. When you finish submitting the automated machine learning run details, it starts automatically. Wait for the run status to change from *Preparing* to *Running*.
4. When the run status changes to *Running*, view the **Models** tab and observe as each possible combination of training algorithm and pre-processing steps is tried and the performance of the resulting model is evaluated. The page automatically refreshes periodically, but you can also select **Refresh**. It might take 10 minutes or so before models start to appear, as the cluster nodes must be initialized before training can begin.
5. Wait for the experiment to finish. It might take a while — now might be a good time for a coffee break!

## Review the best model

1. On the **Overview** tab of the automated machine learning run, note the best model summary.
    ![Screenshot of the best model summary of the automated machine learning run with a box around the algorithm name.](../media/complete-run.png)

2. Select the text under **Algorithm name** for the best model to view its details.

3. Next to the *Normalized root mean squared error* value, select **View all other metrics** to see values of other possible evaluation metrics for a regression model.

    ![Screenshot of how to locate view all other metrics on the Model tab.](../media/review-run-1.png)

4. Select the **Metrics** tab and select the **residuals** and **predicted_true** charts if they are not already selected. 
    ![Screenshot of the metrics tab with the residuals and predicted_true charts selected.](../media/review-run-3.png)

    Review the charts which show the performance of the model. The first chart shows the *residuals*, the differences between predicted and actual values, as a histogram, the second chart compares the predicted values against the true values.

5. Select the **Explanations** tab. Select an explanation ID and then select **Aggregate feature importance**. This chart shows how much each feature in the dataset influences the label prediction, like this:

    ![Screenshot of the feature importance chart on the Explanations tab.](../media/feature-importance.png)

## Deploy a predictive service 

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), on the **Automated ML** page, select the run for your automated machine learning experiment.

2. On the **Details** tab, select the algorithm name for the best model.
   
    ![Screenshot of the best model summary with a box around the algorithm name on the details tab.](../media/deploy-detail-tab.png)

3. on the **Model** tab, select the **Deploy** button and use the **Deploy to web service** option to deploy the model with the following settings:
    - **Name**: predict-rentals
    - **Description**: Predict cycle rentals
    - **Compute type**: Azure Container Instance
    - **Enable authentication**: Selected

4. Wait for the deployment to start - this may take a few seconds. Then, in the **Model summary** section, observe the **Deploy status** for the **predict-rentals** service, which should be **Running**. Wait for this status to change to **Successful**, which may take some time. You may need to select **Refresh** periodically.
5. In Azure Machine Learning studio, on the left hand menu, select **Endpoints**. 
    ![Screenshot of location of Endpoints on the left hand menu.](../media/find-endpoints.png)

## Test the deployed service

Now you can test your deployed service.

1. On the **Endpoints** page, open the **predict-rentals** real-time endpoint.
2. When the **predict-rentals** endpoint opens, view the **Test** tab. 
3. In the input data pane, replace the template JSON with the following input data: 

    ```JSON
    {
      "Inputs": { 
        "data": [
          {
            "day": 1,
            "mnth": 1,   
            "year": 2022,
            "season": 2,
            "holiday": 0,
            "weekday": 1,
            "workingday": 1,
            "weathersit": 2, 
            "temp": 0.3, 
            "atemp": 0.3,
            "hum": 0.3,
            "windspeed": 0.3 
          }
        ]    
      },   
      "GlobalParameters": 1.0
    }
    ```

4. Click on the **Test** button.

5. Review the test results, which include a predicted number of rentals based on the input features. The test pane took the input data and used the model you trained to return the predicted number of rentals.

    ![Screenshot of an example of testing the model with sample data in the test tab.](../media/workaround-test.png)

Let's review what you have done. You used a dataset of historical bicycle rental data to train a model. The model predicts the number of bicycle rentals expected on a given day, based on seasonal and meteorological _features_. In this case, the _labels_ are number of bicycle rentals. 

You have just tested a service that is ready to be connected to a client application using the credentials in the **Consume** tab. We will end the lab here. You are welcome to continue to experiment with the service you just deployed.

> [!TIP]
> After you finish the entire module, be sure to follow the **Clean Up** instructions at the end of the module to stop your compute resources. Stop your compute resources to ensure your subscription won't be charged. 