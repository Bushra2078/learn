The online retailer needs their application to have some basic security. The web Express app should differentiate between registered customers who have access, and other users who shouldn't have access. Other features, like role management, might be added at a later date.

## Add basic authorization to an Express framework

Most applications have parts that anyone can access. But, some parts need to be protected. There are different ways to protect an application. In this exercise, you'll implement a simple protection system to understand how the mechanism of *middleware* works in the Express framework.


## Clone the project repo

In this exercise, you'll use an example project that has product files and starter application code. You'll fill in the missing parts of the project to complete the app updates for the customer.

1. In a terminal, clone the sample repo for this example by running the following command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

1. Inspect the cloned repo by changing to the **exercise-express-middleware** folder of the project:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-middleware
   ```

   This folder has three files: **app.js**, **client.js**, and **package.json**.

1. The package.json file contains a dependency named `express`. Run the following command to install the dependency:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in the package.json file and installs the required packages.

1. In a code editor, open the app.js file and inspect the contents:

   ```javascript
   const express = require("express");
   const app = express();
   const port = 3000;

   app.get("/", (req, res) => res.send("Hello World!"));

   app.get("/users", (req, res) => {
     res.json([
       {
         id: 1,
         name: "User Userson",
       },
     ]);
   });

   app.get("/products", (req, res) => {
     res.json([
       {
         id: 1,
         name: "The Bluest Eye",
       },
     ]);
   });

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The code contains a functioning Express application with three routes: slash `/`, `/users`, and `/products`.

   - Close the app.js file.

1. In a code editor, open the client.js application file and inspect the contents:

   ```javascript
   const http = require("http");

   http.get(
     {
       port: 3000,
       hostname: "localhost",
       path: "/users",
       headers: {},
     },
     (res) => {
       console.log("connected");
       res.on("data", (chunk) => {
         console.log("chunk", "" + chunk);
       });
       res.on("end", () => {
         console.log("No more data");
       });
       res.on("close", () => {
         console.log("Closing connection");
       });
     }
   );
   ```

   The client application code connects to the address `http://localhost:3000/users` for the `/users` route. The client listens for three events: `data`, `end`, and `close`.

   - Close the client.js file.


## Run the Express program 

Now you're ready to try the Express program with a client application.

1. In the terminal, run the Express program by entering this command:

   ```bash
   node app.js
   ```

   > [!Note]
   > Make sure you're running the app.js file located in the cloned repo folder, node-essentials/nodejs-http/exercise-express-middleware.

1. In a **second** terminal, run the client application:

   1. Go to the location where you cloned the project repo. You should be in the **node-essentials** folder.

   1. Change to the folder that has the client.js file:

      ```bash
      cd node-essentials/nodejs-http/exercise-express-middleware
      ```

    1. Start the client application:

       ```bash
       node client.js
       ```

   In the second terminal, you should see the following output from the client:

   ```output
   connected
   chunk [{"id":1,"name":"User Userson"}]
   No more data
   Closing connection
   ```

   The Express program responds with some user data, `chunk [{"id":1,"name":"User Userson"}]`. All the parts of the application work. 

   The client program ends after it displays the output.
   
1. In the first terminal, press Ctrl + C to stop the program.


## Protect the route

To protect this route, we'll add some code to the Express application.

1. In a code editor, open the node-essentials/nodejs-http/exercise-express-middleware/app.js file. Locate the `const app = express()` statement. After this statement, add the following code:

   ```javascript
   function isAuthorized(req, res, next) {
     const auth = req.headers.authorization;
     if (auth === 'secretpassword') {
       next();
     } else {
       res.status(401);
       res.send('Not permitted');
     }
   }
   ```

1. Next, locate the following section of code in the same file:

   ```javascript
   app.get("/users", (req, res) => {
     res.json([
       {
         id: 1,
         name: "User Userson",
       },
     ]);
   });
   ```

1. Replace this section with the following code:

   ```javascript
   app.get("/users", isAuthorized, (req, res) => {
     res.json([
       {
         id: 1,
         name: "User Userson",
       },
     ]);
   });
   ```

   In the updated code, the `isAuthorized` middleware is added as the second argument.

1. Save and close the app.js file.


## Run the Express program and invoke the middleware 

Try the client again with the updated server program.

1. In the first terminal, run the following command to restart the Express program:

   ```bash
   node app.js
   ```

1. In the second terminal, restart the client application:

   ```bash
   node client.js
   ```

   In the second terminal, you should see the following output:

   ```output
   connected
   chunk Not permitted
   No more data
   Closing connection
   ```

   This time, the `isAuthorized()` middleware is invoked and looks for an `authorization` header that has a specific value. Because you didn't provide a specific value as part of your request, the code didn't respond with specific user data. Instead, the response was `chunk Not permitted`. You'll add specific authorization in the next section.

1. In the first terminal, press Ctrl + C to stop the program.


## Add authorization header
   
You need to add an `authorization` header for a specific value.

1. In a code editor, open the node-essentials/nodejs-http/exercise-express-middleware/client.js file again. Locate the following statement:

   ```javascript
   headers: {},
   ```

1. Replace this statement with the following code:

   ```javascript
   headers: {
     authorization: 'secretpassword'
   },
   ```

1. Save and close the client.js file.


## Run the Express program with client authorization

Try the client again with an `authorization` header.

1. In the first terminal, run the following command to restart the Express program:

   ```bash
   node app.js
   ```

1. In the second terminal, run the following command to run the client again:

   ```bash
   node client.js
   ```

   In the second terminal, you should now see the following output:

   ```output
   connected
   chunk [{"id":1,"name":"User Userson"}]
   No more data
   Closing connection
   ```

   The user data is returned because you passed an `authorization` header with an accepted value.

1. In the first terminal, press Ctrl + C to stop the program.

Congratulations! You learned how to use the middleware construct in Express to add some basic authorization to your Express program.

> [!CAUTION]
> Be aware that an authentication/authorization meant for real world use needs to be a bit more robust than our example. It's worth looking up concepts such as OAuth, JSON Web Tokens, JWT and the library **bcrypt** to make sure your app has a decent level of protection.
