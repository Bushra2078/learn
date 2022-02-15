First let's walk through the building blocks for this project before we do the exercise in the next unit. You don't need to copy the code in this unit, everything you need is provided in the exercise.

## Building block 1

Building block 1, part 1, represents declarations, definitions and prototypes: <!--figure 12-->

:::code language="c" source="../samples/project-message-queues.c" range="1-22":::

<a name="building-block-1-part-2"></a>

Building block 1, part 2, is shown in the code below: <!--figure 13-->

:::code language="c" source="../samples/project-message-queues.c" range="23-37":::

> [!TIP]
> - You'll need to add counters, another thread, and another prototype

## Building block 2

Building block 2 represents main entry point: <!--figure 14-->

:::code language="c" source="../samples/project-message-queues.c" range="43-48":::

> [!NOTE]
> - The code above is identical to the other projects in this learning path and no changes are needed

## Building block 3

<a name="building-block-3-part-1"></a>

Building block 3, part 1, represents application definitions: <!--figure 15-->

:::code language="c" source="../samples/project-message-queues.c" range="54-80" highlight="5-6":::

> [!TIP]
> - You'll need to create new pointers as highlighted in the code above.

<a name="building-block-3-part-2"></a>

Building block 3, part 2, is shown in the code below: <!--figure 16-->

:::code language="c" source="../samples/project-message-queues.c" range="82-105" highlight="15":::

> [!TIP]
> - You'll need to create another queue as highlighted in the code above.

<a name="building-block-4-dispatcher-thread-entry"></a>

## Building block 4

Building block 4 contains the functions. The `dispatcher thread entry` function is shown in the code below: <!--figure 17-->

:::code language="c" source="../samples/project-message-queues.c" range="110-130" highlight="9-19":::

> [!TIP]
> - You'll need to send messages to another queue, use a sleep time of 5.

The `urgent thread entry` function is shown in the code below: <!--figure 18-->

:::code language="c" source="../samples/project-message-queues.c" range="133-146":::

<a name="building-block-4-routine-thread-entry"></a>

Building block 4 also contains the `routine thread entry` function, shown in the code below: <!--figure 19-->

:::code language="c" source="../samples/project-message-queues.c" range="149-162" highlight="9-12":::

> [!TIP]
> - Use this entry function as a model to create a new entry function; use a sleep time of 10

<a name="building-block-4-print-stats"></a>

Building block 4 also contains the `print_stats` application timer function, shown in the code below: <!--figure 20-->

:::code language="c" source="../samples/project-message-queues.c" range="165-183":::

> [!TIP]
> - You'll need to make modifications to include the new thread and queue that you created