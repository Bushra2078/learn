You’ve addressed all of the Azure Stack HCI SDN prerequisites and are eager to proceed with its deployment. As part of your evaluation, you want to identify the optimal deployment methodology that you’ll be able to test in your proof-of-concept environment.

## Deploy Azure Stack HCI SDN

There are four primary methods of deploying Azure Stack HCI SDN:

- SDN Express PowerShell module (**SDNExpressModule.psm1**)-based script (**SDNExpress.ps1**). This option provides the most flexibility and you can use it to fully automate your deployment. It supports deployment of the entire SDN fabric including Network Controller, SLB/MUX, and Gateway VMs. To automate your deployment, you can use an input configuration file that includes values of such deployment parameters as prefixes of IP logical subnets, VLAN IDs, deployment credentials, target Azure Stack HCI cluster nodes, and BGP peering settings. You can download the module and sample configuration files as per your requirements (**Traditional VLAN networks.psd1**, **Virtualized networks.psd1**, **Software Load Balancer.psd1**, and **SDN Gateways.psd1**) from the SDN Express GitHub repository to a host from which you’ll initiate the deployment. Alternatively, you have the option of running the **SDNExpress.ps1** interactively. This approach offers a graphical interface guiding you through deployment. The script also allows you to save the settings you specified as a configuration file, which you can subsequently use to automate another deployment.

The following screenshot depicts the **Welcome** page of the SDN Express deployment wizard.

:::image type="content" source="../media/5-deploy-sdn-express-1-introduction.png" alt-text="Screenshot of the Welcome to the SDN Express deployment wizard page.":::

The following screenshot depicts the **Review** page of the SDN Express deployment wizard.

:::image type="content" source="../media/5-deploy-sdn-express-9-review.png" alt-text=" Screenshot of the Review page with an Express option to save the configuration.":::

> [!NOTE]
> You can also use the SDN Express PowerShell module in your own scripts for customized deployments or for scaling out an existing SDN infrastructure.

- VMM. This option simplifies SDN deployments through the VMM graphical interface by using service templates.
- The VMMExpress scripts. This option allows you to customize and automate deployment of the SDN fabric (similar to SDNExpress) by using the VMM PowerShell module. It is dependent on an existing VMM environment, with VMM-managed Azure Stack HCI cluster nodes. It combines the benefits of a scripted deployment with the VMM simplified management experience.

    > [!NOTE]
    > If you intend to manage your SDN environment by using VMM, you must use either of the two VMM deployment methods.

- Windows Admin Center. This option uses the Azure Stack HCI cluster deployment wizard Windows Admin Center extension to set up an Azure Stack HCI cluster, including its Storage Spaces Direct (also known as S2D)-based storage and Network Controller VMs. The extension also supports installing SDN into an existing cluster. The wizard guides you through installing required operating system features, configuring networking, creating the cluster, deploying Storage Spaces Direct, and, optionally, implementing SDN.

    > [!NOTE]
    > As of November 2021, the Windows Admin Center extension doesn't support provisioning of SLB/MUX or Gateway VMs.

The following screenshot depicts the options to choose the cluster type in the Windows Admin Center.

:::image type="content" source="../media/5-deploy-windows-admin-center-choose-cluster-type.png" alt-text="Choose the cluster type pane in Windows Admin Center with the Azure Stack HCI and All servers in one site options selected.":::

The following screenshot depicts the **Host** and **Network** setting options when deploying an Azure Stack HCI cluster in the Windows Admin Center.

:::image type="content" source="../media/5-deploy-windows-admin-center-cluster-settings-1.png" alt-text="Define the Network Controller cluster pane with Host and Network settings in Windows Admin Center.":::

The following screenshot depicts the **Credentials** and **Advanced** setting options when deploying an Azure Stack HCI cluster in the Windows Admin Center.

:::image type="content" source="../media/5-deploy-windows-admin-center-cluster-settings-2.png" alt-text="Define the Network Controller cluster pane with Credentials and Advanced settings in Windows Admin Center.":::

The following screenshot depicts the completion of the deployment process in Windows Admin Center.

:::image type="content" source="../media/5-deploy-windows-admin-center-cluster-deployed.png" alt-text="Windows Admin Center Deploy the Network Controller pane with the deployment completed.":::

## Phased deployments

Depending on your requirements, you have the option to provision only a subset of the SDN services. For example, if your virtualized workloads don’t require external connectivity, you can simply exclude gateway VMs from the scope of your deployment and add them later if your requirements change at some point.
For more details on the infrastructure requirements for your scenarios, refer to the documentation links in the Summary unit.
