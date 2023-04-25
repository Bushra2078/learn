After using Azure Migrate for your assessment, you can decide which of your servers are good candidates to migrate to Azure. You've presented your findings to the IT Director, and now you want to continue with a test migration to assess the end-to-end process. Azure Migrate can also perform an agentless migration of virtual and physical servers into Azure. You've chosen to use Azure Migrate to complete the migration of virtual machines.

In this unit, we review Azure Migrate and how to use it to migrate specific workloads to Azure.

## Virtual machine replication

Add **Azure Migrate: Server Migration** to your Azure Migrate dashboard, which carries over machines and insights from the assessment. You can begin your replication by selecting **Replicate** in the **Migration and modernization** tool window. Azure Migrate replicates up to 100 VMs simultaneously. If you need to do more, we recommend that you create multiple batches. Times for replication vary based on the number and size of virtual machines, along with connection speeds between your data center and Azure.

> [!div class="mx-imgBorder"]
> ![Screenshot of the Azure Migrate Servers page in Azure Admin center.](../media/4-vm-replication.png)

## Test migrated virtual machines

Once all your targeted virtual machines are replicated and into Azure, you can test your virtual machines to ensure everything works before you migrate them into production. The process runs a prerequisite check, prepares for the test, creates a new test virtual machine, and starts it. This process takes a few minutes.

## Migrating the virtual machines into production

Once you’re ready for the production migration, select **Migrate** from the Replicating machines window. The process prompts you to shut down the virtual machine to avoid any data loss and perform a final replication. We recommend running this process during off-peak business hours, because the virtual machine will be down for a few minutes.

> [!div class="mx-imgBorder"]
> ![Screenshot of the Server migration replicating machines page in Azure Admin center.](../media/4-vm-machines.png)

Now Azure Migrate runs through the production migration process. You can check the status as it validates the prerequisites, prepares for migration, creates the Azure VM, and starts the Azure VM.


## Post-migration steps

After the migration has taken place, review the security settings of the virtual machine. Restrict network access for unused services by using network security groups. Deploy Azure Disk Encryption to secure the disks from data theft and unauthorized access.

Consider improving the resilience of the migrated machines by:

- Adding a backup schedule that uses Azure Backup.
- Replicating the machines to a secondary region using Azure Site Recovery.

Complete cleanup tasks for the remaining on-premises servers. Such tasks may include removing the servers from local backups and removing their raw disk files from storage-area network (SAN) storage to free up space. Update documentation related to the migrated servers to reflect their new IP addresses and locations in Azure.
