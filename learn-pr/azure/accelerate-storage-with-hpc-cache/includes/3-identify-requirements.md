Before setting up your Azure HPC Cache, there are a few pre-requisites that need to be met. In this unit, you'll discover the requirements that must be in place and other considerations before deploying an Azure HPC Cache solution.

## Network Requirements for HPC Cache

Azure HPC Cache has three network requirements:

- set up a custom DNS server
- define a dedicated subnet
- verify TCP/UDP port access

### Set Up Custom DNS for HPC Cache

If you plan to use servers in your data center, then you’ll need to configure a DNS server so Azure resources can resolve your internal storage server names.

If you plan to use Azure-based storage like Azure NetApp Files or you plan to copy your data into Azure Blob, then you don’t need to configure this separate DNS server.

In the Azure portal:

- Create the virtual network that will host the Azure HPC Cache.
- Create the DNS server.
- Add the DNS server to the cache's virtual network.

Follow these steps to add the DNS server to the virtual network in the Azure portal:

1. Open the virtual network in the Azure portal.
1. Choose DNS servers from the Settings menu in the sidebar.
1. Select Custom
1. Enter the DNS server's IP address in the field.

![Screenshot showing how to add a custom DNS server to an existing virtual network.](../media/3-identity-requirements-01-custom-DNS-steps.png)

### Define a Dedicated Subnet for HPC Cache

The cache needs to be in its own, dedicated subnet. The cache manages its own IP addresses to provide high availability. To ensure there are no IP address conflicts, the cache must be in its own subnet with a range of at least 64 IP addresses.

To provide high availability, the HPC Cache must be able to move IP addresses among its resources. If there are network hosts inside the subnet, it's possible that the HPC Cache would use an IP address that was already assigned to another host. This would create a network conflict and cause issues with both hosts which share the same IP address.

If you’re running multiple caches, each needs its own, dedicate subnet.

![Screenshot showing how to add a subnet to a virtual network. The new subnet uses a 26-bit mask.](../media/3-identity-requirements-02-add-cache-only-subnet.png)

It’s highly recommended that a high-speed network connection like an ExpressRoute be in place between Azure and the data center where the storage is.

### Verify TCP/UDP Port Access for HPC Cache

Ensure firewall rules and Azure network security groups enable traffic between storage server ports and your internal network.

Different storage servers use different TCP/UDP ports to access data. Use a tool like `rpcinfo` to identify what TCP and UDP ports are used on your storage server. Commonly used TCP/UDP ports include:

- 111
- 2049
- 4045
- 4046
- 4047

## Obtain Azure Permissions for HPC Cache

The cache instance needs to be able to create virtual network interfaces (NICs). The user creating the cache must have sufficient Azure privileges in the subscription to create NICs.

## Set Up NFS Storage Permissions for HPC Cache

The cache needs to have root permissions to perform the read, write, and metadata operations on storage. Configure your storage target to allow root access to the Azure HPC Cache.

- Confirm that `no_root_squash` is enabled otherwise root access from the cache will be blocked.
- Examine export policies to ensure there are no restrictions on root access.
- Make sure the cache has access to the lowest level of the export – parent directories, not subdirectories.
