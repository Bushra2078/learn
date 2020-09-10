So far in this module, you've learned a lot about the theory and principles of deep learning with neural networks. The best way to learn how to apply this theory is to actually build a deep learning model, and that's what you'll do in this exercise.

There are many frameworks available for training deep neural networks, and in this exercise you can choose to explore either (or both) of two of the most popular deep learning frameworks for Python: *PyTorch* and *TensorFlow*.

## Before you start

To complete the exercise, you'll need:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free](https://azure.microsoft.com/free?azure-portal=true).
- An Azure Machine Learning workspace with a compute instance and the **ml-basics** repository cloned.

> [!NOTE]
> This module is one of many that make use of an Azure Machine Learning workspace. If you are completing this module as part of the [Create machine learning models](https://docs.microsoft.com/learn/paths/create-machine-learn-models?azure-portal=true) learning path or in preparation for the [Azure Data Scientist](https://docs.microsoft.com/learn/certifications/azure-data-scientist?azure-portal=true) certification, consider creating the workspace once and reusing it in other modules. After completing the exercise, be sure to follow the **Clean Up** instructions to stop compute resources, and retain the workspace if you plan to reuse it.

### Create an Azure Machine Learning workspace

If you don't already have an Azure Machine Learning workspace in your Azure subscription, follow these steps to create one:

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the Microsoft account associated with your Azure subscription.
2. Select **＋Create a resource**, search for *Machine Learning*, and create a new **Machine Learning** resource with the following settings:
    - **Workspace Name**: *enter a unique name of your choice*
    - **Subscription**: *your Azure subscription*
    - **Resource group**: *create a new resource group with a unique name*
    - **Location**: *choose any available location*
    - **Workspace edition**: Enterprise
3. Wait for your workspace resource to be created (it can take a few minutes). Then go to it in the portal, and on the **Overview** page for your workspace, launch Azure Machine Learning studio (or navigate to [https://ml.azure.com](https://ml.azure.com?azure-portal=true)), and sign in using your Microsoft account.
4. In Azure Machine Learning studio, toggle the  **&#9776;** icon at the top left to view the various pages in the interface. You can use these pages to manage the resources in your workspace.

### Create a compute instance

To run the notebook used in this exercise, you will need a compute instance in your Azure Machine Learning workspace.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Compute** page for your workspace (under **Manage**).
2. On the **Compute Instances** tab, if you already have a compute instance, start it; otherwise create a new compute instance with the following settings:
    - **Compute name**: *enter a unique name*
    - **Virtual Machine type**: CPU
    - **Virtual Machine size**: Standard_DS2_v2
3. Wait for the compute instance to start (this may take a minute or so)

### Clone the **ml-basics** repository

The files used in this module (and other related modules) are published in the **MicrosoftDocs/ml-basics** GitHub repository. If you haven't already done so, use the following steps to clone the repository to your Azure Machine Learning workspace:

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), on the **Compute** page, view your running compute instance.
2. Use the **Jupyter** link to open Jupyter Notebooks in a new browser tab.
3. In the Jupyter page, on the **New** menu, select **Terminal**. This will open a new tab with a terminal shell.
4. In the terminal shell, run the following commands to change the current directory to the **Users** directory, and clone the **ml-basics** repository, which contains the notebook and files you will use in this exercise:

    ```bash
    cd Users
    git clone https://github.com/microsoftdocs/ml-basics
    ```

5. After the command has completed and the checkout of the files is done, close the terminal tab and view the home page in your Jupyter notebook file explorer. Then open the **Users** folder - it should contain an **ml-basics** folder, containing the files you will use in this module.

> [!NOTE]
> We highly recommend using Jupyter in an Azure Machine Learning workspace for this exercise. This setup ensures the correct version of Python and the various packages you will need are installed; and after creating the workspace once, you can reuse it in other modules. If you prefer to complete the exercise in a Python environment on your own computer, you can do so. You'll find details for configuring a local development environment that uses Visual Studio Code at [Running the labs on your own computer](https://github.com/MicrosoftDocs/ml-basics/blob/master/local-setup.md?azure-portal=true). Be aware that if you choose to do this, the instructions in the exercise may not match your notebooks user interface.

## Explore data in a Jupyter notebook

After you've created a Jupyter environment and cloned the **ml-basics** repository, you're ready to explore deep learning.

 1. In Jupyter, in the **ml-basics** folder, open the **Deep Neural Networks (PyTorch).ipynb** or **Deep Neural Networks (Tensorflow).ipynb** notebook, depending on your framework preference, and follow the instructions it contains.
 2. When you've finished, close and halt the notebook.

When you've finished working through the notebook, return to this module and move on to the next unit to learn more.
