In this unit, you use Azure Cloud Shell on the right as your Linux terminal. You can access Cloud Shell through the Azure portal or at the [Cloud Shell sign-in](https://shell.azure.com). You don't have to install anything on your PC or laptop to use it.

To make sure your system is set up to work in PowerShell, run a command to verify your installation.

1. Enter `$PSVersionTable`, and then select the **Enter** key.

   ```powershell
   $PSVersionTable
   ```

    Your output resembles the following text:

   ```output
    Name                           Value
    ----                           -----
    PSVersion                      7.0.3
    PSEdition                      Core
    GitCommitId                    7.0.3
    OS                             Darwin 17.7.0 Darwin Kernel Version 17.7.0: Fri Jul  6 19:54:51 PDT 2018; root:xnu-4570.71.3…
    Platform                       Unix
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0
   ```

   The output is formatted as a table. It provides information about your version of PowerShell and also your platform and edition.

    For more information about your version of PowerShell, you can run a modified version of `$PSVersionTable`.

1. Enter `$PSVersionTable.PSVersion`, and then select the **Enter** key.

   ```powershell
   $PSVersionTable.PSVersion
   ```

    Your output now resembles this text:

    ```output
    Major  Minor  Patch  PreReleaseLabel BuildLabel
    -----  -----  -----  --------------- ----------
    7      0      3  
    ```

    This output gives you more details about your version of PowerShell.

Running `$PSVersionTable` results in output that looks like a table but is actually an object. For this reason, you can use a period (`.`) to access a specific property like `PSVersion`.
