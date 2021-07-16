There are different ways to create and manage website projects. Some of these differences depend on the specific tools you have, and also the preferences of your organization. When creating a website, it's not uncommon for your project structure to change over time as it becomes more complicated. The key is to keep a semblance of organization, and there are common strategies to help. Large projects often require a higher degree of care and attention so that many people can keep everything organized.

In this unit, you'll create a simple project structure using Visual Studio (VS) Code. The project will have three files: an HTML file, a CSS file, and a JavaScript file. You'll also add a VS Code extension to simplify running the website in your browser.

## Create a new folder for your website

1. Open VS Code.

   When you open VS Code, the **Welcome** page opens. Notice that you can create a new file or open a folder in the **Start** list.

   :::image type="content" source="../media/vs-code-welcome.png" alt-text="Screenshot of VS Code Welcome page.":::

   If the **Welcome** page isn't visible, you can displayit by selecting **Help > Welcome** on the menu. (Alternatively, you can display the **Welcome** page using the VS Code Command Palette. You can open the Command Palette using the keyboard shortcut <kbd>Shift+Ctrl+P</kbd> on a Windows computer or <kbd>Shift+Cmd+P</kbd> on macOS, or by selecting **View > Command Palette** from the VS Code menu. When the command palette is displayed, enter **>Help: Welcome** in the search field to open the **Welcome** page.)

1. Select **Open folder** in the **Start** list of the **Welcome** page, or select **File > Open Folder** from the VS Code menu.

   :::image type="content" source="../media/vs-code-open-folder.png" alt-text="Screenshot of VS Code open folder.":::

   When opening a folder, the operating system has a menu option to create a **New Folder**.

1. Navigate to the location where you want to create the new folder for your website, and select **New Folder**.
 
1. Name the folder **simple-website**, and then select **Select Folder**.

## Create some files

1. Create a new file by selecting **File > New File** from the menu, or by using <kbd>Control+N</kbd> on Windows or <kbd>Command+N</kbd> on macOS.

1. Save the file by selecting <kbd>Control+S</kbd> on Windows, or <kbd>Command+S</kbd> on macOS.
 
1. Enter `index.html` for the file name, and then select **Save**.

1. Repeat the preceding steps to create two more files: `main.css` and `app.js`. When you're finished, in  Explorer you see your project folder **SIMPLE-WEBSITE** contains the following files that comprise your website:

   - index.html
   - main.css
   - app.js

   :::image type="content" source="../media/vs-code-explorer-view.png" alt-text="Screenshot of your files in VS Code Explorer view.":::

You could build a website by including all of your HTML, CSS styles, and JavaScript code within a single file. However, in this exercise you're using an HTML file for your content and page structure, a CSS file for your presentation and styling, and a JavaScript file for your behaviors and interactivity.

Setting up three files helps keep your website project organized. The separation of content, styles, and logic is an example of *progressive enhancement*. If JavaScript isn't enabled or supported by your customers, your CSS and HTML will still work. However, if CSS isn't supported by your customers, at least your HTML content will appear.

### Install extensions or packages

You can extend the functionality of VS Code using the extensions marketplace. Keep in mind that these are community-developed resources and there are often several solutions for the same type of feature. You can install extensions individually in your editor, or several at once with the command line.

For web development, all you need right now is **open-in-browser**. This extension helps you to quickly open the website in your default browser, instead of copying and pasting the file URL into your browser.

To install this extension, use the following steps:

1. Select the **Extensions** icon on the vertical **Activity Bar** (left pane).

1. Enter "open in" in the search box, then select the **open in browser** extension that is published by *TechER*.

1. Select **Install**, and VS Code will install the extension.

   :::image type="content" source="../media/vs-code-get-extension.png" alt-text="Screenshot of finding a VS Code extension.":::

1. Switch back to  **Explorer** by clicking the top icon in the **Activity Bar**, or use <kbd>Control+Shift-E</kbd> on Windows or <kbd>Command+Shift-E</kbd> on macOS.

Way to go! Installation and setup take a little extra time, but you only need to install and set up once. Now you're ready to create a website.
