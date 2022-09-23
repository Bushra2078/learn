Azure Cloud Shell is an interactive, authenticated, browser-accessible shell for managing Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work, either Bash or PowerShell.

## Features

### Browser-based shell experience

Cloud Shell enables access to a browser-based command-line experience built with Azure management tasks in mind. Use Cloud Shell to work untethered from a local machine in a way only the cloud can provide.

### Choice of preferred shell experience

Users can choose between Bash or PowerShell.

### Authenticated and configured Azure workstation

Cloud Shell is managed by Microsoft so it comes with popular command-line tools and language support. Cloud Shell also securely authenticates automatically for instant access to your resources through the Azure CLI or Azure PowerShell cmdlets.

### Integrated Cloud Shell editor

Cloud Shell offers an integrated graphical text editor based on the open-source Monaco Editor. Easily create and edit configuration files by running `code .` for seamless deployment through Azure CLI or Azure PowerShell.

### Integrated with Microsoft Learn

You can use Cloud Shell directly in [Microsoft Learn](/?azure-portal=true), [Azure PowerShell](/powershell/azure/overview), and [Azure CLI documentation](/cli/azure). Click on the "Try It" button in a code snippet to open the immersive shell experience.

### Multiple access points

Cloud Shell is a flexible tool that can be used from:

- [portal.azure.com](https://portal.azure.com)
- [shell.azure.com](https://shell.azure.com)
- [Azure CLI documentation](/cli/azure)
- [Azure PowerShell documentation](/powershell/azure/overview)
- [Azure mobile app](https://azure.microsoft.com/features/azure-portal/mobile-app/)
- Visual Studio Code Azure Account extension

### Connect your Microsoft Azure files storage

Cloud Shell machines are temporary, but your files are persisted in two ways: through a disk image, and through a mounted file share named `clouddrive`. On first launch, Cloud Shell prompts to create a resource group, storage account, and Azure Files share on your behalf. This is a one-time step and will be automatically attached for all sessions. A single file share can be mapped and will be used by both Bash and PowerShell in Cloud Shell.

> [!NOTE]
> Azure storage firewall is not supported for Cloud Shell storage accounts.

## Concepts

- Cloud Shell runs on a temporary host provided on a per-session, per-user basis.
- Cloud Shell times out after 20 minutes without interactive activity.
- Cloud Shell requires an Azure file share to be mounted.
- Cloud Shell uses the same Azure file share for both Bash and PowerShell.
- Cloud Shell is assigned one machine per user account.
- Cloud Shell persists $HOME using a 5-GB image held in your file share.
- Permissions are set as a regular Linux user in Bash.

## Pricing

The machine hosting Cloud Shell is free, with a pre-requisite of a mounted Azure Files share. Regular storage costs apply.
