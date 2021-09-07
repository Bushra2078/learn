In this unit, you'll add a HTTP POST page handler for the *Pizza* Razor page form. Finally, you'll walk through the `Pizza` model and its data annotations that drive both client-side and server-side validation.

## Examine the structure of a Razor Pages `PageModel` class

Open the *Pages/Pizza.cshtml.cs* `PageModel` class file. You may remember, that when you created a new Razor page called *Pizza*, its `PageModel` class file named *Pizza.cshtml.cs* was generated. Examine the contents. It contains the following C# code:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace RazorPagesPizza.Pages
{
    public class PizzaModel : PageModel
    {
        public void OnGet()
        {
        }
    }
}
```

## Update the HTTP Get page handler to display the list of Pizzas

Currently, the `PizzaModel` class handles the HTTP GET request with an empty `OnGet` page handler. Let's update this to display a list of pizzas from the `PizzaService`.

### Update the `OnGet` page handler

Update the `OnGet` method as follows:

```csharp
public void OnGet()
{
    pizzas = PizzaService.GetAll();
}
```

Add a `List<Pizza>` variable named `pizzas` to the `PizzaModel` class:

```csharp
public List<Pizza> pizzas;
```

When the `OnGet` method is called, it will assign the results of the `PizzaService.GetAll()` method to the `pizzas` variable. This variable will be accessible to the Razor page template, where it will be written to the table listing the available pizzas.

### Use a utility method to format the Gluten Free information in the list

Our `IsGlutenFree` property is a boolean value. We can use a utility method to format the boolean value as a string. Add the following utility method to the `PizzaModel` class:

```csharp
public string GlutenFreeText(Pizza pizza)
{
    if (pizza.IsGlutenFree)
        return "Gluten Free";
    return "Not Gluten Free";
}
```

## Add an HTTP POST page handler to the `PageModel`

Add the following method to the *Pages/Pizza.cshtml.cs* `PageModel` class. Save your changes.

```csharp
public IActionResult OnPost()
{
    if (!ModelState.IsValid)
    {
        return Page();
    }
    PizzaService.Add(NewPizza);
    return RedirectToAction("Get");
}
```

The `PizzaModel` class now has an asynchronous `OnPost` page handler. `OnPost` executes when the user posts the *Pizza* page's form. You can also use the optional *Async* naming suffix, `OnPostAsync`.

The `OnPost` page handler needs to perform the following tasks for this app:

* Verify the user-submitted data posted to the `PageModel` is valid.
* If the attempted `PageModel` changes are invalid, the *Pizza* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the `PageModel` update is valid, then data changes are passed to a service called `PizzaService`. `PizzaService` will handle the concern of HTTP requests and responses to the web API.

## Bind the model

The `PizzaModel` class needs access to the `Pizza` model. It will validate and pass `Pizza` entries from the *Pizza* form using the `[BindProperty]` attribute. Add the following code to your `PizzaModel` class:

```csharp
[BindProperty]
public Pizza NewPizza { get; set; }
```

## Add an HTTP POST handler for the Delete buttons

A Razor page can include multiple forms. Since the Delete buttons in our list of pizzas modifies data, an HTTP POST rather that an HTTP GET is required.

Add the following `OnPostDelete` method to the `PizzaModel` class:

```csharp
public IActionResult OnPostDelete(int id)
{
    PizzaService.Delete(id);
    return RedirectToAction("Get");
}
```

## Link to the *Pizza* page

The *Pizza* page has been created and implemented. Let's allow users to navigate to it.

### Add an Anchor Tag Helper to the *Index* page

1. In *Pages/Shared/_Layout_.cshtml*, add the following code to the `<nav>` section between the `Home` and `Privacy` links:

```razor
<li class="nav-item">
    <a class="nav-link text-dark" asp-area="" asp-page="/Pizza">Pizza List</a>
</li>
```

The result will appear as follows:

   [!code-cshtml[](../code/layout.cs?highlight=25)]

2. Save your changes.

The preceding highlighted code uses an Anchor Tag Helper. The Tag Helper:

* Directs the user to the *Pages/Pizzas/Create.cshtml* Razor page, located in the same directory as the *Index* page.
* Enhances the standard HTML anchor (`<a>`) tag by adding custom HTML attributes, such as `asp-page-handler`.

The `asp-page-handler` attribute is used to route to a specific page handler for the Razor page defined in the `asp-page` attribute. The `asp-page` attribute is used set an anchor tag's `href` attribute value to a specific Razor page.
