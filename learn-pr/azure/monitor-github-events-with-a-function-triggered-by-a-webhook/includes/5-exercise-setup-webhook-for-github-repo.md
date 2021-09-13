In this exercise, you'll set up a webhook for a GitHub repository. You'll learn how to listen for specific events (in this case, the *Gollum* event), and how to make your webhook callback to your function when the event is triggered.

## Setup

1. Using your web browser, sign in to your [GitHub account](https://www.github.com).

1. Create a new repository by selecting **New** in the left menu pane. The **Create a new repository** page appears.

1. In the **Repository name** box, enter a meaningful name such as **LearnWebhookTest**.

1. Select **Public** to activate your wiki module, and find it in the menu.

1. Select **Create repository**. The **Quick setup** page appears.

1. Select the **creating a new file** link.

1. In the top menu bar, select **Wiki** to display the pages in your repository (or *repo*). A  **Welcome** page appears.

1. Select **Create the first page**. The **Create new page** template appears.

1. Add some text, and select **Save Page**. The first page in a Wiki is the Home page.

## Add a webhook for the Gollum event

**Gollum** is the name of a GitHub event that is fired whenever a page in a repository's wiki is created or updated.

1. On the home page in the Wiki view is a **Pages** sidebar that lists the pages in your repo. Select **Home** to display the home page.

1. On the home page, select the **Settings** tab.

1. In the **Settings** side bar, select **Webhooks**.

1. Select **Add webhook** on the top-right. GitHub may ask you to confirm your password for GitHub.


    | Setting          | Value                                                                                                       |
    | ---------------- | ----------------------------------------------------------------------------------------------------------- |
    | Payload URL  | URL for your Azure function app from the previous exercise. For help see note below. |
    | Content type |Select application/json from dropdown list. |
    | Which events would you like to trigger this webhook?| Let me select individual events. In the event list that appears, scroll down and select the **Wiki** checkbox. Make sure no other checkboxes are selected. |
    | Active  | Checked.|

    > [!TIP]
    > Copy the function URL from the Azure HttpTrigger pane by selecting **Get function Url** from the command bar. Your URL looks similar to: `https://<your-functionapp-name>.azurewebsites.net/api/HttpTrigger1?code=aUjXIpqdJ0ZHPQuB0SzFegxGJu0nAXmsQBnmkCpJ6RYxleRaoxJ8cQ==` 
    
1. Select **Add webhook**. The **Webhooks** page appears.

1. Verify that your new webhook appears. It should have *(gollum)* at the end of its name.

## Test the webhook

1. In GitHub, select the **Wiki** tab. The Home page that you created earlier should appear.

1. Select **Edit**.

1. In the text area of the page, enter the following text:

    ```text
    Testing Webhook
    ```

1. Select **Save Page**.

1. Select the **Settings** tab.

1. In the sidebar, select **Webhooks**.

    > [!NOTE]
    > The webhook will indicate that the message was not processed correctly; it will generate an HTTP 400 error. The webhook is providing a payload that your function app wasn't expecting, and doesn't include a **name** parameter. You will learn how to parse the payload for a *Gollum* event in the next unit.

1. Select **Edit**. The **Webhooks/Manage webhook** page appears.

1. Select the **Recent Deliveries** tab.

1. In the list, select the top (latest) delivery entry by selecting the ellipsis (**...**).

    You'll see the *Headers* information, including the *Event*:

    ```json
    Request URL: https://testwh123456.azurewebsites.net/api/HttpTrigger1?code=aUjXIpqdJ0ZHPQuB0SzFegxGJu0nAXmsQBnmkCpJ6RYxleRaoxJ8cQ%3D%3D
    Request method: POST
    Accept: */*
    content-type: application/json
    User-Agent: GitHub-Hookshot/16496cb
    X-GitHub-Delivery: 9ed46280-6ab3-11e9-8a19-f1a14922a239
    X-GitHub-Event: gollum
    X-GitHub-Hook-ID: 312141005
    X-GitHub-Hook-Installation-Target-ID: 394459163
    X-GitHub-Hook-Installation-Target-Type: repository
    ```

   You'll also see that the **Payload** section contains information indicating that your wiki page was edited. The payload contains **pages**, **repository**, and **sender** sections, which should look something like the example shown below:

    ```json
        "pages": [
            {
                "page_name": "Home",
                "title": "Home",
                "summary": null,
                "action": "edited",
                "sha": "04d012c5f92a95ae3f7721173bf9f2b1b35ea22f",
                "html_url": "https://github.com/.../wiki/Home"
            }
        ],
        "repository" : {
            "id": 176302421,
            "node_id": "MDEwOlJlcG9zaXRvcnkxNzYzMDI0MjE=",
            "name": "tieredstorage",
            ...
        },
        "sender" : {
            ...
        }
    ```

1. Under the **Recent Deliveries** tab, select the **Response** tab.

    You'll see the response message generated by the Azure function. For this example, the body should contain the message. *This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response*.
