Before we start to implement our web API for pizza, we need to have a data store that we can perform operations on. 

A *model* class is needed to represent a pizza in inventory. The model contains properties that represent the characteristics of a pizza. The model is used to pass data in the web API and to persist pizza options in the data store. In this unit, that data store will be a simple local in-memory caching service. In a real-world application, you would consider using a database, such as SQL Server, with [Entity Framework Core](/ef/core). Entity Framework Core allows you to work with your database using .NET objects.

## Create a pizza model

1. Run the following command to create a `Models` folder:

    ```bash
    mkdir Models
    ```

    Select the `Models` folder in Visual Studio Code and add a new File called `Pizza.cs`. 

    ![Image of Visual Studio Code adding a new file to the Models folder](../media/add-pizza-file.png)

    The project root now contains a *:::no-loc text="Models":::* directory with an empty *:::no-loc text="Pizza.cs":::* file. The directory name *:::no-loc text="Models":::* is a convention. The directory name comes from the **Model**-View-Controller architecture used by the web API.

1. Add the following code to *:::no-loc text="Models/Pizza.cs":::* to define a pizza. Save your changes.

    ```csharp
    namespace ContosoPizza.Models
    {
        public class Pizza
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public bool IsGlutenFree { get; set; }
        }
    }
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

## Add data service

1. Run the following command to create a `Services` folder:

    ```bash
    mkdir Services
    ```

    Select the folder in Visual Studio Code and add a new File called `PizzaService.cs`. 

    ![Image of Visual Studio Code adding a new file to the Services folder](../media/add-pizza-service-file.png)


1. Add the following code to *:::no-loc text="Services/PizzaService.cs":::* to create an in-memory pizza data service. Save your changes.

    ```csharp
    using ContosoPizza.Models;
    using System.Collections.Generic;
    using System.Linq;

    namespace ContosoPizza.Services
    {
        public static class PizzaService
        {
            static List<Pizza> Pizzas { get; }
            static int nextId = 3;
            static PizzaService()
            {
                Pizzas = new List<Pizza>
                {
                    new Pizza { Id = 1, Name = "Classic Italian", IsGlutenFree = false },
                    new Pizza { Id = 2, Name = "Veggie", IsGlutenFree = true }
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
                if(pizza is null)
                    return;
                
                Pizzas.Remove(pizza);
            }

            public static void Update(Pizza pizza)
            {
                var index = Pizzas.FindIndex(p => p.Id == pizza.Id);
                if(index == -1)
                    return;
                
                Pizzas[index] = pizza;
            }
        }
    }
    ```
    
    This service provides a simple in-memory data caching service with two pizzas by default that our web API will use for demo purposes. When we stop and start the web API the in-memory data cache will be reset to the two default pizzas from the constructor of the `PizzaService`.

## Build the web API project

[!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

The `Pizza` Model and `PizzaService` class will be used by the controller created in the next unit.
