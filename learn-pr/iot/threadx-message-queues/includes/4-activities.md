The diagram below describes the activities for this project. <!--figure 11-->

:::image type="content" source="../media/project-activities.svg" alt-text="Illustration of the project activities." border="false":::

The `Dispatcher` thread has priority 5, the `Urgent` thread has priority 10, and the `Routine` thread has priority 15. The `Dispatcher` thread sends messages to `UrgentQueue` and `RoutineQueue` at various times. The `Urgent` thread and the `Routine` thread wait for messages to appear on their respective queues, then read and process them.