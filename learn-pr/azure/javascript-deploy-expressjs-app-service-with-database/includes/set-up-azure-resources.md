This unit briefly discusses the web app resources.  

## Azure web-related resources

Azure has several choices for hosting web applications. This module uses Azure App Service. The service hosts web applications and their configuration. The monitoring functionality for the web app is provided by the Azure Monitor service. 

The next exercise creates these resources for you and deploys the sample application. 

## Set up Azure resources

You can create Azure resources in several ways:

|Tool|Method and purpose|
|--|--|
|Azure portal|A browser-based portal to control all of your Azure resources.|
|Azure CLI|A terminal CLI used to automate resource management. <br><br>An Azure CLI script is proved in the sample application, `setup-in-sandbox.sh`. This script can be copied and run in the sandbox's interactive terminal in the next unit. If you used the dev containers in the last exercise, you can also run the bash script in the container terminal because the Azure CLI is installed in the container.|
|Visual Studio Code|A way to keep resource management in the same environment as your other development tasks.<br><br>If you would like to create your resources with Visual Studio Code, return to the previous module's [instructions](/training/modules/javascript-deploy-expressjs-app-service/create-app-service-resource) to create the App Service resource. Make sure to complete those instructions on this module's sandbox. |

## Learn sandbox 

The Learn sandbox allows you to create and use Azure resources with no cost to you and without any credit card. The Learn sandbox is contained in a separate tenant. When you start your sandbox, you need to sign into the Learn sandbox tenant so that you have access to that tenant. With access to the tenant, you can create the Azure resources used in this module. 
