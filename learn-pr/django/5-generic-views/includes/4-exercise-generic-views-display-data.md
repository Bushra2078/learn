We want to create a new detail page for dogs. We're going to use the generic view `DetailView` to streamline the amount of code we need to create.

> [!IMPORTANT]
> This exercise assumes that you've completed the setup steps earlier in this module.

## Create DogDetail view

We start by creating the detail view class.

1. Inside Visual Studio Code, open **dog_shelters/views.py**.
1. Underneath the line that reads `# TODO: Import generic views`, add the following code to import the generic views module.

    ```python
    # TODO: Import generic views
    from django.views import generic
    ```

1. Add the following code to the bottom of **views.py** to create the generic view for `DogDetail` and set the model, template, and context object.

    ```python
    class DogDetailView(generic.DetailView):
        model = models.Dog
        template_name = 'dog_detail.html'
        context_object_name = 'dog'
    ```

## Register the detail view

With the view created, we can register the path.

1. Open **dog_shelters/urls.py**.
1. Underneath the line that reads `# TODO: Register detail view`, add the following code to register the path for our `DogDetailView`.

    ```python
    # TODO: Register detail view
    path('dog/<int:pk>', views.DogDetail.as_view(), name='dog_detail'),
    ```

    > [!IMPORTANT]
    > Remember the trailing comma at the end of the line.

## Update the shelter detail page to include our link

With our path registered, we can update the shelter detail template to include links to our dog detail page.

1. Open **dog_shelters/templates/shelter_detail.html**.
1. Underneath the line that reads `{# TODO: Add link to dogs #}`, add the following code to create a link for each dog to the detail view.

    ```html
    {# TODO: Add link to dogs #}
    <a href="{% url 'dog_detail' dog.id %}">
        {{dog.name}}
    </a>

## Test your page

With everything created, let's see our page in action.

1. Save all the files by selecting **File** > **Save All**.
1. In your browser, go to `http://localhost:8000`.
1. From the list of shelters, select **Contoso**.
1. From the list of dogs, select **Roscoe**.

   The details page appears.

   :::image type="content" source="../media/dog-detail.png" alt-text="Screenshot of the details page for Roscoe.":::

We've now created a view by using the generic view system in Django!
