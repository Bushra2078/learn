

Imagine you trained a model to predict the product sales. The model has been trained and tracked in Azure Machine Learning. Every month, you want to use the model to forecast the sales for the upcoming month. 

In many production scenarios, long-running tasks that deal with on large amounts of data are performed as **batch** operations. In machine learning, ***batch inferencing*** is used to asynchronously apply a predictive model to multiple cases and write the results to a file or database.

![A batch inferencing service](../media/07-02-batch.png)

In Azure Machine Learning, you can implement batch inferencing solutions by deploying a model to a batch endpoint.

## Learning objectives

In this module, you'll learn how to:

- Create a batch endpoint.  
- Deploy your MLflow model to a batch endpoint.
- Deploy a custom model to a batch endpoint.
- Invoke batch endpoints.