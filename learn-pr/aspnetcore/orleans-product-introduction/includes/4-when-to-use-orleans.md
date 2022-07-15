Orleans provides a flexible framework for building applications that handle many different scenarios. As you become more comfortable working with Orleans, you'll start to understand where it can add value in new or existing applications. In general, Orleans is a powerful tool for apps with any of the following architectural requirements:

* Distributed architecture - Orleans can manage and persist data across distributed data stores. Many of the underlying details are hidden from developers, who can still code against grains as though they were single threaded.
* Fault tolerance - Persistent state features ensure Orleans can manage your data across changing or scaling environments.
* Scalability - Orleans adapts to the application environment as it scales up and down. When designed properly, your code will continue to work regardless of how many app instances are running.
* State management - Orleans excels at tracking the state and behavior of entities using grains. You can use Orleans to manage some or all of the state data in your app.

The following table includes examples specific use cases across different types of applications and industries.

|          |      |
|---------|---------|
|Ecommerce     |  Use Orleans to manage shopping carts, product inventory, user accounts, transactions, and more.      |
|Live data apps     | Orleans can provide near real-time data for scenarios such as stock tickers, chat apps, and other interactive experiences.         |
|Gaming     | Orleans can be used with games to support underlying infrastructure, such as managing sessions and rooms, and tracking game state data.         |
|Finance     | Orleans supports ACID transactions for scalable, reliable operations.         |
|IoT and event-driven apps     |  Orleans can handle and process large volumes of incoming event data, such as small transactions from large numbers of GPS enabled smart devices.       |
| Task scheduling | Orleans grains support durable scheduling mechanisms, meaning you can design your app to execute code at specific types. Scheduling could be used to design an app that sends out reminders, notifications, or promotions at specific times. |

Orleans is production ready and already supports major implementations of the preceding examples in popular platforms. For example, Orleans is currently used in products such as Skype, Halo, Gears of War, and Playfab. Microsoft also uses Orleans internally for various products and systems.
