Our goal was to determine if Azure Bastion would be a good choice for your LOB app. We developed the following criteria to guide your decision:

- Security
- Ease of management
- Integration

We applied these criteria to the scenario and decided that Azure Bastion is the preferred choice for remote management of the LOB app. The criteria helped you evaluate whether your business requirements are a good match for Azyre Bastion. First, they let you assess how well Azure Bastion will solve your problem. Second, they give you an idea of the amount of management effort involved in using Azure Bastion for your task. The analysis made it clear that Azure Bastion provides a more secure option than jump servers, and also takes up less of your time with management and update tasks.  

You learned about how Azure Bastion helps protect your hosted VMs because it:

- Provides the convenience of securely using both RDP/SSH to manage remote VMs.
- Avoids exposing RDP/SSH ports to the internet.

You should now be able to determine how you can use Azure Bastion to help secure remote management sessions to your Azure hosted VMs. Consider using Azure Bastion when:

- You have remote Azure hosted VMs to manage
- You want avoid having to maintain the method by which you connect to these remote VMs
- You don't want to have to configure network security group settings to enable remote management

## References

- [Azure Bastion](https://azure.microsoft.com/services/azure-bastion?azure-portal=true).
- [Azure Bastion Pricing](https://azure.microsoft.com/pricing/details/azure-bastion?azure-portal=true)
- [Quickstart: Connect to a VM securely through a browser via private IP address](https://docs.microsoft.com/azure/bastion/quickstart-host-portal?azure-portal=true)
