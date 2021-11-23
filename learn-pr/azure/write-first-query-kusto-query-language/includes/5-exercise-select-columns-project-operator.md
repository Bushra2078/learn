Kusto queries can be used to filter data and return specific information.
Recall that we've looked at arbitrary rows of data to get a sense of its structure. In this unit, you will learn how to choose specific data columns relating to storm types, locations, and their damaging effects.

## Use the `project` operator

If you remember, the meteorological data example has quite a few columns. Not all of these columns are meaningful for our exploration. We'll choose just a few columns to view. We'll use the `project` operator to define which columns we want to see in the output. Multiple column names are separated by commas.

1. Run the following query. In this query, we name the columns to return, and their order, within the project operator.
    
    ```kusto
    StormEvents
    | project EventType, State, DamageProperty, DamageCrops, InjuriesDirect, InjuriesIndirect
    | take 10
    ```

1. You should get results that look like the following image: 

    :::image type="content" source="../media/4-project-operator.png" alt-text="Screenshot of project operator results.":::

1. Notice that only the columns mentioned in the `project` operator appear in the output.

## Rename and define new columns with `project`

To understand the impacts of storms in different U.S. states, we want to get the total number of injuries and amount of damage. With `project`, we can sum integer values from different columns and return the results in a new column. We can also rename columns to make them more meaningful to our analysis. For example, there are other countries with states. So it might be helpful to rename the state column to so it's clear the results are for U.S. states. Let's see how to change your previous query so you get the total number of injuries and amount of damage for U.S. states.

1. First, let's update your previous query to make a new column that shows the sum of *InjuriesDirect* and *InjuriesIndirect*:

   `Injuries=InjuriesDirect+InjuriesIndirect`

1. Let's do the same for the two types of damage columns by adding together damages to crops and damages to property.

   `Damage=DamageCrops+DamageProperty`

1. Hover over the column name in the query editor to see the data type contained in the columns. We can use a numerical operator to add the values because these columns are of type int (integer).

    :::image type="content" source="../media/4-data-type.png" alt-text="Screenshot of datatype in query editor.":::

1. Let's also rename the *State* column to *US_State*.

   `US_State=State`

1. Review your updated query. Altogether, the full query includes calculations for injuries, calculations for damages, and renaming the *State* column.

    ```kusto
    StormEvents
    | project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
    | take 10
    ```

1. Run the following query:
    
    ```kusto
    StormEvents
    | project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
    | take 10
    ```

1.  You should get results that look like the following image:

    :::image type="content" source="../media/4-project-rename.png" alt-text="Screenshot of project operator used to rename columns.":::

1. Notice that the *State* column has been renamed to *US_State*. The *Injuries* column is new, and has been calculated as the sum of *InjuriesDirect* and *InjuriesIndirect*. The *Damage* column is also new, and has been calculated as the sum of *DamageCrops* and *DamageProperty*.

## Use the `project-away` operator

What if you wanted to just remove a few select columns? For our exploration, we don't have any use for the IDs assigned to each episode and event. You can remove specific columns using the `project-away` operator, which indicates which columns to *remove*, while leaving all remaining columns. You can also use a wildcard, such as: `| project-away *ID` to remove all columns ending in `ID`.

1. Run the following query:

    ```kusto
    StormEvents
    | project-away EpisodeId, EventId
    | take 10
    ```

1. Check your results. Recall that the *EpisodeID* and *EventID* columns were between the *EndTime* and *State* columns. Which of these columns do you see in the output?
