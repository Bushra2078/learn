<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m02_virtualization\x-oli-workbook_page\_u03_m02_3_summary.xml -->
##  Virtualization Summary

- Virtualization involves the construction of an _isomorphism_ that maps a virtual _guest_ system to a real (or physical) _host_ system.
- An underlying physical machine (PM) usually is called a _host_, and an OS running on a VM is called a _guest_ OS.
- As compared to a host PM, a VM can have resources different in quantity and in type (e.g., a host can contain one Intel IA-32 physical CPU, while a VM can include eight PowerPC virtual CPUs that all map to the single physical CPU).
- A VM can run only at a single host at a certain point in time, yet can be migrated to a different host (and run at that host) at a different point in time.
- There are two types of VMs, _process VMs_ and _system VMs_.
- A process VM (e.g., JVM) consists of a virtual memory address space, user-level registers, and instructions assigned to an OS process to execute a user program (i.e., no OS can run within a process VM).
- Process VMs can support ISAs that differ from host ISAs. 
- The abstraction of a process VM is provided by a piece of virtualizing software denoted as the _runtime_.
- The runtime of a process VM is placed at the ABI interface, on top of a host OS.
- As opposed to process VMs, a system VM provides a complete system environment (i.e., an OS image can be run in a system VM).
- System VMs can support ISAs that differ from host ISAs. 
- The abstraction of a system VM is provided by a piece of a virtualizing software called the _hypervisor_ (or the _virtual machine monitor_ [VMM]).
- There are three main classes of system VMs, which are defined according to where in the system the hypervisor is placed.
- A system VM is called a _native system VM_ when its hypervisor is placed on bare metal (i.e., the raw hardware).
- In native system VMs, the hypervisor is run in system mode, and the VMs (alongside their associated OSs) are run in user mode.
- Hypervisors in native system VMs should specify and implement every function required for managing hardware resources.
- With native system VMs, every privileged instruction issued by a user program at any guest OS has to _trap_ to the hypervisor.
- A system VM is called a _user-mode hosted VM_ when its hypervisor is placed on top of a host OS. 
- In user-mode hosted VMs, the hypervisor and all its managed VMs run in user mode, while the underlying host OS runs in system mode. 
- With user-mode hosted VMs, privileged instructions from guest OS(s) need to trap to the hypervisor, but the hypervisor needs not implement every function required for managing hardware resources.
- A system VM is called a _dual-mode hosted VM_ when its hypervisor is placed partly on bare metal and partly on a host OS.
- In dual-mode hosted VMs, the hypervisor can partly operate in system mode and partly in user mode, hence, using the best of native system VMs and user-mode hosted VMs.