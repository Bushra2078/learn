::: zone pivot="nodeexpress"

The combination of Node.js and Express.js provides a framework that JavaScript developers can use to build custom webapps.

Suppose the launch date for your new video game is imminent and you still don't have the marketing website up and running. You want to know how your team of JavaScript developers can create that site as fast as possible. You heard about Node.js and you want to find out if it can help you deliver a site quickly.

Here, you learn about Node.js and Express.js and how to use them on development computers, servers, and Azure App Service.

## What is Node.js?

JavaScript is a language that became popular for adding client-side interaction to webpages because many browsers supported it. If you incorporate JavaScript into HTML pages, you can use it to do things like animations, which aren't possible with HTML itself. Many developers became familiar with JavaScript in this context. 

What if you want to run JavaScript outside of the browser? Node.js is a runtime environment that you can use for this purpose. It's a popular way, for example, to create command-line tools written in JavaScript that run without the need for a browser.

In a webapp, you can use Node.js to run the server-side code. That approach enables you to use JavaScript for all the code in the webapp - both on the server and in the client browser. You don't have to learn an alternative language, such as PHP or C#. If you have a team of developers who already know JavaScript, this architecture can save you a large investment in training.

Node.js is open-source, free to use, and runs on many operating systems, including Windows, Linux, and macOS.

Node.js runs all its code asynchronously, which means that long-running requests don't block execution for other tasks. For example, if a user requests a webpage that takes a long time to render, other users can request and receive webpages during that time.

## What is Express.js?

With Node.js alone, you could build an entire web app. However, it would take much work and would replicate work done by many developers in the past. If you want to build a Node.js web server quickly and with minimal custom code, you can install Express.js.

Express.js includes functions that make it easy to intercept HTTP GET, POST, and DELETE requests, and route them to code that formulates responses. It also implements an HTTP server on your local machine, which you can start when you want to try out your code.

For example, a version of **Hello World** in Express.js might look like this:

```JavaScript
var express = require('express');
var app = express();

app.get('/', (req, res) => res.send('Hello World!'));
 
app.listen(3000);
```

In this code, Express.js is initiated and then the `app.get()` method is called to intercept any GET requests and respond with the "Hello World!" message. The last line configures the app to listen for requests on port 3000.

You can create web pages with code similar to the previous example, by formulating more complex HTML than `Hello World!`. However, most developers use a templating engine such as Pug (which used to be known as Jade). Templates are HTML files with extra placeholders. The engine makes it easy to insert values, such as data from a database, into the HTML to create dynamic pages.

When you want to create a skeleton webapp in Express.js, as a starting point for a customized site, you can use the Express Generator tool. With this command, you specify a templating engine and whether to support `git` and stylesheets. It creates a default set of views, routes, styles, and other infrastructure.

## What is Visual Studio Code?

Visual Studio Code is a free code editor for Windows, macOS, and Linux. It has support for JavaScript, TypeScript, and Node.js out-of-the-box, and you can install many extensions for other languages and runtimes.

You can use Visual Studio Code as your editor regardless of the languages, frameworks, operating systems, and deployment mechanisms you use. There's also an extension for Azure App Service, which you use later in this module to create webapps and deploy code.

## Use Express Generator to create a webapp scaffold

Express Generator is a utility that helps you get started on a new app. You can use the `npx` package runner to use Express Generator to create the files for a new app:

```bash
npx express-generator --pug --css
```

This example includes both the **pug** templating engine, and support for **css** stylesheets.

Once the generator completes, you see a default set of files in your webapp, including views, routes, stylesheets, and the **app.js** entry point.

::: zone-end

::: zone pivot="pythonflask"

Flask provides a framework that Python developers can use to build custom webapps.

Suppose the launch date for your new video game is imminent and you still don't have the marketing website up and running. You want to know how your team of Python developers can create that site as fast as possible. You heard about Flask and you want to find out if it can help you deliver a site quickly.

Here, you learn about Flask and how to use it on development computers, servers, and Azure App Service.

## What is Flask?

Flask is a "micro" framework that allows Python developers to quickly build web applications, including dynamic web sites and web APIis. A "micro" framework includes little built-in functionality and instead allows you to choose from extensions that provide the features you want. For example, in this module we use a web page template to render most of the web page. While Flask provides the Jinja templating engine Flask extension by default, it doesn't force you to use it. You could instead opt to install a separate Python package to use a different Flask extension to use as a templating engine.

## What is Visual Studio Code?

Visual Studio Code is a free code editor for Windows, macOS, and Linux. It has support for JavaScript, TypeScript, and Node.js out-of-the-box, and you can install many extensions for other languages and runtimes. When you create your first Python code file with a .py file extension, Visual Studio Code asks if you want to install the Python extension. The extension provides many integrated features in the Visual Studio Code command palette, in the debugging window, and provides help from directly within the code editor.

You can use Visual Studio Code as your editor regardless of the languages, frameworks, operating systems, and deployment mechanisms you use. There's also an extension for Azure App Service, which you use later in this module to create webapps and deploy code.

::: zone-end