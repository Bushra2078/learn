In this exercise, you will learn how to monitor and troubleshoot a performance problem with Azure SQL using familiar and new tools and capabilities.

### Set up: Use scripts to deploy Azure SQL Database

In the right-hand terminal, you'll see the Azure Cloud Shell, which is a way to interact with Azure using a browser. Before you start the labs, you will run a script there in order to create your environment, an Azure SQL Database with the AdventureWorks database. In the script, you will be prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

This script should take 3-5 minutes to complete. Make sure to note your password, unique ID, and region as it will not be shown again.

1. Start by obtaining your local IP address. Ensure you are disconnected from any VPN service and open a local PowerShell terminal on your device. Run the following command and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

1. Next, run the following commands in the Azure Cloud Shell on the right. Fill in a complex password and enter your local public IP address you retrieved when prompted.

    ```powershell
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    # Get resource group and location and random string
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like "<rgn>Sandbox resource group name</rgn>"
    $resourceGroupName = "<rgn>Sandbox resource group name</rgn>"
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $storageAccountName = "mslearnsa"+$uniqueID
    $location = $resourceGroup.Location
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    ```

1. Output and store (in a text file or similar) the information you'll need throughout the module by running the following script in the Azure Cloud Shell.  You'll likely need to press `ENTER` after you paste in the code, as the last line will not be run by default.

    ```powershell
    Write-Host "Please note your unique ID for future exercises in this module:"  
    Write-Host $uniqueID
    Write-Host "Your resource group name is:"
    Write-Host $resourceGroupName
    Write-Host "Your resources were deployed in the following region:"
    Write-Host $location
    Write-Host "Your server name is:"
    Write-Host $serverName
    ```

    > [!TIP]
    > Don't forget to note your password, unique ID, and server. You will need these items throughout the module.**

1. Run the following script to deploy an Azure SQL Database and logical server with the AdventureWorks sample. This script will also add your IP address as a firewall rule, enable Advanced Data Security, and create a storage account for use in future units (this is to be consistent with other units).

    ```powershell
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    # The sample database name
    $databaseName = "AdventureWorks"
    # The storage account name has to be unique in the system
    $storageAccountName = $("sql$($uniqueID)")
    # Create a new server with a system wide unique server name
    $server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -Location $location `
        -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
    # Create a server firewall rule that allows access from the specified IP range and all Azure services
    $serverFirewallRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress $ipAddress -EndIpAddress $ipAddress 
    $allowAzureIpsRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -AllowAllAzureIPs
    # Create a database
    $database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -DatabaseName $databaseName `
        -SampleName "AdventureWorksLT" `
        -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5"
    # Enable Advanced data security
    $advancedDataSecurity = Enable-AzSqlServerAdvancedDataSecurity `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName
    # Create a Storage Account
    $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
        -AccountName $storageAccountName `
        -Location $location `
        -Type "Standard_LRS"
    ```

1. On your local device, open SSMS and create a new connection to your logical server.  

    For server name, input the name of your Azure SQL Database logical server that was displayed from the Cloud Shell, for example *aw-server`<unique ID>`.database.windows.net*.

    Change the authentication to **SQL Server Authentication**, and input the corresponding login and password you provided for the script.  

    Select **Remember password** and select **Connect**.  

    :::image type="content" source="../media/5-connect-azure-sql.png" alt-text="Connect to SQL Database in SSMS"::: 

    > [!NOTE]
    > Depending on your local configuration (e.g. VPN), your client IP address may differ from the IP address the Azure portal used during deployment. If it does, you'll get a pop-up which reads "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign-in using the account you're using for the sandbox, and add a firewall rule for your client IP address. You can complete all of these steps using the pop-up wizard in SSMS.  

## Prepare the exercise by loading and editing scripts

All scripts for this exercise can be found in the folder *04-Performance\monitor_and_scale* in the GitHub repository or zip file you downloaded. Let's prepare the exercise by loading and editing scripts.

1. In SSMS, click the AdventureWorks database in Object Explorer. Then select the File menu and Open to load the **dmexecrequests.sql** script. Your query editor window should look like the following text:

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

1. Use the same method in SSMS to load the **dmdbresourcestats.sql** script. A new query editor window should look like the following text:

    ```sql
    SELECT * FROM sys.dm_db_resource_stats;
    ```

    This DMV will track overall resource usage of your workload against Azure SQL Database such as CPU, I/O, and memory.

1. Edit the script **sqlworkload.cmd** (which will use the ostress.exe program)

    - Substitute your unique_id you saved from the deployment script to put in the correct server name.
    - Substitute the password for the login for the Azure SQL Database Server for the **-P parameter**.

## Run the workload

Now you will run a workload of a T-SQL query to observe its performance simulating concurrent users.

1. Use SSMS to open up the script file **topcustomersales.sql** to observe the query. You will not run the query from SSMS. Your query editor window should look like the following text:

    ```sql
    DECLARE @x int
    DECLARE @y float
    SET @x = 0;
    WHILE (@x < 10000)
    BEGIN
    SELECT @y = sum(cast((soh.SubTotal*soh.TaxAmt*soh.TotalDue) as float))
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
    INNER JOIN SalesLT.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN SalesLT.Product p
    ON p.ProductID = sod.ProductID
    GROUP BY c.CompanyName
    ORDER BY c.CompanyName;
    SET @x = @x + 1;
    END
    GO
    ```

    This database is not large so the query to retrieve customer and their associated sales information ordered by customers with the most sales shouldn't generate a large result set. It is possible to tune this query by reducing the number of columns from the result set but these are needed for demonstration purposes of this exercise.

1. From a PowerShell command prompt, change to the directory for this exercise:

    ```powershell
    cd <base directory>\04-Performance\monitor_and_scale
    ```

1.  Run the workload with the following command

    ```powershell
    .\sqlworkload.cmd
    ```

    This script will use 10 concurrent users running the workload query two times. Notice the script itself runs a single batch but loops 10,000 times. It also assigned the result to a variable therefore eliminating almost all result set traffic to the client. This is not necessary but helps show a "pure" CPU workload run all on the server.

    > [!TIP]
    > If you are not seeing CPU usage behavior with this workload for your environment you can adjust the **-n parameter** for number of users and **-r parameter** for iterations.

    Your screen at the command prompt should look similar to the following output:

    ```output
    [datetime] [ostress PID] Max threads setting: 10000
    [datetime] [ostress PID] Arguments:
    [datetime] [ostress PID] -S[server].database.windows.net
    [datetime] [ostress PID] -isqlquery.sql
    [datetime] [ostress PID] -U[user]
    [datetime] [ostress PID] -dAdventureWorks
    [datetime] [ostress PID] -P********
    [datetime] [ostress PID] -n10
    [datetime] [ostress PID] -r2
    [datetime] [ostress PID] -q
    [datetime] [ostress PID] Using language id (LCID): 1024 [English_United States.1252] for character formatting with NLS: 0x0006020F and Defined: 0x0006020F
    [datetime] [ostress PID] Default driver: SQL Server Native Client 11.0
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_1.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_2.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_3.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_4.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_5.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_6.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_7.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_8.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_9.out]
    [datetime] [ostress PID] Starting query execution...
    [datetime] [ostress PID]  BETA: Custom CLR Expression support enabled.
    [datetime] [ostress PID] Creating 10 thread(s) to process queries
    [datetime] [ostress PID] Worker threads created, beginning execution...
    ```

## Observe performance of the workload

Let's now use the DMV queries you loaded earlier to observe performance.

1. Run the query in SSMS you previously loaded to monitor dm_exec_requests (**dmexecrequests.sql**) to observe active requests. Run this query five or six times and observe some of the results

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

    You should see many of the requests have a status = RUNNABLE and last_wait_type = SOS_SCHEDULER_YIELD. One indicator of many RUNNABLE requests and many SOS_SCHEDULER_YIELD waits is a possible lack of CPU resources for active queries.

    > [!NOTE]
    > You may see one or more active requests with a command = SELECT and a wait_type = XE_LIVE_TARGET_TVF. These are queries run by services managed by Microsoft to help power capabilities like Performance Insights using Extended Events. Microsoft does not publish the details of these Extended Event sessions.

    Leave this query editor window open as you will run it again in the next exercise.

1. Run the query in SSMS you previously loaded to monitor **sys.dm_db_resource_stats** (**dmdbresourcestats.sql**). Run the query to see the results of this DMV three or four times.

    ```sql
    SELECT * FROM sys.dm_db_resource_stats;
    ```

    This DMV records of snapshot of resource usage for the database every 15 seconds (kept for 1 hour).  You should see the column **avg_cpu_percent** close to 100% for several of the snapshots. (at least in the high 90% range). This is a symptom of a workload pushing the limits of CPU resources for the database.

    For a SQL Server on-premises environment, you would typically use a tool specific to the Operating System like Windows Performance Monitor to track overall resource usage such a CPU. If you ran this example on a on-premises SQL Server or SQL Server in a Virtual Machine with 2 CPUs, you would see near 100% CPU utilization on the server.

    > [!NOTE]
    > Another DMV called, **sys.resource_stats**, can be run in the context of the master database of the Azure Database Server to see resource usage for all Azure SQL Database databases associated with the server. This view is less granular and shows resource usage every 5 minutes (kept for 14 days).

    Leave this query editor window open as you will run it again in the next exercise.

1. Let the workload complete and take note of its overall duration. When the workload completes, you should see results like the following output and a return to the command prompt

    ```output
    [datetime] [ostress PID] Total IO waits: 0, Total IO wait time: 0 (ms)
    [datetime] [ostress PID] OSTRESS exiting normally, elapsed time: 00:01:22.637
    ```

    Your duration time may vary but this typically takes at least 1-3 minutes. Make sure to let this run to completion. When the workload is done, you will be put back at the command prompt.

## Use the Query Store for further analysis

Query Store is a capability in SQL Server to track performance execution of queries. Performance data is stored in the user database. Query Store is not enabled by default for databases created in SQL Server but is on by default for Azure SQL Database (and Azure SQL Managed Instance).

Query Store comes with a series of system catalog views to view performance data. SQL Server Management Studio (SSMS) provides reports using these views.

1. Using the Object Explorer in SSMS, open the Query Store Folder to find the report for **Top Resource Consuming Queries**

    :::image type="content" source="../media/5-ssms-find-top-queries.png" alt-text="SSMS_QDS_Find_Top_Queries":::

1. Select the report to find out what queries have consumed the most average resources and execution details of those queries. Based on the workload run to this point, your report should look something like the following image:

    :::image type="content" source="../media/5-ssms-top-query-report.png" alt-text="SSMS_QDS_Top_Query_Report":::

    The query shown is the SQL query from the workload for customer sales. This report has three components: Queries with the high total duration (you can change the metric), the associated query plan and runtime statistics, and the associated query plan in a visual map.

1. Click on the bar chart for the query (the query_id may be different for your system), your results should look like the following image:

    :::image type="content" source="../media/5-ssms-query-id.png" alt-text="SSMS_QDS_Query_ID":::

    You can see the total duration of the query and query text.

1. Right of this bar chart is a chart for statistics for the query plan associated with the query. Hover over the dot associated with the plan. Your results should look like the following image:

    :::image type="content" source="../media/5-ssms-slow-query-stats.png" alt-text="SSMS_Slow_Query_Stats":::

    Note the average duration of the query. Your times may vary but the key will be to compare this average duration to the average wait time for this query and eventually a different average duration when we introduce a performance improvement.

1. The final component is the visual query plan. The query plan for this query looks like the following image:

    :::image type="content" source="../media/5-ssms-workload-query-plan.png" alt-text="SSMS_Workload_Query_Plan":::

    Given the small number of rows in the tables in this database, this query plan is not inefficient. There could be some tuning opportunities but not much performance will be gained by tuning the query itself. You may see a warning in the plan for lack of statistics for one of the columns in the query for the Clustered Index Seek but it does not have a factor in overall performance (and is not in the actual execution plan since statistics are created automatically for the column that generated the warning).

1. Below the Top Resource Consuming Queries report in SSMS is a report called Query Wait Statistics. We know from earlier diagnostics that a high number of requests constantly were in a RUNNABLE status along with almost 100% CPU. Query Store comes with reports to look at possible performance bottlenecks to due waits on resources. Click on this report and hover over the bar chart. Your results should look like the following image:

    :::image type="content" source="../media/5-ssms-top-wait-stats.png" alt-text="SSMS_Top_Wait_Stats":::

    You can see the top wait category is CPU (this is equivalent to the wait_type SOS_SCHEDULER_YIELD, which can be seen in **sys.dm_os_wait_stats**) and the average wait time.

1. Click on the CPU bar chart in the report. The top query waiting for CPU is the query from the workload we are using.

    :::image type="content" source="../media/5-ssms-top-wait-stats-query.png" alt-text="SSMS_Top_Wait_Stats_Query":::

    Notice that the average wait time for CPU for this query is a high % of the overall average duration for the query.

    Given the evidence to this point, without any query tuning, our workload requires more CPU capacity than we have deployed for our Azure SQL Database.

1. You can close both Query Store reports for now. You will use the same reports in the next exercise.

## Observing performance with Azure Monitor

Let's use one other method to view the resource usage of our workload. Azure Monitor provides performance metrics which you can view in various methods including Azure portal.

1. Navigate to the Azure portal for your deployment. Find the Azure SQL Database deployed. In the Overview page for an Azure SQL database, the standard default view in the Monitoring pane is called **Compute Utilization**:

    :::image type="content" source="../media/5-azure-portal-compute-slow-query.png" alt-text="Azure_Portal_Compute_Slow_Query":::

    Notice in this example, the CPU utilization is near 100% for a recent time range. This chart will show resource usage (defaults to CPU and I/O) over the last hour and is refreshed continually. If you click on the chart, you can customize the chart (Ex. bar chart) and look at other resource usage.

1. Click on Metrics in the Resource menu. Another method to see the same compute utilization metrics and others automatically collected by Azure Monitor for Azure SQL Database is to use the **Metrics Explorer** under Monitoring from the Resource pane in the portal (The Compute Utilization is a just a pre-defined view of the Metrics Explorer). If you click on Metrics, you will see the following results:

    :::image type="content" source="../media/5-azure-monitor-metrics.png" alt-text="Azure_Monitor_Metrics":::

    As you can see in the screenshot, there are several metrics you can use to view with  Metrics Explorer. The default view of Metrics Explorer is for a 24-hour period showing a give minute granularity. The Compute Utilization view is the last hour with a one minute granularity (which you can change). To see the same view, select CPU percentage and change the capture for 1 hour. The granularity will change to one minute and should look like the following image:

    :::image type="content" source="../media/5-azure-monitor-metrics-cpu.png" alt-text="Azure_Monitor_Metrics_CPU_1minrefresh":::

    The default is a line chart, but the Explorer view allows you to change the chart type. There are various options with Metrics Explorer including the ability to show multiple metrics on the same chart.

## Azure Monitor Logs

In this exercise, you did not setup an Azure Monitor Log (mainly because there is a delay in metrics information appearing in the log) but it is worth looking at what a log may look like for a CPU resource usage scenario. Azure Monitor Logs can provide a much longer historical record than Azure Metrics.

If you had configured Azure Monitor Logs with a Log Analytics workspace (this is for later study on your own), you could use the following **Kusto Query** to see the same type of results for CPU utilization for the database:

```kusto
AzureMetrics
| where MetricName == 'cpu_percent'
| where Resource == "ADVENTUREWORKS"
| project TimeGenerated, Average
| render columnchart
```

Your results would look like the following image:

:::image type="content" source="../media/5-kusto-query-metric-cpu-percent.png" alt-text="kusto_query_metric_cpu_percent":::

Azure Monitor Logs have a delay when first configuring log diagnostics for a database so these results may take some time to appear.

In this exercise, you learned how to observe a common SQL performance scenario and dive into details to decide on a possible solution to improve performance. In the next unit, you will learn methods to accelerate and tune performance.