A summary of SAP HANA on Azure Large Instances architecture consists of the following infrastructure components:

* **Virtual network**. The Azure Virtual Network service securely connects Azure resources to each other and is subdivided into separate subnets for each layer. SAP application layers are deployed on Azure virtual machines (VMs) to connect to the HANA database layer residing on large instances.

* **Virtual machines**. Virtual machines are used in the SAP application layer and shared services layer. The latter includes a jumpbox used by administrators to set up HANA Large Instances and to provide access to other virtual machines.

* **HANA Large Instance**. A physical server certified to meet SAP HANA Tailored Datacenter Integration (TDI) standards runs SAP HANA. This architecture uses two HANA Large Instances: a primary and a secondary compute unit. High availability at the data layer is provided through HANA System Replication (HSR).

* **High Availability Pair**. A group of HANA Large Instances blades are managed together to provide application redundancy and reliability.

* **MSEE (Microsoft Enterprise Edge)**. MSEE is a connection point from a connectivity provider or your network edge through an ExpressRoute circuit.

* **Network interface cards (NICs)**. To enable communication, the HANA Large Instance server provides four virtual NICs by default. This architecture requires one NIC for client communication, a second NIC for the node-to-node connectivity needed by HSR, a third NIC for HANA Large Instance storage, and a fourth for iSCSI used in high availability clustering.

* **Network File System (NFS) storage**. The NFS server supports the network file share that provides secure data persistence for HANA Large Instance.

* **ExpressRoute**. ExpressRoute is the recommended Azure networking service for creating private connections between an on-premises network and Azure virtual networks that do not go over the public Internet. Azure VMs connect to HANA Large Instances using another ExpressRoute connection. The ExpressRoute connection between the Azure virtual network and the HANA Large Instances is set up as part of the Microsoft offering.

* **Gateway**. The ExpressRoute Gateway is used to connect the Azure virtual network used for the SAP application layer to the HANA Large Instance network. Use the High Performance or Ultra Performance SKU.

* **Disaster recovery (DR)**. Upon request, storage replication is supported and will be configured from the primary to the DR site located in another region.

