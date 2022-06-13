To train and deploy models using Azure Machine Learning designer, you need compute targets to run the training process. You will also use these compute targets to test the trained model after its deployment.

## Create compute targets

Compute targets are cloud-based resources on which you can run model training and data exploration processes.

In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), expand the left pane by selecting the three lines at the top left of the screen. View the **Compute** page (under **Manage**). You manage the compute targets for your data science activities in the studio. There are four kinds of compute resource that you can create:
- **Compute Instances**: Development workstations that data scientists can use to work with data and models.
- **Compute Clusters**: Scalable clusters of virtual machines for on-demand processing of experiment code.
- **Inference Clusters**: Deployment targets for predictive services that use your trained models.
- **Attached Compute**: Links to existing Azure compute resources, such as Virtual Machines or Azure Databricks clusters.

> [!NOTE]
> Compute instances and clusters are based on standard Azure virtual machine images. For this module, the *Standard_DS11_v2* image is recommended to achieve the optimal balance of cost and performance. If your subscription has a quota that does not include this image, choose an alternative image; but bear in mind that a larger image may incur higher cost and a smaller image may not be sufficient to complete the tasks. Alternatively, ask your Azure administrator to extend your quota.

1. On the **Compute Clusters** tab, and add a new compute cluster with the following settings: 
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

> [!TIP]
> After you finish the entire module, be sure to follow the **Clean Up** instructions at the end of the module to stop your compute resources. Stop your compute resources to ensure your subscription won't be charged. 

The compute targets take some time to be created. You can move onto the next unit while you wait.