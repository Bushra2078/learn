
Once you have created your Key Vault and have populated it with keys and secrets. The next step is to set up a rotation strategy for the values you store as Key Vault secrets. Secrets can be rotated in several ways:

* As part of a manual process
* Programmatically by using REST API calls
* Through an Azure Automation script

### Example is Storage Service Encryption with Customer-Managed Keys.

This service uses Azure Key Vault that provides highly available and scalable secure storage for RSA cryptographic keys backed by FIPS 140-2 Level 2 validated HSMs (Hardware Security Modules). Key Vault streamlines the key management process and enables customers to fully maintain control of keys that are used to encrypt data, manage, and audit their key usage, in order to protect sensitive data as part of their regulatory or compliance needs, HIPAA and BAA compliant.

> [!div class="mx-imgBorder"]
> ![Data flow for Azure manual key rotation in Key Vault](../media/az500-customer-keys.png)

Customers can generate/import their RSA key to Azure Key Vault and enable Storage Service Encryption. Azure Storage handles the encryption and decryption in a fully transparent fashion using envelope encryption in which data is encrypted using an AES based key, which is in turn protected using the Customer-Managed Key stored in Azure Key Vault.

Customers can rotate their key in Azure Key Vault as per their compliance policies. When they rotate their key, Azure Storage detects the new key version and re-encrypts the Account Encryption Key for that storage account. This does not result in re-encryption of all data and there is no other action required from user.

Customers can also revoke access to the storage account by revoking access on their key in Azure Key Vault. There are several ways to revoke access to your keys. Please refer to Azure Key Vault PowerShell and Azure Key Vault CLI for more details. Revoking access will effectively block access to all blobs in the storage account as the Account Encryption Key is inaccessible by Azure Storage.

Customers can enable this feature on all available redundancy types of Azure Blob storage including premium storage and can toggle from using Microsoft managed to using customer-managed keys. There is no additional charge for enabling this feature.

You can enable this feature on any Azure Resource Manager storage account using the Azure portal, Azure PowerShell, Azure CLI, or the Microsoft Azure Storage Resource Provider API.
