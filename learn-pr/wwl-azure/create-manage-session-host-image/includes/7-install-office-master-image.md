This unit tells you how to install Microsoft 365 Apps for enterprise, OneDrive, and other common applications on a master virtual hard disk (VHD) image for upload to Azure. If your users need to access certain line of business (LOB) applications, we recommend you install them after completing the instructions in this article.

> [!NOTE]
> This unit assumes you've already created a virtual machine (VM).

> [!NOTE]
> This unit assumes you have elevated access on the VM, whether it's provisioned in Azure or Hyper-V Manager. If not, see [Elevate access to manage all Azure subscription and management groups](/azure/role-based-access-control/elevate-access-global-admin).

## Install Office in shared computer activation mode

Shared computer activation allows deployment of Microsoft 365 Apps for enterprise to a computer that is accessed by multiple users.

Use the [Office Deployment Tool](https://www.microsoft.com/download/details.aspx?id=49117) to install Office. Windows 10 Enterprise multi-session only supports the following versions of Office:

 -  Microsoft 365 Apps for enterprise
 -  Microsoft 365 Apps for business that comes with a Microsoft 365 Business Premium subscription

The Office Deployment Tool requires a configuration XML file. To customize the following sample, see the [Configuration Options for the Office Deployment Tool](/deployoffice/configuration-options-for-the-office-2016-deployment-tool/).

This sample configuration XML we've provided will do the following things:

 -  Install Office from the Monthly Enterprise Channel and deliver updates from the Monthly Enterprise Channel.
 -  Use the x64 architecture.
 -  Disable automatic updates.
 -  Remove any existing installations of Office and migrate their settings.
 -  Enable shared computer activation.

> [!NOTE]
> Shared Computer Activation can be set up through Group Policy Objects (GPOs) or registry settings. The GPO is located at Computer Configuration\\Policies\\Administrative Templates\\Microsoft Office 2016 (Machine)\\Licensing Settings

The Office Deployment Tool contains setup.exe. To install Office, run the following command in a command line:

```
Setup.exe /configure configuration.xml

```

#### Sample configuration.xml

The following XML sample will install the Monthly Enterprise Channel release.

```
<Configuration>
<Add OfficeClientEdition="64" Channel="MonthlyEnterprise">
<Product ID="O365ProPlusRetail">
<Language ID="en-US" />
<Language ID="MatchOS" />
<ExcludeApp ID="Groove" />
<ExcludeApp ID="Lync" />
<ExcludeApp ID="OneDrive" />
<ExcludeApp ID="Teams" />
</Product>
</Add>
<RemoveMSI/>
<Updates Enabled="FALSE"/>
<Display Level="None" AcceptEULA="TRUE" />
<Logging Level="Standard" Path="%temp%\WVDOfficeInstall" />
<Property Name="FORCEAPPSHUTDOWN" Value="TRUE"/>
<Property Name="SharedComputerLicensing" Value="1"/>
</Configuration>
```

After installing Office, you can update the default Office behavior. Run the following commands individually or in a batch file to update the behavior.

```
rem Mount the default user registry hive
reg load HKU\TempDefault C:\Users\Default\NTUSER.DAT
rem Must be executed with default registry hive mounted.
reg add HKU\TempDefault\SOFTWARE\Policies\Microsoft\office\16.0\common /v InsiderSlabBehavior /t REG_DWORD /d 2 /f
rem Set Outlook's Cached Exchange Mode behavior
rem Must be executed with default registry hive mounted.
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v enable /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v syncwindowsetting /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSetting /t REG_DWORD /d 1 /f
reg add "HKU\TempDefault\software\policies\microsoft\office\16.0\outlook\cached mode" /v CalendarSyncWindowSettingMonths  /t REG_DWORD /d 1 /f
rem Unmount the default user registry hive
reg unload HKU\TempDefault

rem Set the Office Update UI behavior.
reg add HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate /v hideupdatenotifications /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate /v hideenabledisableupdates /t REG_DWORD /d 1 /f
```

## Install OneDrive in per-machine mode

OneDrive is normally installed per-user. In this environment, it should be installed per-machine.

Here's how to install OneDrive in per-machine mode:

1.  First, create a location to stage the OneDrive installer. A local disk folder or`[\\unc] (file://unc)` location is fine.
2.  Download [OneDriveSetup.exe](https://go.microsoft.com/fwlink/?linkid=844652) to your staged location.
3.  If you installed Office with OneDrive by omitting **&lt;ExcludeApp ID="OneDrive" /,** uninstall any existing OneDrive per-user installations from an elevated command prompt by running the following command:
    
    ```
    "[staged location]\OneDriveSetup.exe" /uninstall
    ```
4.  Run this command from an elevated command prompt to set the AllUsersInstall registry value:
    
    ```
    REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64
    ```
5.  Run this command to install OneDrive in per-machine mode:
    
    ```
    Run "[staged location]\OneDriveSetup.exe" /allusers
    ```
6.  Run this command to configure OneDrive to start at sign in for all users:
    
    ```
    REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe /background" /f
    ```
7.  Enable Silently configure user account by running the following command.
    
    ```
    REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f
    ```
8.  Redirect and move Windows known folders to OneDrive by running the following command.
    
    ```
    REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "KFMSilentOptIn" /t REG_SZ /d "<your-AzureAdTenantId>" /f
    ```
