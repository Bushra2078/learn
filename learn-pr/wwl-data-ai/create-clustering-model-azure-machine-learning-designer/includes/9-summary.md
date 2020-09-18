In this module, you learned how to use Azure Machine Learning designer to train and publish a clustering model.

## Clean-up

The web service you created is hosted in an *Azure Kubernetes Cluster*. If you don't intend to experiment with it further, you should delete the endpoint and cluster to avoid accruing unnecessary Azure charges. You should also stop the compute instance until you need it again.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), on the **Endpoints** tab, select the **predict-iris-cluster** endpoint. Then select **Delete** (&#128465;) and confirm that you want to delete the endpoint.
2. On the **Compute** page, on the **Compute Instances** tab, select your compute instance and then select **Stop**.
3. On the **Compute** page, on the **Compute clusters** tab, open your compute cluster and select **Edit**. Then set the **Minimum number of nodes** setting to **0** and select **Update**.
4. On the **Compute** page, on the **Inference clusters** tab, select your inference cluster and select **Delete**, and confirm you want to delete the cluster.

If you have finished exploring Azure Machine Learning, you can delete the resource group containing your Azure Machine Learning workspace from your Azure subscription:

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), in the **Resource groups** page, open the resource group you specified when creating your Azure Machine Learning workspace.
2. Click **Delete resource group**, type the resource group name to confirm you want to delete it, and select **Delete**.
