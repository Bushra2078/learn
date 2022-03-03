Event Flags Groups provide a powerful tool for thread synchronization. Event flags can be set or cleared by any thread and can be retrieved by any thread. Threads can suspend while waiting to retrieve or get some combination of event flags. 

Each event flag is represented by a single bit, and event flags are arranged in groups of 32 as illustrated in the following figure:

:::image type="content" alt-text="Diagram that illustrates event flags arranged in groups of 32 bits." source="../media/event-flag-groups.svg" loc-scope="Azure":::

Threads can operate on all 32 event flags in a group simultaneously. To set or clear event flags, we use the `tx_event_flags_set` service and we get or retrieve them with the `tx_event_flags_get` service.

Setting or clearing event flags is performed with a logical AND or OR operation between the current event flags group and the new specified event flags. The user specifies the type of logical operation (either AND or OR) in the call to the `tx_event_flags_set` service.

There are similar logical options for getting event flags. A get request can specify that all specified event flags are required (a logical AND). Alternatively, a get request can specify that any of the specified event flags will satisfy the request (a logical OR). The user specifies the type of logical operation in the `tx_event_flags_get` call.

Event flags that satisfy a get request are cleared if the request specifies either of the options `TX_OR_CLEAR` or `TX_AND_CLEAR`. The flag values remain unchanged when you use the `TX_AND` or `TX_OR` options in a get request.

Each event flags group is a public resource. Azure RTOS ThreadX imposes no constraints as to how an event flags group can be used.

An application usually creates event flags groups during initialization (that is, `tx_application_define`), but this can be done during runtime. At the time of their creation, all event flags in the group are initialized to zero. There is no limit to the number of event flags groups an application may use.

Application threads can suspend while attempting to get any logical combination of event flags from a group. Immediately after one or more flags of a group have been set, Azure RTOS ThreadX reviews the get requests of all threads suspended on that event flags group. All the threads whose get requests were satisfied by the set operation are resumed.

First, we'll investigate how to set flags, and then we'll look at how to retrieve or get flags. The name of this project is ProjectEventFlags.
