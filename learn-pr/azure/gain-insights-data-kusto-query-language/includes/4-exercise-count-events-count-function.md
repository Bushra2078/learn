A Kusto query can be used to explore datasets and gain insights. Recall that we have a meteorological dataset and want to compare events to gain insights from this data. Here, you'll find out how many of a certain type of events occurred in a particular area. 

## Use the `count` function

The sample database we're using has an entry for each storm event in the US in 2007, for a total of about 60 thousand records. 

To group these events into chunks of information, you'll use the `summarize` operator. `summarize` is used for all functions that aggregate groups of values of multiple rows to form a single summary value. You can summarize the whole table, for example by counting the number of results using the following query:

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVUjOL80r0dAEAIiJgN4fAAAA" target="_blank"> Click to run query</a>

:::image type="content" source="../media/4-count-basic.png" alt-text="Screenshot of count operator general query and results.":::

You can also summarize data into groups of similar types of events by specifying the way you want to group the aggregation. For example, to count events by state, you'll write a query to `summarize` `count` by `state`. In fact, the previous sentence is very similar to the actual query. You'll use the aggregate function called `count()`, which counts the number of rows by group. This function generates a new column that gives the count of events grouped by state, which we have renamed within the query to *EventCount*.

1. Copy and paste the query into your query editor.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVQALOeeX5pXYJoNIDU2FpEqF4JLEklSQuvyiEhAfoQoAiCAatkgAAAA=" target="_blank"> Click to run query</a>

    ```kusto
    StormEvents
    | summarize EventCount=count() by State
    | sort by EventCount
    ```
1. Run the query by either selecting the **Run** button above the query window or by pressing **Shift+Enter**.
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/4-count-1.png" alt-text="Screenshot of count operator usage and results.":::

## Use the `dcount` and `countif` functions

The above query returned the number of events per state. There are, however, more sophisticated ways to count events. 
* For example, you could count only certain types of events. The `countif()` function counts records for which a predicate is true. The query using `countif(DamageCrops > 0)` would count the number of records for which the damage to crops was greater than zero.
* You can also count distinct types of events by using the `dcount()` function.

We've constructed a query that uses the `summarize` operator with these count functions to answer the following questions:
* How many storm events happened in each state?
* How many events in each state caused damage?
* How many different type of events happened in each state?

Notice that all elements within the summarize operator are separated by commas, and are grouped by the same column, in this case *State*. Columns not named in the `summarize` operator are dropped. If you want to include other columns, name them after the column on which data is summarized.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy1NSw5AMBDdO8UsSSxcgA1OQGIpxaCLGmmHhDg87Xi792+YrKlP3NhFD7jDGGX1jTDSsXGcpBF8EL/TvFbKqAVbKi3tDnKJ6TkWXdQCsr83yUqot9eOCQwXNKwY/RdZ9jxk+hdcHcMviAAAAA==" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | summarize count(),
        EventsWithDamageToCrops = countif(DamageCrops > 0),
        dcount(EventType) by State
    | sort by count_
    ```
    
    You should get results that look like the following image:

    :::image type="content" source="../media/4-count.png" alt-text="Screenshot of Kusto query that counts events by state.":::

1. Notice the column names in the results. Which part of the query corresponds to each column? How many different types of storms occurred in Texas?

## Use the `distinct` operator

The above query returned a distinct count of 27 different types of storms in Texas during the time period covered by this data. It would be interesting to further drill down and see the names of all those types of storms. To see a list of each different type of event, use the `distinct` operator, which lists the distinct values of a particular column.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSMksLsnMSy5RAIuEVBakAgWL84tKFJIqEWIKicXJAGL0i684AAAA" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | distinct EventType
    | sort by EventType asc
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/4-distinct.png" alt-text="Screenshot of Kusto query using the distinct operator.":::

1. Take a look at the resulting list. Did any of the storm types surprise you?