Microsoft Defender for Storage is an Azure-native layer of security intelligence that detects unusual and potentially harmful attempts to access or exploit your storage accounts. It utilizes the advanced capabilities of security AI and Microsoft Threat Intelligence to provide contextual security alerts and recommendations.

Security alerts are triggered when anomalies in activity occur. The Security alerts are integrated with Defender for Cloud and sent via email to subscription administrators with details of suspicious activity and recommendations on how to investigate and remediate threats.

## What are the benefits of Microsoft Defender for Storage?

Microsoft Defender for Storage provides:

- **Azure-native security** - With one-click enablement, Defender for Storage protects data stored in Azure Blob, Azure Files, and Data Lakes. As an Azure-native service, Defender for Storage provides centralized security across all data assets managed by Azure and is integrated with other security services such as Microsoft Sentinel.

- **Rich detection suite** - Powered by Microsoft Threat Intelligence, the detections in Defender for Storage cover the top storage threats such as anonymous access, compromised credentials, social engineering, privilege abuse, and malicious content.

- **Response at scale** - Defender for Cloud's automation tools make it easier to prevent and respond to identified threats. Learn more in Automate responses to Defender for Cloud triggers.

:::image type="content" source="../media/defender-for-storage-overview.png" alt-text="Screenshot of Microsoft Defender for Storage threat response.":::

## What kind of alerts does Microsoft Defender for Storage provide?

Security alerts are triggered when there's:

- **Suspicious access patterns** - such as successful access from a Tor exit node or from an IP considered suspicious by Microsoft Threat Intelligence

- **Suspicious activities** - such as anomalous data extraction or unusual change of access permissions

- **Uploads of malicious content** - such as potential malware files (based on hash reputation analysis) or hosting of phishing content

Alerts include details of the incident that triggered them, and recommendations on how to investigate and remediate threats. Alerts can be exported to Azure Sentinel or any other third-party SIEM or any other external tool.

## What is hash reputation analysis for malware?

To determine whether an uploaded file is suspicious, Defender for Storage uses hash reputation analysis supported by Microsoft Threat Intelligence. The threat protection tools don’t scan the uploaded files. Rather they examine the storage logs and compare the hashes of newly uploaded files with the hashes of known viruses, trojans, spyware, and ransomware.

When a file is suspected of containing malware, Security Center displays an alert and can optionally email the storage owner for approval to delete the suspicious file. To set up this automatic removal of files containing malware indicated by hash reputation analysis, deploy a workflow automation to trigger on alerts containing "Potential malware uploaded to a storage account”.