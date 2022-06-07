In this unit, you'll create and run a Hello World Node.js script.

## Node.js REPL

Node.js has a built-in read-eval-print loop (REPL) mode that's useful for quick code evaluation and experimentation. REPL mode is an interactive console environment where you can enter JavaScript code and have Node.js interpret and run the code and then print the output.

The Node.js REPL mode works as follows:

- **Read**: Reads and parses the user's JavaScript code input (or shows an error if the code is invalid).
- **Eval**: Evaluates the entered JavaScript code.
- **Print**: Prints the computed results.
- **Loop**: Loops and waits for the user to enter a new command (or exits if the user enters **ctrl-c** twice).

To start REPL mode, run the `node` program in Azure Cloud Shell.

> [!Note]
> Use right-click > **Paste** to enter a copied command in Cloud Shell or in the REPL console.

```bash
node
```

The REPL environment opens. You should see the REPL prompt:

```console
>
```

Enter the following code in the REPL console (right-click > **Paste**):

```console
console.log('Hello World, from the REPL.')
```

This code prints a "Hello World, from the REPL." message in the REPL console:

```output
Hello World, from the REPL.
```

To exit the REPL console, enter Ctrl + C twice. 


## Create a Node.js script

Node.js also supports running code from files.

1. In Azure Cloud Shell, open a new editor by entering the `code` command:

   ```bash
   code
   ```

1. In the Cloud Shell code editor, create a file by entering the following code:

   > [!Note]
   > Use Ctrl + V to enter a copied command in the Cloud Shell code editor.

   ```javascript
   console.log('Hello World, from a script file.');
   ```

1. Save the file with the name **index.js** by entering the following command:

   ::: zone pivot="windows,linux"
   - For Windows and Linux, enter Ctrl + S.
   ::: zone-end

   ::: zone pivot="macos"
   - For macOS, enter Cmd + S.
   ::: zone-end
   
1. In Cloud Shell, enter the `node` command followed by the name of the file index.js:

   ```bash
   node index.js
   ```

You should see the following output:

```output
Hello World, from a script file.
```

You have now run your first Node.js JavaScript code.
