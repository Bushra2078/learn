<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m01_intro\x-oli-workbook_page\_u05_m01_6_summary.xml -->
##  Introduction to Distributed Programming for the Cloud Summary

- Computer programs can be classified as sequential, parallel, distributed, and concurrent programs.
- A sequential program runs in program order on a single CPU (or, more specifically, a core).
- A concurrent program is a set of sequential programs that share one or more CPUs in time during execution.
- A parallel program is a set of sequential programs that overlap in time by running on separate CPUs in parallel.
- Parallel programs that run on separate CPUs on distinct networked machines are called distributed programs.
- A thread is the smallest sequence of instructions that an OS can manage through its scheduler. Multiple threads constitute a process, all of which share the same address space of the processor. Multiple processes constitute a task, while multiple tasks are typically grouped together as a job.
- Distributed programming is crucial to solving many problems, such as scientific workloads, big data computation, databases, and search engines.
- Multiple concerns dictate distributed program design for clouds; namely programming model, computation model, and program architecture. 
- Typical programming models include the shared-memory model and the message-passing model. 
- The shared-memory model assumes a shared address space, which is accessible by all tasks. Tasks communicate with each other by reading and writing to this shared address space. Communication among the tasks must be explicitly synchronized (using constructs such as barriers, semaphores, and locks). OpenMP is an example of a shared-memory model programming language.
- In the message-passing model, tasks do not share an address space and can only communicate to each other by explicitly sending and receiving messages. MPI is an example of a message-passing model programming language.
- Programming models are also classified as synchronous and asynchronous, based on the orchestration of the various tasks that are running in parallel. Synchronous programming models force all component tasks to operate in lock-step mode, while asynchronous models do not.
- Programs can also be classified according the type of parallelism they embody. They can either be data parallel or graph parallel. 
- Data-parallel models focus on distributing the data over multiple machines while running the same code on each, also called the single-program, multiple-data (SPMD) model. 
- Graph parallelism models focus on distributing computation as opposed to data, also called the multiple-program, multiple-data (MPMD) model.
- Tasks in a distributed programming model can be arranged into two distinct architectural models: asymmetric/master-slave and symmetric/peer-to-peer architectures.
- The master-slave organization requires one or more tasks to be specifically designated as the master tasks, which will coordinate the execution of the program among the slave tasks.
- The peer-to-peer organization consists of a set of tasks which are all equal but requires more complicated schemes to organize computation and make decisions. 
- Major challenges in building cloud programs include managing scalability, communication, heterogeneity, synchronization, fault tolerance, and scheduling.
- Programs cannot be infinitely sped up by virtue of Amdahl's law, which expresses the limit on the speedup of a program as a function of the fraction of the program's time spent executing code that is serial in nature.
- Efficiently managing communication among distributed tasks dictates performance for many applications. Strategies to improve communication bottlenecks in the cloud include colocating highly communicating tasks and effectively managing the partitioning of data to map data to nodes that are closest to it.
- Clouds bring heterogeneity in terms of the underlying physical hardware, which is typically masked from the end user through virtualization. Programs running on the cloud that can account for and adjust based on heterogeneous hardware can benefit in terms of performance.
- Robust synchronization techniques are a must in distributed programming to deal with issues such as deadlocks.
- Fault tolerance poses a serious challenge in programming for clouds. Programs must anticipate for and recover against failures of software and hardware while running in the cloud. 
- Task and job scheduling techniques take into account the unique nature of cloud resources in order to maximize performance. 
##  Unit 5 Checkpoint Quiz