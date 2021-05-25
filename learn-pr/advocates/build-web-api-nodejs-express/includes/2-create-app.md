Companies often store data a lot of data in file systems and databases. They access that data by serving it through web applications and APIs using HTTP.

The following are important concepts to consider when you build web applications and APIs:

- **Routing**: Your application is divided into different sections based on parts of the URL address.
- **Support for different content types**: The data to serve up might exist in different file formats, Such as plain text, JSON, HTML, CSV, and more.
- **Authentication/Authorization**: Some data might be sensitive. A user might need to sign in or have a specific role or permission level to access the data.
- **Read/Write data**: Users usually need to both view and add data to the system. To add data, users might enter data in a form or upload files.
- **Time to market**: To create web applications and APIs efficiently, choose tools and libraries that provide solutions to common problems. These choices help the developer spend as much time as possible on the business requirements of the job.  

## HTTP module in Node.js

Node.js comes with a built-in HTTP module. It's a fairly small module that handles most types of requests. It works with important topics such as headers, the URL, and payloads.

The following classes help manage a request from start to finish:

- **http.Server**: Represents an instance of an HTTP Server. This object needs to be instructed to listen to different events on a specific port and address.
- **http.IncomingMessage**: This object is a readable stream created either by **http.Server** or **http.ClientRequest**. Use it to access status, headers, and data.
- **http.ServerResponse**: This object is a stream created internally by the HTTP Server. This class defines what the response should look like, for example, the type of headers and the response content.

## Example web application

This is an example of what a web application looks like:

```javascript

const http = require('http');
const PORT = 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('hello world');
});

server.listen(PORT, () => {
  console.log(`listening on port ${PORT}`)
})
```

The example shows:

1. **Creating the server**:  The call to **createServer()** creates an instance of **http.Server**.
1. **Implementing the callback**: The method **createServer()** expects a function. This function is known as a *callback*. When invoked, it's  supplied with instances of **http.IncomingMessage** and **http.ServerResponse**. Here they are called **req** and **res**:
   1. **Client request**: The **req** instance investigates which headers and data were sent in the client's request.
   1. **Server response**: The server constructs a response by telling the **res** object the data and response headers it should answer back with.
1. **Start listening to requests**: Invoke the method **listen()** while specifying a port. After calling **listen()**, the server you created is ready to accept client requests.

## Streams

*Streams* is not a Node.js concept, but rather an operating system concept. Streams define the way data is transported back and forth. Data is sent, chunk by chunk, from client to server and from server to client. Streams make the server capable of handling many concurrent requests.

 A stream is a fundamental data structure in Node.js that can read and write data, and send and receive messages, or *events*. The way streaming is implemented in the HTTP module is by having classes that are streams.

The **req** and **res** parameters from the example are streams. Use the method **on()** to listen to incoming data from a client request like this:

```javascript
req.on('data', (chunk) => {
  console.log('You received a chunk of data', chunk)
})
```

Use the method **end()** for data sent back to the client in the response stream **res**:

```javascript
res.end('some data')
```

## Express framework

So far you've learned about the capabilities of the HTTP module in Node.js. It's a perfectly valid choice for smaller web applications. If an application becomes large, a framework such as Express can help you build your architecture in a scalable way.  

After you've built a few web applications, you'll notice that you solve the same problems over and over again. Problems like route management, authentication and authorization, and error management are common. At this point, you start looking for a library or framework that addresses some or all of these problems.

Why should you go with Express as the framework for your next app?

- **Good features**: Express has a set of features that makes you fast and productive.
- **Abstracts away complexity**: Express abstracts away complicated concepts like streams, for example, and makes the whole development experience a lot easier.
- **Solves common Web problems**: Express helps you with common problems such as route management, caching, and redirection.
- **Trusted by millions of developers**: According to GitHub, 6.8 million developers currently use Express for their web applications.

### Route management in Express

When a client makes a request toward a web application, they use a URL, which is an address that points to a specific server. A URL might look like this:

```bash
http://localhost:3000/products
```

The term **localhost** in the URL refers to your own machine. A more production-looking URL might have switched out the term **localhost** for a domain name like **microsoft.com**. The end part of the URL is the *route*. It decides a specific place to go on the server. In this case, the route is **/products**.

The Express framework uses the URL, route, and *HTTP verbs* for route management. HTTP verbs like **post**, **put**, and **get** describe what the client wants done. Each HTTP verb has a specific meaning for what should happen to the data. Express helps register routes and pair them to appropriate HTTP verbs to organize the web application.

Express has dedicated methods for handling different HTTP verbs, and has a smart system to associate different routes with different pieces of your code. In the following example, Express helps you handle requests aimed toward a route with the address **/products** that is associated with the HTTP verb **get**:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})
```

Express sees **get** toward **/products** as different from **post** toward **/products**, as shown in this next code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})

app.post('/products', (req, res) => {
  // handle the request
})
```

The HTTP verb **get** means that a user wants to read data. The HTTP verb **post** means that they want to write data. Dividing up your app so that different route and verb pairings execute different pieces of code makes sense. This topic will be covered in more detail later on in the module.

## Serve different content types

Express supports many different content formats that can be returned back to a calling client. The **res** object comes with a set of helper functions to return different types of data. To return plain text, you would use the **send()** method like so:

```javascript
res.send('plain text')
```

For other types of data, like JSON, there are dedicated methods that ensure the correct content type and data conversions are made. To return JSON in Express, use the method **json()**, like this:

```javascript
res.json({ id: 1, name: "Catcher in the Rye" })
```

The previous Express code method is equivalent to this HTTP module code:

```javascript
res.writeHead(200, { 'Content-Type': 'application/json' });
res.end(JSON.stringify({ id: 1, name: "Catcher in the Rye" }))
```

The **Content-Type** header in HTTP is set and the response is also converted from a JavaScript object to a *stringify* version before being returned back to the calling client.

Comparing the two code examples, you can see that Express saves a few lines of typing by using helper methods for common file types, like JSON and HTML.

## Create an Express application

To start developing a Node.js application using the Express framework, you need to install it as a dependency. It's also recommended that you first initialize a Node.js project so that any downloaded dependencies end up in the **package.json** file. It's a general recommendation for any apps developed for the Node.js runtime. The benefits of doing so come when pushing the code to a repository like GitHub. Anyone fetching the code from GitHub can easily use the code you write by first installing its dependencies.  

### Steps

Follow these steps to create a web application using the Express framework:

1. **Instantiate the app**: Create a web application instance. At this point, the instance can't be run, but you have something you can extend.
1. **Define routes and route handlers**: Define what routes the application should listen to. A route is part of the URL. For example, in the URL **http://localhost:8000/products**, the route part is **/products**. Express uses different routes to execute different pieces of code.  Other examples of routes are **/**, also known as the default route, and **/orders**. Routes will be explored in more detail later in this module.
1. **Configure middleware**: Middleware is a piece of code that can run before or after a request. You can also use middleware to handle authentication/authorization, or to add a capability to your app.
1. **Start the app**: Define a port, and then instruct the app to listen to that port. Now the app is ready to receive requests.
