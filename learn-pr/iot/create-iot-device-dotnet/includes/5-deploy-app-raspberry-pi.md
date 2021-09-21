You've constructed the prototype device and written the console app that drives it. Now it's time to deploy your app to the device!

> [!IMPORTANT]
> Ensure your Raspberry Pi is configured as described in the introduction unit. The SSH service must be enabled for secure shell access from your development machine. The I2C service must be enabled to allow your code to access the I2C bus. Ensure your Raspberry Pi is connected to your network via WiFi or Ethernet.
>
> Refer to the [Raspberry Pi documentation](https://www.raspberrypi.org/documentation/configuration/raspi-config.md) for more information. 

## Deployment types

.NET provides two publishing modes, **framework-dependent** and **self-contained**. In a *framework-dependent* deployment, the app relies on an installation of the .NET runtime on the target device. In a self-contained deployment, the app includes all of the .NET runtime dependencies with the compiled assemblies. There are advantages to each approach. For this module, you'll deploy your app as a self-contained app.

## Create a destination directory on the Raspberry Pi

Complete the following steps **in a new terminal window**:

1. Create a secure shell session on your Raspberry Pi.

    ```bash
    ssh pi@raspberrypi
    ```

    In the preceding command:

    - `ssh` is the command to launch OpenSSH.
    - `pi` is the username on the Raspberry Pi.
    - `raspberrypi` is the host name for the Raspberry Pi. If you've changed this on your device, use the device's host name or IP address.

    > [!NOTE]
    > Most modern operating systems have OpenSSH preinstalled. If the `ssh` command doesn't resolve, install OpenSSH.

1. In the SSH session, create a directory named *cheesecave.net* in the home directory. Switch to the new directory.

    ```bash
    mkdir cheesecave.net
    cd cheesecave.net
    ```

    Your current location is *~/cheesecave.net*.

    :::image type="content" source="../media/pi-new-directory.png" alt-text="A screenshot of an SSH session on a Raspberry Pi with the above steps." lightbox="../media/pi-new-directory.png":::

## Publish a self-contained app to the Raspberry Pi

Complete the following steps **in the original terminal window on your development machine**:

1. Publish the app as a self-contained app.

    ```dotnetcli
    dotnet publish -r linux-arm
    ```

    The preceding command creates a directory with the files required for a self-contained deployment. Take note of the location of the *publish* folder.

    :::image type="content" source="../media/dotnet-publish.png" alt-text="A screenshot of a terminal session showing the output from dotnet publish." lightbox="../media/dotnet-publish.png":::

1. Copy the files from the *publish* folder to the deployment location on the Raspberry Pi.

    ```bash
    scp ./bin/Debug/net5.0/linux-arm/publish/* pi@raspberrypi:~/cheesecave.net
    ```

    In the preceding command:

    - `scp` is the secure file copy command included with OpenSSH.
    - `./bin/Debug/net5.0/linux-arm/publish/*` specifies the files to be copied. In this case, every file in the `./bin/Debug/net5.0/linux-arm/publish/` directory is included. Enter the correct path if you're using a different version of the .NET SDK, as the `/net5.0/` segment will be different.
    - `pi@raspberrypi:~/cheesecave.net` is the destination.
        - `pi@raspberrypi` is the username and host name, as before.
        - `~/cheesecave.net` is the location on the Raspberry Pi where the files will be copied to.

## Grant execute permissions

In Linux-based operating systems like Raspberry Pi OS, binary files aren't allowed to execute until they've been marked as executable in the file system.

**In the SSH session on the Raspberry Pi**, execute the following command:

```bash
chmod +x ./cheesecave.net
```

The `cheesecave.net` executable file now has permission to execute.

In the next unit, you'll test the code on your device!
