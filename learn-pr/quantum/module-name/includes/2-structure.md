Azure Quantum is a Microsoft Azure service for running quantum computing programs and solving optimization problems in the cloud. In this unit, the crew will familiarize with the basic elements of the Azure Quantum platform.  

**Mike** Do we want to explan a couple more concepts? It shouldn't be an exact copy of the documentation.

## What is an Azure subscription?

The cloud is a powerful place that hosts many moving parts. To use the Microsoft cloud, Azure, your crew needs to first have an account to access and manage Azure resources. A *subscription* represents a grouping of Azure resources. An invoice is generated at the subscription scope. It has its own payment methods that are used to pay its invoice. [Link to creating a subscrption/account?](https://docs.microsoft.com/en-us/learn/modules/create-an-azure-account/)

(TBD) Luckily, before leaving Earth, the Spaceship obtained a Sandbox Environment, which grants you access to Azure for X sessions without needing to create a subscription. 

## How to use quantum services on Azure?

Azure Quantum is a service on Azure. To use it, you'll create a *Quantum Workspace* in your subscription, which is a resource that stores all the quantum programs and optimization problems (called *Jobs*) that you submit to the service.

The Quantum Workspace will also contain a list of providers and targets that you've selected. *Providers* publish a set of *Targets*, each of which allows you to either run a quantum program or solve an optimization problem. Simulators, quantum computers, and optimization solvers are examples of targets.

In the next section of this module you'll create a Quantum Workspace.


## Storage Account

To store your jobs and results, you will need an Azure storage account. It is one of the properties configured when you set up a Quantum Workspace. 

## Jobs

When you run a quantum computing program or solve an optimization problem in Azure Quantum, you create and run a *job*. 

The steps to create and run a job depend on
the job type and the provider and target that you configure for the Workspace.  All jobs, however, have the following properties in common:

|Property |Description|
|-----|----|
|**ID**|A unique identifier for the job. It must be unique within the Workspace.    |
|**Provider**|_Who_ you want to run your job. For example, the Microsoft Quantum Solution provider, or a third-party provider. |
|**Target**| _What_ you want to run your job on. For example, the exact quantum hardware or quantum simulator offered by the provider. |
|**Name**|A user-defined name to help organize your jobs.|
|**Parameters**|Optional input parameters for targets. See the documentation for the selected target for a definition of available parameters.|

Once you create a job, you'll also find various metadata available about its state and run history.

In the next unit, you will create a Quantum Workspace.
