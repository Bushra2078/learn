![Process Element.](../media/process.png)

Depicted by a circle, this element represents activities that can modify or redirect received input to their proper outputs.

Examples include:

- A micro service that receives an API call request and forwards it to an API handling service
- Code that validates data input before it writes to a data store

## When to use the process element

Add a process element between:

- **Data stores** - processes handle all communication between data stores
- **External entities with other elements** - processes handle all tasks and communication
- **Processes** - processes handle all tasks

Depending on the information depth level required for a data-flow diagram, you may use the process element to represent a few distinct use cases:

|Use case|Description|
|--------|-----------|
|Stubs|Using the process element as a "stub" on a higher-level data-flow diagram is a good way to help keep things clean. It involves creating a separate data-flow diagram for a specific process and mapping it back to the higher-level diagram. It works like a "zoom-in" feature, where the in-depth data-flow diagram is available when you "zoom-in" that process.|
|Multiple tasks|This use case applies when a process handles more than one task. This context is important because it allows anyone looking at the data-flow diagram to apply the proper security controls for each task.|

## Include context

Include the following context to each process element:

|Context|Questions|
|-------|---------|
|Code|Is this process running in C#, C++, Objective C, Java, or a scripting language?|
|Permission level|Does this process need kernel, local, or administration level permissions to run?|
|Service isolation|Is the process running in a sandbox?|
|Input|Can this process accept input from everyone, local accounts, or just administrators?|
|Validation|How does the process parse, handle and accept input?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, what does it rely on?|
|Authorization|Does it rely on Access Control Lists (ACL) for authorization? If not, what does it rely on?|