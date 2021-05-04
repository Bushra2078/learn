Congratulations! You saved the day and completed all the repair tasks before disaster occurred.

![Image showing a cross-section of the spaceship, with rooms such as life support, the reactor and the cockpit.](../media/spaceship-core.png)

In this module, you learned:

- What the job shop scheduling problem is and why it matters
- How to represent constraints in the form of penalty functions
- How to define an objective function
- How to combine these penalty and objective functions and assign weights to form a cost function
- How to submit the cost function to Azure Quantum
- How to understand & parse the results
- How to validate the results
- How to tune the problem parameters

## Next steps

Now that you understand the problem scenario and how to define the cost function, you can perform a number of experiments to deepen your understanding and improve the solution defined above:

- Modify the problem definition:
  - Change the number of jobs, operations, and/or machines
    - Vary the number of operations in each job
    - Change operation runtimes
    - Change machine assignments
    - Add/remove machines
- Rewrite the penalty functions to improve their efficiency
- Tune the parameters
- Try using a different solver (such as `ParallelTempering`)

You can find this tutorial in Jupyter notebook format in our [samples repo](https://github.com/microsoft/qio-samples/tree/main/samples/job-shop-scheduling?azure-portal=true) - this will allow you to modify and experiment with the code.

## Learn more about Azure Quantum & the Quantum development kit

If this has piqued your interest, be sure to check out other Microsoft Learn modules that explore Azure Quantum.

If you're curious to learn more about quantum computing, be sure to check out the [Microsoft Quantum documentation](/quantum/?azure-portal=true). There, you'll find comprehensive reference material, including:

- Fundamental concepts around quantum computing.
- Quickstarts and tutorials.
- Q# language and API reference.
- How to use Q# with C#, Python, and Jupyter Notebook.

When you're ready to dive deeper, you can [browse code samples](/samples/browse/?languages=qsharp&azure-portal=true) or [learn quantum computing with the Quantum Katas](https://docs.microsoft.com/azure/quantum/tutorial-qdk-intro-to-katas?azure-portal=true).

To learn about real-world usage of the Quantum development kit, check out this blog post on the Microsoft Quantum collaboration with Pacific Northwest National Laboratory (PNNL): [Simulating nature with the new Microsoft Quantum development kit chemistry library](https://cloudblogs.microsoft.com/quantum/2018/12/04/simulating-nature-with-the-new-microsoft-quantum-development-kit-chemistry-library/?azure-portal=true).

Be sure to [join the quantum community](https://docs.microsoft.com/quantum/overview/understanding-quantum-computing?azure-portal=true) if you have questions or want to contribute to the many Microsoft open-source projects.
