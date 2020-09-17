In this unit, you'll create and deploy Azure machine learning module to the edge device.

Before you start the module, you need to set up your virtual environment.

# Set up a virtual environment

Firstly, you need to go to the .

You'll need:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com](https://azure.microsoft.com/) or a Student Subscription at [https://aka.ms/azureforstudents].

- A Visual Studio Online environment. This provides a hosted instance of Visual Studio Code, in which you'll be able to run the notebooks for the lab exercises.

  To set up this environment:

  1. Browse to [https://online.visualstudio.com](https://online.visualstudio.com/)
  2. Click **Get Started**.
  3. Sign in using the Microsoft account associated with your Azure subscription.
  4. Click **Create environment**. If you don't already have a Visual Studio Online plan, create one. This is used to track resource utlization by your Visual Studio Online environments. Then create an environment with the following settings:
     - **Environment Name**: *A name for your environment - for example, **MSLearn-create-deploy-azure-ml-module**.*
     - **Git Repository**: MicrosoftDocs/Train-package-Azure-ML-module-for-IoT-Edge
     - **Instance Type**: Standard (Linux) 4 cores, 8GB RAM
     - **Suspend idle environment after**: 120 minutes
  5. Wait for the environment to be created, and then click **Connect** to connect to it. This will open a browser-based instance of Visual Studio Code.

After you've completed the setup steps above, you can use your Visual Studio Online environment to complete the labs.

  1. Now go to the folder **IoT Edge anomaly detection tutorial** and click on **00-anomaly-detection-tutorial.ipynb**.
  2. You'll run all the code cells step by step in the notebook. The notebook is available in the [github repo](https://github.com/MicrosoftDocs/Train-package-Azure-ML-module-for-IoT-Edge).