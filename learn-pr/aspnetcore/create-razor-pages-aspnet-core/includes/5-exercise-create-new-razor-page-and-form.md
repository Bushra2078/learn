In this unit, you'll create a form in the *RazorPagesPizza* project using Razor Pages to separate the logic of the page from its presentation.

## Create a page

The *RazorPagesPizza* project directory is currently open in the Visual Studio Code. Run the following .NET Core CLI command in the command shell:

```dotnetcli
dotnet new page --name Pizza --namespace RazorPagesPizza.Pages --output Pages
```

The preceding command:

* Creates the following files in the `RazorPagesPizza.Pages` namespace:
  * *Pizza.cshtml*&mdash;The Razor page
  * *Pizza.cshtml.cs*&mdash;The accompanying `PageModel` class
* Stores both files in the project's *Pages* directory.

Note that there's nothing magical about using the CLI to create these files. You can also create the files manually; the CLI command is just a shortcut for doing so.

## Examine the Razor page's structure

1. Open the new *Pages/Pizza.cshtml* Razor page. Examine the file's markup:

	```cshtml
	@page
	@model RazorPagesPizza.Pages.PizzaModel
	@{
	}
	```

    The preceding Razor page contains reserved Razor keywords:

    * The `@page` directive is what makes the page a Razor page. It indicates the page can handle HTTP requests. The `@page` directive must be the first directive on a Razor page.
    * The `@model` directive specifies the model type made available to the Razor page. In this case, the type is the `PageModel`-derived class name, prefixed with its namespace. As you recall, that class is defined in *Pages/Pizza.cshtml.cs*.

## Render HTML and transition to C#

The following markup is an example of an `@` symbol followed by C# code. The code sets the `ViewData` collection's `Title` key value to `Create`. Razor syntax uses the `@` symbol to transition from HTML to C#. If the `@` symbol is followed by a Razor reserved keyword, it transitions into Razor-specific markup; otherwise, it transitions to C#. Razor evaluates the C# expressions and renders them in the HTML output.

```cshtml
@{
    ViewData["Title"] = "Pizza";
}
```

A Razor page supports Razor syntax, which is HTML and C# combined. The C# code defines the dynamic rendering logic for the page on the server. The default Razor language is HTML. Rendering HTML from Razor markup is no different than rendering HTML from an HTML file. HTML markup in *.cshtml* Razor page files is rendered by the server unchanged. In Razor Pages, HTML can be used as you're used to. At the same time, you can take advantage of powerful and time-saving Razor features as you learn to use them.

## Add Pizza and PizzaService classes

Before we start to implement our form to manage pizzas, we need to have a data store that we can perform operations on.

A *model* class is needed to represent a pizza in inventory. The model contains properties that represent the characteristics of a pizza. The model is used to pass data in the web app and to persist pizza options in the data store. In this unit, that data store will be a simple local in-memory caching service. In a real-world application, you would consider using a database, such as SQL Server, with Entity Framework Core.

## Create a pizza model

1. Run the following command to create a `Models` folder:

    ```bash
    mkdir Models
    ```

    Select the `Models` folder in Visual Studio Code and add a new File called `Pizza.cs`.

    The project root now contains a *Models* directory with an empty *Pizza.cs* file. The directory name *Models* is a convention.

1. Add the following code to *Models/Pizza.cs* to define a pizza. Save your changes.

    ```csharp
    namespace RazorPagesPizza.Models
    {
        public class Pizza
        {
            public int Id { get; set; }
    
            [Required]
            public string Name { get; set; }
            public PizzaSize Size { get; set; }
            public bool IsGlutenFree { get; set; }
    
            [Range(0.01, 9999.99)]
            public decimal Price { get; set; }
        }
    
        public enum PizzaSize { Small, Medium, Large }
    }
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

## Add data service

1. Run the following command to create a `Services` folder:

    ```bash
    mkdir Services
    ```

    Select the folder in Visual Studio Code and add a new File called `PizzaService.cs`. 

1. Add the following code to *Services/PizzaService.cs* to create an in-memory pizza data service. Save your changes.

    ```csharp
    using RazorPagesPizza.Models;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    
    namespace RazorPagesPizza.Services
    {
        public static class PizzaService
        {
            static List<Pizza> Pizzas { get; }
            static int nextId = 3;
            static PizzaService()
            {
                Pizzas = new List<Pizza>
                {
                    new Pizza { Id = 1, Name = "Classic Italian", Price=20.00M, Size=PizzaSize.Large, IsGlutenFree = false },
                    new Pizza { Id = 2, Name = "Veggie", Price=15.00M, Size=PizzaSize.Small, IsGlutenFree = true }
                };
            }
    
            public static List<Pizza> GetAll() => Pizzas;
    
            public static Pizza Get(int id) => Pizzas.FirstOrDefault(p => p.Id == id);
    
            public static void Add(Pizza pizza)
            {
                pizza.Id = nextId++;
                Pizzas.Add(pizza);
            }
    
            public static void Delete(int id)
            {
                var pizza = Get(id);
                if (pizza is null)
                    return;
    
                Pizzas.Remove(pizza);
            }
    
            public static void Update(Pizza pizza)
            {
                var index = Pizzas.FindIndex(p => p.Id == pizza.Id);
                if (index == -1)
                    return;
    
                Pizzas[index] = pizza;
    
            }
        }
    }
    ```

    This service provides a simple in-memory data caching service with two pizzas by default that our web app will use for demo purposes. When we stop and start the web app the in-memory data cache will be reset to the two default pizzas from the constructor of the `PizzaService`.

## Add form markup to the *Pizza* Razor page

Replace the contents of *Pages/Pizza.cshtml* with the following markup. Save your changes.

```cshtml
@page
@using RazorPagesPizza.Models
@model RazorPagesPizza.Pages.PizzaModel
@{
    ViewData["Title"] = "Pizza List";
}

<h1>Pizza List 🍕</h1>
<form method="post" class="card p-3">
    <div class="row">
        <div asp-validation-summary="All"></div>
    </div>
    <div class="form-group mb-0 align-middle">
        <label asp-for="NewPizza.Name">Name</label>
        <input type="text" asp-for="NewPizza.Name" class="mr-5">
        <label asp-for="NewPizza.Size">Size</label>
        <select asp-for="NewPizza.Size" asp-items="Html.GetEnumSelectList<PizzaSize>()" class="mr-5"></select>
        <label asp-for="NewPizza.Price"></label>
        <input asp-for="NewPizza.Price" class="mr-5" />
        <label asp-for="NewPizza.IsGlutenFree">Gluten Free</label>
        <input type="checkbox" asp-for="NewPizza.IsGlutenFree" class="mr-5">
        <button class="btn btn-primary">Add</button>
    </div>
</form>
<table class="table mt-5">
    <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Size</th>
            <th scope="col">Gluten Free</th>
            <th scope="col">Delete</th>
        </tr>
    </thead>
    @foreach (var pizza in Model.pizzas)
    {
        <tr>
            <td>@pizza.Name</td>
            <td>@($"{pizza.Price:C}")</td>
            <td>@pizza.Size</td>
            <td>@Model.GlutenFreeText(pizza)</td>
            <td>
                <form method="post" asp-page-handler="Delete" asp-route-id="@pizza.Id">
                    <button class="btn btn-danger">Delete</button>
                </form>
            </td>
        </tr>
    }
</table>

@section Scripts {
<partial name="_ValidationScriptsPartial" />
}
```

[!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

The *Pizza* Razor page uses HTML and Razor to support a product creation form. The form accepts **Name** and **Price** values for the product to be created. With relatively little markup, dynamic features have been provided through Razor Tag Helpers. Client-side form input validation is enabled via the inclusion of the *Pages/Shared/_ValidationScriptsPartial.cshtml* partial view. The partial view's contents are injected into the layout page's `Scripts` section.

## Review Razor Tag Helpers

Tag Helpers address the inefficiencies of context switching between HTML and C#. Most of ASP.NET Core's built-in Tag Helpers extend standard HTML elements. Tag Helpers provide additional server-side attributes for HTML elements, making the elements more robust.

There are four Tag Helpers on this page:

* Partial
* Label
* Input
* Validation Summary Message

### Partial Tag Helper

The following markup uses the Partial Tag Helper to asynchronously render a partial view:

```cshtml
<partial name="_ValidationScriptsPartial" />
```

The Partial Tag Helper's `name` attribute accepts the partial view name without the file extension. A view discovery process locates the partial view in the project.

This Tag Helper syntax is an alternative to the following HTML Helper syntax:

```cshtml
@{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
```

### Label Tag Helper

The following markup uses the Label Tag Helper:

```cshtml
<label asp-for="NewPizza.Name" class="control-label"></label>
```

The Label Tag Helper extends the standard HTML `<label>` element. As is common for many Tag Helpers, it uses an `asp-for` attribute. The attribute accepts a specified `PageModel` property. In this case, the value of the `PageModel` `Name` property will be rendered as the content for an HTML `<label>` element. The `asp-for` attribute is scoped to the `PageModel` for the Razor page, so the `@` symbol isn't used. The label is dynamic as is needed here, but remains compact and easy to add in your markup.

### Input Tag Helper

The following markup uses the Input Tag Helper. It extends the standard HTML `<input>` element. It also uses an `asp-for` attribute to specify a `PageModel` property.

```cshtml
<input asp-for="NewPizza.Name" class="form-control" />
```

The Input Tag Helper:

* Evaluates the `NewPizza.Name` property, like the Label Tag Helper.
* Adds an `id` and `name` HTML attribute based on that property.
* Sets the input type appropriately. For example, if the specified property type is `bool`, an input type of `checkbox` is used in the generated HTML. In this case, the `NewPizza.Name` property type is `string`. The `NewPizza.Name` property is set by the model's data annotation attributes, which will be reviewed later in this module.
* Provides client-side validation using jQuery, based on the model's data annotation attributes provided through the `PageModel`.
* Prompts the Razor engine to provide additional, more robust server-side validation, if client-side validation was successful. The *Pizza* Razor page's HTTP POST event lifecycle, which includes client-side and server-side input validation, is walked through later in this module.

The following HTML output is generated from the Input Tag Helper located in the *Pizza* page:

```html
<input name="NewPizza.Name" class="form-control" id="NewPizza_Name" type="text" value="" data-val-required="The Name field is required." data-val="true">
```

### Validation Summary Tag Helper

The following markup uses the Validation Summary Tag Helper. It displays a validation message for a single property on the model.

```cshtml
<div asp-validation-summary="All"></div>
```

The Input Tag Helper adds HTML5 `data-` attributes to input elements. The attributes are based on properties in the C# model classes. While responsive client-side validation occurs, validation is also done on the server, which is more secure.

The following HTML is rendered by the Validation Summary Tag Helper:

```html
<input name="NewPizza.Price" class="form-control" id="NewPizza_Price" type="text" value="" data-val-required="The Price field is required." data-val="true" data-val-range-min="0.01" data-val-range-max="9999.99" data-val-range="The field Price must be between 0.01 and 9999.99." data-val-number="The field Price must be a number.">
```

The `type`, `data-val-range-min`, `data-val-range-max`, and error response are dynamically set by the model's data annotations for the model's `Product.Price` property.

The product creation Razor page has been created. In order to process form interactions, we'll need to modify the `PageModel` class to handle the form's HTTP POST request. We'll explore `PageModel` interactions next.
