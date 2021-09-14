In this unit, you'll use Azure Cloud Shell as a Linux terminal. You also can access the Cloud Shell through the Azure portal or at [Cloud Shell sign-in](https://shell.azure.com). You don't need to install anything on your PC or laptop to use the Azure Cloud Shell.

Before beginning this exercise, be sure to activate the sandbox.

1. Run the following command to verify that your system is set up to use PowerShell. The `$PSVersionTable` verifies your installation. Copy the following command and paste it into the Azure Cloud Shell on the right, and then press <kbd>Enter</kbd>.

   ```powershell
   $PSVersionTable
   ```

    Your output resembles the following table:

   ```output
    Name                           Value
    ----                           -----
    PSVersion                      7.1.4
    PSEdition                      Core
    GitCommitId                    7.1.4
    OS                             Linux 5.4.0-1058-azure #60~18.04.1-Ubuntu SMP Tue Aug 31 20:34:4…
    Platform                       Unix
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0
   ```

   The output provides information about your version of PowerShell and also your platform and edition.

   For information limited to  your version of PowerShell, you can run a modified version of `$PSVersionTable`.

1. Enter copy the following command, paste it into the Azure Cloud Shell, and then press <kbd>Enter</kbd>.

   ```powershell
   $PSVersionTable.PSVersion
   ```

    Your output now resembles the following table:

    ```output
    Major  Minor  Patch  PreReleaseLabel BuildLabel
    -----  -----  -----  --------------- ----------
    7      1      4  
    ```

    This output gives you more details about your version of PowerShell.

Running `$PSVersionTable` results in output that looks like a table but is actually an object. For this reason, you can use a period (`.`) to access a specific property, such as `PSVersion`.
