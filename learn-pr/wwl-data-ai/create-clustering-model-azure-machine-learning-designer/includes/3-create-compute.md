To train and deploy models using Azure Machine Learning designer, you need compute on which to run the training process, test the model, and host the model in a deployed service.

## Create compute targets

Compute targets are cloud-based resources on which you can run model training and data exploration processes.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Compute** page (under **Manage**). This is where you manage the compute targets for your data science activities. There are four kinds of compute resource you can create:
    - **Compute Instances**: Development workstations that data scientists can use to work with data and models.
    - **Compute Clusters**: Scalable clusters of virtual machines for on-demand processing of experiment code.
    - **Inference Clusters**: Deployment targets for predictive services that use your trained models.
    - **Attached Compute**: Links to existing Azure compute resources, such as Virtual Machines or Azure Databricks clusters.
2. On the **Compute Instances** tab, add a new compute instance with the following settings. You'll use this to test your model:
    - **Compute name**: *enter a unique name*
    - **Virtual Machine type**: CPU
    - **Virtual Machine size**: Standard_DS2_v2
3. While the compute instance is being created, switch to the **Compute Clusters** tab, and add a new compute cluster with the following settings. You'll use this to train a machine learning model:
    - **Compute name**: aml-cluster
    - **Virtual Machine size**: Standard_DS2_v2
    - **Virtual Machine priority**: Dedicated
    - **Minimum number of nodes**: 2
    - **Maximum number of nodes**: 2
    - **Idle seconds before scale down**: 120
4. While the compute cluster is being created, switch to the  **Inference Clusters** tab, and add a new cluster with the following settings. You'll use this to deploy your model as a service.
    * **Compute name**: aks-cluster
    * **Kubernetes Service**: Create new
    * **Region**: *Select a different region than the one used for your workspace*
    * **Virtual Machine size**: Standard_DS2_v2 (*Use the filter to find this in the list*)
    * **Cluster purpose**: Dev-test
    * **Number of nodes**: 2
    * **Network configuration**: Basic
    * **Enable SSL configuration**: Unselected
4. Verify that the inference cluster is in the *Creating* state - it will take a while to be created, so leave it for now.

> [!NOTE]
> In a production environment, you'd typically set the **minimum number of nodes** value to 0 so that compute is only started when it is needed. However, compute can take a while to start, so to reduce the amount of time you spend waiting for it in this module, you've initialized it with two permanently running nodes.
>
> If you decide not to complete this module, be sure to stop your compute instance,  edit the compute cluster to reset the minimum number of nodes to 0, and delete the inference cluster in order to avoid leaving your compute running and incurring unnecessary charges to your Azure subscription. Alternatively, if you're finished exploring Azure Machine Learning, delete the entire resource group in your Azure subscription.

The compute targets will take some time to be created. You can move onto the next unit while you wait.
