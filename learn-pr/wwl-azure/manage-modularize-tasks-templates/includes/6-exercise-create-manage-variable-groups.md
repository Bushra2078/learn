In this exercise, you'll investigate Variable Groups.

> [!NOTE]
> *Before starting this walkthrough, ensure you've done the steps in the prerequisites section and the previous activities.*

## Steps

Let's now look at how a release pipeline can use predefined variables, called Variable Groups.

Like how we used task groups, variable groups provide a convenient way to avoid redefining many variables when defining stages within pipelines and even when working across multiple pipelines.

Let's create a variable group and see how it can be used.

1. On the main menu for the **Parts Unlimited** project, click **Pipelines**, then click **Library**. There are currently no variable groups in the project.

    :::image type="content" source="../media/08-01-no-existing-variable-groups-7804ff9d.png" alt-text="No existing variable groups.":::


1. Click **+ Variable group** to start creating a variable group. Set **Variable group name** to **Website Test Product Details**.

    :::image type="content" source="../media/08-02-new-variable-group-91c7cc04.png" alt-text="New variable group.":::


1. In the **Variables** section, click **+Add**, enter **Name**, enter **ProductCode**, and in **Value**, enter **REDPOLOXL**.

    :::image type="content" source="../media/08-03-added-product-code-592a385d.png" alt-text="Added ProductCode.":::


    You can see an extra column that shows a lock. It allows you to have variable values that are locked and not displayed in the configuration screens.

    While it's often used for values like passwords, notice an option to link secrets from an Azure key vault as variables.

    It would be a preferable option for variables that provide credentials that need to be secured outside the project.

    In this example, we're just providing details of a product used in testing the website.

1. Add another variable called **Quantity** with a value of **12**.
1. Add another variable called **SalesUnit** with a value of **Each**.

    :::image type="content" source="../media/08-04-three-variables-configured-354c5de1.png" alt-text="Three variables are configured.":::


1. Click **Save** to save the new variable group.

    :::image type="content" source="../media/08-05-save-location-9243d3f0.png" alt-text="Save location.":::


1. On the main menu, click **Pipelines**, click Releases and click **Edit** to return to editing the release pipeline we have been working on. From the top menu, click **Variables**.

    :::image type="content" source="../media/08-06-variables-location-a8472dad.png" alt-text="Variables location.":::


1. In the left-hand pane, click **Variable Groups**.

    :::image type="content" source="../media/08-07-variable-groups-selection-013dd0fd.png" alt-text="Variable groups selection.":::


    Variable groups are linked to pipelines rather than being directly added to them.

1. Click **Link variable group**, then in the **Link variable group** pane, click the **Website Test Product Details** variable group (notice that it shows you how many variables are contained). In the **Variable group scope**, select the **Development**, **Test Team A**, and **Test Team B** stages.

    :::image type="content" source="../media/08-08-link-variable-group-0e492b12.png" alt-text="Link variable group.":::


    We need the test product for development and testing, but we don't need it in production. If required in all stages, we would have chosen **Release** for the Variable group scope instead.

1. Click the **Link** to complete the link.

    :::image type="content" source="../media/08-09-linked-variable-group-8df463e4.png" alt-text="Linked variable group.":::


The variables contained in the variable group are now available for use within all stages except production, just the same way as any other variable.
