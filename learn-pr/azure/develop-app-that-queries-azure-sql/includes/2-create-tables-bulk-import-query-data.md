Microsoft provides several tools that you can use to upload data to Azure SQL Database. These tools include SQL Server Integration Services (SSIS), the SQL `BULK INSERT` statement, and the Bulk Copy Program (bcp) utility. This unit focuses on `bcp` because it's convenient, and can be easily scripted if you are importing data into multiple tables.

Before you can import data, you must first create a logical database server to host and manage the single database, so this unit also shows you how to create a this database server, and connect to this server to create and use the database.

In this unit, you'll see how to create a single database, and add tables to a database using the Query Editor in the Azure portal. You'll also learn about using the `sqlcmd` utility from the command line to connect to a database. You'll see how to use the `bcp` utility to import data. Finally, you'll learn how to query the data, again using the Query Editor and the `sqlcmd` utility.

## Create a single database using the Azure portal

You can create a single database through several methods, including Azure CLI, Azure PowerShell, and the Azure portal. When creating a single database in the portal, either click the **SQL databases** shortcut under **Favorites**, or click **+ Create a resource**, select **Databases**, and then click **SQL Database**. If you prefer to use the Azure CLI, you can create a server and database with the `az sql server create` and `az sql db create` commands. If you prefer PowerShell, there are a number of cmdlets available.

![Screenshots of the Azure portal, showing the ways to create a new Azure SQL Database](../media/2-create-database.png)

When you create a single database, you'll be prompted for the server to use to manage the database. You can create a new server, or you can select a server that you've created previously.

If you create a new server, you'll be asked to specify a server admin username and password. You use these credentials to connect to the server to perform administrative tasks and access the databases controlled by this server. Azure SQL Database also supports authentication using Azure Active Directory. However, you always have to create an admin account when first creating a new server, and then grant access to accounts stored in Azure Active Directory.

Each database server is protected by a firewall, to block access to potentially malicious processes. You can open the firewall to enable access by other Azure services, and you can selectively enable access to other computers based on their IP address or address range. Azure SQL Server also provides advanced data security, enabling you to specify the sensitivity of data in individual columns in tables, assess the vulnerability of your databases and take the necessary remediation steps, and send alerts when a threat is detected.

You can provision resources using the virtual core (vCore) model, which specifies the resources (memory, I/O, and CPU) to allocate, and enables you to scale compute and storage resources independently. Alternatively, you can assign resources in terms of Database Transaction Units (DTUs). A DTU is a measure of the calibrated cost of the resources required to perform a benchmarked transaction, defined by Microsoft.

If you have a number of databases, and the resource requirements of these databases fluctuate, you can use SQL elastic pool. SQL elastic pool provides a pool of resources that can be shared between pooled databases as demand requires.

One final choice that you make when creating a database is to specify how data should be collated. A collation defines the rules that the database uses for sorting and comparing data, and sets the character set used for text data. You can change the collation after you've created the database, but it is discouraged once the database contains data. For more information see [COLLATE (Transact-SQL)](https://docs.microsoft.com/sql/t-sql/statements/collations?view=sql-server-2017).

## Create tables

You can create tables using the Query Editor in the Azure portal, or from the `sqlcmd` utility. In both cases, you define the table with the `CREATE TABLE` SQL command. Azure SQL Database supports primary keys, foreign keys, indexes, and triggers on tables. The following code shows an example that creates a pair of related tables and a non-clustered index. You can run these commands as a batch in the Query Editor or the `sqlcmd` utility.

```SQL
CREATE TABLE MyTable
(
    MyColumn1 INT NOT NULL PRIMARY KEY,
    MyColumn2 VARCHAR(50) NOT NULL
);

CREATE TABLE MyTable2
(
    AnotherColumn1 INT NOT NULL,
    AnotherColumn2 INT NOT NULL REFERENCES MyTable,
    AnotherColumn3 VARCHAR(50) NULL,
    PRIMARY KEY (AnotherColumn1, AnotherColumn2)
);

CREATE INDEX cci ON MyTable2(AnotherColumn3);
```

To access the Query Editor in the Azure portal, go to the page for your database, and then click **Query editor**. You'll be prompted for your credentials. You can either set the **Authorization type** to **SQL Server authentication** and enter the username and password that you set up when you created the database earlier, or you can select **Active Directory password authentication** and provide the credentials of an authorized user in Azure Active Directory. If Active Directory single sign-on is enabled, you can connect using your Azure identity.

![Screenshot of the Azure SQL Database sign-in page in the Azure portal](../media/2-sign-in-annotated.png)

You enter your SQL code in the query pane, and click **Run** to execute it. If the SQL statement is a query, any rows returned appear in the **Results** pane. The **Messages** pane displays information, such as the number of rows returned, or any errors that might have occurred:

![Screenshot of the Query editor in the Azure portal with the various panes highlighted](../media/2-query-editor-annotated.png)

To use the `sqlcmd` utility, go to the Cloud Shell, and run the following command. Replace `<server>` with the name of the database server that you created, `<database>` with the name of your database, and `<username>` and `<password>` with your credentials.

```bash
sqlcmd -S <server>.database.windows.net -d <database> -U <username> -P <password>
```

If sign-in is successful, you'll see a `1>` prompt. You can enter SQL commands over several lines and run them by typing `GO`.

## Bulk import data with bcp

`bcp` is a command-line utility that you can use to upload data to, and download data from a database. For importing data, `bcp` requires three things:

1. The source data to upload,
2. An existing table in the destination database, and
3. A specification that defines the format of the data and how to map this data to columns in the destination table (a *format* file).

The `bcp` utility is flexible, and the source data can be in almost any format. The format file indicates the layout of the data, whether it's binary or character-based, the type and length of each item, how the data is separated, and so on. The format file also specifies how to map each item in the file to a column in the table. It's important to define the contents of this file correctly, otherwise your data might not be imported, or data could be read into the wrong columns.

Suppose you had the following data in a file named **mydata.csv**, and you want to import this data into the **MyTable** table shown earlier.

```text
Column1,Column2
some text,99
some more text,101
another bit of text,97
yet more text,87
a final bit of text,33
```

The first line contains field names, which aren't the same as the columns in the table. The data is comma-separated, with each row terminated by a newline character. Additionally, the order of the columns is different from that in the table; in the table, the first column is numeric and the second is a string, as shown below:

```SQL
CREATE TABLE MyTable
(
    MyColumn1 INT NOT NULL PRIMARY KEY,
    MyColumn2 VARCHAR(50) NOT NULL
);
```

You can create a format file for import by using the `bcp` command to generate it for you. The `bcp` command can create a format file based on the schema of the target table in the database. You can then edit this file to match the data in the source file.

To generate a format file with `bcp`, run the following command. Replace the items in angle brackets with the values for your database, server, username, and password:

```bash
bcp <database>.dbo.mytable format nul -c -f mytable.fmt -t, -S <server>.database.windows.net -U <username> -P <password>
```

The first argument to the `bcp` command is the fully qualified name of the target table, in the format `<database>.<schema>.<table>`. Unless you created your own schema, tables will be held in the *dbo* schema by default. The `format nul` argument indicates that we're using bcp to generate a format file rather than importing or exporting data. The `-c` flag specifies that we'll be importing data held in a text file (8-bit character data). If your file uses a multi-byte character set, you can specify the `-w` flag instead. If your source data is in binary format, use `-n`. The `-f` flag names the format file to be created. If this file already exists, it will be overwritten. The `-t` flag specifies the field separator in the source file; a comma in this case. The `-S` flag is the Azure SQL Database instance holding the database, and the `-U` and `-P` arguments specify the username and password for connecting to the database server.

If you look at the contents of the **mytable.fmt** format file generated by this command, it will look like this:

```text
14.0
2
1       SQLCHAR             0       12      ","    1     MyColumn1                                ""
2       SQLCHAR             0       50      "\n"   2     MyColumn2                                SQL_Latin1_General_CP1_CI_AS
```

The first line (14.0) is the version of Azure SQL Database. Don't change it. The second line (2) shows the number of columns identified in the source table. The final two lines indicate how to map data in the source file to these columns.

Both lines start with a number. These are the column numbers in the table. The second field (SQLCHAR) specifies that, when we use this format file to import data, each field in the source file contains character data. The `bcp` utility will attempt to convert this data to the appropriate type for the corresponding column in the table. The next field (12 and 50) is the length of the data in each column in the database; again, don't change this. The next items ("," and "\n") are the field terminators in the source file; "\n" represents the newline character. The next column is the field number in the source file. The penultimate field (MyColumn1 and MyColumn2) is the name of the column in the database, and the final field is the collation to use; this field only applies to character data in the database.

Recall that the fields in the source file are in a different order to the columns in the database. Therefore, you should edit the format file, and change the field numbers, as shown below:

```text
14.0
2
1       SQLCHAR             0       12      ","    2     MyColumn1                                ""
2       SQLCHAR             0       50      "\n"   1     MyColumn2                                SQL_Latin1_General_CP1_CI_AS
```

Now the data in field 2 in the source file will be mapped to the first column in the database, and field 1 will be mapped to the second column.

We can now use the `bcp` command to import the data, as follows:

```bash
bcp <database>.dbo.mytable in mydata.csv -f mytable.fmt -S <server>.database.windows.net -U <username> -P <password> -F 2
```

The `in` flag specifies that we're using `bcp` to import data; you can use `out` to transfer data from a database to a file. The `-F 2` flag indicates that the import operation should start at line 2 of the source file. Remember, the first line contains headers rather than data.

The command should run successfully, with messages similar to these:

```text
Starting copy...

5 rows copied.
Network packet size (bytes): 4096
Clock Time (ms.) Total     : 46     Average : (108.7 rows per sec.)
```

The important line is `5 rows copied`. This was the number of lines in the source file that contain data that was imported. If this number is different (or zero), then your format file is incorrect.

## Query data

You can verify that the import was successful by querying the data. You can use the Query Editor from the Azure portal, or you can connect to the database from the command line with the `sqlcmd` utility. In either case, you can run a `SELECT` statement such as this:

```SQL
SELECT *
FROM MyTable;
```

You should see the following results.

![Screenshot of the Query editor in the Azure portal showing the results of the query](../media/2-query-results-annotated.png)