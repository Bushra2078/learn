Imagine you're a Java developer working for a company that creates Quarkus applications. The applications currently run on on-premises servers. Your applications also integrate with a relational database (in this case, PostgreSQL).

You want to build a to-do list application that uses a PostgreSQL database. You've decided to build this Quarkus application from scratch.

In this module, you'll first scaffold a Quarkus web application by using the Quarkus Maven plugin. The Quarkus Maven plugin generates a Quarkus project that includes just what you need to start quickly. This scaffold gives you a base to work from.

You'll then code a to-do application that stores tasks in a relational database. The tasks will need a PostgreSQL database, so you'll create and host by using Azure Database for PostgreSQL.

Next you'll build the application and also configure it to connect to the PostgreSQL database. Before you deploy, you'll confirm the application can run locally. You'll then deploy through Azure CLI and host on Azure Container Apps .

By the end of this module, you'll be able to incorporate Quarkus applications into Azure Container Apps and integrate with a relational database.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you finish this module.

## Learning objectives

By the end of this module, you'll be able to:

- Develop a Quarkus application.
- Connect your application to a PostgreSQL database.
- Deploy the web application to Azure Container Apps.

## Prerequisites

As a Java developer, you're already familiar with Java applications. Quarkus will be explained as you follow along. As you complete the exercises in this module, you'll use a personal Azure account. Make sure that you've the following resources:
  
- An Azure subscription
- Local installations of Java JDK (11 or later), Maven (3.8 or later), and the Azure CLI (2.43 or later)
- Docker and Docker Desktop
