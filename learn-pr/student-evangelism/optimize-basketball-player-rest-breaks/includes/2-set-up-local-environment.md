In *Space Jam: A New Legacy*, we know that superstar LeBron James's teammates, the Tune Squad, are coming back in full force with their singular basketball skills and unique cartoon powers to have fun on the court. Their coach has been preparing to lead the team to victory against any opponent, but the coach doesn't have a ton of experience coaching a basketball team. So, we're going to build a basic app to help out the coach. 

Before jumping into the module, make sure your environment is set up and ready to go. For this module, you'll need Visual Studio Code, with the [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python?azure-portal=true) and [Azure Static Web Apps](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps?azure-portal=true) extensions installed. You'll also need an [Azure account](/learn/modules/create-an-azure-account?azure-portal=true) and a [GitHub account](/learn/modules/introduction-to-github?azure-portal=true). 

If you haven't yet installed Visual Studio Code, you can find guides on the [Visual Studio Code Learn to Code site](https://aka.ms/LearnOnVSCode?azure-portal=true). Here, you also can find a coding pack for Python for Windows that will install everything you need for this module. If you're not using Windows, you can find a guide for setting up your environment on the [Data Science in Visual Studio Code docs page](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true).

## Set up Visual Studio Code with a new Jupyter file

After you have your environment set up, create a folder named *space-jam-anl* wherever you store code on your computer. You can save this folder anywhere, including, for example, on your desktop. You might already have this folder if you're continuing from the [preceding *Space Jam: A New Legacy*-inspired module](/learn/modules/predict-basketball-player-efficiency-ratings?azure-portal=true).

:::image type="content" source="../media/new-folder.png" alt-text="Screenshot that shows the new *space-jam-anl* folder created on the desktop.":::

Open Visual Studio Code and, on the **Welcome** tab, select **Open Folder**. Another way to open the folder is to select **File** > **Open**, and then go to the folder you created.

:::image type="content" source="../media/open-folder.png" alt-text="Screenshot that shows the new *space-jam-anl* folder open in Visual Studio Code.":::

Create a new file named *space-jam-anl.ipynb* in the *space-jam-anl* folder. To create the file, in Visual Studio Code Explorer, select the new file icon next to the folder name.

:::image type="content" source="../media/new-file.png" alt-text="Screenshot that shows creating the *space-jam-anl.ipynb* file in Visual Studio Code.":::

> [!NOTE]
> You also can just continue using the *space-jam-anl.ipynb* file that you created in the [preceding *Space Jam: A New Legacy*-inspired module](/learn/modules/predict-basketball-player-efficiency-ratings?azure-portal=true), if you already have that.

Make sure the file opens into a notebook and that the Jupyter server is connected and the kernel is pointing to the correct Python version.

:::image type="content" source="../media/jupyter-file.png" alt-text="Screenshot that shows a blank Jupyter Notebook file open in Visual Studio Code and Python 3 as the Python version.":::

## Download data with basketball stats and Tune Squad character names

Next, you'll need some data. You might already have this data from the [preceding *Space Jam: A New Legacy*-inspired module](/learn/modules/predict-basketball-player-efficiency-ratings?azure-portal=true), but if you don't, you can download a clean copy from [player_data_final.csv on GitHub](https://aka.ms/LearnWithDrG/Basketball/Data2?azure-portal=true). Download the CSV file. Make sure you save the data in a file called *player_data_final.csv* and save it in the *space-jam-anl* folder you created. 

Then, you'll need the Tune Squad character names. This data is stored in [tune_squad.csv on GitHub](https://aka.ms/LearnWithDrG/Basketball/Data3?azure-portal=true). Make sure that you save the data in a file called tune_squad.csv, and save the file in the *space-jam-anl* folder you created. 

If you select the CSV file, you see this data in Visual Studio Code:

:::image type="content" source="../media/csv-visual-studio-code.png" alt-text="Screenshot that shows viewing the C S V file in Visual Studio Code.":::

## Check the local setup with Python libraries

Now that you have your local environment and data ready to go, check to make sure everything is set up properly.

If this file is a new file, in the top cell of the *space-jam-anl.ipynb* file, import the pandas library as `pd`. If you're continuing on with the file created in the [preceding *Space Jam: A New Legacy*-inspired module](/learn/modules/predict-basketball-player-efficiency-ratings?azure-portal=true), skip this import step, but be sure to rerun your entire notebook to ensure that everything is loaded into your Python environment. This way, you can call pandas functions by using `pd`.

```python
import pandas as pd
```

If that completes successfully, you'll see `[1]` next to the cell and no output: 

:::image type="content" source="../media/successful-pandas-import.png" alt-text="Screenshot that shows a successful pandas import in Visual Studio Code.":::

Next, you'll make sure you can import the data into your coding environment by using the pandas `read_csv` function: 

```python
# Import the CSV file and create a DataFrame.
player_df_final = pd.read_csv('player_data_final.csv')
```

If that is successful, you'll see `[2]` next to the cell (if you're continuing on with the file created in the [preceding *Space Jam: A New Legacy*-inspired module](/learn/modules/predict-basketball-player-efficiency-ratings?azure-portal=true), you might see number other than 2, and no output.

:::image type="content" source="../media/successful-data-import.png" alt-text="Screenshot that shows a successful data import in Visual Studio Code.":::

Now, you're ready to start exploring and cleansing your data!

## Check local setup with the Azure Static Web Apps extension

Before continuing, make sure you are signed in to Azure and you have access to your subscriptions within the Azure Static Web Apps extension. 

In the left icon menu, select the Azure extension. Look for a section for Static Web Apps. In this section, you'll see all of your Azure subscriptions, including, for example, a Pay-As-You-Go subscription. If you haven't created a Static Web App in Azure before, there should be nothing listed under the subscription. Make sure that at the bottom of your Visual Studio Code window, you are signed in to the Azure account that you want to use to create this resource.

:::image type="content" source="../media/set-up-azure-static-web-app.png" alt-text="Screenshot that shows the Azure Static Web App setup in Visual Studio Code.":::

## Check local setup with CodeTour extension

Finally, make sure that you've installed the [Visual Studio Code CodeTour extension](https://aka.ms/codetour-mslearn). If you have, look for it at the bottom of Visual Studio Code Explorer. Having the CodeTour extension installed will come in handy later when you create the web app because there are many ways to build a basic JavaScript app. We'll guide you through the steps we used to build ours!

:::image type="content" source="../media/codetour-setup.png" alt-text="Screenshot that shows CodeTour in Visual Studio Code.":::

© 2020 Warner Bros. Ent. All Rights Reserved