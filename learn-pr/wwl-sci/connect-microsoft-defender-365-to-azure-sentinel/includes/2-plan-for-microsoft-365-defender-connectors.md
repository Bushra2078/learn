The Microsoft 365 security portal provides a purpose-driven user interface to mitigate threats detected by Microsoft 365 Defender. The Microsoft 365 Defender families of products includes:

- Microsoft Defender for Endpoint

- Microsoft Defender for Identity

- Microsoft Defender for Office 365

- Microsoft Defender for Cloud Apps

- Microsoft 365 Defender

- Microsoft 365 Insider Risk Management (IRM) (Preview)

The products each have a connector that will send alerts to the SecurityAlerts table in Sentinel, which then can generate an Incident.  The Microsoft 365 Defender connector allows for the raw normalized data to be ingested by Microsoft Sentinel.  Currently, only Microsoft Defender for Endpoint data is configurable in the Microsoft 365 Defender connector.  You must decide if you want Microsoft 365 Defender products alerts in Microsoft Sentinel.  

- Should those alerts generate incidents when the incidents are already being investigated in the Microsoft 365 security portal?  
- Should Microsoft Sentinel ingest the Microsoft Defender for Endpoints data?

A security team needs to understand what raw log data is required, how alerts should be handled, and where incidents should be investigated.

This lesson will demonstrate the connecting of three services:

- Microsoft Defender for Office 365

- Microsoft Defender for Endpoint

- Microsoft 365 Defender

