Recall that we've filtered certain columns in or out of the displayed results. In this unit, you will learn how to answer questions about what kind of meteorological events took place in different regions or timespans, and which types of events caused damage.

## Use the `where` operator

Up to this point, all the operators we've used have returned selected columns. Now, let's take a look at specific rows of the data.

The `where` operator filters results that satisfy a certain condition. In this first example, we'll compare an integer column to a minimum value using the numerical operator *greater than* (>). Specifically, we only want to see storms that damaged property, so we'll look at rows of data where the damage property is greater than zero.

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | take 10
    ```

1. You should get results that look like the following image: 
    
    :::image type="content" source="../media/5-where-1.png" alt-text="Screenshot of where operator.":::
    
1. Notice that all rows returned do, in fact, have *DamageProperty* values greater than zero.
    
1. Similarly, you could filter where the time of an event occurred more than a certain number of days ago, for example in the following query. Note that 365d is a shortened version of writing 365 days.

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | where StartTime > ago(365d)
    | project State, EventType, DamageProperty
    ```

1. Notice that this query returns no results. Since the data is from 2007, there are no records from the past year.

## Filter using string operators

It looks like there are quite a few types of damage-causing storms, occurring all over the US. Let's narrow that down to storms that happened in a certain location, like the state of Florida. 

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageCrops > 0
    | where State == "FLORIDA"
    | project State, EventType, DamageCrops
    ```
    
1. You should get results that look like the following image: 

    :::image type="content" source="../media/5-where-2.png" alt-text="Screenshot of where operator example 2.":::

1. Notice that all records returned from this query are from Florida, and have crop damage greater than zero.

### Filter using the `has` operator

Looking at the results of the last query, we see that one of the Event Types is called "Thunderstorm Wind". Let's see if there are any other kinds of wind that caused property damage in Florida. We'll search on a string match of "wind" using the `has` operator. The `has` operator is a case-insensitive search that matches on a full [term](/azure/data-explorer/kusto/query/datatypes-string-operators#what-is-a-term).

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | where State == "FLORIDA"
    | where EventType has "wind"
    | project StartTime, EventType, DamageProperty
    ```
    
1. You should get results that look like the following image: 

    :::image type="content" source="../media/5-where-has.png" alt-text="Screenshot of where and has operators.":::

1. Notice in the results that we no longer see events such as tornados, but we do see Thunderstorm Wind and Strong Wind event types.

The `contains` operator is similar to `has`, but it matches on any substring. For example, the following query will return results such as *Freezing fog* and *Frost/Freeze*.

```kusto
StormEvents | where EventType contains "free" 
```

The `has` operator is more performant than the `contains` operator, so use `has` wherever you have a choice between the two.

## Filter on datetime values

Let's look closer at the damage done in the first half of the calendar year. In fact, we often want to limit our search to see events within a specific time range. Some interfaces with Kusto Query Language have a dropdown time picker, but others require you to incorporate the date filter into the query itself.

Since time ranges are bounded by two extremes, it's most efficient to construct a query where we choose a value that is between these two times.

The syntax for constructing this date range is as follows:

> `where` *time* `between` `( datetime(`*value*`)..datetime(`*value*`)`

1. Let's incorporate this datetime range into a kind of query we've already seen. Run the following query:

    ```kusto
    StormEvents
    | where StartTime between (datetime(2007-01-01)..datetime(2007-06-01))
    | where DamageProperty > 0
    | where State == "FLORIDA"
    | project StartTime, EventType, DamageProperty
    | take 50
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/5-where-3.png" alt-text="Screenshot of where operator example 3.":::

1. Notice that all the dates are within the first half of the year, months 1-6. You may also see that even though we've selected events from the state of Florida, we don't see the state as an output column, since it wasn't specified in the `project` operator.