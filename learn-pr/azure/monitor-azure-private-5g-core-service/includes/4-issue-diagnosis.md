During the monitoring of your private mobile network, you may find network issues. For example, a connection or a network function may not be working as expected. In this case, you can use a *distributed tracing tool*, which is a network issue diagnostic tool that Azure Private 5G Core offers, to diagnose the issues reported.

The distributed tracing tool allows you to collect detailed traces for signaling flows involving packet core instances. Each *trace* represents the results of a distinct occurrence of a network activity. Through a web graphical user interface (GUI), you can use traces to diagnose many common configuration, network, and interoperability problems affecting network services.

The distributed tracing tool is available from the ASE on which the packet core instance runs. As the tool resides within each site in your private mobile network, it doesn't have much reliance on the network bandwidth or the cloud connectivity. With the tool, you can quickly diagnose network issues and minimize their impact to your network services.

To effectively diagnose issues in your private mobile network, you need to be familiar with the network functions that Azure Private 5G Core provides. For more information about the network functions, see [Packet core architecture](/azure/private-5g-core/private-5g-core-overview#packet-core-architecture). You also need to understand how different components in an [Azure private multi-access edge compute (MEC)](https://azure.microsoft.com/solutions/private-multi-access-edge-compute-mec/#overview) solution interact with each other.

<!-- Insert an issue debugging video here once it is available -->

## Access the distributed tracing tool

The URL for accessing the distributed tracing tool is as follows:

`https://<LocalMonitoringIP>/sas`

Here *\<`LocalMonitoringIP`\>* is the IP address for accessing the local monitoring tools that you set up when you configure the management network during Azure Private 5G Core deployment.

If this is the first time you access the packet core dashboards, use the following default account to sign in:

- Name: *admin*
- Password: *packetCoreAdmin*

Change the password for the account after the initial sign-in.

## Trace types that you can check

What to check for what issues

example issues: Connectivity to Azure such as ports, URLs, RAN connection, and UE attaching; packet capture capability

## Search for specific information

How to search for the info I need
Info to search; need to understand network functions and the communication process between functions.

## Check diagnostics details

What should I check for each issue
details of each type
How to check details of a trace

## Share traces for technical support

Further support - Collecting diagnostics packages