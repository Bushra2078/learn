In some scenarios, you'll need to manage processes on a machine. If you need to stop some of the processes, then you might want to track what processes are running, how much resources they're using, and what their process IDs are. 

## Discover an object by using Get-Member

You know that the cmdlet `Get-Process` lists information about processes. Now you want to find what other cmdlets work with processes and what a process consists of.

In this scenario, you'll use the `Get-Member` cmdlet.

1. Run `Get-Process`.

   ```powershell
   Get-Process
   ```

   The table-like response consists of all running processes on your machine. The exact response depends on what's running on your machine. Pick a process name from the column on the right, and use it as an argument for your next command.

1. Run `Get-Process` again. This time, use the process name and pipe `Get-Member`.

   ```powershell
   Get-Process -Name 'selected process name' | Get-Member
   ```

   This command produces a long response that consists of all of the members, events, and methods. At this point, focus on the first line, which lists the following information:

   ```output
   TypeName: System.Diagnostics.Process
   ```

   Now you know the type is `Process`, so you can learn more about what other cmdlets use this type. Next, use `Get-Command` and add the type as a parameter.

1. Run `Get-Command`.

   ```powershell
   Get-Command -ParameterType Process
   ```

   This command produces a response similar to the following text:

   ```output
    CommandType     Name                                               Version    Source
    -----------     ----                                               -------    ------
    Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Enter-PSHostProcess                                7.0.3.0    Microsoft.PowerShell.Core
    Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Get-PSHostProcessInfo                              7.0.3.0    Microsoft.PowerShell.Core
    Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Management
    Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Management
   ```

Congratulations! By knowing the name of the cmdlet `Get-Process`, you've discovered related commands. You can continue to learn about these commands by using `Get-Help`.
