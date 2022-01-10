There are many ways to run notebooks. You can run them right within this environment, on Microsoft Learn, and in fact in several of this path's modules you will run notebooks. In this module, however, you will learn how to get set up to run notebooks locally by using Visual Studio Code.

Before we start, take a look at this [video tutorial](https://www.youtube.com/watch?v=yyQM70vi7V8) on YouTube. The video explains how to download Python, get set up in Visual Studio Code, and run a notebook locally.

To start building your notebook, you need to have the following software available on your computer:

- Python
- Visual Studio Code
- Visual Studio Code Jupyter extension

## Install Python

If you don't have Python installed on your computer, you need to download it. On a Mac, go to [Python.org](https://www.python.org/downloads/?azure-portal=true) to install the latest version compatible with your operating system. On Windows, go to the [Microsoft Store](https://www.microsoft.com/store/top-free/apps/pc?category=Developer+tools%5cDevelopment+kits?azure-portal=true) to download the most recent version.

If you already have Python installed, you might need to update your installation to the latest version. Make sure you have Python 3 by typing `python3 --version` in your terminal or command line. If it is installed, the version will be displayed.

## Install Visual Studio Code

Next, install [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true). When the installation is complete, configure it to your liking. There are several good videos on setting things up in the [Visual Studio Code documentation](https://code.visualstudio.com/docs/getstarted/introvideos?azure-portal=true).

## Install the Python extension

When these two installations are complete, you'll then need to install a Visual Studio Code [extension](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter?azure-portal=true). This extension allows you to run Jupyter notebooks from within Visual Studio Code by using a *kernel*. A [kernel](https://wikipedia.org/wiki/Kernel_(operating_system)?azure-portal=true) in Visual Studio Code helps you activate an Anaconda environment, so you can run your notebooks by using your Python installation.

In Visual Studio Code, from extensions panel on the left, search for *Jupyter* by Microsoft. To install this extension, select **Install**.

:::image type="content" source="../media/jupyter-extension.png" alt-text="Screenshot that shows the Jupyter extension in Visual Studio Code.":::

Now that you have the three elements of your workspace set up, you can start working with Jupyter notebooks in Visual Studio Code.
