There's a client-side route **/products** in your front-end application that displays a list of products for your shopping list. When you go to **/products** in your app by selecting the **Products** link, your browser's address bar will confirm that you're at **/products**. When you refresh the browser while on this page, you want the app to refresh and display the products once again. However, without a fallback route, you'll see a 404 error stating the page cannot be found.

You see a 404 error when you refresh the page because the browser sends a request to the hosting platform to serve **/products**. There's no page on the server named **products** to serve.

Fortunately, it's easy to resolve this by creating a fallback route. A fallback route is a route that matches all unmatched page requests to the server.

## Configure a fallback route

Azure Static Web Apps supports custom routing rules defined in an optional _staticwebapp.config.json_ file located in the app's source folder. You can define a navigation fallback route in the **navigationFallback** object. A common fallback route configuration follows.

```json
{
  "navigationFallback": {
    "rewrite": "/index.html",
    "exclude": ["/_framework/*", "/css/*"]
  }
}
```

| Setting | Value                       | Description                                                  |
| ------- | --------------------------- | ------------------------------------------------------------ |
| rewrite | `/index.html`                  | The file to serve when a route didn't match any other files. |
| exclude | `["/_framework/*", "/css/*"]` | Path(s) to ignore from fallback routing.                     |

The navigation fallback rule is applied after any other routing rules that appear in the _staticwebapp.config.json_ file.

## Route file location

The recommended location for the _staticwebapp.config.json_ is in the folder set as the `app_location` in the workflow file. However, the file may be placed in any location within your application source code folder.
