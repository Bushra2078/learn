To train a regression model, you need a dataset that includes historical *features* (characteristics of the entity for which you want to make a prediction) and known *label* values (the numeric value that you want to train a model to predict).

## Create a pipeline

To use the Azure Machine Learning designer, you create a *pipeline* that you will use to train a machine learning model. This pipeline starts with the dataset from which you want to train the model.

1. in [Azure Machine Learning studio](https://ml.azure.com), view the **Designer** page (under **Author**), and select **+** to create a new pipeline.
2. In the **Settings** pane, change the default pipeline name (**Pipeline-Created-on-*date***) to **Auto Price Training** (if the **Settings** pane is not visible, select the **&#9881;** icon next to the pipeline name at the top).
3. Observe that you need to specify a compute target on which to run the pipeline. In the **Settings** pane, use **Select compute target** to select the **aml-cluster** compute target you created in the previous lab.

## Add and explore a dataset

In this module, you'll train a regression model that predicts the price of an automobile based on its characteristics. Azure Machine Learning includes a sample dataset that you can use for this model.

1. On the left side of the designer, expand the **Datasets** section, and drag the **Automobile price data (Raw)** dataset from the **Samples** section onto the canvas.
2. Select the **Automobile price data (Raw)** dataset on the canvas, and view its settings (the settings pane for the dataset may open automatically and cover the canvas). On the **outputs** tab, select the **Visualize** icon (which looks like a column chart).
3. Review the schema of the data, noting that you can see the distributions of the various columns as histograms.
4. Scroll to the right of the dataset until you see the **Price** column. This is the label your model will predict.
5. Select the column header for the **price** column and view the details that are displayed in the pane to the right. These include various statistics for the column values, and a histogram showing the distribution of the column values.
6. Scroll back to the left and select the **normalized-losses** column header. Then review the statistics for this column noting, there are quite a few missing values in this column. This will limit its usefulness in predicting the **price** label; so you might want to exclude it from training.
7. View the statistics for the **bore**, **stroke**, and **horsepower** columns, noting the number of missing values. These columns have significantly fewer missing values than **normalized-losses**, so they may still be useful in predicting **price** if you exclude the rows where the values are missing from training.
8. Compare the values in the **stroke**, **peak-rpm**, and **city-mpg** columns. These are all measured in different scales, and its possible that the larger values for **peak-rpm** might bias the training algorithm and create an over-dependency on this column compared to columns with lower values, such as **stroke**. Typically, data scientists mitigate this possible bias by *normalizing* the numeric columns so they're on the similar scales.
9. Close the **Automobile price data (Raw) result visualization** window, and then close or resize the settings pane using the X or **<sub>&#8599;</sub><sup>&#8601;</sup>** icon.

## Add data transformations

You typically apply data transformations to prepare the data for modeling. In the case of the automobile price data, you'll add transformations to address the issues you identified when exploring the data.

1. In the pane on the left, collapse the **Datasets** section if it is still expanded, and expand the **Data Transformation** section, which contains a wide range of modules you can use to transform data before model training.
2. Drag a **Select Columns in Dataset** module to the canvas, below the **Automobile price data (Raw)** module. Then connect the output at the bottom of the **Automobile price data (Raw)** module to the input at the top of the **Select Columns in Dataset** module.
3. Select the **Select Columns in Dataset** module, and in its **Settings** pane on the right, select **Edit column**. Then in the **Select columns** window, select **By name** and use the **+** links to add all columns other than **normalized-losses**, like this:

    <p style='text-align:center'><img src='media/select-columns.png' alt='all columns other than normalized_losses'/></p>

4. Drag a **Clean Missing Data** module from the **Data Transformations** section, and place it under the **Select Columns in Dataset** module. Then connect the output from the **Select Columns in Dataset** module to the input of the **Clean Missing Data** module.
5. Select the **Clean Missing Data** module, and in the settings pane on the right, click **Edit column**. Then in the **Select columns** window, select **With rules**, in the **Include** list select **Column names**, in the box of column names enter **bore**, **stroke**, and **horsepower** (making sure you match the spelling and capitalization exactly), like this:

    <p style='text-align:center'><img src='media/clean-missing-values.png' alt='bore, stroke, and horsepower columns are selected'/></p>

6. With the **Clean Missing Data** module still selected, in the settings pane, set the following configuration settings:
    - **Minimum missing value ratio**: 0.0
    - **Maximum missing value ratio**: 1.0
    - **Cleaning mode**: Remove entire row
7. Drag a **Normalize Data** module to the canvas, below the **Clean Missing Data** module. Then connect the left-most output from the **Clean Missing Data** module to the input of the **Normalize Data** module.
8. Select the **Normalize Data** module and view its settings, noting that it requires you to specify the transformation method and the columns to be transformed. Then, set the transformation to **MinMax** and edit the columns by applying a rule to include the following **Column names** (ensuring you match the spelling, capitalization, and hyphenation exactly):
    - **symboling**
    - **wheel-base**
    - **length**
    - **width**
    - **height**
    - **curb-weight**
    - **engine-size**
    - **bore**
    - **stroke**
    - **compression-ratio**
    - **horsepower**
    - **peak-rpm**
    - **city-mpg**
    - **highway-mpg**

    <p style='text-align:center'><img src='media/normalize-rules.png' alt='all numeric columns other than price are selected'/></p>

## Run the pipeline

To see the effect of your data transformations, you need to run the pipeline as an experiment.

1. Ensure your pipeline looks similar to this:

    <p style='text-align:center'><img src='media/data-transforms.png' alt='Automobile price data (Raw) dataset with Select Columns in Dataset, Clean Missing Data, and Normalize Data modules'/></p>

2. Select **Submit**, and run the pipeline as a new experiment named **auto-price-training**.
3. Wait for the run to complete - this may take 5 minutes or more.
4. When the run has completed (indicated by a &#x2705; icon for each module), select the **Normalize Data** module and in the settings pane, on the **Outputs + Logs** tab, under **Port outputs** in the **Transformed dataset** section, use the **Visualize** icon to view the transformed columns.
5. Close the **Normalize Data** visualization.

The dataset is now prepared for model training.
