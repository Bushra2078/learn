Azure storage provides a safe and secure repository for your application data. If access to the data is critical to the well-being of a system, you also need to make sure it's also highly available. To achieve this goal, you should use geo-redundant storage. Using geo-redundant storage ensures high-availability by storing synchronized copies of the data in different Azure regions. If connectivity to an Azure region fails, you can fail over to an accessible region and still access your data.

Imagine you're the solution architect for the healthcare organization, your role is to work with the developers to develop an application that allows clinicians in the field to upload images from visits with patients. These images contain important clinical information, and these images need to be available even if an Azure region fails. They would like to use built-in capabilities that Azure provides for storage replication.  Your goal is to ensure that the system being deployed will be highly available and accessible to the staff at all times. but at the same time ensuring that the environment is secure.

You'll use read-access-geo-redundant storage to make your application and data highly available.

## Learning objectives

In this module, you will:

- Identify the features of RA-GRS storage.
- Identify the application design considerations when using RA-GRS.
- Implement the circuit breaker pattern in a sample application.

## Prerequisites

- Basic knowledge of Azure Storage accounts
- Familiarity with C#
- Ability to install software locally (Visual Studio, Fiddler, Git)
