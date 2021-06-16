Now that you've installed everything you need, you can create a Jupyter Notebook file and start coding.

## Create a Jupyter Notebook file

To start, make a folder to easily organize all of the Jupyter files you'll create. Pick a location on your computer that's easily accessible, such as the documents folder or desktop, and create a folder named something like `Jupyter files` or `Python`.

Create a Jupyter Notebook file that will run your Python code.

1. Open Visual Studio Code.
1. Select **File** > **New** (or type `Ctrl-N`). A blank file opens.
1. Save the file as a Jupyter file: 
    1. Select **File** > **Save** (or type `Ctrl-S`).
    1. Give your file a name of your choosing.
    1. Select the save location to be the folder you just created.
    1. Change the file type to "Jupyter" from the drop-down menu. Or, you can add the file extension `.ipynb`, which automatically changes the file type to "Jupyter".

You'll know that it worked if you see the filename followed by ".ipynb" in the top left of the screen and your file displays cells instead of the solid editor view when you open it in Visual Studio Code.

:::image type="content" source="../media/make-jupyter.png" alt-text="Screenshot of the Python setup environment Jupyter file type":::

> [!NOTE]
> If your file doesn't display cells but is still showing the solid editor view instead, try closing VS Code and then open your `.ipynb` file by selecting **Open with Code**. Then, if Code indicates that the file is in "Restricted Mode", select the **Restricted Mode** box in the lower-left corner and then select **Trust**.

## Configure Python environment

When you have a Jupyter Notebook file, you'll need to choose which Python environment you're using. Visual Studio Code might have recognized Python after you installed it. But if it doesn't, select the area on the bottom left of the screen and select the version you installed.

:::image type="content" source="../media/jupyter-environment.png" alt-text="Screenshot showing setup of Python environment Python version selection":::

Next, you'll need to add Jupyter Notebooks to your path.
1. Type "2+2" into the first line of the editor.
1. Select the green play button.
1. At the bottom right of the screen, you'll see a pop-up asking you to install Jupyter Notebooks.
1. Select **Install** to start the installation. The install could take up to 5 minutes, so you may have to wait a while.

:::image type="content" source="../media/install-jupyter.png" alt-text="Screenshot showing Python setup environment install Jupyter Notebooks":::

Now, Jupyter Notebooks should be installed on your computer. Before you continue, make sure that the Jupyter Notebook Kernel is also running with the right version of Python. You can see the version in the top right of Visual Studio Code where it says "Jupyter Server: local" followed by the instance of Python.

## Information about Jupyter Notebooks

[Visual Studio Code Jupyter Notebooks](https://code.visualstudio.com/docs/python/jupyter-support?azure-portal=true) has good documentation about how to use the environment. In Jupyter notebooks, you write code in cells.
- Select the plus button to the left of a cell to create a new cell below the current cell.
- Select the garbage can to the right to delete the selected cell.
- Use the arrow buttons to move the cell up or down in relation to the cells around it.
- Use the green play button in each cell to run that cell.

After you run a cell, a number will appear, surrounded by square brackets. This number helps you keep track of which cells you run. That's important because, as you'll remember, you can rerun cells within a Jupyter Notebook, which might change variables or program state.

If you look at the top of the file, you'll see you can run all cells above or below the current cell by using the play button. Finally, you can select the red pause button to force stop the program at any time.

## Write and run a simple program

Now you'll test your setup by writing a simple "Hello World" program. In the first line of the editor, type the following code and then select the green play button.

```python
"Hello World"
```

:::image type="content" source="../media/run-jupyter.png" alt-text="Screenshot showing test in Jupyter Notebook":::

Below the cell that you ran, there should be an output saying **Hello World**.

Congratulations! You've programmed a computer to output text. Next step: ~~hacking the mainframe~~ ... or maybe we'll start by learning more about Python fundamentals!
