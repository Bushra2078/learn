In this section, you'll deploy your application to Azure App Service.

## What is Azure App Service

Azure provides Azure App Service as a Platform as a Service for running Tomcat.
It features a Window and Linux environment, security, load balancing, autoscaling, and DevOps integration.
You can leave the OS and Tomcat management to Azure, and concentrate on building applications.

:::image type="content" source="../media/app-service-portal-screen.png" alt-text="Azure portal Screen":::


## Get Sample JSF Applications

In order to deploy a Java Web Application, you can get a PrimeFaces JSF Web Application from GitHub as below.

```bash
git clone https://github.com/yoshioterada/Deploy-PrimeFaces-JSF-Web-App-on-Tomcat-9.0
```

Then you will see following files in the directory:

```
Deploy-PrimeFaces-JSF-Web-App-on-Tomcat-9.0
├── pom.xml
└── src
    └── main
        ├── java
        │   └── com
        │       └── microsoft
        │           └── azure
        │               └── samples
        │                   ├── controller
        │                   │   └── TodoListController.java
        │                   ├── dao
        │                   │   ├── ItemManagement.java
        │                   │   └── TodoItemManagementInMemory.java
        │                   └── model
        │                       └── TodoItem.java
        └── webapp
            ├── META-INF
            │   └── context.xml
            ├── WEB-INF
            │   ├── beans.xml
            │   ├── classes
            │   │   └── logging.properties
            │   ├── faces-config.xml
            │   └── web.xml
            └── index.xhtml
```

## Maven Plugin for Azure App Service

Microsoft provides the `Maven Plugins for Azure Services` to make it easier for Java developers to deploy applications to Azure.
By using this plugin, you can easily configure and deploy your application to Azure.
Execute the following command to use `Maven Plugin for Azure App Service`.

### Configure Maven Plugin for Azure App Service

To configure the `Maven Plugin for Azure App Service`, execute the following command:

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
```

After the command, some question will be displayed at the prompt, so enter and select the appropriate items and set them. Enter the following options:

|  Item  |  Input value  |
| ---- | ---- |
|  Subscription  |  Choose the right subscription |
|  Define value for OS  |  1: Linux |
|  Define value for pricingTier | P1v2 |
|  Define value for Java Version  |  1: Java 8 or 2: Java 11 |
|  Define value for Runtime Stack  |  3: TOMCAT 9.0 |
|  Confirm (Y/N)  |  Y |

After you execute the command, the results will be displayed:

```bash
mvn com.microsoft.azure:azure-webapp-maven-plugin:1.12.0:config
Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8
[INFO] Scanning for projects...
[INFO]
[INFO] -----------< com.microsoft.azure.samples:azure-javaweb-app >------------
[INFO] Building azure-javaweb-app Maven Webapp 1.0-SNAPSHOT
[INFO] --------------------------------[ war ]---------------------------------
[INFO]
[INFO] --- azure-webapp-maven-plugin:1.12.0:config (default-cli) @ azure-javaweb-app ---

Available subscriptions:
* 1: My Subscription (********-****-****-****-************)
Please choose a subscription [My Subscription]: [Enter]
[INFO] It may take a few minutes to load all Java Web Apps, please be patient.
[WARNING] There are no Java Web Apps in current subscription, please follow the following steps to create a new one.
Define value for OS [Linux]:
* 1: Linux
  2: Docker
  3: Windows
Enter your choice:
Define value for pricingTier [P1v2]:
   1: B1
   2: B2
   3: B3
   4: D1
   5: F1
*  6: P1v2
   7: P2v2
   8: P3v2
   9: S1
  10: S2
  11: S3
Define value for javaVersion [Java 8]:
* 1: Java 8
  2: Java 11
Enter your choice: 1
Define value for runtimeStack:
  1: Jbosseap 7.2
* 2: Tomcat 8.5
  3: Tomcat 9.0
Enter your choice: 3
Please confirm webapp properties
Subscription Id : f77aafe8-6be4-4d3d-bd9c-d0c37687ef70
AppName : azure-javaweb-app-1604982052600
ResourceGroup : azure-javaweb-app-1604982052600-rg
Region : westeurope
PricingTier : PremiumV2_P1v2
OS : Linux
Java : Java 8
Web server stack: Tomcat 9.0
Deploy to slot : false
Confirm (Y/N) [Y]: y
[INFO] Saving configuration to pom.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  37.656 s
[INFO] Finished at: 2020-10-01T17:24:02+09:00
[INFO] ------------------------------------------------------------------------
```

You'll see a new section in the `<plugins>` section in your `pom.xml` file.

If you want to change the resource group name, instance name, and deployment location, change `<resourceGroup>`, `<appName>`, and `<region>`.

```xml
    <plugins>
      <plugin>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-webapp-maven-plugin</artifactId>
        <version>1.12.0</version>
        <configuration>
          <schemaVersion>V2</schemaVersion>
          <subscriptionId>********-****-****-****-************</subscriptionId>
          <resourceGroup>azure-javaweb-app</resourceGroup>
          <appName>azure-javaweb-app-1601463451101</appName>
          <pricingTier>P1v2</pricingTier>
          <region>japaneast</region>
          <runtime>
            <os>linux</os>
            <javaVersion>Java 8</javaVersion>
            <webContainer>TOMCAT 9.0</webContainer>
          </runtime>
          <deployment>
            <resources>
              <resource>
                <directory>${project.basedir}/target</directory>
                <includes>
                  <include>*.war</include>
                </includes>
              </resource>
            </resources>
          </deployment>
        </configuration>
      </plugin>
    </plugins>
```

### Compile & Deploy to Azure  App Services

Now that the settings for deploying to Azure App Services are complete, compile the source code again:

```bash
mvn clean package
```

Once compiled, use the `Maven Plugin for Azure Web Apps` command to deploy your application.
Execute the following command:

```bash
mvn azure-webapp:deploy
```

When the deployment is completed, the following message will be output.

```text
[INFO] Successfully deployed the artifact to https://azure-javaweb-app-1601463451101.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:15 min
[INFO] Finished at: 2020-11-19T15:55:55+09:00
[INFO] ------------------------------------------------------------------------
```

The public URL of the deployed application is displayed in `Successfully deployed the artifact to`.
 Access your URL with a browser.

`https://azure-javaweb-app-1601463451101.azurewebsites.net`

:::image type="content" source="../media/deployed-to-the-appservices.png" alt-text="Deployed Web App on Azure App Services":::

## Confirm the Log Stream from Command Line

To access the Log Stream, execute the following CLI command:

```azurecli
az webapp log tail -g azure-javaweb-app -n azure-javaweb-app-1601463451101
```

Then you can see the following result:

:::image type="content" source="../media/azure-cli-log-stream.png" alt-text="Execution of the Log Stream":::

## Completed the Exercise

In this module, you learned how to create and package a Java Web application, how to use the `Maven Plugin for Azure Web Apps` and deploy your application to Azure App Service. These steps are applicable not only for JSF applications but also most Java Web applications.
