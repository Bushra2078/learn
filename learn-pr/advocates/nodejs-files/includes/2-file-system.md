Large retailers often write data to files so that it can be processed later in batches.

Tailwind Traders has each of its stores write its sales total to a file and send that file to a central location. To use those files, the company needs to create a batch process that can work with the file system.

Here, you'll learn how to use Node.js to read the file system to discover files and directories.

## Include the fs module

Node.js provides a built-in module for working with the file system. It's called the *fs* module. The name is short for "file system."

The fs module is included by default in Node.js, so you don't need to install it from npm.

This can be a bit confusing because you can't see the fs module in your file system or in your node_modules folder. So how do you include the fs module in a project? You reference it just as you would any other dependency. 

The fs module has a `promises` namespace that has promise versions of all methods. This is the preferred way to work with the fs module because it allows you to use `async`. It avoids the messiness of callbacks or the blocking of synchronous methods.

```javascript
const fs = require("fs").promises;
```

You can use the fs module to do various operations on files and directories. It has several methods to pick from. For now, we're going to focus on what you need to know to work with directories by using the fs module.

## List contents in a directory

One task that you'll often do with the fs module is list out or *enumerate* the contents in a directory. For instance, Tailwind Traders has a root folder called *stores*. In that folder are subfolders organized by store number. Inside those folders are the sales-total files. The structure looks like this:

```
📂 stores
    📄 sales.json
    📄 totals.txt
    📂 201
    📂 202
```

To read through the contents of the folder, you can use the `readdir` method. Most operations on the fs module have both synchronous and asynchronous options.

The `readdir` method returns a list of items:

```javascript
const items = await fs.readdir("stores");
console.log(items); // [ 201, 202, sales.json, totals.txt ]
```

The `readdir` and `readdirsync` methods return results in alphabetical order.

## Determine content type

When you read the contents of a directory, you get back both folders and files as an array of strings. You can determine which strings are files and which ones are directories by passing in the `withFileTypes` option. This option will return an array of `Dirent` objects instead of an array of strings. The `Dirent` object has `isFile` and `isDirectory` methods that you can use to determine what type of object you're dealing with.

```javascript
const items = await fs.readdir("stores", { withFileTypes: true });
for (let item of items) {
  const type = item.isDirectory() ? "folder" : "file";
  console.log(`${item.name}: ${type}`);
  // 201: folder, 202: folder, sales.json: file, totals.txt: file
}
```

## A note about recursion

A common requirement is to have folders with subfolders, which also have subfolders. Somewhere in this tree of nested folders are files that you need. You need a program that can find the files in the folder tree. To do that, you'll have to determine if an item is a folder, and then search that folder for files. You'll have to repeat this for every folder that you find.

You can search nested directory structures by having a method that finds folders and then calls itself to find folders inside those folders. In this way, the program will "walk" the directory tree until it reads every folder inside. When a method calls itself, that's called *recursion*.

```javascript
function findFiles(folderName) {
  const items = await fs.readdir(folderName, { withFileTypes: true });
  items.forEach((item) => {
    if (item.isDirectory()) {
      // this is a folder, so call this method again and pass in
      // the path to the folder
      findFiles(`${folderName}/${item.name}`);
    } else {
      console.log(`Found file: ${item.name} in folder: ${folderName}`);
    }
  });
}

findFiles("stores");
```

Recursion is a powerful feature of many programming languages. You'll likely use it a lot in the real world.

In the next exercise, you'll use the fs module to dynamically read through Tailwind Traders' main "stores" directory to find all of the sales.json files.
