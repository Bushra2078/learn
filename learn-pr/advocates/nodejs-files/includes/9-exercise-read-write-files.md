The "fs" module in Node.js can also be used to write data to files and read data from files.

You're almost finished creating a Node.js masterpiece for Tailwind Traders. So far, your code reads any given directory, finds all ".json" files, and creates a "totals.txt" file.

In this exercise, you'll complete the project by reading the ".json" files, adding up the store totals, and writing the grand total to the "totals.txt" file.

## Create method to calculate sales totals

1. At the top of `index.js`, just below the `require("path")` statement, create a function that will calculate the sales total. This method should take in the array of file paths that it can iterate over.

   ```javascript
   async function calculateSalesTotal(salesFiles) {
     let salesTotal = 0;

     // READ FILES LOOP

     return salesTotal;
   }
   ```

1. Within that method, replace the "// READ FILES LOOP" with a loop that iterates over the "salesFiles" array, reads the file, parses the content as JSON, and then increments the "salesTotal" variable with the "total" value from the file.

   ```javascript
   async function calculateSalesTotal(salesFiles) {
     let salesTotal = 0;
     // loop over each file path in the salesFiles array
     for (file of salesFiles) {
       // read the file and parse the contents as JSON
       const data = JSON.parse(await fs.readFile(file));
       // Add the amount in the data.total field to the salesTotal variable
       salesTotal += data.total;
     }
     return salesTotal;
   }
   ```

## Call the calculateSalesTotals method

1. In the `main` function, add a call to the `calculateSalesTotals` function just above the `fs.writeFile` call.

   ```javascript
   async function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // create the salesTotal directory if it doesn't exist
     try {
       await fs.mkdir(salesTotalsDir);
     } catch {
       console.log(`${salesTotalsDir} already exists.`);
     }

     // find paths to all the sales files
     const salesFiles = await findSalesFiles(salesDir);

     // read through each sales file to cacluate the sales total
     const salesTotal = await calculateSalesTotal(salesFiles);

     // write the total to the "totals.txt" file
     await fs.writeFile(path.join(salesTotalsDir, "totals.txt"), String());
   }
   ```

## Write the total to the "totals.txt" file

1. In the `main` function, modify the `fs.writeFile` a block to write the value of the `salesTotal` variable to the "totals.txt" file.

   ```javascript
   async function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // create the salesTotal directory if it doesn't exist
     try {
       await fs.mkdir(salesTotalsDir);
     } catch {
       console.log(`${salesTotalsDir} already exists.`);
     }

     // find paths to all the sales files
     const salesFiles = await findSalesFiles(salesDir);

     // read through each sales file to cacluate the sales total
     const salesTotal = await calculateSalesTotal(salesFiles);

     // write the total to the "totals.json" file
     await fs.writeFile(
       path.join(salesTotalsDir, "totals.txt"),
       `${salesTotal}\r\n`,
       { flag: "a" }
     );
   }
   ```

1. Press <kbd>Cmd</kbd> / <kbd>Ctrl</kbd> + <kbd>S</kbd> to save the `index.js` file.

## Execute the program

1. Execute the program from the terminal.

   ```bash
   node index.js
   ```

   There is no output from the program. If you look in the "salesTotals/totals.txt", you will see the total of all the sales from the "sales.json" files.

1. Execute the program from the terminal again.

   ```bash
   node.index.js
   ```

1. Select the "index.js" file.

1. Select the "salesTotals/totals.txt" file.

   There is now a second line in the "totals.txt" file. Every time you run the program, the totals are added up again and a new line is written to the file.

Outstanding work! You've written a smart, robust, and handy tool that Tailwind Traders can use to process all of its stores sales every night. You make this stuff look easy. In the next section, we'll review what you learned, and a few tips to remember as you head on your merry way.

## Got stuck?

If you got stuck during this exercise, here is the full code for this project.

```javascript
const fs = require("fs").promises;
const path = require("path");

async function calculateSalesTotal(salesFiles) {
  let salesTotal = 0;
  // loop over each file path in the salesFiles array
  for (file of salesFiles) {
    // read the file and parse the contents as JSON
    const data = JSON.parse(await fs.readFile(file));
    // Add the amount in the data.total field to the salesTotal variable
    salesTotal += data.total;
  }
  return salesTotal;
}

async function findSalesFiles(folderName) {
  // this array will hold sales files as they are found
  let salesFiles = [];

  async function findFiles(folderName) {
    // read all the items in the current folder
    const items = await fs.readdir(folderName, { withFileTypes: true });

    // iterate over each found item
    for (item of items) {
      // if the item is a directory, it will need to be searched
      if (item.isDirectory()) {
        // call this method recursively, appending the folder name to make a new path
        await findFiles(path.join(folderName, item.name));
      } else {
        // Make sure the discovered file is a .json file
        if (path.extname(item.name) === ".json") {
          // store the file path in the salesFiles array
          salesFiles.push(path.join(folderName, item.name));
        }
      }
    }
  }

  await findFiles(folderName);

  return salesFiles;
}

async function main() {
  const salesDir = path.join(__dirname, "stores");
  const salesTotalsDir = path.join(__dirname, "salesTotals");

  // create the salesTotal directory if it doesn't exist
  try {
    await fs.mkdir(salesTotalsDir);
  } catch {
    console.log(`${salesTotalsDir} already exists.`);
  }

  // find paths to all the sales files
  const salesFiles = await findSalesFiles(salesDir);

  // read through each sales file to cacluate the sales total
  const salesTotal = await calculateSalesTotal(salesFiles);

  // write the total to the "totals.json" file
  await fs.writeFile(
    path.join(salesTotalsDir, "totals.txt"),
    `${salesTotal}\r\n`,
    { flag: "a" }
  );
  console.log(`Wrote sales totals to ${salesTotalsDir}`);
}

main();
```
