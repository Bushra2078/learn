In this exercise, you use the Total Cost of Ownership (TCO) Calculator to compare the cost of running a sample workload in the datacenter versus on Azure.

Tailwind Traders is interested in moving some of their on-premises workloads to the cloud. But first, their Chief Financial Officer wants to understand more about moving from a relatively fixed cost structure to an ongoing monthly cost structure.

You've been tasked to investigate whether there are any potential cost savings in moving your European datacenter to the cloud over the next three years. You need to take into account all of the potentially hidden costs involved with operating on-premises and in the cloud.

Instead of manually collecting everything you think might be included, you use the Total Cost of Ownership (TCO) Calculator as a starting point. You adjust the provided cost assumptions to match Tailwind Traders' on-premises environment.

> [!NOTE]
> Remember, you don't need an Azure subscription to work with the TCO Calculator.

Let's say that:

* Tailwind Traders run two sets, or banks, of 50 virtual machines (VMs) in each bank.
* The first bank of VMs runs Windows Server under Hyper-V virtualization.
* The second bank of VMs runs Linux under VMware virtualization.
* There is also a storage area network (SAN) with 60 terabytes (TB) of disk storage.
* You consume an estimated 15 TB of outbound network bandwidth each month.
* There are also a number of databases involved, but for now, you'll omit those details.

Recall that the TCO Calculator breaks down into these three steps:

:::image type="content" source="../media/2-total-cost-ownership-steps.png" alt-text="A visual representation of the three steps; define your workloads, adjust assumptions, view report." border="false":::

Let's see how Tailwind Traders' existing workloads stack up in the datacenter versus on Azure.

## Define your workloads

Enter the specifications of your on-premises infrastructure into the TCO calculator.

1. Go to the [Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator?azure-portal=true).

1. Under **Define your workloads**, select **Add server workload** to create a row for your bank of Windows Server virtual machines.

1. Under **Servers**, set the value for each of these settings:

    | Setting | Value |
    | -- | -- |
    | Name | *Servers: Windows VMs* |
    | Workload | **Windows/Linux Server** |
    | Environment | **Virtual Machines** |
    | Operating system | **Windows** |  
    | VMs | **50** |
    | Virtualization | **Hyper-V** |
    | Core(s) | **8**|
    | RAM (GB) | **16** |
    | Optimize by | **CPU** |
    | Windows Server 2008/2008 R2 | **Off** |
    | | |

1. Select **Add server workload** to create a second row for your bank of Linux virtual machines.

    | Setting | Value |
    | -- | -- |
    | Name | *Servers: Linux VMs* |
    | Workload | **Windows/Linux Server** |
    | Environment | **Virtual Machines** |
    | Operating system | **Linux** |  
    | VMs | **50** |
    | Virtualization | **VMware** |
    | Core(s) | **8**|
    | RAM (GB) | **16** |
    | Optimize by | **CPU** |
    | | |

1. Under **Storage**, select **Add storage**. Then specify these settings:

    | Setting | Value |
    | -- | -- |
    | Name | *Server Storage* |
    | Storage type | **Local Disk/SAN** |
    | Disk type | **HDD** |
    | Capacity | **60 TB** |  
    | Backup | **120 TB** |
    | Archive | **0 TB** |
    | | |

1. Under **Networking**, set **Outbound bandwidth** to **15 TB**.

1. Select **Next**.

## Adjust assumptions

Here, you specify your currency. For brevity, you leave the remaining fields at their default values.

In practice, you would adjust any cost assumptions and make any adjustments to match your current on-premises infrastructure.

1. At the top of the page, select your currency. This example uses **US Dollar ($)**.
1. Select **Next**.

## View report

Take a moment to review generated report.

Remember, you've been tasked to investigate cost savings for your European datacenter over the next three years.

To make these adjustments:

1. Set **Timeframe** to **3 Years**.
1. Set **Region** to **North Europe**.

Scroll to the summary at the bottom. You see a comparison of running your workloads in the datacenter versus on Azure. The prices you see might differ, but here's an example of the cost savings you might expect:

![TODO: Screenshot of the report pane of the TCO Calculator in Azure. The highlighted and completed input fields indicates how set the TCO Calculator timeframe to three years and the region to North Europe. A graph shows the cost of on-premises infrastructure and workloads off-set against the reduced cost of using Azure.](../media/3-tco-calculator-summary.png)

Select **Download** to download or print a copy of the report in PDF format.

Great work. You now have the information that you can share with your Chief Financial Officer. If you need to make adjustments, you can revisit the TCO Calculator to generate a fresh report.
