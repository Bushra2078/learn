Your shopping list web app needs an API. In this exercise, you'll build and run your API using an Azure Functions project. You'll get and explore an API using an Azure Functions project. You'll also extend the API with a new function for your HTTP GET endpoint using the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

You'll follow this breakdown, in this exercise:

1. Explore the Azure Function project
1. Create the HTTP GET function
1. Refactor the function logic to get products
1. Configure the web app to proxy HTTP requests to the API
1. Run the API and the web app

## Get the Function app

When you created your git repository from the template, you selected to include all branches. So far you've been using the **master** branch. Now you'll use the **api** branch, which has the same web app but also includes an Azure Functions project.

Start by checking out the **api** branch, by following these steps:

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Git: Discard All Changes** since you have no changes to save
1. Open the command palette by pressing **F1**
1. Type and select **Git: Checkout to...**
1. Select the **api** branch

You'll now see an **api** folder in the Visual Studio Code explorer. The **api** folder contains your Azure Functions project, along with three functions.

| Folder and file       | Method | Route          |
| --------------------- | ------ | -------------- |
| _api/products-post_   | POST   | `products`     |
| _api/products-put_    | PUT    | `products:id`  |
| _api/products-delete_ | DELETE | `products/:id` |

Your API has routes for manipulating the products for the shopping list, but it lacks a route for getting the products. You'll add that next.

## Create the HTTP GET function

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. When prompted to create a function, select **HTTP Trigger**
1. Enter **products-get** as the name of the function
1. Select **Anonymous** as the authentication level

You just extended your Azure Function app with a function to get your products!

> [!NOTE]
> The function app is in the _api_ folder, which separates it from the web apps. All of the web apps using the front-end frameworks can hit the same API. You can decide how to structure your application, but for this sample it helps to see them separated.

### Configure the HTTP Method and route endpoint

Notice the folder _api/products-get_ contains the file _function.json_. This file contains the configuration for your function.

The route endpoint has the same name as the folder that contains the function, by convention. Since the function is created in the _products-get_ folder, the route endpoint is generated as **products-get**, by default. However, you want the endpoint to be **products**.

Configure your function:

1. Open the file _api/products-get/function.json_
1. Notice the methods allow both `GET` and `POST`
1. Change the methods array to only allow `GET` requests
1. Go to the `bindings` section's `req` properties
1. Add a `route: "products"` entry

Now your function is triggered on an HTTP `GET` request to **products**. Your _function.json_ should look like the following code:

```json
{
  "disabled": false,
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": ["get"],
      "route": "products"
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    }
  ],
  "scriptFile": "../dist/products-get/index.js"
}
```

### Refactor the route logic

The file _index.js_ in the folder _api/products-get_ contains logic that runs when your make an HTTP request to the route.

You'll need to refactor the logic to get your products. There is data access logic in the JavaScript module _/services/product-data.js_. The `product-data` module exposes a function `getProducts` to get the products for the shopping list.

Now, refactor the function endpoint to return the products:

1. Open the file _api/products-get/index.js_
1. Replace its contents with the following code:

   ```javascript
   const data = require('../services/product-data');

   module.exports = async function (context, req) {
     try {
       const products = data.getProducts();
       context.res.status(200).json(products);
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

Your function will get the products and return them with a status code of 200, when successful.

### Configure CORS locally

When you run your API locally it runs on port 7071. Your web app runs on a different port locally. When your web app tries to make a HTTP request from its port to your API's port 7071, this is known as a Cross-Origin Resource Sharing (CORS). Your browser will prevent the HTTP request from completing unless the API server allows the request to proceed.

You wont have to worry about CORS when you publish to Azure Static Web Apps. That's because Azure Static Web Apps automatically configures a reverse proxy so your web app can communicate with your API on Azure. So you only have to setup CORS when you run locally

Now, tell Azure Functions to allow your web app to make HTTP requests to the API, on your computer.

1. Create a file named _api/local.settings.json_
1. Add the following contents to the file

   ::: zone pivot="angular"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:4200"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:3000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:5000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:8080"
     }
   }
   ```

   ::: zone-end

> [!NOTE]
> The _local.settings.json_ file is listed in the _.gitignore_ file, which prevents this file from being pushed to GitHub. This is because you could store secrets in this file you would not want that in GitHub. This is why when you created your repository from the template it lacked this file and you had to create it.

### Run the API

Now it's time to watch your web app and Azure Functions project work together. Start by running your Azure Functions project locally by following these steps:

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Terminal: Create New Integrated Terminal**
1. Go to the _api_ folder

   ```bash
   cd api
   ```

1. Run the Azure Functions app locally

   ```bash
   npm start
   ```

## Run the web app

Your API is running. Now you need to configure your front-end app to make its HTTP request to your API. The front-end app runs on one port and the API runs on a different port (7071). Each front-end framework can be configured to proxy HTTP requests to another port safely.

### Configure your proxy port

Configure the proxy for your front-end app with the following steps:

::: zone pivot="angular"

1. Open the file _proxy.conf.json_
1. Locate the `target: 'http://localhost:7010'` setting
1. Change the target's port to point to 7071 `target: 'http://localhost:7071',`

::: zone-end

::: zone pivot="react"

1. Open the file _package.json_
1. Locate the `"proxy": "http://localhost:7020/",'` setting
1. Change the proxy's port to point to port 7071 `proxy: 'http://localhost:7071',`

::: zone-end

::: zone pivot="svelte"

1. Open the file _rollup.config.js_
1. Locate the line of code `const api = 'http://localhost:7030/api';`
1. Change the api's port to point to port 7071 `const api = 'http://localhost:7071/api';`

::: zone-end

::: zone pivot="vue"

1. Open the file _vue.config.js_
1. Locate the `target: 'http://localhost:7040',` setting
1. Change the target's port to point to port 7071 `target: 'http://localhost:7071',`

::: zone-end

### Run your front-end web app

Your API is already running on port 7071. Now when you run your web app it will make its HTTP requests to your API. Run your web app by following these steps:

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Terminal: Create New Integrated Terminal**
1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Run the front-end client application

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

### Browse to your app

It's time to see your application running locally against the Azure Functions API. Select your preferred front-end application and click the link to browse to the application.

::: zone pivot="angular"

Browse to <http://localhost:4200>

::: zone-end

::: zone pivot="react"

Browse to <http://localhost:3000>

::: zone-end

::: zone pivot="svelte"

Browse to <http://localhost:5000>

::: zone-end

::: zone pivot="vue"

Browse to <http://localhost:8080>

::: zone-end

You built your application and now it's running locally making HTTP GET requests to your API.

## Next steps

Your app works locally and your next step is to publish the app with the API together.
