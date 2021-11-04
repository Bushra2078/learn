Engaging websites need to display dynamic content that may change all the time. Obtaining data from a dynamic source such as a database or web service is a fundamental technique in web development.

Suppose you're working for a pizza delivery firm on their updated customer-facing website. You have a range of web pages laid out and designed as Blazor components. Now, you want to populate those pages with information about pizzas, toppings, and orders that you want to obtain from a database.

In this unit, you'll learn how to access data and render it within HTML markup for display to the user.

## Create a registered data service

If you want to create a dynamic website that shows changing information to users, you must write code to get that data from somewhere. For example, suppose you have a database that stores all the pizzas your company sells. Because the pizzas are always changing, it's a bad idea to hardcode them into the website HTML. Instead, use C# code and Blazor to query the database and then format the details as HTML so that the user can pick their favorite.

In a Blazor Server app, you can create a registered service to represent a data source and obtain data from it.

> [!NOTE]
> The sources of data you can use in a Blazor app includes relational databases, NoSQL databases, web services, various Azure services, and many other systems. You can use .NET technologies such as Entity Framework, HTTP clients, ODBC, and so on to query those sources. These techniques are beyond the scope of this course. Here, you'll learn how to format and use data that you've obtain from one of these sources and technologies.

Start creating your registered service, by writing a class that defines its properties. Here's an example that you might write to represent a pizza:

```csharp
using System;

namespace BlazingPizza.Data
{
 public class Pizza
 {
  public int PizzaId { get; set; }
 
  public string Name { get; set; }
  
  public string Description { get; set; }
  
  public decimal Price { get; set; }
  
  public bool Vegetarian { get; set; }
  
  public bool Vegan { get; set; }
 }
}
```

The class defines the pizza's properties and datatypes. You must make sure these properties match the pizza schema in the data source. It makes sense to create this class in the **Data** folder of your project and use a member namespace called **Data** but you can choose other folders and namespaces if you prefer.

Next, define the service:

```csharp
using System;
using System.Threading.Tasks;

namespace BlazingPizza.Data
{
 public class PizzaService
 {
  public Task<Pizza[]> GetPizzasAsync()
  {
   // Call your data access technology here
  }
 }
}
```

Notice that the service uses an asynchronous call to access data and return a collection of Pizza objects. Because the data source may be remote from the server where the Blazor code is running, it's good practice to use an asynchronous call to ensure that, if the data source responds slowly, other code can continue to run as you await the response.

You must also register the service by adding a line to the `Add Services to the container` section in the **Program.cs** file:

```csharp
...
// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
// Register the pizzas service
builder.services.AddSingleton<PizzaService>();
...
```

## Use a service to obtain data

The next thing to do is to use the service you've defined by calling it in a Blazor component and obtaining data. Let's suppose you have the following component code and you want to display pizzas in it:

```razor
@page "/pizzas"

<h1>Choose your pizza</a>

<p>We have all these delicious recipes:</p>
```

### Inject the service

Before you can call the service from the component, you must use dependency injection to add the service. To do that, add the following code just after the `@page` directive:

```razor
@using Blazor.Data
@inject PizzaService PizzaSvc
```

Usually, the component and the service will be in different namespace members, so you must include the `@using` directive. This directive works in the same way as a `using` statement at the top of a C# code file. The `@inject` directive adds the service to the current component and initiates an instance of it. In the directive, specify the name of the service class, followed by the name you want to use for the instance of the service in this component.

### Override the OnInitializedAsync method

A good place to call the service and obtain data is in the `OnInitializedAsync` method. This event fires when the component's initialization is complete and it has received initial parameters but before the page is rendered and displayed to the user. The event is defined on the Blazor component's base class, and you can override it in a code block like this:

```csharp
protected override async Task OnInitializedAsync()
{
 \\ Call the service here
}
```

### Call the service to obtain data

When you call the service, remember to use the `await` keyword, because the call is asynchronous:

```csharp
private Pizza[] todaysPizzas;

protected override async Task OnInitializedAsync()
{
 todaysPizzas = await PizzaSvc.GetPizzasAsync();
}
```

## Display data to the user

Now that you have some data from the service, you should display it to the user. In our pizzas example, we expect the service to return a list of pizzas that the users can choose from. Blazor includes a rich set of directives that you can use to insert this data into the page that the user sees.

### Check for data

First, let's determine what the page displays before the pizzas are loaded. We can do this by checking whether the `todaysPizzas` collection is `null`. To run conditional rendering code in a Blazor component, use the `@if` directive:

```razor
@if (todaysPizzas == null)
{
 <p>We're finding out what pizzas are available today...</p>
}
else
{
 <!-- This markup will be rendered once the pizzas are loaded -->
}
```

The `@if` directive renders the markup in its first code block only if the C# expression returns `true`. You can also use an `else if` code block to run other tests and render markup if they are true. Finally, you can specify an `else` code block to render code if none of the previous conditions returned true. By checking for `null` in the `@if` code block, you ensure that Blazor won't try to display pizza details before data has been obtained from the service.

> [!NOTE]
> Blazor also includes the `@switch` directive for rendering markup based on a test that may return multiple values. This works in a similar way to the C# `switch` statement.

### Render a collection of objects

If Blazor executes the `else` statement in the above code, then you know that some pizzas have been obtained from the service. Your next task is to display these to the user. Let's construct a simple HTML table to display them.

We don't know how many pizzas will be available when we code this page, but we can use the `@foreach` directive to loop through all the objects in the `todaysPizzas` collection and render a row for each one:

```razor
<table>
 <thead>
  <tr>
   <th>Pizza Name</th>
   <th>Description</th>
   <th>Vegetarian?</th>
   <th>Vegan?</th>
   <th>Price</th>
  </tr>
 </thead>
 <tbody>
  @foreach (var pizza in todaysPizzas)
  {
   <tr>
    <td>@pizza.Name</td>
    <td>@pizza.Description</td>
    <td>@pizza.Vegetarian</td>
    <td>@pizza.Vegan</td>
    <td>@pizza.Price</td>
   </tr>
  }
 </tbody>
</table>
```

:::image type="content" source="../media/4-simple-pizza-list.png" alt-text="Screenshot showing how the list of pizzas appears on a Blazor component":::

Of course, you probably want a richer display of pizzas than the plain table displayed in this example and you might want to format the price and other values. Work with your graphic designers to develop a more engaging user interface, for example with pictures of each pizza.

> [!NOTE]
> Blazor includes other looping directives, including `@for`, `@while`, and `@do while`. These directives return repeated blocks of markup and work in a similar way to the equivalent C# `for`, `while`, and `do...while` loops.
