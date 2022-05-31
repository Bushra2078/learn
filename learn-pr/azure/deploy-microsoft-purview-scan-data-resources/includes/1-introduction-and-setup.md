## What is Microsoft Purview?

Microsoft Purview (formerly Azure Purview) is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS), and multi-cloud data. You can use Microsoft Purview to create a comprehensive, up-to-date map of your data landscape that will tell you what kind of data you've stored, and where. You can then use Microsoft Purview to govern this data with automated data discovery, sensitive data classification, end-to-end data lineage, insights reports, and a business glossary. Empower data consumers, data officers, data stewards, experts, and analytics admins to find valuable, trustworthy data and where it's located.

### How does Microsoft Purview benefit an organization?

Microsoft Purview helps chief data officers, data analysts, BI engineers, data stewards, governance experts and admins to answer these kinds of questions:

- What data does my org have?
- Where did this data come from?
- Where is data stored?
- What’s my exposure to risk?
- What is the data being used for?
- Is my data usage compliant?
- How do I control access & use?
- What is required by regulation X (read CELA, HIPAA, etc.)?
- For what business purpose?
- Where is the sensitive data?

## Scenario

The Fabrikam Corp shoe company has expanded rapidly over the last year, going from a handful of employees and a single data lake, to a multi-regional business with data across several platforms. In the expansion, keeping track of what data Fabrikam stores and where has mostly fallen to department heads. Data officers often have to repeat security procedures as new data repositories surface, data experts and officers are flooded with requests for data access and questions about their data. Before the company can go international, Fabrikam needs a solution to help them understand and take command of their full data estate.

Microsoft Purview will allow Fabrikam to register all their data sources, manage access and data discovery by department, and even understand where data comes from and what kind of data it is.

You've been requested to create a small Microsoft Purview proof of concept for Fabrikam, to understand how to deploy Microsoft Purview in their environment and onboard resources.

## What is the main goal?

By the end of this session, you'll have deployed a Microsoft Purview account in your Azure environment, registered an Azure Data Lake Gen 2 Storage Account, and scanned the storage account so Microsoft Purview can classify the data and add the metadata to its data map.

## Prerequisites

In order to follow the hands-on exercises in this module, you'll need the following:

- An [Azure account](https://azure.microsoft.com/free/) with an active subscription. If you don't have one, you can follow the link to create a free one.
- Owner permissions within a Resource Group to create resources and manage role assignments. If you just created your Azure account, you'll have owner permissions already. If you didn't create your subscription, check with your Azure administrator to confirm [you have owner permissions within a resource group](/azure/role-based-access-control/quickstart-assign-role-user-portal).

## Prepare environment

To provide data for Microsoft Purview to classify, we'll set up an ADLS Gen 2 account with some sample data. Follow the steps below to create the resource.

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

1. Select **Create a resource**.
1. Search for and select **Storage account**.
1. Select the **Storage account** plan, and select **Create**.
1. Select an existing resource group, or create a new one.
1. Create a unique storage account name.
1. Select **Standard** performance.
1. Select **Locally-redundant storage**.NET
1. Select **Next: Advanced**.
1. Select **Enable hierarchical namespace**.
1. Select **Review + create**.
1. After validation succeeds, select **Create**.
1. While waiting for you account to deploy, download and install [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/).
1. Open Azure Storage Explorer.
1. Sign in to Azure in Azure Storage Explorer via **View > Account Management > Add an account...**.
1. Select **Subscription**.
1. You'll be directed to the browser to authenticate with Azure. Once that process is complete, go to the **Data Explorer**.
1. Select your subscription, then Storage Accounts, then locate the storage account you created.
1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. Note: This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

1. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking or holding on the file and selecting **Extract All...**.

    :::image type="content" source="../media/02.10-explorer-unzip.png" alt-text="Screenshot of the BingCoronavirusQuerySet zip file with the menu open and Extract All highlighted.":::

1. Select **Extract**.

    :::image type="content" source="../media/02.11-explorer-extract.png" alt-text="Screenshot of the extract menu with the Extract button highlighted.":::

1. In the Azure Storage Explorer, under your storage account, right-click or hold on Blob Containers and select **Create Blob Container**. Name the container **raw**.

    :::image type="content" source="../media/02.12-explorer-container.png" alt-text="Screenshot of the Microsoft Azure Storage Explorer with the storage account highlighted, blob containers selected, and the Create Blob Container option highlighted.":::

1. With the container name selected, select the **Upload** button and select **Upload Folder...**.

    :::image type="content" source="../media/02.13-explorer-upload.png" alt-text="Screenshot of the new container with the upload button selected, and the upload folder option highlighted.":::

1. Select the **ellipsis** to select a folder.

    :::image type="content" source="../media/02.14-explorer-browse.png" alt-text="Screenshot of the upload folder window with the ellipsis button next to the Selected folder line.":::

1. Navigate to the extracted **BingCoronavirusQuerySet** folder (for example, Downloads\BingCoronavirusQuerySet) and select **Select Folder**.

    :::image type="content" source="../media/02.15-explorer-folder.png" alt-text="Screenshot showing folder browser with the BigCoronavirusQuerySet folder being selected from, for example, the downloads folder.":::

1. Select **Upload**.

    :::image type="content" source="../media/02.16-explorer-data.png" alt-text="Screenshot of the upload folder window with BingCoronavirusQuerySet as the selected folder and the upload button highlighted.":::

1. Monitor the **Activities** until the transfer is complete.

    :::image type="content" source="../media/02.17-explorer-transfer.png" alt-text="Screenshot of the activities window with the upload showing as successfully completed.":::