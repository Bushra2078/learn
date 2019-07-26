For high-intensity tasks with specialized requirements, you may need to use specialized Virtual Machines (VMs).

The 3D models used in your engineering organization require many calculations to render and use memory resources intensively. You find that standard VMs render these models relatively slowly. These delays affect the productivity of your engineers and you'd like to avoid them.

Here, you'll learn about VM tiers in Azure that support specialized high-performance tasks.

## H-series VMs

As the solution architect for the engineering organization, you've already seen how Azure Batch orchestrates hundreds and thousands of nodes working together in parallel. The emphasis is on the sheer number of VMs that can be orchestrated in parallel. This process means that work is achieved in a fraction of the time. However, some use cases also call for especially powerful VMs with exceptional CPU, memory, and networking capabilities. In these cases, use Azure VM HPC instances. HPC Instances are a series of Azure VMs expressly designed to cater for some of the harder aspects of HPC scenarios.

Azure *H-series* VMs are a family of the most powerful and fastest CPU-based VMs on Azure. These VMs are optimized for applications that require high CPU frequencies or large amounts of memory per core requirements. The basic H-series is well suited to use cases like genomic research, seismic and reservoir simulation, financial risk modeling, and molecular modeling. 

The VMs feature the Intel Xeon E5-2667 v3 Haswell 3.2 GHz CPU with DDR4 memory. Configurations range from 8 cores and 56 GB at the lower end – the H8 SKU – to 16 cores and 224 GB at the higher end – the H16m SKU.

All these HPC instances can be used in concert with Azure Batch. When you set up an Azure Batch pool, you can specify that H-series VMs should be used.

### HB-series VMs

The *HB-series* of VMs specifically target applications requiring extreme memory bandwidth, particularly fluid dynamics, explicit finite element analysis, and weather modeling. HB VMs have 60 AMD EPYC 7551 processor cores, with 4 GB of RAM per CPU core and 240 GB of memory overall. HB-series VMs provide more than 260 GB/sec of memory bandwidth. This bandwidth is 33 percent faster than x86 alternatives and 2.5x faster than is standard for most current HPC customers.

### HC-series VMs

The *HC-series* of VMs are optimized for applications driven by dense computation, such as implicit finite element analysis, reservoir simulation, and computational chemistry. HC VMs have 44 Intel Xeon Platinum 8168 processor cores, with 8 GB of RAM per CPU core and 352 GB of memory overall. HC-series VMs support Intel software tools such as the Intel Math Kernel Library, and feature an all-cores clock speed greater than 3 GHz for most workloads.

## Remote Direct Memory Access

A subset of the H-series – the H16r and H16mr SKUs – and both the HB and HC-series VMs also use a second low-latency, high-throughput network interface called Remote Direct Memory Access (RDMA). The RDMA can give a significant boost to the performance of Message Passing Interface (MPI) applications.

MPI is a protocol for communication between computers as they run complex HPC tasks in parallel. To use it, your developers must use an implementation of the protocol, which is usually a library of routines in a .dll. 

Ask your developers if they are using MPI. If the answer is yes, you should ensure that the VM tier and size you select supports the protocol. Otherwise, your nodes will not communicate at the highest possible speed.

## Infiniband interconnects

Infiniband is a data interconnect hardware standard for HPC that is often used to accelerate communications between components both within a single server and between servers. It has been designed to support the highest speeds and the lowest latency for messages between CPUs and between processors and storage components.

Both HC-series and HB-series VMs use a 100GB/sec Mellanox EDR Infiniband interconnect in non-blocking tree configuration to boost hardware performance.

## N-series VMs

Some HPC tasks are both compute-intensive and graphics-intensive. Suppose, for example, you are modeling behavior of a wing in a wind tunnel, and you want to show a live visualization to help engineers understand that behavior. For these applications, consider using N-service VMs, which include single or multiple NVIDIA GPUs. 

### NC-series VMs

The *NC-series* of VMs use the NVIDIA Tesla K80 GPU card and Intel Xeon E5-2690 v3 processors. This series is the lowest-cost of the N-series tiers, but VMs in this tier are capable of graphics-intensive applications. They also support NVIDIA's CUDA platform, so that you can use the GPUs to run compute instructions.

### ND-series VMs

The *ND-series* of VMs is optimized for AI and Deep Learning workloads. They use the NVIDIA Tesla P40 GPU card and Intel Xeon E5-2690 v4 processors. They are fast at running single-precision floating point operations, which are used by AI frameworks including Microsoft Cognitive Toolkit, TensorFlow, and Caffe.