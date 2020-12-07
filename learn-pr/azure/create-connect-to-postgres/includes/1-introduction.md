On Azure, hosting and using PostgreSQL is simple. Develop your application with your choice of open-source tools and platform, and let Azure take care of managing virtual machines and infrastructure.

Azure Database for PostgreSQL runs the open-source, community edition of PostgreSQL. This means you can leverage decades of development by the postgres community, and rely on Azure to make hosting a secure database easy.

### Postgres on Azure

Azure Database for PostgreSQL is a fully managed Platform as a Service (PaaS). The main benefit of this configuration is that Azure manages maintenance and security obligations.

Alternatively, PostgreSQL Server workloads can also run as Infrastructure as a Service (IaaS) on either Azure or on-premises servers. These options offer full control over the database engine, should you require it. However, this control comes at the cost of added responsibility for many database administration (DBA) tasks, including:

* Database management
* Applying patches
* Making backups
* Managing virtual machines

With PaaS, you can pass these responsibilities to Azure. Additionally, setting up your database to ensure high availability to another datacenter requires very little hands-on configuration or administration.

#### More control with a flexible server

Some situations will require more granular server control. In these instances, Azure Database for PostgreSQL can be deployed with a flexible server option. A flexible server gives developers more control, while retaining the automation benefits of Azure Database for PostgreSQL, without the complex operational requirements of IaaS.

### Scenario: A new kind of payment app

Throughout this module, we’ll be using an example scenario to explain key PostgreSQL concepts and processes.

In this scenario, you work for Woodgrove Bank, and you’ve been asked to develop a new contactless payment app that works from six feet away. You’ve already created a proof-of-concept app that uses a relational database, hosted on an on-premises server. Development continues, with plans to trial the app in a small city.

You realize the trial will bring many new users and high volumes of new data. The on-premises server could become overloaded, causing slow transaction times or timeout errors. You understand that the database solution must be scaled, both for capacity and performance. For maximum utility and data redundancy, it’s also better to host data in more than one location, which will require a move away from the current on-premises database server - without compromising security.

With this scenario in mind, over the rest of the module, we’ll set up an Azure Database for PostgreSQL instance and connect it to an ASP.NET app for development. We’ll go through the concepts that underlie how we’re going about doing this, and why.

## Prerequisites

* Basic familiarity with relational databases

## Learning objectives

In this module, you will:

* Create an Azure Database for PostgreSQL instance using the Azure portal
* Develop and query the database in the Azure Cloud Shell using pgsql
* Query the PostgreSQL database from an ASP.NET app
